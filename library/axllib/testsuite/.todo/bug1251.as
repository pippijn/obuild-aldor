--* From youssef@d0mino.fnal.gov  Wed Sep  6 01:44:14 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id BAA18157
--* 	for <ax-bugs@nag.co.uk>; Wed, 6 Sep 2000 01:44:10 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id TAA25569;
--* 	Tue, 5 Sep 2000 19:43:59 -0500 (CDT)
--* Date: Tue, 5 Sep 2000 19:43:59 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200009060043.TAA25569@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: bug.as

--+ --
--+ -- Hi Martin,
--+ --
--+ --    This is a simplified version of one of my attempts at a Functor.  axiomxl -g interp core 
--+ -- dumps on "functor(SingleInteger,SingleIntger,Fun,f)".  A curious aspect of this one, is if you
--+ -- remove the last statement and compile, you get a warning:
--+ --
--+ --  "Function returns a domain that might not be constant (which may cause problems if it is 
--+ --   used in a dependent type)."
--+ --
--+ -- adding the last statement causes this message to disappear (why, I don't know).  It seems to me
--+ -- that all Domains are constant in this example, however.
--+ --
--+ --    If you have any clue about what is going wrong here, I would be very interested.
--+ --
--+ --    Saul 
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ Functor(Obj:Type,Mc:(Obj,Obj)->Category,Md:(A:Obj,B:Obj)->Mc(A,B),_
--+         Fo:Obj->Obj,Fm:(A:Obj,B:Obj,Md(A,B))->Md(Fo A,Fo B)): with
--+     apply: (%,Obj)->Obj
--+     functor: (A:Obj,B:Obj,F:%,Md(A,B))->Md(F A,F B)
--+     functor: %
--+ == add
--+     Rep ==> SingleInteger; import from Rep
--+     apply(F:%,A:Obj):Obj == Fo A
--+     functor(A:Obj,B:Obj,F:%,f:Md(A,B)):Md(F A,F B) == error " "
--+     functor:% == per 0
--+ 
--+ Fo(A:Ring):Ring == A
--+ 
--+ define MorCat(A:Ring,B:Ring):Category == with { sample: % }
--+ 
--+ Mor(A:Ring,B:Ring):MorCat(A,B)
--+ == add
--+    Rep ==> SingleInteger;  import from Rep
--+    sample:% == per 0
--+ 
--+ Fm(A:Ring,B:Ring,f:Mor(A,B)):Mor(Fo A,Fo B) == sample
--+ 
--+ FooRing:Ring == Fun SingleInteger
--+ 
--+ f:Mor(SingleInteger,SingleInteger) == sample
--+ 
--+ Fun:Functor(Ring,MorCat,Mor,Fo,Fm) == functor
--+ 
--+ functor(SingleInteger,SingleInteger,Fun,f)
--+ 
--+ 
--
-- Hi Martin,
--
--    This is a simplified version of one of my attempts at a Functor.  axiomxl -g interp core 
-- dumps on "functor(SingleInteger,SingleIntger,Fun,f)".  A curious aspect of this one, is if you
-- remove the last statement and compile, you get a warning:
--
--  "Function returns a domain that might not be constant (which may cause problems if it is 
--   used in a dependent type)."
--
-- adding the last statement causes this message to disappear (why, I don't know).  It seems to me
-- that all Domains are constant in this example, however.
--
--    If you have any clue about what is going wrong here, I would be very interested.
--
--    Saul 
--
#include "axllib"
#pile

Functor(Obj:Type,Mc:(Obj,Obj)->Category,Md:(A:Obj,B:Obj)->Mc(A,B),_
        Fo:Obj->Obj,Fm:(A:Obj,B:Obj,Md(A,B))->Md(Fo A,Fo B)): with
    apply: (%,Obj)->Obj
    functor: (A:Obj,B:Obj,F:%,Md(A,B))->Md(F A,F B)
    functor: %
== add
    Rep ==> SingleInteger; import from Rep
    apply(F:%,A:Obj):Obj == Fo A
    functor(A:Obj,B:Obj,F:%,f:Md(A,B)):Md(F A,F B) == error " "
    functor:% == per 0

Fo(A:Ring):Ring == A

define MorCat(A:Ring,B:Ring):Category == with { sample: % }

Mor(A:Ring,B:Ring):MorCat(A,B)
== add
   Rep ==> SingleInteger;  import from Rep
   sample:% == per 0

Fm(A:Ring,B:Ring,f:Mor(A,B)):Mor(Fo A,Fo B) == sample

FooRing:Ring == Fun SingleInteger

f:Mor(SingleInteger,SingleInteger) == sample

Fun:Functor(Ring,MorCat,Mor,Fo,Fm) == functor

functor(SingleInteger,SingleInteger,Fun,f)


