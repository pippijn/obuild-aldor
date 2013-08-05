--* From youssef@d0mino.fnal.gov  Thu Aug 24 07:08:15 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id HAA01515
--* 	for <ax-bugs@nag.co.uk>; Thu, 24 Aug 2000 07:08:13 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id BAA00537;
--* 	Thu, 24 Aug 2000 01:08:13 -0500 (CDT)
--* Date: Thu, 24 Aug 2000 01:08:13 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200008240608.BAA00537@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: catproblem.as

--+ --
--+ -- Hi Martin.  Here's another problem seemingly related to category
--+ --   valued constants in a category.  Do axiomxl -g interp to get a 
--+ --  core dump.   Saul 
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define FooCat:Category == with
--+     Bar:Category == with
--+     D:Bar == add
--+ 
--+ 
--
-- Hi Martin.  Here's another problem seemingly related to category
--   valued constants in a category.  Do axiomxl -g interp to get a 
--  core dump.   Saul 
--
#include "axllib"
#pile

define FooCat:Category == with
    Bar:Category == with
    D:Bar == add


