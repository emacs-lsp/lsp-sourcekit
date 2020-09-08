[![MELPA](https://melpa.org/packages/lsp-sourcekit-badge.svg)](https://melpa.org/#/lsp-sourcekit)

# lsp-sourcekit

lsp-sourcekit is a client for [SourceKit-lsp](https://github.com/apple/sourcekit-lsp), a Swift/C/C++/Objective-C language server created by Apple.

Uses [lsp-mode](https://github.com/emacs-lsp/lsp-mode), but it's also open to be extended with additions outside of the LSP protocol, like semantic highlighting, if the server supports that.

## Screenshot

![alt text](https://github.com/emacs-lsp/lsp-sourcekit/raw/master/images/main_screenshot.png "Screenshot of SourceKit-lsp in Emacs")

## Quickstart

The SourceKit-LSP language server is included by default in Xcode 11.4+, so the simplest way to get started is the following:

- Download and install Xcode 11.4+ from the Mac App Store or from [the Apple developer portal](https://developer.apple.com).
- In Emacs, install `lsp-sourcekit`: `M-x package-install lsp-sourcekit RET`.
- Then you need to configure the package to point to the `sourcekit-lsp` executable:

If you use `use-package`:

```elisp
(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))
```

If you don't use `use-package`:

```elisp
(eval-after-load 'lsp-mode
  (progn
    (require 'lsp-sourcekit)
    (setq lsp-sourcekit-executable
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp")))
```

(On macOS, you can get the path to the SourceKit-LSP executable by running `xcrun --find sourcekit-lsp` in Terminal.)

- Finally, if you want to enable `lsp` automatically whenever you visit a `.swift` file:

```elisp
(use-package swift-mode
  :hook (swift-mode . (lambda () (lsp))))
```

If you don't use `use-package`:

```elisp
(add-hook 'swift-mode-hook (lambda () (lsp)))
```

## Advanced Setup

If you are using a custom Swift toolchain, a toolchain you compiled from source, or simply want to run SourceKit-LSP on a platform different from macOS, the above steps are almost the same, but you may need to set a different value for `lsp-sourcekit-executable`, or set a special environment variable to search for the corresponding toolchain. You can get further details in the [SourceKit-LSP](https://github.com/apple/sourcekit-lsp) repository.
