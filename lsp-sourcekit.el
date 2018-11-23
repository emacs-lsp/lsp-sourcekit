;;; lsp-sourcekit.el --- sourcekit-lsp client for lsp-mode     -*- lexical-binding: t; -*-

;; Copyright (C) 2018 Daniel Martín

;; Author: Daniel Martín
;; Version: 0.1
;; Homepage: https://github.com/emacs-lsp/lsp-sourcekit
;; Package-Requires: ((emacs "25.1") (lsp-mode "4.2"))
;; Keywords: languages, lsp, swift, objective-c, c++

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and-or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.
;;
;;; Commentary:

;;
;; Call (lsp-sourcekit-swift-enable) in your swift-mode hook.
;;
;; TODO: Configure the Objective-C/C++ LSP client (requires clangd).

;;; Code:

(require 'lsp-mode)
(require 'lsp-methods)

;; ---------------------------------------------------------------------
;;   Customization
;; ---------------------------------------------------------------------

(defcustom lsp-sourcekit-executable
  "ccls"
  "Path of the lsp-sourcekit executable."
  :type 'file
  :group 'sourcekit)

(defcustom lsp-sourcekit-extra-args
  nil
  "Additional command line options passed to the lsp-sourcekit executable."
  :type '(repeat string)
  :group 'sourcekit)

;; ---------------------------------------------------------------------
;;   Notification handlers
;; ---------------------------------------------------------------------

(defvar lsp-sourcekit--handlers nil
  "List of cons-cells of (METHOD . HANDLER) pairs, where METHOD is the lsp method to handle,
and handler is a function invoked as (handler WORKSPACE PARAMS), where WORKSPACE is the current
lsp-workspace, and PARAMS is a hashmap of the params received with the notification.")

;; ---------------------------------------------------------------------
;;  Register lsp client
;; ---------------------------------------------------------------------

(defun lsp-sourcekit--make-renderer (mode)
  `(lambda (str)
     (with-temp-buffer
       (delay-mode-hooks (,(intern (format "%s-mode" mode))))
       (insert str)
       (font-lock-ensure)
       (buffer-string))))

(defun sourcekit--initialize-client (client)
  (dolist (p lsp-sourcekit--handlers)
    (lsp-client-on-notification client (car p) (cdr p)))
  (lsp-provide-marked-string-renderer client "swift" (lsp-sourcekit--make-renderer "swift")))

;;;###autoload (autoload 'lsp-sourcekit-swift-enable "lsp-sourcekit")
(lsp-define-stdio-client
 lsp-sourcekit-swift "swift" (lambda () default-directory)
 `(,lsp-sourcekit-executable ,@lsp-sourcekit-extra-args)
 :initialize #'sourcekit--initialize-client)

(provide 'lsp-sourcekit)
;;; lsp-sourcekit.el ends here
