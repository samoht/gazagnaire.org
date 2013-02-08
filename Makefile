include Makefile.private # should define DEST

BUILD = ocamlbuild -use-ocamlfind

all: html css

html:
	$(BUILD) template.byte --

css:
	$(BUILD) template_css.byte --

clean:
	rm -f *.cmo *.cmi *~ template.byte template_css.byte
	rm -rf _build

update: all
	rsync -avz www/ $(DEST)
