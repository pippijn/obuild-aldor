--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA09220; Thu, 6 Jun 96 12:21:22 BST
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id NAA19825 for <ax-bugs@nag.co.uk>; Thu, 6 Jun 1996 13:15:35 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id NAA15035 for ax-bugs@nag.co.uk; Thu, 6 Jun 1996 13:15:34 +0200
--* Date: Thu, 6 Jun 1996 13:15:34 +0200
--* Message-Id: <199606061115.NAA15035@ru7.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [7] 'local' affects the type inference

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.6
-- Original bug file name: local.as

----------------------------- local.as ---------------------------
--
-- Looks like the word 'local' affects the type inference!
--

#include "axllib"

macro REC == Record(S:BasicType, L:List S);

-- compiles ok if the word 'local' is removed
local explode1(r:REC):(T:BasicType, L:List T) == {
	(x, y) := explode r;
	(x, y);
}

foo(r:REC):() == foo0(explode1 r);
foo0(S:BasicType, l:List S):() == print << l;
