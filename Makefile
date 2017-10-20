#include Makefile.private # should define DEST

BUILD = ocamlbuild -use-ocamlfind -tags "syntax(camlp4o),package(cow.syntax),package(cow),package(unix),package(ezjsonm)"

all:
	$(BUILD) lib/template.byte --

clean:
	rm -f *.cmo *.cmi *~ template.byte
	rm -rf _build

update: all
	rsync -avz www/ $(DEST)
