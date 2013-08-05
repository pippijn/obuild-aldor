--* From bronstei@inf.ethz.ch  Wed Jul  2 16:01:32 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA13363; Wed, 2 Jul 97 16:01:32 +0100
--* Received: from inf.ethz.ch (root@neptune.ethz.ch [129.132.10.10])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with SMTP
--* 	  id QAA00482 for <ax-bugs@nag.co.uk>; Wed, 2 Jul 1997 16:03:57 +0100 (BST)
--* Received: from ru8.inf.ethz.ch (bronstei@ru8.inf.ethz.ch [129.132.12.17]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id RAA28386 for <ax-bugs@nag.co.uk>; Wed, 2 Jul 1997 17:02:28 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (from bronstei@localhost) by ru8.inf.ethz.ch (8.8.4/8.7.1) id RAA05881 for ax-bugs@nag.co.uk; Wed, 2 Jul 1997 17:02:27 +0200 (MET DST)
--* Date: Wed, 2 Jul 1997 17:02:27 +0200 (MET DST)
--* Message-Id: <199707021502.RAA05881@ru8.inf.ethz.ch>
--* To: ax-bugs@nag.co.uk
--* Subject: [1] compile-time error with .al archive

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl buglib.as
-- Version: 1.1.9
-- Original bug file name: buglib.as

--------------------------- buglib.as --------------------------
--
-- YOU NEED libfoo.al TO REPRODUCE THIS BUG.
-- IF YOU DO
--        ar xv libfoo.al holonom.ao
--        ar dv libfoo.al holonom.ao
-- AND UNCOMMENT THE 3 LINES MENTIONED BELOW, THEN IT COMPILES OK!
--
-- % axiomxl -m2 -mno-mactext buglib.as
-- % "buglib.as", line 42: E := D::EQ;
-- %                       ........^
-- % [L42 C15] #1 (Error) (After Macro Expansion) There are no suitable meanings
-- % for the operator `coerce'.
-- %    The possible types of the left hand side are:
-- %        -- LinearOrdinaryDifferentialOperator(DenseUnivariatePolynomial(I...
-- % Expanded expression was: HolonomicEquation(Integer,
-- % DenseUnivariatePolynomial(Integer, "x"),
-- % LinearOrdinaryDifferentialOperator(DenseUnivariatePolynomial(Integer,"x"),
-- %                                    "D"))

#assert NImportBoolean
#assert NImportString

#include "axllib"

#library foo "libfoo.al"
import from foo;
inline from foo;

import from Boolean, String;

-- COMPILES OK IF holonom.ao IS EXTRACTED AND REMOVED FROM libfoo.al
-- AND IF THE NEXT 3 LINES ARE UNCOMMENTED
-- #library holo "holonom.ao"
-- import from holo;
-- inline from holo;

macro {
	Z == Integer;
	ZX == DenseUnivariatePolynomial(Z, "x");
	ZXD == LinearOrdinaryDifferentialOperator(ZX, "D");
	EQ == HolonomicEquation(Z, ZX, ZXD);
}

import from ZXD, EQ;
D := monom;
E := D::EQ;
