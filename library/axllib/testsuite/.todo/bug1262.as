--* From youssef@d0mino.fnal.gov  Thu Oct 12 07:42:19 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id HAA12576
--* 	for <ax-bugs@nag.co.uk>; Thu, 12 Oct 2000 07:42:18 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id BAA98677;
--* 	Thu, 12 Oct 2000 01:42:19 -0500 (CDT)
--* Date: Thu, 12 Oct 2000 01:42:19 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200010120642.BAA98677@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: dependenttypebug.as

--+ --
--+ --  Hi Martin,  Here is another dependent type problem.  Compile this with
--+ --  axiomxl -g interp to see "Compiler bug...Bug: gen0syme: ..."
--+ --
--+ --    Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ FooType:Type == (A:Type,F:(a:A)->with) -> (b:A,F b)
--+ 
--
--  Hi Martin,  Here is another dependent type problem.  Compile this with
--  axiomxl -g interp to see "Compiler bug...Bug: gen0syme: ..."
--
--    Saul
--
#include "axllib"
#pile

FooType:Type == (A:Type,F:(a:A)->with) -> (b:A,F b)

