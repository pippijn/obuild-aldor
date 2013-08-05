--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA12352; Wed, 24 Apr 96 17:04:31 BST
--* Received: from ru7.inf.ethz.ch (bronstei@ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id RAA21752 for <ax-bugs@nag.co.uk>; Wed, 24 Apr 1996 17:59:20 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id RAA13972 for ax-bugs@nag.co.uk; Wed, 24 Apr 1996 17:59:19 +0200
--* Date: Wed, 24 Apr 1996 17:59:19 +0200
--* Message-Id: <199604241559.RAA13972@ru7.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [6] default argument oddity

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.6
-- Original bug file name: baddef.as

---------------------- baddef.as ---------------
--
-- This compiles fine if both categories are in the same file.
-- If however we break this into baddef.as and baddef2.as, then
-- we get "Default arguments strike again!"
-- Note that the bug disappears if the line
--	default foo(a:Z, n:Z):Z == a + n;
-- is replaced by
--	default foo(a:Z, n:Z == 0):Z == a + n;
-- but it would be very inconvenient if the default parameter values have
-- to be repeated for each implementation of an exported function. If that
-- is required, why does it work ok in a single file?
--
-- % axiomxl baddef.as
-- % axiomxl -m2 baddef2.as
-- "baddef2.as", line 11:         default bar(m:Z):Z == foo m;
--                        ..................................^
-- [L11 C35] #1 (Error) Argument 1 of `foo' did not match any possible parameter type.
--     The rejected type is SingleInteger.
--     Expected type a: SingleInteger, n: SingleInteger.
--


#include "axllib"

macro Z == SingleInteger;

Foo:Category == with {
	foo: (Z, n:Z == 0) -> Z;
	default foo(a:Z, n:Z):Z == a + n;
};


---------------------- baddef2.as ---------------
#include "axllib"

#library bad "baddef.ao"
import from bad;

macro Z == SingleInteger;

Bar:Category == Foo with {
	bar: Z -> Z;
	default bar(m:Z):Z == foo m;
}

