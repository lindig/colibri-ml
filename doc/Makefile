#
# 

TOP :=		..
include		$(TOP)/config/config.mk


.PHONY:		all clean clobber

# -- high-level targets

all:		$(NAME).man

clean: 
		rm -f $(NAME).man

# -- rules

%.man:		%.pod
		$(POD2MAN) $< > $@

