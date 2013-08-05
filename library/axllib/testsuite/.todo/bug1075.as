--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA01319; Tue, 30 Apr 96 17:03:04 BST
--* Received: from vinci.inf.ethz.ch (bronstei@vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id RAA01543 for <ax-bugs@nag.co.uk>; Tue, 30 Apr 1996 17:57:40 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id RAA06373 for ax-bugs@nag.co.uk; Tue, 30 Apr 1996 17:57:38 +0200
--* Date: Tue, 30 Apr 1996 17:57:38 +0200
--* Message-Id: <199604301557.RAA06373@vinci.inf.ethz.ch>
--* To: ax-bugs
--* Subject: [1] compile-time + run-time problems

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -q1 mytype.as mycat.as buggy.as
-- Version: 1.1.6
-- Original bug file name: badbug.as

------------------------------   badbug.as   ------------------------------
--
-- To reproduce this bug, you must extract the 3 files:
--         mytype.as     mycat.as   and  buggy.as
--
-- Compiling them on the same command line produces a compile-time error:
-- % axiomxl -q1 mytype.as mycat.as buggy.as
-- 
-- mytype.as:
-- 
-- mycat.as:
-- 
-- buggy.as:
-- "buggy.as", line 15: 
--                 for i in 1..m repeat basis := cons(g m, basis);
-- ..........................^
-- [L15 C27] #1 (Error) There are no suitable meanings for the operator `..'.
-- 
--
-- Compiling the 3 files separately does seem to work however,
-- but someone is producing bad code somewhere, because in the
-- instance when we ran into this, the resulting code seg faults in
-- some domain initialization function.
-- This explains the high priority -- on this bug.
--
------------------------------   mytype.as   ------------------------------
#include "axllib"

macro SI == SingleInteger;

MyType: with { f: % -> SI; g: SI -> % } == add {
	macro Rep == SI;
	import from Rep;

	f(a:%):SI == rep a;
	g(b:SI):% == per b;
}

------------------------   mycat.as   -----------------------
#include "axllib"

#library lib "mytype.ao"
import from lib;

macro SI == SingleInteger;

MyCat: Category == with {
	coerce:         MyType -> %;
	zero:		(SI, SI) -> %;
	default {
		coerce (v:MyType) : % == {
			import from SI;
			n := f v;
			zero(n, 1);
		}
	}
}

------------------------   buggy.as   -----------------------
#include "axllib"

#library lib1 "mytype.ao"
#library lib2 "mycat.ao"
import from lib1, lib2;

macro SI  == SingleInteger;

Foo(P:MyCat): with { foo: P -> List MyType } == add {
	foo(a:P):List MyType == {
		import from SI, MyType;
		basis:List MyType := empty();
		m := #basis;
		for i in 1..m repeat basis := cons(g m, basis);
		basis;
	}
}
