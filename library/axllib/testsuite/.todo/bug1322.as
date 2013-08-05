--* From mnd@dcs.st-and.ac.uk  Wed Jul 25 13:33:01 2001
--* Received: from mail.london-1.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id NAA08636
--* 	for <ax-bugs@nag.co.uk>; Wed, 25 Jul 2001 13:33:01 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 8371 invoked from network); 25 Jul 2001 12:29:29 -0000
--* Received: from host213-122-41-6.btinternet.com (HELO dcs.st-and.ac.uk) (213.122.41.6)
--*   by server-20.tower-4.starlabs.net with SMTP; 25 Jul 2001 12:29:29 -0000
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.11.0/8.11.0) id f6PCZFT04491
--* 	for ax-bugs@nag.co.uk; Wed, 25 Jul 2001 13:35:15 +0100
--* Date: Wed, 25 Jul 2001 13:35:15 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200107251235.f6PCZFT04491@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] tfAuditExportList bug

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -ginterp bug1322.as
-- Version: 1.1.13(33)
-- Original bug file name: bug1322.as


-- See bug 1309 for the original bug. This is a modified version to recreate
-- the original tfAuditExportList problem following recent compiler updates.

#include "axllib"
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

define Domain:Category == with;
define Set:Category == Domain with {
    <<:(TextWriter,%) -> TextWriter;
    =:(%,%) -> Boolean
}
define Semigroup:Category == Set with {
    *: (%,%) -> %
}

define Two(Obj:Category):Category == with {
    one: Obj;
    two: Obj;
    put: (one,two) -> %;
    get: % -> (one,two)
}

Pair(Obj:Category,A:Obj,B:Obj):Two Obj == add {
    one: Obj == A;
    two: Obj == B;
    Rep == Record(a:one,b:two); import from Rep;
    put(x:one,y:two):% == per [x,y];
    get(x:%):(one,two) == explode rep x
}

Diagonal(Obj:Category)(X:Obj):Two Obj == Pair(Obj,X,X) add;

define   Product(Obj:Category):Category == RightAdjoint(    Obj,Two Obj,Diagonal Obj) with; -- direct product
define CoProduct(Obj:Category):Category ==  LeftAdjoint(Two Obj,    Obj,Diagonal Obj) with; -- direct sum

-- Extracted from the old SGProduct domain.
SG0(T:Two Semigroup):Semigroup with Two Semigroup == Pair(Semigroup,one$T,two$T) add {
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

OuterRight(T:Two Semigroup):Semigroup == SG0(T) add;

SGProduct:Product Semigroup == add {
    Right: (T:Two Semigroup)->Semigroup == OuterRight;
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

