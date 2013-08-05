--* From youssef@buphyk.bu.edu  Fri Apr 13 19:22:34 2001
--* Received: from server-6.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id TAA26023
--* 	for <ax-bugs@nag.co.uk>; Fri, 13 Apr 2001 19:22:33 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 31161 invoked from network); 13 Apr 2001 18:19:23 -0000
--* Received: from buphyk.bu.edu (128.197.41.10)
--*   by server-6.tower-4.starlabs.net with SMTP; 13 Apr 2001 18:19:23 -0000
--* Received: (from youssef@localhost)
--* 	by buphyk.bu.edu (8.9.3/8.9.3) id OAA03820
--* 	for ax-bugs@nag.co.uk; Fri, 13 Apr 2001 14:21:52 -0400
--* Date: Fri, 13 Apr 2001 14:21:52 -0400
--* From: Saul Youssef <youssef@buphyk.bu.edu>
--* Message-Id: <200104131821.OAA03820@buphyk.bu.edu>
--* To: ax-bugs@nag.co.uk
--* Subject: [3] Compiler bug...Bug: tfAuditExportList

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Fao
-- Version: 1.1.12p6
-- Original bug file name: Ideal.as

--+ --
--+ --  Hi Martin, Stephen & Tony,
--+ --
--+ --     I've made some progress doing category theory in Aldor.  If you organize as much as possible
--+ --  around adjoints, category theory seems to fit fairly nicely in the language.  In this sort of 
--+ --  solution, there is exactly one mathematical category for each Aldor category, morphisms from 
--+ --  A:Obj to B:Obj are just functions A->B and functors between ObjA:Category and ObjB:Category are 
--+ --  just domain constructors like F:ObjA->ObjB.  The idea is that the action of a functor like F on 
--+ --  morphisms is determined by Adjoint(below) if F is an adjoint partner with G:ObjB->ObjA.  For some 
--+ --  applications, this won't be good enough and I'll need one of the solutions with Hom(A:Obj,B:Obj) 
--+ --  for more general morphism types.  However, this may be good enough for many things.
--+ --
--+ --     The solution below works fine for free constructions and other adjoints like the exponential 
--+ --  object, but it fails to work for Products, Sums, etc.  I have a less pretty workaround, but since 
--+ --  it seems like it might be very close to working, you (Martin) might want to look into what's 
--+ --  going on.  If you compile this file in 1.1.12p6, you get
--+ --
--+ --   Compiler bug...Bug: tfAuditExportList
--+ --
--+ --  I've tried quite a few workarounds, but without success.
--+ --
--+ --   Cheers,  Saul
--+ -- 
--+ #include "axllib"
--+ --
--+ --   The main concept in this solution is an "Adjoint".  In the category below, << and >> provide
--+ --   the left and right adjunctions of the isomorphism
--+ --
--+ --        Hom (Left ObjA, ObjB) << >> Hom (ObjA, Right ObjB)
--+ --
--+ --   that defines the adjoint.  Because functors usually come in adjoint pairs, we can informally
--+ --   consider domain constructors F:ObjA -> ObjB to be "functors" because the action of F on morphisms
--+ --   is gotten by default (it is the "left" function in the adjoint).  You also get the unit/counit 
--+ --   natural transformations (== "universal arrows") for free.
--+ --
--+ --
--+ define Adjoint(ObjA:Category,ObjB:Category, Left:ObjA->ObjB, Right:ObjB->ObjA):Category == with  {
--+     >>: (A:ObjA,B:ObjB,  Left A ->       B ) -> (      A -> Right B );  -- 1/2 of the adj. isomorphism
--+     <<: (A:ObjA,B:ObjB,       A -> Right B ) -> ( Left A ->       B );  -- 2/2 of the adj. isomorphism
--+     
--+     unit:   (A:ObjA) -> (           A -> Right  Left A);    --   unit natural transformation
--+     counit: (B:ObjB) -> (Left Right B ->             B);    -- counit natural transformation
--+     
--+     left:  (X:ObjA,Y:ObjA,X->Y) -> (  Left X ->  Left Y );  --  Left functor action on morphisms
--+     right: (X:ObjB,Y:ObjB,X->Y) -> ( Right X -> Right Y );  -- Right functor action on morphisms
--+     default  {
--+         unit  (A:ObjA):(A -> Right Left A)               == >>(      A,Left A,(l:Left  A):Left  A +-> l);
--+         counit(B:ObjB):(Left Right B -> B)               == <<(Right B,     B,(r:Right B):Right B +-> r);
--+         left (X:ObjA,Y:ObjA,f:X->Y):( Left X -> Left  Y) == <<(      X,Left Y,(x:           X):Right Left Y +->     unit(Y)(f x));
--+         right(X:ObjB,Y:ObjB,f:X->Y):(Right X -> Right Y) == >>(Right X,     Y,(x:Left Right X):           Y +-> f counit(X)(x) )
--+     }
--+ }
--+ define RightAdjoint(ObjA:Category,ObjB:Category,Left:ObjA->ObjB):Category == with {
--+     Right: ObjB -> ObjA;
--+     Adjoint(ObjA,ObjB,Left,Right)
--+ }
--+ define LeftAdjoint(ObjA:Category,ObjB:Category,Right:ObjB->ObjA):Category == with {
--+     Left:  ObjA -> ObjB;
--+     Adjoint(ObjA,ObjB,Left,Right)
--+ }
--+ --
--+ --  Given this, you can organize everything around Adjoints.  Free constructions are a special case.  The usual
--+ --  limits and colimits: Final/Product/Equalizer/Pullback, Initial/CoProduct/CoEqualizer/PushForward are then
--+ --  right and left adjoints respectively of the diagonal functor below.  The exponential object also is the 
--+ --  right adjoint of the right product functor.
--+ --
--+ --  Adjoints seem to work fine for free construction and exponential objects, but there is a bug preventing 
--+ --  me from using them for limits and colimits too.  
--+ -- 
--+ --  First let's simplify a bit and concentrate on doing the direct products for Semigroups.
--+ --
--+ define Domain:Category == with;
--+ define Set:Category == Domain with {
--+     <<:(TextWriter,%) -> TextWriter;
--+     =:(%,%) -> Boolean
--+ }
--+ define Semigroup:Category == Set with {
--+     *: (%,%) -> %
--+ }
--+ --
--+ --  To not make things too complicated, I'll first do products of exactly two Semigroups.
--+ -- 
--+ --   Two Obj is the category of Pairs of Obj domains.
--+ --
--+ define Two(Obj:Category):Category == with {
--+     one: Obj;
--+     two: Obj;
--+     put: (one,two) -> %;
--+     get: % -> (one,two)
--+ }
--+ --
--+ --  Pair satisfies Two
--+ --
--+ Pair(Obj:Category,A:Obj,B:Obj):Two Obj == add {
--+     one: Obj == A;
--+     two: Obj == B;
--+     Rep == Record(a:one,b:two); import from Rep;
--+     put(x:one,y:two):% == per [x,y];
--+     get(x:%):(one,two) == explode rep x
--+ }
--+ --
--+ --  Diagonal(Obj)(X) is the diagonal functor from Obj to Two Obj
--+ --
--+ Diagonal(Obj:Category)(X:Obj):Two Obj == Pair(Obj,X,X) add;
--+ 
--+ --
--+ --  The direct product in any category is the right adjoint of the diagonal functor
--+ --
--+ define   Product(Obj:Category):Category == RightAdjoint(    Obj,Two Obj,Diagonal Obj) with; -- direct product
--+ define CoProduct(Obj:Category):Category ==  LeftAdjoint(Two Obj,    Obj,Diagonal Obj) with; -- direct sum
--+ --
--+ --  Here is a domain implementing the direct product for semigroups.  The bug seems to occur 
--+ --  in the >> function.
--+ --
--+ SGProduct:Product Semigroup == add {
--+     Right(T:Two Semigroup):Semigroup ==  {
--+         SG0:Semigroup with Two Semigroup == Pair(Semigroup,one$T,two$T) add {
--+             (t:TextWriter)<<(x:%):TextWriter == {
--+                 (x1:one,x2:two) == get x;
--+                 t << "( " << x1 << " x " << x2 << " )"
--+             }
--+             (x:%)=(y:%):Boolean == {
--+                 (x1:one,x2:two) == get x;
--+                 (y1:one,y2:two) == get y;
--+                 x1=y1 and x2=y2
--+             }
--+             (x:%)*(y:%):% == {
--+                 (x1:one,x2:two) == get x;
--+                 (y1:one,y2:two) == get y;
--+                 put(x1*y1,x2*y2)
--+             }
--+         }
--+         SG0 add;
--+     }
--+     >>(A:Semigroup,B:Two Semigroup,f:Diagonal(Semigroup)(A)->B):(A->Right B) == {
--+         F(a:A):Right B == {
--+            d:Diagonal(Semigroup)(A) == { import from Record(a:A,b:A); [a,a] pretend Diagonal(Semigroup)(A); }
--+            b:B == f d;
--+            (b1:one$B,b2:two$B) == get b;
--+            error " ";
--+         }
--+         F
--+     }
--+     <<(A:Semigroup,B:Two Semigroup,f:A->Right B):Diagonal(Semigroup)(A) -> B == { error " "; }
--+ }
--+ 
--+ #if extra 
--+ --
--+ --   Here is a fancier version of the same thing but doing n fold Semigroup products.  This also
--+ --   doesn't work, however.
--+ --
--+ define (Obj:Category)^(n:SingleInteger):Category == with {
--+     dom: Tuple Obj;
--+     put: dom -> %;
--+     get: % -> dom
--+ }
--+ nTuple(Obj:Category,t:Tuple Obj):(Obj^(length t)) == add {
--+     dom:Tuple Obj == t;
--+     Rep == Record t;
--+     put(x:dom):% == per [x];
--+     get(x:%):dom == explode rep x;
--+ }
--+ Diagonal(Obj:Category,n:SingleInteger)(X:Obj):(Obj^n) == nTuple(Obj,(X for i:SingleInteger in 1..n)@Tuple Obj) pretend (Obj^n);
--+ 
--+ define   Product(Obj:Category,n:SingleInteger):Category == RightAdjoint(Obj  ,Obj^n,Diagonal(Obj,n)) with;
--+ define CoProduct(Obj:Category,n:SingleInteger):Category ==  LeftAdjoint(Obj^n,Obj  ,Diagonal(Obj,n)) with;
--+ 
--+ SGProduct(n:SingleInteger):Product(Semigroup,n) == add {
--+     Right(F:(Semigroup^n)):Semigroup with (Semigroup^n) == nTuple(Semigroup,dom$F) add {
--+         (w:TextWriter)<<(x:%):TextWriter == w;
--+         (x:%)=(y:%):Boolean == {
--+             dx:dom == get x;
--+             dy:dom == get y;
--+             error " "
--+         }
--+     }
--+ }
--+ 
--+ #endif
--
--  Hi Martin, Stephen & Tony,
--
--     I've made some progress doing category theory in Aldor.  If you organize as much as possible
--  around adjoints, category theory seems to fit fairly nicely in the language.  In this sort of 
--  solution, there is exactly one mathematical category for each Aldor category, morphisms from 
--  A:Obj to B:Obj are just functions A->B and functors between ObjA:Category and ObjB:Category are 
--  just domain constructors like F:ObjA->ObjB.  The idea is that the action of a functor like F on 
--  morphisms is determined by Adjoint(below) if F is an adjoint partner with G:ObjB->ObjA.  For some 
--  applications, this won't be good enough and I'll need one of the solutions with Hom(A:Obj,B:Obj) 
--  for more general morphism types.  However, this may be good enough for many things.
--
--     The solution below works fine for free constructions and other adjoints like the exponential 
--  object, but it fails to work for Products, Sums, etc.  I have a less pretty workaround, but since 
--  it seems like it might be very close to working, you (Martin) might want to look into what's 
--  going on.  If you compile this file in 1.1.12p6, you get
--
--   Compiler bug...Bug: tfAuditExportList
--
--  I've tried quite a few workarounds, but without success.
--
--   Cheers,  Saul
-- 
#include "axllib"
--
--   The main concept in this solution is an "Adjoint".  In the category below, << and >> provide
--   the left and right adjunctions of the isomorphism
--
--        Hom (Left ObjA, ObjB) << >> Hom (ObjA, Right ObjB)
--
--   that defines the adjoint.  Because functors usually come in adjoint pairs, we can informally
--   consider domain constructors F:ObjA -> ObjB to be "functors" because the action of F on morphisms
--   is gotten by default (it is the "left" function in the adjoint).  You also get the unit/counit 
--   natural transformations (== "universal arrows") for free.
--
--
define Adjoint(ObjA:Category,ObjB:Category, Left:ObjA->ObjB, Right:ObjB->ObjA):Category == with  {
    >>: (A:ObjA,B:ObjB,  Left A ->       B ) -> (      A -> Right B );  -- 1/2 of the adj. isomorphism
    <<: (A:ObjA,B:ObjB,       A -> Right B ) -> ( Left A ->       B );  -- 2/2 of the adj. isomorphism
    
    unit:   (A:ObjA) -> (           A -> Right  Left A);    --   unit natural transformation
    counit: (B:ObjB) -> (Left Right B ->             B);    -- counit natural transformation
    
    left:  (X:ObjA,Y:ObjA,X->Y) -> (  Left X ->  Left Y );  --  Left functor action on morphisms
    right: (X:ObjB,Y:ObjB,X->Y) -> ( Right X -> Right Y );  -- Right functor action on morphisms
    default  {
        unit  (A:ObjA):(A -> Right Left A)               == >>(      A,Left A,(l:Left  A):Left  A +-> l);
        counit(B:ObjB):(Left Right B -> B)               == <<(Right B,     B,(r:Right B):Right B +-> r);
        left (X:ObjA,Y:ObjA,f:X->Y):( Left X -> Left  Y) == <<(      X,Left Y,(x:           X):Right Left Y +->     unit(Y)(f x));
        right(X:ObjB,Y:ObjB,f:X->Y):(Right X -> Right Y) == >>(Right X,     Y,(x:Left Right X):           Y +-> f counit(X)(x) )
    }
}
define RightAdjoint(ObjA:Category,ObjB:Category,Left:ObjA->ObjB):Category == with {
    Right: ObjB -> ObjA;
    Adjoint(ObjA,ObjB,Left,Right)
}
define LeftAdjoint(ObjA:Category,ObjB:Category,Right:ObjB->ObjA):Category == with {
    Left:  ObjA -> ObjB;
    Adjoint(ObjA,ObjB,Left,Right)
}
--
--  Given this, you can organize everything around Adjoints.  Free constructions are a special case.  The usual
--  limits and colimits: Final/Product/Equalizer/Pullback, Initial/CoProduct/CoEqualizer/PushForward are then
--  right and left adjoints respectively of the diagonal functor below.  The exponential object also is the 
--  right adjoint of the right product functor.
--
--  Adjoints seem to work fine for free construction and exponential objects, but there is a bug preventing 
--  me from using them for limits and colimits too.  
-- 
--  First let's simplify a bit and concentrate on doing the direct products for Semigroups.
--
define Domain:Category == with;
define Set:Category == Domain with {
    <<:(TextWriter,%) -> TextWriter;
    =:(%,%) -> Boolean
}
define Semigroup:Category == Set with {
    *: (%,%) -> %
}
--
--  To not make things too complicated, I'll first do products of exactly two Semigroups.
-- 
--   Two Obj is the category of Pairs of Obj domains.
--
define Two(Obj:Category):Category == with {
    one: Obj;
    two: Obj;
    put: (one,two) -> %;
    get: % -> (one,two)
}
--
--  Pair satisfies Two
--
Pair(Obj:Category,A:Obj,B:Obj):Two Obj == add {
    one: Obj == A;
    two: Obj == B;
    Rep == Record(a:one,b:two); import from Rep;
    put(x:one,y:two):% == per [x,y];
    get(x:%):(one,two) == explode rep x
}
--
--  Diagonal(Obj)(X) is the diagonal functor from Obj to Two Obj
--
Diagonal(Obj:Category)(X:Obj):Two Obj == Pair(Obj,X,X) add;

--
--  The direct product in any category is the right adjoint of the diagonal functor
--
define   Product(Obj:Category):Category == RightAdjoint(    Obj,Two Obj,Diagonal Obj) with; -- direct product
define CoProduct(Obj:Category):Category ==  LeftAdjoint(Two Obj,    Obj,Diagonal Obj) with; -- direct sum
--
--  Here is a domain implementing the direct product for semigroups.  The bug seems to occur 
--  in the >> function.
--
SGProduct:Product Semigroup == add {
    Right(T:Two Semigroup):Semigroup ==  {
        SG0:Semigroup with Two Semigroup == Pair(Semigroup,one$T,two$T) add {
            (t:TextWriter)<<(x:%):TextWriter == {
                (x1:one,x2:two) == get x;
                t << "( " << x1 << " x " << x2 << " )"
            }
            (x:%)=(y:%):Boolean == {
                (x1:one,x2:two) == get x;
                (y1:one,y2:two) == get y;
                x1=y1 and x2=y2
            }
            (x:%)*(y:%):% == {
                (x1:one,x2:two) == get x;
                (y1:one,y2:two) == get y;
                put(x1*y1,x2*y2)
            }
        }
        SG0 add;
    }
    >>(A:Semigroup,B:Two Semigroup,f:Diagonal(Semigroup)(A)->B):(A->Right B) == {
        F(a:A):Right B == {
           d:Diagonal(Semigroup)(A) == { import from Record(a:A,b:A); [a,a] pretend Diagonal(Semigroup)(A); }
           b:B == f d;
           (b1:one$B,b2:two$B) == get b;
           error " ";
        }
        F
    }
    <<(A:Semigroup,B:Two Semigroup,f:A->Right B):Diagonal(Semigroup)(A) -> B == { error " "; }
}

#if extra 
--
--   Here is a fancier version of the same thing but doing n fold Semigroup products.  This also
--   doesn't work, however.
--
define (Obj:Category)^(n:SingleInteger):Category == with {
    dom: Tuple Obj;
    put: dom -> %;
    get: % -> dom
}
nTuple(Obj:Category,t:Tuple Obj):(Obj^(length t)) == add {
    dom:Tuple Obj == t;
    Rep == Record t;
    put(x:dom):% == per [x];
    get(x:%):dom == explode rep x;
}
Diagonal(Obj:Category,n:SingleInteger)(X:Obj):(Obj^n) == nTuple(Obj,(X for i:SingleInteger in 1..n)@Tuple Obj) pretend (Obj^n);

define   Product(Obj:Category,n:SingleInteger):Category == RightAdjoint(Obj  ,Obj^n,Diagonal(Obj,n)) with;
define CoProduct(Obj:Category,n:SingleInteger):Category ==  LeftAdjoint(Obj^n,Obj  ,Diagonal(Obj,n)) with;

SGProduct(n:SingleInteger):Product(Semigroup,n) == add {
    Right(F:(Semigroup^n)):Semigroup with (Semigroup^n) == nTuple(Semigroup,dom$F) add {
        (w:TextWriter)<<(x:%):TextWriter == w;
        (x:%)=(y:%):Boolean == {
            dx:dom == get x;
            dy:dom == get y;
            error " "
        }
    }
}

#endif
