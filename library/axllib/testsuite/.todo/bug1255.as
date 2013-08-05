--* From youssef@d0mino.fnal.gov  Sat Sep 16 05:29:49 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id FAA05295
--* 	for <ax-bugs@nag.co.uk>; Sat, 16 Sep 2000 05:29:48 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id XAA09252;
--* 	Fri, 15 Sep 2000 23:29:46 -0500 (CDT)
--* Date: Fri, 15 Sep 2000 23:29:46 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200009160429.XAA09252@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: domains.as

--+ --
--+ -- Hi Martin,
--+ --     This seems to be an importation problem.  With axiomxl -g interp,
--+ -- the compiler claims that there are 2 meanings for "Mor".  Also, I 
--+ -- haven't been able to make foo:%->% visible when it's inside another
--+ -- domain like RngCategory.
--+ --   Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define MathCat(Obj:Type,Morphism:Obj->Category):Category == with
--+     Mor: (A:Obj) -> Morphism(A) with
--+     
--+ define Rng:Category == with { foo: % -> % }
--+ 
--+ define RngMorphism(A:Rng):Category == Rng 
--+ 
--+ RngCategory:MathCat(Rng,RngMorphism) == add
--+     Mor(A:Rng):RngMorphism A with == add
--+         foo(x:%):% == x  
--+ 
--+ import from RngCategory
--+ 
--+ (A:Rng,x:Mor A):() +-> foo( x )
--
-- Hi Martin,
--     This seems to be an importation problem.  With axiomxl -g interp,
-- the compiler claims that there are 2 meanings for "Mor".  Also, I 
-- haven't been able to make foo:%->% visible when it's inside another
-- domain like RngCategory.
--   Saul
--
#include "axllib"
#pile

define MathCat(Obj:Type,Morphism:Obj->Category):Category == with
    Mor: (A:Obj) -> Morphism(A) with
    
define Rng:Category == with { foo: % -> % }

define RngMorphism(A:Rng):Category == Rng 

RngCategory:MathCat(Rng,RngMorphism) == add
    Mor(A:Rng):RngMorphism A with == add
        foo(x:%):% == x  

import from RngCategory

(A:Rng,x:Mor A):() +-> foo( x )
