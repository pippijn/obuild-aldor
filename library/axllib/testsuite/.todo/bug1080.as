--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA05700; Mon, 20 May 96 10:35:30 BST
--* Received: from vinci.inf.ethz.ch (bronstei@vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id LAA21295 for <ax-bugs@nag.co.uk>; Mon, 20 May 1996 11:30:01 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id LAA00667 for ax-bugs@nag.co.uk; Mon, 20 May 1996 11:30:00 +0200
--* Date: Mon, 20 May 1996 11:30:00 +0200
--* Message-Id: <199605200930.LAA00667@vinci.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [7] compile-time "Bad case 9" error

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.6
-- Original bug file name: badcase9.as

--------------------------- badcase9.as ----------------------------
--
-- If a function returns a tuple, I cannot assign its result
-- to a tuple if one of the assignments is in fact a set!(...) call.
-- It may well be illegal, but the compiler dies ungracefully:
--
--   "badcase9.as", line 20 char 6Compiler bug...Bug: Bad case 9 (line 1631 in file ../src/absyn.c).
--
--

#include "axllib"

macro Z == SingleInteger;

f(n:Z):(Z, Z) == (n, n);

import from Z, Array Z;

a := [1,2,3];
(b, a.2) := f 4;
