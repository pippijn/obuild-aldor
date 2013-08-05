--* From hemmecke@milkyway.risc.uni-linz.ac.at  Mon May  8 15:57:42 2000
--* Received: from milkyway.risc.uni-linz.ac.at (milkyway.risc.uni-linz.ac.at [193.170.37.166])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA15168
--* 	for <ax-bugs@nag.co.uk>; Mon, 8 May 2000 15:57:41 +0100 (BST)
--* Received: (from hemmecke@localhost) by milkyway.risc.uni-linz.ac.at (8.9.3/980728.SGI.AUTOCF) id QAA51808; Mon, 8 May 2000 16:59:48 +0200 (MST)
--* Date: Mon, 8 May 2000 16:59:48 +0200 (MST)
--* From: hemmecke@milkyway.risc.uni-linz.ac.at (Ralf HEMMECKE)
--* Message-Id: <200005081459.QAA51808@milkyway.risc.uni-linz.ac.at>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -fx -V -DOneFile zzz.as
-- Version: Aldor version 1.1.12p2 for LINUX(glibc)
-- Original bug file name: zzz.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 08-MAY-2000
-- Aldor version 1.1.12p2 for LINUX(glibc) 
-- Subject: Using package in category defaults

-- The following bug demonstration consists of two files:
-- xxx.as:
--     Package  CxExpressionReader
--     Category CxPolynomialCategory
-- yyy.as:
--     Domain   CxPolynomials
--     Function main

-- The bug is two-fold:
-- 1) The code does not compile for options C0 and C1.
-- 2) Executing the code (compiled without any option) results in a
--    segmentation fault.

-- Problem 2 did not occur in that way with my original code. It
-- worked fine with the executable and just crashed in an 
-- `axiomxl -gloop' session. After shortening the code, the crash now
-- happens in the executable as well as in the LOOP session.

-------------------------------------------------------------------
-- Problem 1.
-------------------------------------------------------------------
-- There is no problem in compiling xxx.as and yyy.as with any
-- of the following combination of options:
--     C0 C1
-- 1   -  -
-- 2   -  x
-- 3   x  -

-- However, compiling with the following commands does not work.
--: axiomxl -fo -fao -V -DC0 -DC1 xxx.as
--: axiomxl -fx -V -Mno-mactext -DC0 -DC1 yyy.as xxx.o
--: Aldor version 1.1.12p2 for LINUX(glibc) 
--: 
--: yyy.as:
--: "yyy.as", line 12:         variable(s: String): % == s :: %;
--:                    .......................................^
--: [L12 C40] #1 (Error) There are no suitable meanings for the operator `coerce'.
--:    The possible types of the left hand side are:
--:           -- String
--: 
--: "yyy.as", line 31:         p:POL := "Y" :: POL;
--:                    ........................^
--: [L31 C25] #2 (Error) There are no suitable meanings for the operator `coerce'.
--:    The possible types of the left hand side are:
--:           -- String
--: 
--:                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--:  Time    0.4 s  0  0  0  4  0  0  0  0  0  2 91  0  0  0  0  0  0  2 %
--: 
--:  Source  216 lines,  27574 lines per minute
--:  Store  1844 K pool
--: 
--: Totals:
--:  Time    0.5 s
--:  Source  216 lines,  24452 lines per minute
--:  Store  1844 K pool
--: 
--: Compilation exited abnormally with code 2 at Mon May  8 12:55:48




-------------------------------------------------------------------
-- Problem 2.
-------------------------------------------------------------------
-- Compile with 
--     axiomxl -fo -fao -V xxx.as
--     axiomxl -fx -V -Mno-mactext yyy.as xxx.o
-- Execute yyy.
-- The output is:
--: MAIN
--: Segmentation fault

-- The segmentation fault also occurs when one saves the two files
-- in one.
--   cat xxx.as yyy.as > zzz.as
-- Compile with 
--     axiomxl -fx -V -DOneFile zzz.as
-- Execute zzz.
-- The output is:
--: MAIN
--: Segmentation fault

-------------------------------------------------------------------
-- xxx.as
-------------------------------------------------------------------
#include "axllib"

CxExpressionReader(
    P: Type,
    embed: String -> P
): with {
	getExpression: String -> P;
} == add {
	getExpression(s: String): P == embed s;
}

define CxPolynomialCategory(T: Type): Category == with {
	coerce: String -> %;
#if C0
    default {
	coerce(s: String): % == {
#if C1
		getExpression(s) $ CxExpressionReader(%, coerce $ %);
#else
		getExpression(s) $ CxExpressionReader(%, coerce);
#endif
	}
    }
#endif
}

-------------------------------------------------------------------
-- yyy.as
-------------------------------------------------------------------
#if OneFile
#else
#include "axllib"

#library XXXLib "xxx.ao"
import from XXXLib;
#endif 

CxPolynomials(T: Type): CxPolynomialCategory(T) with {
	variable: String -> %
} == add {
	Rep ==> Record(tt: T);
	import from Rep,T;
	coerce(t: T): % == per [t];
	variable(s: String): % == s :: %;
#if C0
#else
	coerce(s: String): % == {
#if C1
		getExpression(s) $ CxExpressionReader(%, coerce $ %);
#else
		getExpression(s) $ CxExpressionReader(%, coerce);
#endif
	}
#endif
}

POL == CxPolynomials(String);
import from String, POL;

main():() == {
	print << "MAIN" << newline;
	v:POL := variable("Z")$POL;
	p:POL := "Y" :: POL;
}
main();
