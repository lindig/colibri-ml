#
#

TOP :=	    .
include	    $(TOP)/config/config.mk

NAME	    := colibri
BINDIR	    := $(PREFIX)/bin
MAN1DIR	    := $(PREFIX)/man/man1

DIR = libsrc src doc

# -- high-level targets
.PHONY: all clean install test

all:	$(TOP)/config/config.mk
	for d in $(DIR); do $(MAKE) -C $$d $@; done

clean:	
	for d in $(DIR); do $(MAKE) -C $$d $@; done
	rm -f test.* gmon.out
	rm -f VERSION

clobber: clean
	for d in $(DIR); do $(MAKE) -C $$d $@; done

install: all dirs
	cp src/$(NAME).$(BINEXT) $(BINDIR)/$(NAME) 
	cp doc/$(NAME).man $(MAN1DIR)/$(NAME).1

dirs:	$(BINDIR) $(MAN1DIR)
	mkdir -p $(BINDIR) $(MAN1DIR)

$(BINDIR):
	mkdir -p $@

$(MAN1DIR):
	mkdir -p $@

VERSION: FORCE
	svn -v list . | sort -rn | head -1 | awk '{print $$1}' > $@

FORCE:

# -- compare lattice size computed by colibri with size computed with
# -- concepts(1). Lattices are computed from randomly generated
# -- contexts. Obviously, this requires access to concepts. The idea
# -- is, that this should find flaws in the implementation that computes
# -- all concepts.

test:	all
	for i in 0 1 2 3 4 5 6 7 8 9 a b c d e f; do		 \
		./tools/randcon 100 100 10 > test.in		;\
		concepts -s test.in > test.1			;\
		./src/colibri.opt size test.in | tee test.2	;\
		diff test.1 test.2 || break			;\
		./src/colibri.opt dot test.in | sort | uniq -d  ;\
	done						
	
# --

$(TOP)/config/config.mk:    
	@echo "config/config.mk is missing. Have you run ./configure?"
	@exit 1
