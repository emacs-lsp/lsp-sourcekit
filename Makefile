.PHONY: all compile clean

EMACS ?= emacs
CASK ?= cask

LSP-SOURCEKIT-GENERAL := lsp-sourcekit.el

all:
	$(CASK) build

build:
	$(CASK) install

compile:
	@echo "Compiling..."
	@$(CASK) $(EMACS) -Q --batch \
		-l test/windows-bootstrap.el \
		-L . \
		--eval '(setq byte-compile-error-on-warn t)' \
		-f batch-byte-compile *.el

ci: CASK=
ci: clean compile

clean:
	rm -rf .cask *.elc
