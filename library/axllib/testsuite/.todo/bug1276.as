--* From youssef@d0mino.fnal.gov  Thu Nov  9 03:54:29 2000
--* Received: from server-2.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id DAA29294
--* 	for <ax-bugs@nag.co.uk>; Thu, 9 Nov 2000 03:54:28 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 6281 invoked from network); 9 Nov 2000 03:53:54 -0000
--* Received: from d0mino.fnal.gov (131.225.224.45)
--*   by server-2.tower-4.starlabs.net with SMTP; 9 Nov 2000 03:53:54 -0000
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id VAA16565;
--* 	Wed, 8 Nov 2000 21:53:57 -0600 (CST)
--* Date: Wed, 8 Nov 2000 21:53:57 -0600 (CST)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200011090353.VAA16565@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: export.as

--+ --
--+ --  Hi Martin,
--+ --
--+ --      Here's another one of those "Export not found" run-time errors. Any hints for getting around this kind of thing?
--+ --
--+ --   Cheers,  Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define FunctorCategory(ObjA:Type,MorA:(ObjA,ObjA)->with,  ObjB:Type,MorB:(ObjB,ObjB)->with, Fo:ObjA->ObjB):Category == with
--+     functor: ((X:ObjA,Y:ObjA)->MorA(X,Y)->MorB(Fo X,Fo Y)) -> %
--+ 
--+ Functor(ObjA:Type,MorA:(ObjA,ObjA)->with,  ObjB:Type,MorB:(ObjB,ObjB)->with):with
--+     Functor: (Fo:ObjA->ObjB) -> FunctorCategory(ObjA,MorA,ObjB,MorB,Fo)
--+ == add
--+     Functor(Fo:ObjA->ObjB):FunctorCategory(ObjA,MorA,ObjB,MorB,Fo) == 
--+         Foo:FunctorCategory(ObjA,MorA,ObjB,MorB,Fo) == add
--+             Rep ==> (X:ObjA,Y:ObjA)->(MorA(X,Y))->MorB(Fo X,Fo Y)
--+ 	    functor(F:(X:ObjA,Y:ObjA)->MorA(X,Y)->MorB(Fo X,Fo Y)):% == per F
--+         Foo add
--+ 
--+ define Agg:Category == with
--+ define AggMorphism(A:Agg,B:Agg):Category == with
--+ Agg(A:Agg,B:Agg):AggMorphism(A,B) == add
--+ 
--+ define Set:Category == Agg with
--+     =:(%,%) -> Boolean
--+ 
--+ define SetMorphism(A:Set,B:Set):Category == with
--+ Set(A:Set,B:Set):SetMorphism(A,B) == add
--+ 
--+ +++
--+ +++ Forgetful functor to Agg
--+ +++
--+ Forgeto(A:Set):Agg == (A@Agg) add
--+ Forgetm(A:Set,B:Set)(f:Set(A,B)):Agg(Forgeto A,Forgeto B) == f pretend Agg(Forgeto A,Forgeto B)
--+ 
--+ --F:Functor(Set,Set,Agg,Agg,Forgeto) == functor Forgetm
--+ import from Functor(Set,Set,Agg,Agg)
--+ F:Functor(Forgeto) == functor Forgetm
--
--  Hi Martin,
--
--      Here's another one of those "Export not found" run-time errors. Any hints for getting around this kind of thing?
--
--   Cheers,  Saul
--
#include "axllib"
#pile

define FunctorCategory(ObjA:Type,MorA:(ObjA,ObjA)->with,  ObjB:Type,MorB:(ObjB,ObjB)->with, Fo:ObjA->ObjB):Category == with
    functor: ((X:ObjA,Y:ObjA)->MorA(X,Y)->MorB(Fo X,Fo Y)) -> %

Functor(ObjA:Type,MorA:(ObjA,ObjA)->with,  ObjB:Type,MorB:(ObjB,ObjB)->with):with
    Functor: (Fo:ObjA->ObjB) -> FunctorCategory(ObjA,MorA,ObjB,MorB,Fo)
== add
    Functor(Fo:ObjA->ObjB):FunctorCategory(ObjA,MorA,ObjB,MorB,Fo) == 
        Foo:FunctorCategory(ObjA,MorA,ObjB,MorB,Fo) == add
            Rep ==> (X:ObjA,Y:ObjA)->(MorA(X,Y))->MorB(Fo X,Fo Y)
	    functor(F:(X:ObjA,Y:ObjA)->MorA(X,Y)->MorB(Fo X,Fo Y)):% == per F
        Foo add

define Agg:Category == with
define AggMorphism(A:Agg,B:Agg):Category == with
Agg(A:Agg,B:Agg):AggMorphism(A,B) == add

define Set:Category == Agg with
    =:(%,%) -> Boolean

define SetMorphism(A:Set,B:Set):Category == with
Set(A:Set,B:Set):SetMorphism(A,B) == add

+++
+++ Forgetful functor to Agg
+++
Forgeto(A:Set):Agg == (A@Agg) add
Forgetm(A:Set,B:Set)(f:Set(A,B)):Agg(Forgeto A,Forgeto B) == f pretend Agg(Forgeto A,Forgeto B)

--F:Functor(Set,Set,Agg,Agg,Forgeto) == functor Forgetm
import from Functor(Set,Set,Agg,Agg)
F:Functor(Forgeto) == functor Forgetm

