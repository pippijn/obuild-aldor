--* From C1GOMEZ%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Sep  9 23:46:55 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA27656; Fri, 9 Sep 1994 23:46:55 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1783; Fri, 09 Sep 94 23:46:59 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.C1GOMEZ.NOTE.VAGENT2.0263.Sep.09.23:46:59.-0400>
--*           for asbugs@watson; Fri, 09 Sep 94 23:46:59 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 0259; Fri, 9 Sep 1994 23:46:59 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Fri, 09 Sep 94 23:46:58 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA27506; Fri, 9 Sep 1994 23:47:33 -0400
--* Date: Fri, 9 Sep 1994 23:47:33 -0400
--* From: teresa@watson.ibm.com
--* X-External-Networks: yes
--* Message-Id: <9409100347.AA27506@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] Fatal Error from -Ginterp

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp -Ginterp testl.as listo.aso dyn.aso dpol.aso dgpol.aso claw.aso
-- Version: 0.36.5
-- Original bug file name: testl.as

--+ % asharp -Ginterp testl.as listo.aso dyn.aso dpol.aso dgpol.aso claw.aso
--+
--+
--+ testl.as:
--+
--+ listo.aso:
--+ #1 (Warning) The file `listo.o' will now be out of date.
--+
--+ dyn.aso:
--+ #1 (Warning) The file `dyn.o' will now be out of date.
--+
--+ dpol.aso:
--+ #1 (Warning) The file `dpol.o' will now be out of date.
--+
--+ dgpol.aso:
--+
--+ claw.aso:
--+ #1 (Warning) The file `testl' will now be out of date.
--+ #2 (Fatal Error) Could not open file `testl.aso' with mode `rb'.
--+
#include "asinit.as"
#pile

#library listolib "listo.aso"
#library dynlib "dyn.aso"
#library dpolib "dpol.aso"
#library dgpolib "dgpol.aso"
#library clawlib "claw.aso"
--#library cdenlib "cden.aso"
--#library cfralib "cfra.aso"
--#library cclolib "cclo.aso"

import from listolib
import from dynlib
import from dpolib
import from dgpolib
import from clawlib
--import from cdenlib
--import from cfralib
--import from cclolib

DK ==> DynamicBuildField RI
Poly ==> DynamicUnivariatePolynomial DK
Gpol ==> DynamicConstructibleGeneralizedPolynomial(DK,Poly)
LGpol ==> List Gpol
Law ==> ConstructibleLaw(DK)
Split ==> Record(notEq:Law,Eq:Law)

import from DK,Poly,Flag,List Gpol,Law
import from Split
import from Enumeration(al,any,ex,fa,tr)

x:Poly:= monomial(1@DK,1@SI)

p:Poly:= x^2@I - 1@Poly

fl:Flag:= squarefree()$Flag

gp:Gpol:= build(p,fl,true@Boolean)

lgp:List Gpol:= [gp]

print << "list of gp" <<$LGpol lgp << newline

l1:Law:= build(any,"a",[])$Law
la:Law:= build(al,"a",lgp)$Law
le:Law:= build(ex,"a",lgp)$Law
lf:Law:= build(fa,"a",[])$Law

print << "law any " << l1 << newline
print << "algebraic law " << la << newline
print << "exception law " << le << newline
print << "law failed " << lf << newline << newline

sp:Split:= split(l1,gp)$Law

print << "Splitting" << newline
print << "NOTEQ = " << sp.notEq << newline
print << "EQ = " << sp.Eq << newline

sp:Split:= split(la,gp)$Law
print << "NOTEQ = " << sp.notEq << newline
print << "EQ = " << sp.Eq << newline

sp:Split:= split(le,gp)$Law
print << "NOTEQ = " << sp.notEq << newline
print << "EQ = " << sp.Eq << newline





