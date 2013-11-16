# vim:ts=8 sw=4 noet:
#

TOP			:= ..
include			$(TOP)/config/config.mk
PATH			:= $(PATH):$(TOP)/tools

OCAMLC_FLAGS		:= -g -dtypes	    
OCAMLOPT_FLAGS		:= -p -dtypes -noassert -unsafe
OCAMLOPT_FLAGS		:=    -dtypes -noassert
OCAMLOPT_FLAGS		:= -p -dtypes -noassert -unsafe
OCAMLOPT_FLAGS		:=    -dtypes -noassert -unsafe

# -- high-level targets
.PHONY:	    all doc clean pdf test

all:	    load.ml $(NAME).$(LIBEXT)

byte:	    $(NAME).cma
opt:	    $(NAME).cmxa
	    
clean:
	    rm -f *.cmx *.cmo *.cmi *.o *.ml *.mli quest.opt quest.byte
	    rm -f *.log *.pdf *.aux *.inc *.tex *.out
	    rm -f $(NAME).cma $(NAME).cmxa
	    rm -f DEPEND
	    rm -f load.ml *.annot

clobber:    clean

# -- important files

ML :=       debug.ml	    \
	    bitvec.ml       \
	    bitset.ml  	    \
	    context.ml      \
	    fca.ml          \

MLI :=      $(patsubst %.ml, %.mli, $(ML))
CMO :=      $(patsubst %.ml, %.cmo, $(ML))
CMX :=      $(patsubst %.ml, %.cmx, $(ML))
OBJ :=      $(patsubst %.ml, %.o  , $(ML))

TEX :=      $(patsubst %.ml, %.tex, $(ML))
INC :=      $(patsubst %.ml, %.inc, $(ML))
PDF :=      $(patsubst %.ml, %.pdf, $(ML))

# -- 

cmo:	$(CMO)
cmi:	$(CMI)
obj:	$(OBJ)

# -- libraries

$(NAME).cma:	$(CMO) $(CMI) 
		$(OCAMLC) $(OCAMLC_FLAGS) -a -o $@ $(CMO)

$(NAME).cmxa:	$(CMX) $(CMI) 
		$(OCAMLOPT) $(OCAMLOOPT_FLAGS) -a -o $@ $(CMX)


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
	    $(OCAMLDEP) $(ML) $(MLI) > DEPEND	

include	    DEPEND   		
