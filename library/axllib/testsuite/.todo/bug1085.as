--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA08911; Thu, 6 Jun 96 11:15:26 BST
--* Received: from vinci.inf.ethz.ch (bronstei@vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id MAA10670 for <ax-bugs@nag.co.uk>; Thu, 6 Jun 1996 12:09:57 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id MAA24023 for ax-bugs@nag.co.uk; Thu, 6 Jun 1996 12:09:52 +0200
--* Date: Thu, 6 Jun 1996 12:09:52 +0200
--* Message-Id: <199606061009.MAA24023@vinci.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [2] dependent types strike in code generation too

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -fc -q1 case72.as
-- Version: 1.1.6
-- Original bug file name: case72.as

----------------------------- case72.as ---------------------------
--
-- The explode1/bang0 workaround to bug1082 allows me to produce
-- foam code, but not C code...
--
-- % axiomxl -fc -q1 base72.as
-- Compiler bug...Bug: Bad case 72 (line 2074 in file ../src/genc.c).
--

#include "axllib"

macro REC == Record(S:BasicType, L:List S);

explode1(r:REC):(T:BasicType, L:List T) == {
	(x, y) := explode r;
	(x, y);
}

foo(r:REC):() == foo0(explode1 r);

foo0(S:BasicType, l:List S):() == print << l;
