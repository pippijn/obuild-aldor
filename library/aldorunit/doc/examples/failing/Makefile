##########################################################################
#                                                                        #
#                             Makefile                                   #
#                                                                        #
##########################################################################
#                                                                        #
# Makefile for the "failing" examples                                    #
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

SUBDIRS =

OUTPUTS = TestSuite_-m.out \
  TestSuite_-m_-d_300.out

include $(RELATIVE_ROOT)/environment.mk

ALDORVARIANTOPTIONS=$(COMPILERLIBRARYOPTIONS) $(COMPILERINCLUDEOPTIONS) 


all:


doc: TestSuite errors.test.as-prepared $(OUTPUTS)


clean: 
	$(RM) TestSuite tst-suit.* *.as-prepared *.signatures.as *.ao *.al *.o *.a *.out


#############################################

include $(RELATIVE_ROOT)/default_targets.mk

%.out: TestSuite

errors.test.signatures.as: errors.test.as
	$(RELATIVE_ROOT)/$(SCRIPTDIR)/extract_test_signatures.sh $< >$@

errors.test.ao: errors.test.as errors.test.signatures.as
errors.test.o: errors.test.ao

tst-suit.ao: tst-suit.as

libtest.al: libtest.al(errors.test.ao)
libtest.a:  libtest.a(errors.test.o)
	$(RANLIB) $@

tst-suit.as: libtest.al libtest.a
	$(RELATIVE_ROOT)/$(SCRIPTDIR)/generate_testsuite.sh ListLib >$@.unpatched && head --lines=7 $@.unpatched >$@ && echo "#library listtestlib \"test\"" >>$@ && echo "import from listtestlib;" >>$@ && sed -e "1,8d" $@.unpatched >>$@ || rm $@ $@.unpatched && test -f $@

TestSuite: tst-suit.as
	$(ALDOR) -I . -I $(RELATIVE_ROOT)/$(INCLUDEDIR) -Y $(RELATIVE_ROOT)/$(LIBDIR) $(COMPILERLIBRARYOPTIONS) $(COMPILERINCLUDEOPTIONS) -Fx=TestSuite -ltest -l$(LIBNAMESTUB) $(LIBSLINKSTR) -lm tst-suit.as