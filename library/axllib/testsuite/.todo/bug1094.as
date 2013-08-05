--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA03325; Thu, 22 Aug 96 10:49:21 BST
--* Received: from ru8.inf.ethz.ch (bronstei@ru8.inf.ethz.ch [129.132.12.17]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id LAA04395 for <ax-bugs@nag.co.uk>; Thu, 22 Aug 1996 11:43:19 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (from bronstei@localhost) by ru8.inf.ethz.ch (8.7.1/8.7.1) id LAA06259 for ax-bugs@nag.co.uk; Thu, 22 Aug 1996 11:43:16 +0200 (MET DST)
--* Date: Thu, 22 Aug 1996 11:43:16 +0200 (MET DST)
--* Message-Id: <199608220943.LAA06259@ru8.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [4] compile time seg fault

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.7 (Solaris)
-- Original bug file name: segfault.as

----------------------------- segfault.as ---------------------------
--
-- This is a result of fix1085: this now seg faults during the .as to .ao phase
-- (1.1.7 for Solaris)
--
-- % axiomxl segfault.as
-- Program fault (segmentation violation).#1 (Error) Program fault (segmentation violation).

#include "axllib"

macro REC == Record(S:BasicType, L:List S);

explode1(r:REC):(T:BasicType, L:List T) == {
	(x, y) := explode r;
	(x, y);
}

foo(r:REC):() == foo0(explode1 r);

foo0(S:BasicType, l:List S):() == print << l;
