--* From youssef@d0lxbld1.fnal.gov  Mon Aug 21 17:42:19 2000
--* Received: from d0lxbld1.fnal.gov (d0lxbld1.fnal.gov [131.225.225.15])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA28239
--* 	for <ax-bugs@nag.co.uk>; Mon, 21 Aug 2000 17:42:16 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0lxbld1.fnal.gov (8.9.3/8.9.3) id LAA04694
--* 	for ax-bugs@nag.co.uk; Mon, 21 Aug 2000 11:42:14 -0500
--* Date: Mon, 21 Aug 2000 11:42:14 -0500
--* From: Saul Youssef <youssef@fnal.gov>
--* Message-Id: <200008211642.LAA04694@d0lxbld1.fnal.gov>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] Problem with Category valued domain constants

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: catprob.as

--+ --
--+ -- Problem with category constants in a domain
--+ --
--+ --  Do % axiomxl -g interp bug.as to reproduce the problem. S.Y.
--+ --  The compiler complains that the Dom:Cat signature is missing.
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define FooCat:Category == with
--+     Cat: Category
--+     Dom: Cat
--+     
--+ define FooCat2:Category == with
--+     foo: () -> SingleInteger
--+     
--+ FooDom:FooCat == add
--+     Cat:Category == FooCat2
--+     Dom:Cat == add
--+        foo():SingleInteger == 5
--+     
--
-- Problem with category constants in a domain
--
--  Do % axiomxl -g interp bug.as to reproduce the problem. S.Y.
--  The compiler complains that the Dom:Cat signature is missing.
--
#include "axllib"
#pile

define FooCat:Category == with
    Cat: Category
    Dom: Cat
    
define FooCat2:Category == with
    foo: () -> SingleInteger
    
FooDom:FooCat == add
    Cat:Category == FooCat2
    Dom:Cat == add
       foo():SingleInteger == 5
    
