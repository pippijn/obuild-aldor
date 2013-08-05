--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Thu Mar 31 12:58:16 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA25865; Thu, 31 Mar 1994 12:58:16 -0500
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1625; Thu, 31 Mar 94 12:59:30 EST
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.3559.Mar.31.12:59:28.-0500>
--*           for asbugs@watson; Thu, 31 Mar 94 12:59:29 -0500
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 3557; Thu, 31 Mar 1994 12:59:27 EST
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 31 Mar 94 12:59:25 EST
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA15335; Thu, 31 Mar 1994 12:58:44 -0500
--* Date: Thu, 31 Mar 1994 12:58:44 -0500
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9403311758.AA15335@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2] Two meanings for record operations [ecfact.as][v34.5]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--+ cd /home/smwatt/
--+ asharp -M2 -Mno-mactext ecfact.as
--+ "ecfact.as", line 29:
--+         p0: % == per [hp0.x rem n, hp0.y rem n, hp0.z rem n];
--+ .................^
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `bracket' in this context.
--+ The possible types were:
--+ 	  bracket: (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  bracket: (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ... from Record(x: Integer, y: Integer, z: Integer)
--+   The context requires an expression of type (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ....
--+ Expanded expression was: bracket
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `apply' in this context.
--+ The possible types were:
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Integer) -> OutPort from Integer
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, String) -> OutPort from String
--+ 	  apply: OutPort -> OutPort from OutPort
--+ 	  apply: (OutPort, Segment(SingleInteger)) -> OutPort from Segment(SingleInteger)
--+ 	  apply: (OutPort, Boolean) -> OutPort from Boolean
--+   The context requires an expression of type (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -....
--+ Expanded expression was: apply
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `x' in this context.
--+ The possible types were:
--+ 	  x: Enumeration(x) from Record(x: Integer, y: Integer, z: Integer)
--+ 	  x: Enumeration(x) from Record(x: Integer, y: Integer, z: Integer)
--+   The context requires an expression of type Enumeration(x).
--+ Expanded expression was: x
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `apply' in this context.
--+ The possible types were:
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Integer) -> OutPort from Integer
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, String) -> OutPort from String
--+ 	  apply: OutPort -> OutPort from OutPort
--+ 	  apply: (OutPort, Segment(SingleInteger)) -> OutPort from Segment(SingleInteger)
--+ 	  apply: (OutPort, Boolean) -> OutPort from Boolean
--+   The context requires an expression of type (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -....
--+ Expanded expression was: apply
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `y' in this context.
--+ The possible types were:
--+ 	  y: Enumeration(y) from Record(x: Integer, y: Integer, z: Integer)
--+ 	  y: Enumeration(y) from Record(x: Integer, y: Integer, z: Integer)
--+   The context requires an expression of type Enumeration(y).
--+ Expanded expression was: y
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `apply' in this context.
--+ The possible types were:
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Integer) -> OutPort from Integer
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, String) -> OutPort from String
--+ 	  apply: OutPort -> OutPort from OutPort
--+ 	  apply: (OutPort, Segment(SingleInteger)) -> OutPort from Segment(SingleInteger)
--+ 	  apply: (OutPort, Boolean) -> OutPort from Boolean
--+   The context requires an expression of type (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -....
--+ Expanded expression was: apply
--+ [L29 C18] (Error) (After Macro Expansion) 2 meanings for `z' in this context.
--+ The possible types were:
--+ 	  z: Enumeration(z) from Record(x: Integer, y: Integer, z: Integer)
--+ 	  z: Enumeration(z) from Record(x: Integer, y: Integer, z: Integer)
--+   The context requires an expression of type Enumeration(z).
--+ Expanded expression was: z
--+
--+ "ecfact.as", line 33:         0: %        ==  per [1, (-1) rem n, 0];
--+                       ........................^
--+ [L33 C25] (Error) (After Macro Expansion) 2 meanings for `bracket' in this context.
--+ The possible types were:
--+ 	  bracket: (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  bracket: (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ... from Record(x: Integer, y: Integer, z: Integer)
--+   The context requires an expression of type (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ....
--+ Expanded expression was: bracket
--+
--+ "ecfact.as", line 34:         -(u: %): %  ==  per [py u, px u, pz u];
--+                       ........................^
--+ [L34 C25] (Error) (After Macro Expansion) 2 meanings for `bracket' in this context.
--+ The possible types were:
--+ 	  bracket: (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  bracket: (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ... from Record(x: Integer, y: Integer, z: Integer)
--+   The context requires an expression of type (x: Integer, y: Integer, z: Integer) -> Record(x: Integer, y: ....
--+ Expanded expression was: bracket
--+ [L34 C25] (Error) (After Macro Expansion) 2 meanings for `apply' in this context.
--+ The possible types were:
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Integer) -> OutPort from Integer
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(x)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (Record(x: Integer, y: Integer, z: Integer), Enumeration(z)) -... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, Record(x: Integer, y: Integer, z: Integer)) -> OutPo... from Record(x: Integer, y: Integer, z: Integer)
--+ 	  apply: (OutPort, String) -> OutPort from String
--+ 	  apply: OutPort -> OutPort from OutPort
--+ 	  apply: (OutPort, Segment(SingleInteger)) -> OutPort from Segment(SingleInteger)
--+ 	  apply: (OutPort, Boolean) -> OutPort from Boolean
--+   The context requires an expression of type (Record(x: Integer, y: Integer, z: Integer), Enumeration(y)) -....
--+ Expanded expression was: apply
--+ [L34 C25] (Fatal Error) (After Macro Expansion) Too many errors (use `-M emax=n' or `-M no-emax' to change the limit).
--+ Expanded expression was: ()
--+
--+
--+ Compilation exited abnormally with code 1 at Thu Mar 31 12:56:47
--% Elliptic curve method for integer factorization
--  This file implements Lenstra's algorithm for integer factorization.
--  A divisor of N is found by computing a large multiple of a rational
--  point on a randomly generated elliptic curve in P2 Z/NZ.
--  The Hessian model is used for the curve (1) to simplify the selection
--  of the initial point on the random curve and (2) to minimize the
--  cost of adding points.
--  Ref:  IBM RC 11262, DV Chudnovsky & GV Chudnovsky
--  SMW Sept 86.

#include "axllib"

HPoint ==> Record(x: Integer, y: Integer, z: Integer);

EllipticCurveRationalPoints(hp0: HPoint, n: Integer): AbelianGroup with {
        double:             %  -> %;
        p0:                 () -> %;
        HessianCoordinates: % -> HPoint;
}
== add {
        Rep ==> HPoint;
	import from Rep;
	import from Integer;

	px(u) ==> rep(u).x;
	py(u) ==> rep(u).y;
	pz(u) ==> rep(u).z;

        p0: % == per [hp0.x rem n, hp0.y rem n, hp0.z rem n];

        HessianCoordinates(u: %): HPoint == rep u;

        0: %        ==	per [1, (-1) rem n, 0];
        -(u: %): %  ==	per [py u, px u, pz u];

        (u: %) = (v: %): Boolean == {
		XuZv := px u * pz v;
		XvZu := px v * pz u;
		YuZv := py u * pz v;
		YvZu := py v * pz u;
		(XuZv-XvZu) rem n = 0 and (YuZv-YvZu) rem n = 0
	}
        (u: %) + (v: %): % == {
		XuZv := px u * pz v;
		XvZu := px v * pz u;
		YuZv := py u * pz v;
		YvZu := py v * pz u;
		(XuZv-XvZu) rem n = 0 and (YuZv-YvZu) rem n = 0 => double u;
		XuYv := px u * py v;
		XvYu := px v * py u;
		Xw := XuZv*XuYv - XvZu*XvYu;
		Yw := YuZv*XvYu - YvZu*XuYv;
		Zw := XvZu*YvZu - XuZv*YuZv;
		per [Yw rem n, Xw rem n, Zw rem n]
	}
        double(u: %): % == {
		X3 := px u * px u * px u;
		Y3 := py u * py u * py u;
		Z3 := pz u * pz u * pz u;
		Xw := px u * (Y3 - Z3);
		Yw := py u * (Z3 - X3);
		Zw := pz u * (X3 - Y3);
		per [Yw rem n, Xw rem n, Zw rem n]
	}
        (k: Integer) * (u: %): % == {
		k < 0 => (-k)*(-u);
		v: % := 0;
		for i: SingleInteger in 0..length k - 1 repeat {
			if bit(k,i) then v := u + v;
			u := double u
		}
		v
	}
}


#if nope
--% EllipticCurveFactorization
)abbrev package ECFACT EllipticCurveFactorization

EllipticCurveFactorization: with
        LenstraEllipticMethod: (Integer)                   -> Integer
        LenstraEllipticMethod: (Integer, NewFloat)         -> Integer
        LenstraEllipticMethod: (Integer, Integer, Integer) -> Integer
        LenstraEllipticMethod: (Integer, Integer)          -> Integer

        lcmLimit: Integer -> Integer
        lcmLimit: NewFloat-> Integer

        solveBound: NewFloat -> NewFloat
        bfloor:     NewFloat -> Integer
        primesTo:   Integer -> List Integer
        lcmTo:      Integer -> Integer
    == add
        Ex ==> Expression
        NNI==> NonNegativeInteger
        OutputPackage()

        blather := true

        --% Finding the multiplier
        flabs (f: NewFloat): NewFloat == (f < 0 => -f; f)
        flsqrt(f: NewFloat): NewFloat == exp(log f/2::NewFloat)
        nthroot(f:NewFloat,n:Integer):NewFloat == exp(log f/n::NewFloat)

        bfloor(f: NewFloat): Integer  ==
            f := floor f
            digits: Integer := CADR(f)$Lisp
            expon:  Integer := CDDR(f)$Lisp
            expon >= 0 => digits*10**(expon: NNI)
            sgn: Integer   := (digits < 0 => -1; 1)
            digits:= abs digits
            expon := abs expon
            sgn*(digits quo (10**expon:NNI))

        lcmLimit(n: Integer) ==
            lcmLimit nthroot(n::NewFloat, 3)
        lcmLimit(divisorBound: NewFloat) ==
            y := solveBound divisorBound
            lcmLim := bfloor exp(log divisorBound/y)
            if blather then
                output ["The divisor bound is"::Ex, divisorBound::Ex]
                output ["The lcm Limit is"::Ex, lcmLim::Ex]
            lcmLim

        -- Solve the bound equation using a Newton iteration.
        --
        -- f = y**2 - log(B)/log(y+1)
        --
        -- f/f' = fdf =
        --    2                 2
        --   y (y + 1)log(y + 1)  - (y + 1)log(y + 1) logB
        --   ---------------------------------------------
        --                                 2
        --              2y(y + 1)log(y + 1)  + logB
        --
        fdf(y: NewFloat, logB: NewFloat): NewFloat ==
            logy  := log(y + 1)
            ylogy := (y + 1)*logy
            ylogy2:= y*logy*ylogy
            (y*ylogy2 - logB*ylogy)/(2*ylogy2 + logB)
        solveBound divisorBound ==
            -- solve               y**2 = log(B)/log(y + 1)
            -- although it may be  y**2 = log(B)/(log(y)+1)
            relerr := (10::NewFloat)**(-5)
            logB := log divisorBound
            y0   := flsqrt log10 divisorBound
            y1   := y0 - fdf(y0, logB)
            while flabs((y1 - y0)/y0) > relerr repeat
                y0 := y1
                y1 := y0 - fdf(y0, logB)
            y1

        -- maxpin(p, n, logn) is max d s.t. p**d <= n
        maxpin(p:Integer,n:Integer,logn:NewFloat): NonNegativeInteger ==
            d: Integer := bfloor(logn/log(p::NewFloat))
            if d < 0 then d := 0
            d:NonNegativeInteger

        multiple?(i: Integer, plist: List Integer): Boolean ==
            for p in plist repeat if i rem p = 0 then return true
            false

        primesTo n ==
            n < 2 => []
            n = 2 => [2]
            plist := [3, 2]
            i := 5
            while i <= n repeat
                if not multiple?(i, plist) then plist := cons(i, plist)
                i := i + 2
                if not multiple?(i, plist) then plist := cons(i, plist)
                i := i + 4
            plist
        lcmTo n ==
            plist := primesTo n
            m: Integer := 1
            logn := log(n::NewFloat)
            for p in plist repeat m := m * p**maxpin(p,n,logn)
            if blather then
                output ["The lcm of 1.."::Ex, n::Ex, "is"::Ex, m::Ex]
            m
        LenstraEllipticMethod(n: Integer) ==
            LenstraEllipticMethod(n, flsqrt(n::NewFloat))
        LenstraEllipticMethod(n: Integer, divisorBound: NewFloat) ==
            lcmLim0 := lcmLimit divisorBound
            multer0 := lcmTo lcmLim0
            LenstraEllipticMethod(n, lcmLim0, multer0)
        LenstraEllipticMethod(n: Integer, multer: Integer) ==
            X0 := random()
            Y0 := random()
            Z0 := random()
            EC := EllipticCurveRationalPoints(X0,Y0,Z0,n)
            p  := p0()$EC
            pn := multer *$EC p
            Zn := (HessianCoordinates$EC).pn.z
            gcd(n, Zn)

        LenstraEllipticMethod(n, lcmLim0, multer0) ==
            nfact: Integer := 1
            for i in 1.. while nfact = 1 repeat
                output ["Trying elliptic curve number"::Ex, i::Ex]
                X0 := random()
                Y0 := random()
                Z0 := random()
                EC := EllipticCurveRationalPoints(X0,Y0,Z0,n)
                p  := p0()$EC
                pn := multer0 *$EC p
                Zn := (HessianCoordinates$EC).pn.z
                nfact := gcd(n, Zn)
                if nfact = n then
                    lcmLim := lcmLim0
                    until nfact ^= n repeat
                        output ["Too many iterations... backing off"::Ex]
                        lcmLim := bfloor(lcmLim * 0.6)
                        multer := lcmTo lcmLim
                        pn := multer *$EC p
                        Zn := (HessianCoordinates$EC).pn.z
                        nfact := gcd(n, Zn)
            nfact

#endif
