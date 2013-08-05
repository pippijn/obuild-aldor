--* From Manuel.Bronstein@sophia.inria.fr  Thu Jul 20 11:53:08 2000
--* Received: from droopix.inria.fr (droopix.inria.fr [138.96.111.4])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id LAA20378
--* 	for <ax-bugs@nag.co.uk>; Thu, 20 Jul 2000 11:53:07 +0100 (BST)
--* Received: by droopix.inria.fr (8.10.0/8.10.0) id e6KAqbR25855 for ax-bugs@nag.co.uk; Thu, 20 Jul 2000 12:52:37 +0200
--* Date: Thu, 20 Jul 2000 12:52:37 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <200007201052.e6KAqbR25855@droopix.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [5] type inference gets really confused

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p6
-- Original bug file name: tuptype.as

------------------------------- tuptype.as ----------------------------------
--
-- % axiomxl -m2 -mno-mactext tuptype.as 
-- "tuptype.as", line 4: Foo(T:Tuple Type): with { foo: Record T -> % } == add {
--                       ..................................................^
-- [L4 C51] #3 (Error) The domain is missing some exports.
--         Missing foo: Record(T) -> %
-- 
-- "tuptype.as", line 7:         foo(r:Record T):% == per(r pretend Pointer);
--                       ............^...........^
-- [L7 C13] #2 (Error) Have determined 1 possible types for the expression.
--         Meaning 1: (r: Record(T)) -> %
--   The context requires an expression of type (r: Record(T)) -> %.
-- [L7 C25] #1 (Error) No meaning for identifier `%'.
--

#include "axllib"

Foo(T:Tuple Type): with { foo: Record T -> % } == add {
	macro Rep == Pointer;

	foo(r:Record T):% == per(r pretend Pointer);
}
