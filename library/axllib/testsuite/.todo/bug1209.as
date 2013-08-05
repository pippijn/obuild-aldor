--* From hemmecke@risc.uni-linz.ac.at  Mon May  8 18:31:12 2000
--* Received: from kernel.risc.uni-linz.ac.at (root@kernel.risc.uni-linz.ac.at [193.170.37.225])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id SAA17189
--* 	for <ax-bugs@nag.co.uk>; Mon, 8 May 2000 18:31:10 +0100 (BST)
--* Received: from deneb.risc.uni-linz.ac.at (deneb.risc.uni-linz.ac.at [193.170.37.113])
--* 	by kernel.risc.uni-linz.ac.at (8.9.2/8.9.2/Debian/GNU) with ESMTP id TAA01734;
--* 	Mon, 8 May 2000 19:33:36 +0200 (CEST)
--* Message-ID: <XFMail.000508193335.hemmecke@risc.uni-linz.ac.at>
--* X-Mailer: XFMail 1.3 [p0] on Solaris
--* X-Priority: 3 (Normal)
--* Content-Type: text/plain; charset=us-ascii
--* Content-Transfer-Encoding: 8bit
--* MIME-Version: 1.0
--* Date: Mon, 08 May 2000 19:33:35 +0200 (MET DST)
--* Sender: hemmecke@risc.uni-linz.ac.at
--* From: Ralf.Hemmecke@risc.uni-linz.ac.at
--* To: ax-bugs@nag.co.uk
--* Subject: [2] Using package in category defaults (revised)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -fx -V -DC0 -DOneFile zzz.as
-- Version: Aldor version 1.1.12p2 for LINUX(glibc)
-- Original bug file name: zzz.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 08-MAY-2000
-- Aldor version 1.1.12p2 for LINUX(glibc) 
-- Subject: Using package in category defaults (revised)

-- The following bug demonstration consists of two files:
-- xxx.as:
--     Package  CxExpressionReader
--     Category CxPolynomialCategory
-- yyy.as:
--     Domain   TERMS
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
--: "yyy.as", line 41:         v:POL := variable("Z")$POL;
--:                    .................^
--: [L41 C18] #1 (Error) There is no suitable interpretation for the expression
variable$POL("Z")
--:   The context requires an expression of type POL.
--:      The possible types of the right hand side (`variable$POL("Z")') are:
--:           -- %
--: 
--: "yyy.as", line 42:         p:POL := "Y" :: POL;
--:                    ........................^
--: [L42 C25] #2 (Error) There are no suitable meanings for the operator
`coerce'.
--:    The possible types of the left hand side are:
--:           -- String
--: 
--:                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--:  Time    0.4 s  0  2  0  4  0  0  2  0  0  0 91  0  0  0  0  0  0  0 %
--: 
--:  Source  227 lines,  28978 lines per minute
--:  Store  1776 K pool
--: 
--: Totals:
--:  Time    0.5 s
--:  Source  227 lines,  25222 lines per minute
--:  Store  1776 K pool
--: 
--: Compilation exited abnormally with code 2 at Mon May  8 19:04:49




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
--     axiomxl -fx -DC0 -V -DOneFile zzz.as
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

define CxPolynomialCategory(
    T: with {variable: String -> %}
): Category == with {
        coerce: String -> %;
        variable: String -> %;
#if C0
    default {
        coerce(s: String): % == {
#if C1
                getExpression(s) $ CxExpressionReader(%, variable $ %);
#else
                getExpression(s) $ CxExpressionReader(%, variable);
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

TERMS: with {
        variable: String -> %;
} == add {
        Rep ==> String;
        variable(s: String): % == per s;
}

CxPolynomials(T: with {variable: String -> %}): CxPolynomialCategory(T) with {
} == add {
        Rep ==> String;
        import from Rep;
        variable(s: String): % == per s;
#if C0
#else
        coerce(s: String): % == {
#if C1
                getExpression(s) $ CxExpressionReader(%, variable $ %);
#else
                getExpression(s) $ CxExpressionReader(%, variable);
#endif
        }
#endif
}

POL == CxPolynomials(TERMS);
import from String, POL;

main():() == {
        print << "MAIN" << newline;
        v:POL := variable("Z")$POL;
        p:POL := "Y" :: POL;
}
main();
