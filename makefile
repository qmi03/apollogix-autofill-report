.PHONY: fmt
fmt:
	find . -name *.typ -exec typstfmt {} \; 

watch:
	typst watch main.typ out/main.pdf

compile:
	typst compile main.typ out/main.pdf

open:
	sioyek out/main.pdf
