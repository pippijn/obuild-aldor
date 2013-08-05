--* From youssef@d0lxbld1.fnal.gov  Mon Aug 21 17:37:18 2000
--* Received: from d0lxbld1.fnal.gov (d0lxbld1.fnal.gov [131.225.225.15])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA28103
--* 	for <ax-bugs@nag.co.uk>; Mon, 21 Aug 2000 17:37:16 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0lxbld1.fnal.gov (8.9.3/8.9.3) id LAA04669
--* 	for ax-bugs@nag.co.uk; Mon, 21 Aug 2000 11:37:16 -0500
--* Date: Mon, 21 Aug 2000 11:37:16 -0500
--* From: Saul Youssef <youssef@fnal.gov>
--* Message-Id: <200008211637.LAA04669@d0lxbld1.fnal.gov>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] Cross problem causing compiler core dump

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


