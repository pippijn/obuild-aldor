--* From youssef@d0mino.fnal.gov  Thu Aug 24 05:00:45 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id FAA00642
--* 	for <ax-bugs@nag.co.uk>; Thu, 24 Aug 2000 05:00:44 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id XAA26805;
--* 	Wed, 23 Aug 2000 23:00:43 -0500 (CDT)
--* Date: Wed, 23 Aug 2000 23:00:43 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200008240400.XAA26805@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: names.as

--+ --
--+ --  Here's an inconsistency if I understand the situation correctly.  
--+ --
--+ --  FooCat compiles without problems.  In FooCat2 and FooCat3, on the other hand,
--+ --  the compiler complains that it doesn't know if A():Name1 == add and
--+ --  A:Name1 == add are local or are supplying the signature.  However, it seems
--+ --  to me that A(x:SingleInteger):Name == add could be a local just as much as 
--+ --  the previous two.
--+ --
--+ --     Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define Name1:Category == with
--+ 
--+ define FooCat:Category == with 
--+     A:(x:SingleInteger) -> Name1
--+     default 
--+         A(x:SingleInteger):Name1 == add
--+ 	
--+ define FooCat2:Category == with
--+     A:() -> Name1
--+     default
--+         A():Name1 == add
--+ 
--+ define FooCat3:Category == with 
--+     A: Name1
--+     default 
--+         A:Name1 == add
--
--  Here's an inconsistency if I understand the situation correctly.  
--
--  FooCat compiles without problems.  In FooCat2 and FooCat3, on the other hand,
--  the compiler complains that it doesn't know if A():Name1 == add and
--  A:Name1 == add are local or are supplying the signature.  However, it seems
--  to me that A(x:SingleInteger):Name == add could be a local just as much as 
--  the previous two.
--
--     Saul
--
#include "axllib"
#pile

define Name1:Category == with

define FooCat:Category == with 
    A:(x:SingleInteger) -> Name1
    default 
        A(x:SingleInteger):Name1 == add
	
define FooCat2:Category == with
    A:() -> Name1
    default
        A():Name1 == add

define FooCat3:Category == with 
    A: Name1
    default 
        A:Name1 == add
