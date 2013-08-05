--* From youssef@d0mino.fnal.gov  Sun Aug 27 20:41:16 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id UAA09435
--* 	for <ax-bugs@nag.co.uk>; Sun, 27 Aug 2000 20:41:15 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id OAA70102;
--* 	Sun, 27 Aug 2000 14:41:03 -0500 (CDT)
--* Date: Sun, 27 Aug 2000 14:41:03 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200008271941.OAA70102@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: bug5.as

--+ --
--+ -- Hi Martin:  
--+ --
--+ --   This domain is similar to "Object" in axllib.  If you compile with axiomxl -g interp,
--+ --   you get    
--+ --
--+ --       "Compiler bug...Bug: gen0Syme:  syme unallocated by gen0vars"
--+ --
--+ --   Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ mathcategory: with
--+     category: (Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B)) -> %
--+     value:    % -> (Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B))
--+ == add
--+     Rep ==> Record(Ob:Type,Mo:(Ob,Ob)->Category,Mr:(A:Ob,B:Ob)->Mo(A,B)); import from Rep
--+     
--+     category(Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B)):% == per [Object,Morphism,Mor]
--+     value(cat:%):(Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B)) == explode rep cat
--+     
--
-- Hi Martin:  
--
--   This domain is similar to "Object" in axllib.  If you compile with axiomxl -g interp,
--   you get    
--
--       "Compiler bug...Bug: gen0Syme:  syme unallocated by gen0vars"
--
--   Saul
--
#include "axllib"
#pile

mathcategory: with
    category: (Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B)) -> %
    value:    % -> (Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B))
== add
    Rep ==> Record(Ob:Type,Mo:(Ob,Ob)->Category,Mr:(A:Ob,B:Ob)->Mo(A,B)); import from Rep
    
    category(Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B)):% == per [Object,Morphism,Mor]
    value(cat:%):(Object:Type,Morphism:(Object,Object)->Category,Mor:(A:Object,B:Object)->Morphism(A,B)) == explode rep cat
    
