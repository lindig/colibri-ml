# vim:ts=8 sw=4 noet:
#

TOP			:= ..
include			$(TOP)/config/config.mk

PATH			:= $(PATH):$(TOP)/tools

INCLUDES		:= $(TOP)/libsrc
OCAMLC_FLAGS		:= -g -dtypes -I $(INCLUDES)
OCAMLOPT_FLAGS		:= -p -dtypes -I $(INCLUDES)
OCAMLOPT_FLAGS		:= -p -dtypes -I $(INCLUDES)
OCAMLOPT_FLAGS		:=    -dtypes -I $(INCLUDES)

# -- high-level targets
.PHONY:	    all doc clean pdf test

all:	    load.ml $(NAME).$(BINEXT)
byte:	    $(NAME).byte
opt:	    $(NAME).opt
	    
clean:
	    rm -f *.cmx *.cmo *.cmi *.o *.ml *.mli quest.opt quest.byte
	    rm -f *.log *.pdf *.aux *.inc *.tex *.out
	    rm -f DEPEND
	    rm -f load.ml *.annot
	    
clobber:    clean
	    rm -f $(NAME).byte $(NAME).opt

# -- important files

ML :=       atom.ml	    \
	    parser.ml	    \
	    scanner.ml	    \
	    lattice.ml	    \
	    rules.ml	    \
	    main.ml	    \

NW := 	    atom.nw lattice.nw main.nw rules.nw syntax.nw	
	    

MLI :=      $(patsubst %.ml, %.mli, $(ML))
CMO :=      $(patsubst %.ml, %.cmo, $(ML))
CMX :=      $(patsubst %.ml, %.cmx, $(ML))
OBJ :=      $(patsubst %.ml, %.o  , $(ML))

TEX :=      $(patsubst %.ml, %.tex, $(NW))
INC :=      $(patsubst %.ml, %.inc, $(NW))
PDF :=      $(patsubst %.ml, %.pdf, $(NW))

# -- 

cmo:	$(CMO)
cmi:	$(CMI)
obj:	$(OBJ)

# --

LIBCMO :=	$(TOP)/libsrc/$(NAME).cma
LIBCMX :=	$(TOP)/libsrc/$(NAME).cmxa

# -- binaries

$(NAME).byte:	$(CMO) $(LIBCMO)
		$(OCAMLC) $(OCAMLC_FLAGS) -o $@ $(LIBCMO) $(CMO) 

$(NAME).opt:	$(CMX) $(LIBCMX)
		$(OCAMLOPT) $(OCAMLOPT_FLAGS) -o $@ $(LIBCMX) $(CMX) 

# -- debugging support

load.ml:    $(CMO)
	    echo $(CMO) | tr ' ' \\012 | sed 's/^.*$$/#load "&";;/' > $@

# -- rules

%.ml:       %.nw
	    $(NOTANGLE) '-L# %L "%F"%N' -R$@ $< > $@

%.mli:      %.nw
	    $(NOTANGLE) '-L# %L "%F"%N' -R$@ $< > $@

%.sig:	    %.ml
	    $(OCAMLC) $(OCAMLC_FLAGS) -c -i $< > $@

%.cmo:      %.ml
	    $(OCAMLC) $(OCAMLC_FLAGS) -c $<

%.cmx:      %.ml
	    $(OCAMLOPT) $(OCAMLOPT_FLAGS) -c $<

%.cmi:      %.mli
	    $(OCAMLC) $(OCAMLC_FLAGS) -c $<

%.mli %.ml: %.mly
	    $(OCAMLYACC) $<

%.ml:	    %.mll
	    $(OCAMLLEX) $<

# -- special rules

scanner.mli: syntax.nw
	    $(NOTANGLE) '-L# %L "%F"%N' -R$@ $< > $@

scanner.mll: syntax.nw
	    $(NOTANGLE) '-L# %L "%F"%N' -R$@ $< > $@

parser.mly: syntax.nw
	    $(NOTANGLE) '-L# %L "%F"%N' -R$@ $< > $@

# -- documentation

RERUN =     Rerun (LaTeX|to get cross-references right)

pdf:	    $(PDF)

%.pdf:	%.tex 
	    $(PDFLATEX) $<
	    if egrep -s '$(RERUN)' $*.log ;then $(PDFLATEX) $<; fi
	    if egrep -s '$(RERUN)' $*.log ;then $(PDFLATEX) $<; fi

%.inc:      %.nw
	    $(NOWEAVE) -delay $< > $@

%.tex:	%.inc
	    echo "    \documentclass[11pt]{article}	"  > $@
	    echo "    \usepackage{a4wide}		" >> $@
	    echo "    \usepackage{hyperref}		" >> $@
	    echo "    \usepackage{noweb}		" >> $@
	    echo "    \noweboptions{breakcode}		" >> $@
	    echo "    \begin{document}			" >> $@
	    echo "    \input{$<}			" >> $@
	    echo "    \end{document}			" >> $@

# -- dependencies

DEPEND:	    $(ML) $(MLI)
	    $(OCAMLDEP) -I $(INCLUDES) $(ML) $(MLI) > DEPEND	

include	    DEPEND   		
