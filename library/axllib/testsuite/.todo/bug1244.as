--* From youssef@d0mino.fnal.gov  Thu Aug 24 04:57:04 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id EAA00530
--* 	for <ax-bugs@nag.co.uk>; Thu, 24 Aug 2000 04:57:03 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id WAA99461;
--* 	Wed, 23 Aug 2000 22:56:54 -0500 (CDT)
--* Date: Wed, 23 Aug 2000 22:56:54 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200008240356.WAA99461@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: category_args.as

--+ --
--+ --  Hi Martin, 
--+ --    
--+ --     Here is a pretty fundamental problem.  It seems to me that 
--+ --  TestCat1(FooCat,BarCat) and TestCat2(FooCat) below should be Type-equal.  
--+ --  The mystery is that Dom1 below compiles but Dom2 fails with the message:
--+ --
--+ --     "The domain is missing some exports.
--+ --        Missing D: Join(A, BarCat) with "
--+ --
--+ --  This looks like it might be a bug of some sort.
--+ --
--+ --   Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define FooCat:Category == with 
--+     +:(%,%) -> %
--+     
--+ define BarCat:Category == with
--+     *:(%,%) -> %
--+    
--+ define TestCat1(A:Category,B:Category):Category == with
--+     D:A with B
--+ 
--+ define TestCat2(A:Category):Category == with
--+     D:A with BarCat
--+  
--+ Dom1:TestCat1(FooCat,BarCat) == add
--+     D:FooCat with BarCat == add 
--+         (x:%)+(y:%):% == error " " 
--+ 	(x:%)*(y:%):% == error " "  
--+     
--+ Dom2:TestCat2(FooCat) == add
--+     D:FooCat with BarCat == add
--+         (x:%)+(y:%):% == error " "
--+ 	(x:%)*(y:%):% == error " "
--
--  Hi Martin, 
--    
--     Here is a pretty fundamental problem.  It seems to me that 
--  TestCat1(FooCat,BarCat) and TestCat2(FooCat) below should be Type-equal.  
--  The mystery is that Dom1 below compiles but Dom2 fails with the message:
--
--     "The domain is missing some exports.
--        Missing D: Join(A, BarCat) with "
--
--  This looks like it might be a bug of some sort.
--
--   Saul
--
#include "axllib"
#pile

define FooCat:Category == with 
    +:(%,%) -> %
    
define BarCat:Category == with
    *:(%,%) -> %
   
define TestCat1(A:Category,B:Category):Category == with
    D:A with B

define TestCat2(A:Category):Category == with
    D:A with BarCat
 
Dom1:TestCat1(FooCat,BarCat) == add
    D:FooCat with BarCat == add 
        (x:%)+(y:%):% == error " " 
	(x:%)*(y:%):% == error " "  
    
Dom2:TestCat2(FooCat) == add
    D:FooCat with BarCat == add
        (x:%)+(y:%):% == error " "
	(x:%)*(y:%):% == error " "
