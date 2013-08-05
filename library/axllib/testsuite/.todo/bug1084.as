--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA08763; Thu, 6 Jun 96 10:47:37 BST
--* Received: from vinci.inf.ethz.ch (bronstei@vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id LAA06970 for <ax-bugs@nag.co.uk>; Thu, 6 Jun 1996 11:41:58 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id LAA23909 for ax-bugs@nag.co.uk; Thu, 6 Jun 1996 11:41:53 +0200
--* Date: Thu, 6 Jun 1996 11:41:53 +0200
--* Message-Id: <199606060941.LAA23909@vinci.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [7] Bug: gen0Syme:  syme unallocated by gen0Vars

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.6
-- Original bug file name: symebug.as

----------------------------- symebug.as ---------------------------
--
-- I guess this is due to the fact that r.S is not a constant
-- The foo0/explode1 workaround to bug 1082 works in this case,
-- so this is a minor bug: the compiler shouldn't die like this:
--
-- % axiomxl symebug.as
-- Compiler bug...Bug: gen0Syme:  syme unallocated by gen0Vars
--

#include "axllib"

macro REC == Record(S:BasicType, L:List S);

foo(r:REC):()=={
	import from List(r.S);
	print << r.L;
}

