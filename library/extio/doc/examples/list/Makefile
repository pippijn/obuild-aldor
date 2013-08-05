##########################################################################
#                                                                        #
#                         Makefile                                       #
#                                                                        #
##########################################################################
#                                                                        #
# Makefile for building the example (for the documentation) in the       #
# current directory                                                      #
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

RELATIVE_ROOT=../../../..

SUBDIRS = $(shell $(FIND) . -mindepth 1 -maxdepth 1 -type d )

NAMESTUB= $(shell $(LS) *.as$ | $(SED) -e "s/.as$$//"  )

OUTPUTS = $(NAMESTUB).out

include $(RELATIVE_ROOT)/environment.mk

ALDORVARIANTOPTIONS=$(COMPILERLIBRARYOPTIONS) $(COMPILERINCLUDEOPTIONS) 


all:


doc: $(NAMESTUB) $(NAMESTUB).as-prepared $(OUTPUTS)


clean: 
	$(RM) $(NAMESTUB) *.as-prepared *.ao *.al *.o *.a *.out


#############################################

include $(RELATIVE_ROOT)/default_targets.mk

$(NAMESTUB).out: $(NAMESTUB)

$(RELATIVE_ROOT)/$(LIBDIR)/$(LIBNAME).a:
	cd $(RELATIVEROOT) && $(MAKE) lib

$(RELATIVE_ROOT)/$(LIBDIR)/$(LIBNAME).al:
	cd $(RELATIVEROOT) && $(MAKE) lib

$(NAMESTUB): $(NAMESTUB).as $(RELATIVE_ROOT)/$(LIBDIR)/$(LIBNAME).a  $(RELATIVE_ROOT)/$(LIBDIR)/$(LIBNAME).a
	$(ALDOR) -I . -I $(RELATIVE_ROOT)/$(INCLUDEDIR) -Y $(RELATIVE_ROOT)/$(LIBDIR) $(COMPILERLIBRARYOPTIONS) $(COMPILERINCLUDEOPTIONS) -Fx=$> -l$(LIBNAMESTUB) $(LIBSLINKSTR) -lm $^