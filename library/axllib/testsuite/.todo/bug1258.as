--* From youssef@d0mino.fnal.gov  Thu Sep 21 08:34:26 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id IAA15676
--* 	for <ax-bugs@nag.co.uk>; Thu, 21 Sep 2000 08:34:24 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id CAA20530;
--* 	Thu, 21 Sep 2000 02:34:24 -0500 (CDT)
--* Date: Thu, 21 Sep 2000 02:34:24 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200009210734.CAA20530@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: multi2.as

--+ 
--+ #include "axllib"
--+ #pile
--+ 
--+ Foo == (A:Type,F:A->Category)
--+ 
--+ define FooCat(X:Foo):Category == with
--+ 

#include "axllib"
#pile

Foo == (A:Type,F:A->Category)

define FooCat(X:Foo):Category == with

