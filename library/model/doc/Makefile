##########################################################################
#                                                                        #
#                         Makefile                                       #
#                                                                        #
##########################################################################
#                                                                        #
# The Makefile for managing the built documentation                      #
#                                                                        #
##########################################################################
#                                                                        #
# Copyright (C) 2005  Research Institute for Symbolic Computation, J.    #
# Kepler University, Linz, Austria                                       #
#                                                                        #
# Written by Christian Aistleitner                                       #
#                                                                        #
# This program is free software; you can redistribute it and/or          #
# modify it under the terms of the GNU General Public License version 2, #
# as published by the Free Software Foundation.                          #
#                                                                        #
# This program is distributed in the hope that it will be useful,        #
# but WITHOUT ANY WARRANTY; without even the implied warranty of         #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
# GNU General Public License for more details.                           #
#                                                                        #
# You should have received a copy of the GNU General Public License      #
# along with this program; if not, write to the Free Software            #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,             #
# MA  02110-1301, USA.                                                   #
#                                                                        #
##########################################################################


RELATIVE_ROOT=../..

SUBDIRS = $(shell if [ -d examples ] ; then echo examples; fi )

include $(RELATIVE_ROOT)/environment.mk


all:


doc: doc-recursive $(LOWERCASEPROJECTNAME).pdf

distdir:
	if [ "$(PATCHLATEXFRONTPAGE)" = "yes" ] ; then $(SED) -e "s/\\\\date{.*}/\\\\date{`date +%Y-%m-%d`}/" frontpage.tex >frontpage-patched.tex && $(MV) frontpage-patched.tex frontpage.tex || ( $(RM) frontpage-patched.tex && test 0 -eq 1 ) ; fi

clean: clean-recursive
	$(RM) *.aux *.bbl *.blg *.brf *.idx *.dvi *.ilg *.ind *.log *.pdf *.ps *.toc *.out apiinputs.tex apiinputsinclude.tex.unsorted $(DOCINCLUDEDOCDIR) $(DOCLIBRARYDOCDIR)

distclean: clean
	$(RM) apiinputslibrary.tex.unsorted

#############################################

include $(RELATIVE_ROOT)/default_targets.mk
include .dependencies

$(LOWERCASEPROJECTNAME).pdf: $(LOWERCASEPROJECTNAME).tex $(shell $(FIND) -follow -type f | grep -e \.tex$$) 

%.pdf: %.tex 
	TEXINPUTS="./styles:${TEXINPUTS}" echo $(PDFLATEX) $< ; \
	TEXINPUTS="./styles:${TEXINPUTS}" $(PDFLATEX) $< ; \
	$(RM) $@ ; \
	if [ `$(GREP) -c '^[^%]*\\\bibliography{' $<` -gt 0 ] ;\
	then \
	 BSTINPUTS="./bibtex:${TEXINPUTS}" $(BIBTEX) $(<:%.tex=%.aux) ;\
	fi && \
	TEXINPUTS="./styles:${TEXINPUTS}" $(PDFLATEX) $< && \
	$(SED) -i -e 's/\\discretionary {-}{}{}//g' $(<:%.tex=%.idx) && \
	$(MAKEINDEX) $(<:%.tex=%.idx) && \
	TEXINPUTS="./styles:${TEXINPUTS}" $(PDFLATEX) $< || ( $(RM) $@ && test 0 -eq 1 )

