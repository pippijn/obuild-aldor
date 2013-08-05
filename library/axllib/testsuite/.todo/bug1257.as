--* From youssef@d0mino.fnal.gov  Thu Sep 21 08:33:46 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id IAA15607
--* 	for <ax-bugs@nag.co.uk>; Thu, 21 Sep 2000 08:33:44 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id CAA19861;
--* 	Thu, 21 Sep 2000 02:33:41 -0500 (CDT)
--* Date: Thu, 21 Sep 2000 02:33:41 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200009210733.CAA19861@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: multi.as

--+ --
--+ --  Hi Martin,
--+ --      There are some problems with multiple values.  Here's one for example.
--+ --
--+ --    Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ SI ==> SingleInteger
--+ 
--+ Multi == (A:SI,B:SI)
--+ 
--+ F(M:Multi):SI == A + B
--+   
--
--  Hi Martin,
--      There are some problems with multiple values.  Here's one for example.
--
--    Saul
--
#include "axllib"
#pile

SI ==> SingleInteger

Multi == (A:SI,B:SI)

F(M:Multi):SI == A + B
  
