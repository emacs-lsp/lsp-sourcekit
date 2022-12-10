.PHONY: all compile clean

EMACS ?= emacs
EASK ?= eask

LSP-SOURCEKIT-GENERAL := lsp-sourcekit.el

ci: clean build compile checkdoc lint

build:
	$(EASK) package
	$(EASK) install

compile:
	@echo "Compiling..."
	@$(EASK) compile

checkdoc:
	$(EASK) lint checkdoc

lint:
	@echo "package linting..."
	$(EASK) lint package

clean:
	$(EASK) clean all
