--* From smwatt@watson.ibm.com  Thu Mar 18 12:47:50 1993
--* Received: from watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA11087; Thu, 18 Mar 1993 12:47:50 -0500
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA24413; Thu, 18 Mar 1993 12:38:28 -0500
--* Date: Thu, 18 Mar 1993 12:38:28 -0500
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9303181738.AA24413@watson.ibm.com>
--* To: axc-bug@watson.ibm.com, scm@yorktown
--* Subject: sin gets inlined into tan, but cos doesn't (when compiled with -Fc -O) [xxx.as][v27.2 (current)]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <name of new or existing file in test directory>
--@ Summary:   <One line description of real problem and the fix>


#include "axllib"

F  ==> DoubleFloat

ForeignNumericFunctions: with
	xsin:	F -> F
	xcos:	F -> F
	xtan:	F -> F
    == add

	import Machine

	import Foreign: with
		sin: BDFlo -> BDFlo
		cos: BDFlo -> BDFlo

	xsin(x: F): F == sin(x::BDFlo):: F
	xcos(x: F): F == cos(x::BDFlo):: F
	xtan(x: F): F == (sin(x::BDFlo)/cos(x::BDFlo))::F

AFunkyDomain: with
	ysin:	F -> F
	ycos:	F -> F
	ytan:	F -> F

    == add
	FNF ==> ForeignNumericFunctions

	ysin(x: F): F == xsin(x)$FNF
	ycos: F -> F  == xcos$FNF
	ytan(x: F): F == ysin x/ycos x
