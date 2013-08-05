--* From youssef@d0mino.fnal.gov  Sun Sep 24 06:22:24 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id GAA08954
--* 	for <ax-bugs@nag.co.uk>; Sun, 24 Sep 2000 06:22:18 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id AAA39763;
--* 	Sun, 24 Sep 2000 00:22:14 -0500 (CDT)
--* Date: Sun, 24 Sep 2000 00:22:14 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200009240522.AAA39763@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: object.as

--+ --
--+ --  Hi Martin,
--+ --      Now I'm getting pretty confused.  I've been having some trouble with "Object"-like
--+ --  Domains but then I noticed that Stephen's Object example from the Aldor library from
--+ --  his Sophia Antipolis (June 15,2000) talk doesn't compile.  Am I missing something?
--+ --  I'd check if this really is the "Object" code in axllib, but I don't have the source
--+ --  code.
--+ --      Am I missing something?  Could I have a look at the code for "Object" in Axllib?
--+ --   Saul
--+ --
--+ --  compile the following (1.1.12p6) with axiomxl -g interp to get an error starting:
--+ --
--+ --  "#1 (Error) (After Macro Expansion) There are 2 meaning for 'T' this context...
--+ --
--+ 
--+ #include "axllib"
--+ #pile
--+     
--+ Object2(C:Category):with 
--+     object:  (T:C,T) -> %
--+     avail:   % -> (T:C,T)
--+ == add
--+     Rep ==> Record(T:C,val:T); import from Rep
--+     
--+     object(T:C,t:T):% == per [T,t]
--+     avail(ob:%):(T:C,T) == explode rep ob
--+     
--
--  Hi Martin,
--      Now I'm getting pretty confused.  I've been having some trouble with "Object"-like
--  Domains but then I noticed that Stephen's Object example from the Aldor library from
--  his Sophia Antipolis (June 15,2000) talk doesn't compile.  Am I missing something?
--  I'd check if this really is the "Object" code in axllib, but I don't have the source
--  code.
--      Am I missing something?  Could I have a look at the code for "Object" in Axllib?
--   Saul
--
--  compile the following (1.1.12p6) with axiomxl -g interp to get an error starting:
--
--  "#1 (Error) (After Macro Expansion) There are 2 meaning for 'T' this context...
--

#include "axllib"
#pile
    
Object2(C:Category):with 
    object:  (T:C,T) -> %
    avail:   % -> (T:C,T)
== add
    Rep ==> Record(T:C,val:T); import from Rep
    
    object(T:C,t:T):% == per [T,t]
    avail(ob:%):(T:C,T) == explode rep ob
    
