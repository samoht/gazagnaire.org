DEST = john@doo.com:~/public_html

all: html css

html:
	ocamlbuild template.byte --

css:
	ocamlbuild template_css.byte --

clean:
	rm -f *.cmo *.cmi *~ template.byte template_css.byte
	rm -rf _build

update: all
	rsync -avz www/ $(DEST)