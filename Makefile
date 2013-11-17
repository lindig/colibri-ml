#
#
#
PREFIX  = $(HOME)
NAME	= colibri
BINDIR	= $(PREFIX)/bin
MAN1DIR = $(PREFIX)/man/man1
LIPSUM  = https://github.com/lindig/lipsum.git

LP	= ./lipsum/lipsum.native
OCB	= ocamlbuild

# -- high-level targets
.PHONY: all clean install test

all:	src
	$(OCB) -I src -I libsrc main.native

src:	lipsum
	cd libsrc; for f in *.nw; do ../$(LP) expand -f cpp $$f; done
	cd    src; for f in *.nw; do ../$(LP) expand -f cpp $$f; done

clean:	
	$(OCB) -I src -I libsrc -clean
	rm -f *src/*.ml *src/*.mli *src/*.mly *src/*.mll
	rm -f libsrc/nice*

clobber: clean
	$(MAKE) -C lipsum clean
	rm -f doc/colibri.1

install: all doc/colibri.1
	install $(NAME).$(BINEXT) $(BINDIR)/$(NAME) 
	install doc/$(NAME).man $(MAN1DIR)/$(NAME).1

%.1:	%.pod
	pod2man $< > $@

# update lipsum subtree from upstream
update:
	git subtree pull --prefix lipsum $(LIPSUM) master --squash
	
lipsum:	FORCE    
	$(MAKE) -C lipsum all

FORCE:

