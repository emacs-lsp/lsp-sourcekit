.PHONY: all compile clean

EMACS ?= emacs
CASK ?= cask

LSP-SOURCEKIT-GENERAL := lsp-sourcekit.el

all:
	$(CASK) build

build:
	$(CASK) install

compile:
	@$(CASK) $(EMACS) -Q --batch \
		-l test/windows-bootstrap.el \
		-L . \
		--eval '(setq byte-compile-error-on-warn t)' \
		-f batch-byte-compile $(LSP-SOURCEKIT-GENERAL)

ci: CASK=
ci: clean compile

clean:
	rm -rf .cask *.elc
