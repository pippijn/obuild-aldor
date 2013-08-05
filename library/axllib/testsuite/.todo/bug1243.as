--* From youssef@d0lxbld1.fnal.gov  Wed Aug 23 00:49:13 2000
--* Received: from d0lxbld1.fnal.gov (d0lxbld1.fnal.gov [131.225.225.15])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id AAA15142
--* 	for <ax-bugs@nag.co.uk>; Wed, 23 Aug 2000 00:49:12 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0lxbld1.fnal.gov (8.9.3/8.9.3) id SAA09447
--* 	for ax-bugs@nag.co.uk; Tue, 22 Aug 2000 18:49:14 -0500
--* Date: Tue, 22 Aug 2000 18:49:14 -0500
--* From: Saul Youssef <youssef@fnal.gov>
--* Message-Id: <200008222349.SAA09447@d0lxbld1.fnal.gov>
--* To: ax-bugs@nag.co.uk
--* Subject: [6] default domain not recognized

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.12p6
-- Original bug file name: defaults2.as

--+ --
--+ --  Hi Martin.  This default is recognized for some reason.  Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define Foo:Category == with
--+     RingDomain: Ring
--+     default
--+         RingDomain: Ring == SingleInteger add
--+ 
--
--  Hi Martin.  This default is recognized for some reason.  Saul
--
#include "axllib"
#pile

define Foo:Category == with
    RingDomain: Ring
    default
        RingDomain: Ring == SingleInteger add

