--* From PETEB%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Wed Jun  1 01:07:11 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA25865; Wed, 1 Jun 1994 01:07:11 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5261; Wed, 01 Jun 94 01:07:18 EDT
--* Received: from WATSON by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.1317.Jun.01.01:07:17.-0400>
--*           for asbugs@watson; Wed, 01 Jun 94 01:07:17 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 4767; Wed, 1 Jun 1994 01:07:09 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 01 Jun 94 01:07:08 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA23945; Wed, 1 Jun 1994 01:04:16 -0500
--* Date: Wed, 1 Jun 1994 01:04:16 -0500
--* From: pab@watson.ibm.com
--* Message-Id: <9406010604.AA23945@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4] optimiser has a field day [ore0.as][v35.3]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"
--> testcomp
--> testrun

-- 2 bugs:
-- The optimiser creates functions which are much longer than nec. (~1700 locals)
-- genc splits files badly if a single function is larger than the max file length

-- NonNegativeInteger is not yet in aslib, so we use Integer instead for now
macro NonNegativeInteger == Integer

macro {
    N == NonNegativeInteger;
    Z == Integer;
}

--% RetractableTo
RetractableTo(T:Type):Category == with {
	coerce :      T -> %;
	retract:      % -> T;
	retractIfCan: % -> Partial T;
	default retract(x:%):T == {
		import from Partial T;
		not failed?(u := retractIfCan x) => u::T;
		error "retract: value is not retractable"
	}
}

--% Module
Module(R:Ring):Category == Ring with {
	*: (R, %) -> %;
	*: (%, R) -> %
}

--% Algebra
Algebra(R:Ring):Category == Module R with {
	coerce: R -> %;
	default coerce(r:R):% == r * 1
}

--% Applicable
Applicable(A:Type, B:Type):Category == with { apply: (%, A) -> B }


--% UnivariateSkewPolynomialCategory
UnivariateSkewPolynomialCategory(R:Field): -- ring later
	Category == Join(Ring, RetractableTo R) with {
    	degree:             % -> N;
	++ degree(sum_{i=0}^n monomial(a_i,i)) = n if a_n \ne 0.
    	minimumDegree:      % -> N;
	++ minimumDegree(sum_{i=0}^n monomial(a_i,i)) is the smallest i
	++ such that a_i \ne 0.
    	leadingCoefficient: % -> R;
	++ leadingCoefficient(sum_{i=0}^n monomial(a_i,i))=a_n if a_n\ne 0.
    	reductum:           % -> %;
	++ reductum(sum_{i=0}^n monomial(a_i,i)) =
	++          sum_{i=0}^{n-1} monomial(a_i,i)a_n if a_n \ne 0.
    	coefficient:        (%, N) -> R;
	++ coefficient(sum_{i=0}^n monomial(a_i,i), m) = a_m.
    	monomial:           (R, N) -> %;
	++ monomial(c, n) = c monomial(1,1)^n, where monomial(1,1) is the
	++ generating operator.
    	coefficients:       % -> List R;
	++ coefficients(sum_{i=0}^n monomial(a_i,i))=[a_n,a_{n-1},\dots,a_0]
	++ with all the zero coefficients removed.
	apply: (%, R, R) -> R;
	++ apply(p, c, m) returns \spad{p(m)} where the action is
	++ given by \spad{x m = c sigma(m) + delta(m)}.
	Algebra R;                           -- if R has CommutativeRing later
	-- the next 3 will later be  if R has IntegralDomain
	exactQuotient: (%, R) -> Partial %;
	++ exactQuotient(l, a) returns the exact quotient of l by a.
	monicLeftDivide:   (%, %) -> (%, %);
	++ monicLeftDivide(a,b) returns the pair \spad{(q,r)} such that
	++ \spad{a = b*q + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ \spad{b} must be monic.
	++ This process is called ``left division''.
	monicRightDivide:   (%, %) -> (%, %);
	++ monicRightDivide(a,b) returns the pair \spad{(q,r)} such that
	++ \spad{a = q*b + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ \spad{b} must be monic.
	++ This process is called ``right division''.
	-- the next 2 will later be  if R has GcdDomain
	content: % -> R;
	++ content(l) returns the gcd of all the coefficients of l.
	primitivePart: % -> %;
	++ primitivePart(l) returns l0 such that \spad{l = a * l0}
	++ for some a in R, and \spad{content(l0) = 1}.
	-- all the following will later be  if R has Field
	leftDivide:   (%, %) -> (%, %);
	++ leftDivide(a,b) returns the pair \spad{(q,r)} such that
		++ \spad{a = b*q + r} and the degree of \spad{r} is
	leftQuotient:  (%, %) -> %;
	++ leftQuotient(a,b) computes the pair \spad{(q,r)} such that
	++ \spad{a = b*q + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ The value \spad{q} is returned.
	leftRemainder:  (%, %) -> %;
	++ leftRemainder(a,b) computes the pair \spad{(q,r)} such that
	++ \spad{a = b*q + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ The value \spad{r} is returned.
	leftExactQuotient:(%, %) -> Partial %;
	++ leftExactQuotient(a,b) computes the value \spad{q}, if it exists,
	++  such that \spad{a = b*q}.
	leftGcd:   (%, %) -> %;
	++ leftGcd(a,b) computes the value \spad{g} of highest degree
	++ such that
	++    \spad{a = g*aa}
	++    \spad{b = g*bb}
	++ for some values \spad{aa} and \spad{bb}.
	++ The value \spad{g} is computed using left-division.
	leftExtendedGcd:   (%, %) -> Record(coef1:%, coef2:%, generator:%);
	++ leftExtendedGcd(a,b) returns \spad{[c,d]} such that
	++ \spad{g = a * c + b * d = leftGcd(a, b)}.
	rightLcm:   (%, %) -> %;
	++ rightLcm(a,b) computes the value \spad{m} of lowest degree
	++ such that \spad{m = a*aa = b*bb} for some values
	++ \spad{aa} and \spad{bb}.  The value \spad{m} is
	++ computed using left-division.
	rightDivide:   (%, %) -> (%, %);
	++ rightDivide(a,b) returns the pair \spad{(q,r)} such that
	++ \spad{a = q*b + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ This process is called ``right division''.
	rightQuotient:  (%, %) -> %;
	++ rightQuotient(a,b) computes the pair \spad{(q,r)} such that
	++ \spad{a = q*b + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ The value \spad{q} is returned.
	rightRemainder:  (%, %) -> %;
	++ rightRemainder(a,b) computes the pair \spad{(q,r)} such that
	++ \spad{a = q*b + r} and the degree of \spad{r} is
	++ less than the degree of \spad{b}.
	++ The value \spad{r} is returned.
	rightExactQuotient:(%, %) -> Partial %;
	++ rightExactQuotient(a,b) computes the value \spad{q}, if it exists
	++ such that \spad{a = q*b}.
	rightGcd:   (%, %) -> %;
	++ rightGcd(a,b) computes the value \spad{g} of highest degree
	++ such that
	++    \spad{a = aa*g}
	++    \spad{b = bb*g}
	++ for some values \spad{aa} and \spad{bb}.
	++ The value \spad{g} is computed using right-division.
	rightExtendedGcd:   (%, %) -> Record(coef1:%, coef2:%, generator:%);
	++ rightExtendedGcd(a,b) returns \spad{[c,d]} such that
	++ \spad{g = c * a + d * b = rightGcd(a, b)}.
	leftLcm:   (%, %) -> %;
	++ leftLcm(a,b) computes the value \spad{m} of lowest degree
	++ such that \spad{m = aa*a = bb*b} for some values
	++ \spad{aa} and \spad{bb}.  The value \spad{m} is
	++ computed using right-division.
	default {
		coerce(x:R):% == { import from N; monomial(x, 0) }

		retractIfCan(x:%):Partial R == {
			import from N;
			zero? degree x => [leadingCoefficient x];
			failed
		}

		coefficients(l:%):List(R) == {
			import from List(R);
			ans:List(R) := empty();
			while l ~= 0 repeat {
				ans := cons(leadingCoefficient l, ans);
				l   := reductum l;
			}
			ans
		}

		(a:R) * (y:%):% == {
			z:% := 0;
			while y ~= 0 repeat {
				z := z + monomial(a * leadingCoefficient y,
							degree y);
				y := reductum y
			}
			z
		}

		-- if R has IntegralDomain then
		exactQuotient(l:%, a:R):Partial(%) == {
			import from R;
			ans:% := 0;
			while l ~= 0 repeat {
				(q, r) := divide(leadingCoefficient l, a);
				r ~= 0 => return failed;
				ans := ans + monomial(q, degree l);
				l   := reductum l;
			}
			[ans]
		}

		-- if R has GcdDomain then
		content(l:%):R == {
			import from List R;
			empty?(c := coefficients l) => 0;
			g := first c;
			while not empty?(c:=rest c) repeat g:=gcd(g,first c);
			g;
		}

		primitivePart(l:%):% == {
			import from Partial %;
			retract exactQuotient(l, content l)
		}

		-- if R has Field then
		rightLcm(a:%, b:%):%          == nclcm(a, b, leftEEA);
		leftLcm(a:%, b:%):%           == nclcm(a, b, rightEEA);
		rightGcd(a:%, b:%):%          == ncgcd(a, b, rightRemainder);
		leftGcd(a:%, b:%):%           == ncgcd(a, b, leftRemainder);
		leftQuotient(a:%, b:%):%      == {(q,r):= leftDivide(a,b); q }
		leftRemainder(a:%, b:%):%     == {(q,r):= leftDivide(a,b); r }
		rightQuotient(a:%, b:%):%     == {(q,r):= rightDivide(a,b);q }
		rightRemainder(a:%, b:%):%    == {(q,r):= rightDivide(a,b);r }
		exactQuot(q:%, r:%):Partial % == { zero? r => [q]; failed }

		leftExactQuotient(a:%, b:%):Partial % ==
			exactQuot leftDivide(a, b);

		rightExactQuotient(a:%,b:%):Partial % ==
			exactQuot rightDivide(a,b);

		leftExtendedGcd(a:%,b:%):Record(coef1:%,coef2:%,generator:%)==
			extended(a, b, leftEEA);

		rightExtendedGcd(a:%,b:%):Record(coef1:%,coef2:%,generator:%)==
			extended(a, b, rightEEA);

		-- returns [g = leftGcd(a, b), c, d, l = rightLcm(a, b)]
		-- such that g := a c + b d
		leftEEA(a:%, b:%):(%, %, %, %) == {
			a0 := a;
			u0:% := v:% := 1;
			v0:% := u:% := 0;
			while b ~= 0 repeat {
				(q, r) := leftDivide(a, b);
				(a, b) := (b, r);
				(u0, u):= (u, u0 - u * q);
				(v0, v):= (v, v0 - v * q)
			}
			(a, u0, v0, a0 * u)
		}

		ncgcd(a:%, b:%, ncrem:(%, %) -> %):% == {
			import from N;
			zero? a => b;
			zero? b => a;
			degree a < degree b => ncgcd(b, a, ncrem);
			while b ~= 0 repeat (a, b) := (b, ncrem(a, b));
			a
		}

		extended(a:%, b:%, eea:(%,%) -> (%,%,%,%)):
			Record(coef1:%, coef2:%, generator:%) == {
			import from N;
			zero? a => [0, 1, b];
			zero? b => [1, 0, a];
			degree a < degree b =>
				{(g, c1, c2, l) := eea(b,a); [c2, c1, g]}
			(g, c1, c2, l) := eea(a, b);
			[c1, c2, g]
		}

		nclcm(a:%, b:%, eea:(%,%) -> (%,%,%,%)):% == {
			import from N;
			zero? a or zero? b => 0;
			degree a < degree b => nclcm(b, a, eea);
			(g, c1, c2, l) := eea(b, a);
			l
		}

		-- returns [g = rightGcd(a, b), c, d, l = leftLcm(a, b)]
		-- such that g := a c + b d
		rightEEA(a:%, b:%):(%, %, %, %) == {
			a0 := a;
			u0:% := v:% := 1;
			v0:% := u:% := 0;
			while b ~= 0 repeat {
				(q, r) := rightDivide(a, b);
				(a, b) := (b, r);
				(u0, u):= (u, u0 - q * u);
				(v0, v):= (v, v0 - q * v)
			}
			(a, u0, v0, u * a0)
		}
	}   -- end from default definitions
}

--% Automorphisms
Automorphism(R:Ring): Join(Group, Applicable(R, R)) with {
	morphism: (R -> R) -> %;
	++ morphism(f) returns the non-invertible morphism given by f.
	morphism: (R -> R, R -> R) -> %;
	++ morphism(f, g) returns the invertible morphism given by f, where
	++ g is the inverse of f.
	morphism: ((R, Z) -> R) -> %;
	++ morphism(f) returns the morphism given by \spad{f^n(x) = f(x,n)}.
} == add {
	macro Rep == ((R, Z) -> R);

	1                          == per((r:R, n:Z):R +-> r);
	sample:%                   == 1;
	apply(f:%, r:R):R          == {import from Z; (rep f)(r, 1);}
	inv(f:%):%                 == per((r:R, n:Z):R +-> (rep f)(r, -n));
	(f:%) ^ (m:Z):%            == per((r:R, n:Z):R +-> (rep f)(r,n*m));
	morphism(f:(R, Z) -> R):%  == per f;
	morphism(f:R->R, g:R->R):% == per((r:R,n:Z):R +-> iterat(f,g,n,r));
	(u:%) = (v:%):Boolean      == false;
	apply(p:OutPort, x:%):OutPort == p;

	morphism(f:R -> R):% == {
		morphism(f, (r:R):R +-> error "Morphism is not invertible");
	}

	iterat(f:R->R, g:R->R, n:Z, r:R):R == {
		n < 0 => iter(g, -n, r);
		iter(f, n, r);
	}

	iter(f:R->R, n:Z, r:R):R == {
		import from Segment Z;
		for i in 1..n repeat r := f r;
		r
	}

	(f:%) * (g:%):% == {
		import from Z;
		f = g => f^2;
		per((s:R, n:Z):R +->
			iterat((r:R):R +-> f g r,
				(r:R):R +-> (inv g)((inv f) r),n,s));
	}
}

--% UnivariateSkewPolynomialCategoryOps
UnivariateSkewPolynomialCategoryOps(R:Field, -- Ring
	C:UnivariateSkewPolynomialCategory R): with {
		times: (C, C, Automorphism R, R -> R) -> C;
		++ times(p, q, sigma, delta) returns \spad{p * q}.
		++ \spad{\sigma} and \spad{\delta} are the maps to use.
		apply: (C, R, R, Automorphism R, R -> R) -> R;
		++ apply(p, c, m, sigma, delta) returns \spad{p(m)} where the
		++ action is given by \spad{x m = c sigma(m) + delta(m)}.
		-- the next 2 will later be  if R has IntegralDomain
		monicLeftDivide: (C, C, Automorphism R) -> (C, C);
		++ monicLeftDivide(a, b, sigma) returns the pair \spad{[q,r]}
		++ such that \spad{a = b*q + r} and the degree of \spad{r} is
		++ less than the degree of \spad{b}.
		++ \spad{b} must be monic.
		++ This process is called ``left division''.
		++ \spad{\sigma} is the morphism to use.
		monicRightDivide: (C, C, Automorphism R) -> (C, C);
		++ monicRightDivide(a, b, sigma) returns the pair \spad{[q,r]}
		++ such that \spad{a = q*b + r} and the degree of \spad{r} is
		++ less than the degree of \spad{b}.
		++ \spad{b} must be monic.
		++ This process is called ``right division''.
		++ \spad{\sigma} is the morphism to use.
		-- the next 2 will later be  if R has Field
		leftDivide: (C, C, Automorphism R) -> (C, C);
		++ leftDivide(a, b, sigma) returns the pair \spad{[q,r]} such
		++ that \spad{a = b*q + r} and the degree of \spad{r} is
		++ less than the degree of \spad{b}.
		++ This process is called ``left division''.
		++ \spad{\sigma} is the morphism to use.
		rightDivide: (C, C, Automorphism R) -> (C, C);
		++ rightDivide(a, b, sigma) returns the pair \spad{[q,r]} such
		++ that \spad{a = q*b + r} and the degree of \spad{r} is
		++ less than the degree of \spad{b}.
		++ This process is called ``right division''.
		++ \spad{\sigma} is the morphism to use.
} == add {
	times(x:C, y:C, sigma:Automorphism R, delta:R -> R):C == {
		zero? y => 0;
		z:C := 0;
		while x ~= 0 repeat {
			z := z + termPoly(leadingCoefficient x, degree x, y,
						sigma, delta);
			x := reductum x;
		}
		z
	}

	termPoly(a:R, n:N, y:C, sigma:Automorphism R, delta:R -> R):C == {
		zero? y => 0;
		zero? n => a * y;
		n1 := n - 1;
		z:C := 0;
		while y ~= 0 repeat {
			m := degree y;
			b := leadingCoefficient y;
			z := z + termPoly(a, n1, monomial(sigma b, m + 1),
					sigma, delta) + termPoly(a, n1,
					monomial(delta b, m), sigma, delta);
			y := reductum y;
		}
		z
	}

	apply(p:C, c:R, x:R, sigma:Automorphism R, delta:R -> R):R == {
		import from N; import from Segment N;
		w:R  := 0;
		xn:R := x;
		for i in 0..degree p repeat {
			w  := w + coefficient(p, i) * xn;
			xn := c * sigma xn + delta xn;
		}
		w
	}

	-- localLeftDivide(a, b) returns (q, r) such that a = q b + r
	-- b1 is the inverse of the leadingCoefficient of b
	localLeftDivide(a:C, b:C, sigma:Automorphism R, b1:R):(C, C) == {
		import from N; import from R;
		-- must comment out the error check, due to a compiler bug
		-- in version 33.2,  MB 1/94
		--zero? b => error "leftDivide: division by 0";
		n := degree(a) - (m := degree b);
		zero? a or n < 0 => (0, a);
		q0 := monomial((sigma^(-m))(b1 * leadingCoefficient a), n);
		(q, r) := localLeftDivide(a - b * q0, b, sigma, b1);
		(q + q0, r)
	}

	-- localRightDivide(a, b) returns (q, r) such that a = q b + r
	-- b1 is the inverse of the leadingCoefficient of b
	localRightDivide(a:C, b:C, sigma:Automorphism R, b1:R):(C, C) == {
		import from N; import from R;
		-- must comment out the error check, due to a compiler bug
		-- in version 33.2,  MB 1/94
		--zero? b => error "rightDivide: division by 0";
		n := degree(a) - (m := degree b);
		zero? a or n < 0 => (0, a);
		q0 := monomial(leadingCoefficient(a) * (sigma^n) b1, n);
		(q, r) := localRightDivide(a - q0 * b, b, sigma, b1);
		(q + q0, r)
	}

	-- if R has IntegralDomain then
	-- later will want to check for the leading coeff being a unit
	monicLeftDivide(a:C, b:C, sigma:Automorphism R):(C, C) == {
		import from R;
		u := leadingCoefficient b;
		--unit? u =>
			localLeftDivide(a, b, sigma, inv u);
		-- error "monicLeftDivide: divisor is not monic"
	}

	-- later will want to check for the leading coeff being a unit
	monicRightDivide(a:C, b:C, sigma:Automorphism R):(C, C) == {
		import from R;
		u := leadingCoefficient b;
		--unit? u =>
			localRightDivide(a, b, sigma, inv u);
		-- error "monicRightDivide: divisor is not monic"
	}

	-- if R has Field then
	leftDivide(a:C, b:C, sigma:Automorphism R):(C, C) == {
		import from R;
		localLeftDivide(a, b, sigma, inv leadingCoefficient b);
	}

	rightDivide(a:C, b:C, sigma:Automorphism R):(C, C) == {
		import from R;
		localRightDivide(a, b, sigma, inv leadingCoefficient b);
	}
}

--% SparseUnivariateSkewPolynomial
SparseUnivariateSkewPolynomial(R: Field,
			       sigma:Automorphism R,
			       delta:R -> R):
	  UnivariateSkewPolynomialCategory R with {
		apply: (OutPort, %, String) -> OutPort;
		++ apply(p, q, x) prints q on p using x for the anonymous variable.
} == add {
--	import from UnivariateSkewPolynomialCategoryOps(R, %);

	Term: BasicType with {
		term: (R, N) -> %;    -- term(c, n) creates the monomial c x^n
		coef: % -> R;         -- coef(c x^n) returns c
		expt: % -> N;         -- expt(c x^n) returns n
	} == add {
		macro Rep == Record(coef:R, expt:N);
		import from Rep;

		term(c:R, n:N):% == per [c, n];
		coef(t:%):R      == rep(t).coef;
		expt(t:%):N      == rep(t).expt;
		sample:%         == term(1, 1);
		apply(p:OutPort, x:%):OutPort == p;
		(u:%) = (v:%):Boolean == coef u = coef v and expt u = expt v;
	}
	macro Rep == List Term;   -- sorted, highest term first
	import from Term;
	import from Rep;
	import from R;
	import from N;

	0:%                       == per empty();
	1:%                       == per list term(1, 0);
	sample:%                  == 1;
	degree(p:%):N             == {zero? p => 0; expt first rep p}
	minimumDegree(p:%):N      == {zero? p => 0; expt last rep p}
	leadingCoefficient(p:%):R == {zero? p => 0; coef first rep p}
	reductum(p:%):%           == {zero? p => 0; per rest rep p}
	monomial(c:R, n:N):%      == {zero? c => 0; per list term(c, n)}
	(x:%) = (y:%):Boolean     == rep x = rep y;
	-(p:%):%                  == (-1@%) * p;   -- doesn't see the Algebra R
	(p:%) * (c:R):%           == p * (c::%);
	apply(p:OutPort, x:%):OutPort == {import from String; apply(p, x, " ?")}

	(x:%) + (y:%):% == {
		zero? x => y; zero? y => x;
		nx := degree x; ny := degree y;
		nx > ny => per cons(first rep x, rep(reductum x + y));
		nx < ny => per cons(first rep y, rep(x + reductum y));
		z := reductum x + reductum y;
		zero?(c := leadingCoefficient x + leadingCoefficient y) => z;
		per cons(term(c, nx), rep z);
	}

	applyTerm(p:OutPort, c:R, n:N, v:String):OutPort == {
		p := p(c);
		if n > 0 then {p := p v; if n > 1 then p := p("^")(n);}
		p;
	}

	apply(p:OutPort, x:%, v:String):OutPort == {
		zero? x => p(0$R);
		while x ~= 0 repeat {
			p := applyTerm(p, leadingCoefficient x, degree x, v);
			x := reductum x;
			if (x ~= 0) then p := p(" + ");
		}
		p;
	}

	coefficient(p:%, n:N):R == {
		for t in rep p repeat { n = expt t => return coef t }
		0
	}

	(x:%) * (y:%):%        == times(x, y, sigma, delta);
	apply(p:%, c:R, r:R):R == apply(p, c, r, sigma, delta);

	--if R has IntegralDomain then
	monicLeftDivide(a:%, b:%):(%, %)  == (a, b); --monicLeftDivide(a, b, sigma);
	monicRightDivide(a:%, b:%):(%, %) == (a, b); --monicRightDivide(a, b, sigma);

	--if R has Field then
	leftDivide(a:%, b:%):(%, %)  == (a, b); --leftDivide(a, b, sigma);
	rightDivide(a:%, b:%):(%, %) == (a, b); --rightDivide(a, b, sigma);

	times(x:%, y:%, sigma:Automorphism R, delta:R -> R):% == {
		zero? y => 0;
		z:% := 0;
		while x ~= 0 repeat {
			z := z + termPoly(leadingCoefficient x, degree x, y,
						sigma, delta);
			x := reductum x;
		}
		z
	}

	termPoly(a:R, n:N, y:%, sigma:Automorphism R, delta:R -> R):% == {
		zero? y => 0;
		zero? n => a * y;
		n1 := n - 1;
		z:% := 0;
		while y ~= 0 repeat {
			m := degree y;
			b := leadingCoefficient y;
			z := z + termPoly(a, n1, monomial(sigma b, m + 1),
					sigma, delta) + termPoly(a, n1,
					monomial(delta b, m), sigma, delta);
			y := reductum y;
		}
		z
	}

	apply(p:%, c:R, x:R, sigma:Automorphism R, delta:R -> R):R == {
		import from N; import from Segment N;
		w:R  := 0;
		xn:R := x;
		for i in 0..degree p repeat {
			w  := w + coefficient(p, i) * xn;
			xn := c * sigma xn + delta xn;
		}
		w
	}


}


macro {
	Q == Ratio Z;
	AUT == Automorphism Q;
	ORE == SparseUnivariateSkewPolynomial(Q, 1, zero);
}

zero(x:Q):Q == 0;

main():Z == {
	import from N, AUT;
  	import from ORE;
	a:Q := 1;
	sigma:AUT := 1;
	print("a = ")(a)()("sigma^(-100)(a) = ")((sigma^(-100)) a)();
  	p:ORE := monomial(a, 2) + monomial(a, 0);
  	print("x^2 + 1 = ")(p)();
	0
}

main()



#if 0
-- somewhat odder code added by pab

#library asdem "asdem"
import from asdem

PolyField(S: Field, E: OrderedAbelianGroup):Join(PolynomialCategory(S, E), Field) ==
  Polynomial (S, E) add {
	(a: %) ^ (n: Integer): % == {
		n = 0 => a;
		n < 0 => a ^ (-n);
		a*(a^(n-1))
	}
	
	inv(a: %): % == error "oops--inverse";
}


macro {
	Q == Ratio Z;
	P == PolyField (Q, Z);
	ORE == SparseUnivariateSkewPolynomial(P, morphism diff, zero);
}

zero(x:Q):Q == 0;
iden(x: Q): Q == x;

zero(x:P):P == 0;
iden(x: P): P == x;

diff(x: P): P == {
	import from P, Q, Z;
	if zero? x then 0
	else if degree x = 0 then 0
	else {
		monomial((degree x)::Q * leadingCoefficient(x), (degree x) - 1)
		+ diff(reductum x);
	}
}

import from Automorphism P;

main2():Z == {
	import from N;
  	import from ORE, P, Q;
	a: P := monomial(1+1+1, 2) + 1;
  	p:ORE := monomial(a, 2) + monomial(a, 0);
  	print("x^2 + 1 = ")(p)();
  	print("x^2 + 1 = ")(p)();
	print(p*p, "x")();
	print(p*p, "x")();
	print("a*a")(a*a)();
	print("p a")(p(1, a*a))();
	0
}

main()
#endif
