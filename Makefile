include Makefile.private # should define DEST

all:
	ramen

update: all
	rsync -avz site/ $(DEST)
