--* From youssef@d0mino.fnal.gov  Mon Aug 21 17:23:31 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA27927
--* 	for <ax-bugs@nag.co.uk>; Mon, 21 Aug 2000 17:23:29 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id LAA09373;
--* 	Mon, 21 Aug 2000 11:23:15 -0500 (CDT)
--* Date: Mon, 21 Aug 2000 11:23:15 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200008211623.LAA09373@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: cross.as

--+ --
--+ -- Hi.  This causes the compiler to core dump (axiomxl -g interp).  If you
--+ --    change the variable "C" to "A", it compiles so this is probably 
--+ --    interference with the external C language domain in axllib.  Saul 
--+ --
--+ 
--+ #include "axllib"
--+ 
--+ Foo:Cross(C:Category,X:C) == (Ring,Integer)
--+ 
--+ 
--
-- Hi.  This causes the compiler to core dump (axiomxl -g interp).  If you
--    change the variable "C" to "A", it compiles so this is probably 
--    interference with the external C language domain in axllib.  Saul 
--

#include "axllib"

Foo:Cross(C:Category,X:C) == (Ring,Integer)


