--* From youssef@d0lxbld1.fnal.gov  Mon Aug 21 17:43:54 2000
--* Received: from d0lxbld1.fnal.gov (d0lxbld1.fnal.gov [131.225.225.15])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA28313
--* 	for <ax-bugs@nag.co.uk>; Mon, 21 Aug 2000 17:43:52 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0lxbld1.fnal.gov (8.9.3/8.9.3) id LAA04709
--* 	for ax-bugs@nag.co.uk; Mon, 21 Aug 2000 11:43:48 -0500
--* Date: Mon, 21 Aug 2000 11:43:48 -0500
--* From: Saul Youssef <youssef@fnal.gov>
--* Message-Id: <200008211643.LAA04709@d0lxbld1.fnal.gov>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] Problem with (XXX$%)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: domains.as

--+ --
--+ --  I suspect but am not 100% sure that this is supposed to work.
--+ --  If you do axiomxl -g interp it does not understand (Domain$%) as
--+ --  a type expression.
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define FooCat(A:Category):Category == with
--+     Domain:   A
--+     CoDomain: A
--+    
--+ define BarCat(A:Category):Category == FooCat A with
--+     apply: (%,(Domain$%)) -> (CoDomain$%)
--+ 
--
--  I suspect but am not 100% sure that this is supposed to work.
--  If you do axiomxl -g interp it does not understand (Domain$%) as
--  a type expression.
--
#include "axllib"
#pile

define FooCat(A:Category):Category == with
    Domain:   A
    CoDomain: A
   
define BarCat(A:Category):Category == FooCat A with
    apply: (%,(Domain$%)) -> (CoDomain$%)

