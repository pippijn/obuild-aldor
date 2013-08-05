--* From Manuel.Bronstein@sophia.inria.fr  Tue Jul 27 15:24:33 1999
--* Received: from droopix.inria.fr (IDENT:root@droopix.inria.fr [138.96.111.4])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA13352
--* 	for <ax-bugs@nag.co.uk>; Tue, 27 Jul 1999 15:24:18 +0100 (BST)
--* Received: by droopix.inria.fr (8.8.8/8.8.5) id QAA32555 for ax-bugs@nag.co.uk; Tue, 27 Jul 1999 16:19:54 +0200
--* Date: Tue, 27 Jul 1999 16:19:54 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <199907271419.QAA32555@droopix.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [3] dissemble wrong on 64-bit machines

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -ginterp dissemble.as
-- Version: 1.1.12
-- Original bug file name: dissemble.as

-------------------------- dissemble.as ------------------------
--
-- The pair dissemble/assemble works ok on 32-bit machines
-- but produces wrong SingleInteger's on 64-bit machines:
--
-- On a 32-bit linux box:
-- % axiomxl -ginterp dissemble.as 
-- 1
-- -1
--
-- On a 64-bit DEC:
-- % axiomxl -ginterp dissemble.as 
-- 4294967297
-- 4294967295
--
-- That's not the correct exponent anymore!
--

#include "axllib"

import from Machine, SingleFloat, SingleInteger;

a := -0.5;
(sgn,exp,mant) := dissemble(a pretend SFlo);
print << sgn::SingleInteger << newline << exp::SingleInteger << newline;

