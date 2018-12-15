# lsp-sourcekit

lsp-sourcekit is a client for [sourcekit-lsp](https://github.com/apple/sourcekit-lsp), a Swift/C/C++/Objective-C language server created by Apple.

Uses [lsp-mode](https://github.com/emacs-lsp/lsp-mode), but it's also open to be extended with additions outside of the LSP protocol, like semantic highlighting, if the server supports that.

## Screenshot

![alt text](https://github.com/emacs-lsp/lsp-sourcekit/raw/master/images/main_screenshot.png "Screenshot of sourcekit-lsp in Emacs")

## Quickstart

You need to download [sourcekit-lsp](https://github.com/apple/sourcekit-lsp) and follow their repo instructions to build it using Swift Package Manager, for example.

After that, you need to download and install [a custom development Swift toolchain from Swift.org website](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a-osx.pkg) (in the future, Apple plans to make sourcekit-lsp work with Swift release toolchains).

Finally, add the following code to your `init.el`:

```elisp
(require 'lsp-sourcekit)
(setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2018-12-07-a.xctoolchain")
(setq lsp-sourcekit-executable (expand-file-name "<path_to_sourcekit-lsp_executable>"))
```

You can add `lsp-sourcekit-swift-enable` to your `swift-mode` hook and it will load sourcekit-lsp whenever you visit a `.swift` file.
