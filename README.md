[![Melpa Status](http://melpa.milkbox.net/packages/lsp-sourcekit-badge.svg)](http://melpa.milkbox.net/#/lsp-sourcekit)

# lsp-sourcekit

lsp-sourcekit is a client for [sourcekit-lsp](https://github.com/apple/sourcekit-lsp), a Swift/C/C++/Objective-C language server created by Apple.

Uses [lsp-mode](https://github.com/emacs-lsp/lsp-mode), but it's also open to be extended with additions outside of the LSP protocol, like semantic highlighting, if the server supports that.

## Screenshot

![alt text](https://github.com/emacs-lsp/lsp-sourcekit/raw/master/images/main_screenshot.png "Screenshot of sourcekit-lsp in Emacs")

## Quickstart

You need to download [sourcekit-lsp](https://github.com/apple/sourcekit-lsp) and follow their repo instructions to build it using Swift Package Manager, for example.

After that, you need to download and install the [latest master Swift toolchain snapshot from Swift.org website](https://swift.org/download/#releases) (SourceKit-LSP development is happening rapidly and using it with a recent toolchain is highly recommended).

Finally, add the following code to your `init.el`:

```elisp
(require 'lsp-sourcekit)
(setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-latest.xctoolchain")
(setq lsp-sourcekit-executable (expand-file-name "<path_to_sourcekit-lsp_executable>"))
```

Or, if you use `use-package`:

```elisp
(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-latest.xctoolchain")
  (setq lsp-sourcekit-executable (expand-file-name "<path_to_sourcekit-lsp_executable>")))
```

You can add `lsp` to your `swift-mode` hook and it will load sourcekit-lsp whenever you visit a `.swift` file, for example:

```elisp
(use-package swift-mode
  :hook (swift-mode . (lambda () (lsp))))
```

Now visit a Swift file inside a Swift Package Manager project and lsp-sourcekit should start managing it and offering code intelligence.
