DEST = samoht@amis.tv:~/public_html/perso/thomas

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