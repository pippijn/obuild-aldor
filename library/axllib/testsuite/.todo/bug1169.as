--* From Manuel.Bronstein@sophia.inria.fr  Tue Oct  5 15:36:48 1999
--* Received: from nirvana.inria.fr (IDENT:root@nirvana.inria.fr [138.96.48.30])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA23993
--* 	for <ax-bugs@nag.co.uk>; Tue, 5 Oct 1999 15:36:44 +0100 (BST)
--* Received: by nirvana.inria.fr (8.8.8/8.8.5) id QAA23038 for ax-bugs@nag.co.uk; Tue, 5 Oct 1999 16:32:51 +0200
--* Date: Tue, 5 Oct 1999 16:32:51 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <199910051432.QAA23038@nirvana.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [3] symbolic parameter in signature significant?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.11e
-- Original bug file name: param.as

--------------------------- param.as ---------------------------
--
-- "param.as", line 16: extend Integer:Foo == add {
--                      ......................^
-- [L16 C23] #1 (Error) The domain is missing some exports.
--         Missing foo: (R: Ring) -> R
--
--

#include "axllib"

define Foo:Category == with {
	foo: (R:Ring) -> R;
}

extend Integer:Foo == add {
	-- DOES NOT COMPILE UNLESS 'F' IS REPLACED BY 'R'
	foo(F:Ring):F == 1;
}

