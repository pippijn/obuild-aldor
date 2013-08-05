--* From Manuel.Bronstein@sophia.inria.fr  Wed Mar 24 21:26:46 1999
--* Received: from nirvana.inria.fr (bmanuel@nirvana.inria.fr [138.96.48.30])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id VAA03224 for <ax-bugs@nag.co.uk>; Wed, 24 Mar 1999 21:26:45 GMT
--* Received: by nirvana.inria.fr (8.8.8/8.8.5) id WAA05128 for ax-bugs@nag.co.uk; Wed, 24 Mar 1999 22:26:31 +0100
--* Date: Wed, 24 Mar 1999 22:26:31 +0100
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <199903242126.WAA05128@nirvana.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] cyclic cat def gives infinite loop at compile time

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12
-- Original bug file name: infloop.as

------------------- infloop.as -----------------------
--
-- This cutie causes the compiler to overflow the stack
--
#include "axllib"

-- This code is wrong all right, but crash the compiler?
define Foo: Category == Join(BasicType, Foo);

