--* From youssef@d0mino.fnal.gov  Fri Aug 25 23:02:28 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id XAA25491
--* 	for <ax-bugs@nag.co.uk>; Fri, 25 Aug 2000 23:02:26 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id RAA43357;
--* 	Fri, 25 Aug 2000 17:02:24 -0500 (CDT)
--* Date: Fri, 25 Aug 2000 17:02:24 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200008252202.RAA43357@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: defaults3.as

--+ --
--+ --  This core dumps (axiomxl -g interp) in 1.1.12p6 with traceback:
--+ --
--+ --    otTransferFoamInfoToSyme()
--+ --    otTransferFoamInfo()
--+ --    libPutSymes()
--+ --    emitTheIntermed()
--+ --    compPhaseSave()
--+ --    compSourceFile()
--+ --    compFilesLoop()
--+ --    compCmd()
--+ --    main()
--+ --
--+ --  Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define FooCategory(Object:Type,Cat:Category):Category == with
--+     Foo: Object -> Cat with
--+              f: % -> %
--+ 	     default
--+ 	         f(x:%):% == error " "
--
--  This core dumps (axiomxl -g interp) in 1.1.12p6 with traceback:
--
--    otTransferFoamInfoToSyme()
--    otTransferFoamInfo()
--    libPutSymes()
--    emitTheIntermed()
--    compPhaseSave()
--    compSourceFile()
--    compFilesLoop()
--    compCmd()
--    main()
--
--  Saul
--
#include "axllib"
#pile

define FooCategory(Object:Type,Cat:Category):Category == with
    Foo: Object -> Cat with
             f: % -> %
	     default
	         f(x:%):% == error " "
