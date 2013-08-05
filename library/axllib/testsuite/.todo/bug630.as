--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue May 10 11:24:18 1994
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA30002; Tue, 10 May 1994 11:24:18 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5395; Tue, 10 May 94 11:24:19 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.9157.May.10.11:24:19.-0400>
--*           for asbugs@watson; Tue, 10 May 94 11:24:19 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Tue, 10 May 94 11:24:18 EDT
--* Received: from vinci.inf.ethz.ch (vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.8/8.6.6) with ESMTP id RAA03843 for <asbugs@watson.ibm.com>; Tue, 10 May 1994 17:24:15 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id RAA18450 for asbugs@watson.ibm.com; Tue, 10 May 1994 17:24:14 +0200
--* Date: Tue, 10 May 1994 17:24:14 +0200
--* Message-Id: <199405101524.RAA18450@vinci.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [3] Export not found at runtime [minisup.as][0.35.0 [=]]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--------------------------- minisup.as -----------------------------
-- produces an "Export not found" at runtime:
--
-- vinci.inf.ethz.ch{bronstei} 188: minisup
-- Looking in UP(Integer : <category>, x==<value> : String) for monomial
-- with code 436577962
-- Export not found

#include "axllib"

macro Z == Integer;

UPolyCat(F:Ring):Category == Ring with {
	monomial: (F, Z) -> %;
	degree  : % -> Z;
	leadingCoefficient: % -> F;
	reductum: % -> %;
	coerce  : F -> %;
	*       : (F, %) -> %;
}

SUP(F:Ring): UPolyCat F with {
	apply: (OutPort, %, String) -> OutPort;
} == add {
	Term: BasicType with {
		term: (F, Z) -> %;    -- term(c, n) creates the monomial c x^n
		coef: % -> F;         -- coef(c x^n) returns c
		expt: % -> Z;         -- expt(c x^n) returns n
	} == add {
		macro Rep == Record(coef:F, expt:Z);
		import from Rep;

		term(c:F, n:Z):% == per [c, n];
		coef(t:%):F      == rep(t).coef;
		expt(t:%):Z      == rep(t).expt;
		sample:%         == term(1, 1);
		apply(p:OutPort, x:%):OutPort == p;  -- never used
		(u:%) = (v:%):Boolean == coef u = coef v and expt u = expt v;
	}
	macro Rep == List Term;   -- sorted, highest term first
	import from {Term, Rep, F, Z};

	0:%                       == per empty();
	1:%                       == per list term(1, 0);
	degree(p:%):Z             == {zero? p => 0; expt first rep p}
	leadingCoefficient(p:%):F == {zero? p => 0; coef first rep p}
	reductum(p:%):%           == {zero? p => 0; per rest rep p}
	coerce(c:F):%             == monomial(c, 0);
	(x:%) = (y:%):Boolean     == rep x = rep y;
	-(p:%):%                  == per map(cterm(-1), rep p);
	(c:F) * (p:%):%           == per map(cterm c, rep p);
	cterm(c:F):(Term->Term)   == (t:Term):Term +-> term(c * coef t,expt t);

	apply(p:OutPort, x:%):OutPort == {
		import from String;
		apply(p, x, "?");
	}

	monomial(c:F, n:Z):% == {
		n < 0 => error("monomial: exponent should be nonnegative!");
		zero? c => 0;
		per list term(c, n);
	}

	(x:%) + (y:%):% == {
		zero? x => y; zero? y => x;
		nx := degree x; ny := degree y;
		nx > ny => per cons(first rep x, rep(reductum x + y));
		nx < ny => per cons(first rep y, rep(x + reductum y));
		z := reductum x + reductum y;
		zero?(c := leadingCoefficient x + leadingCoefficient y) => z;
		per cons(term(c, nx), rep z);
	}

	applyTerm(p:OutPort, c:F, n:Z, v:String):OutPort == {
		if c ~= 1 then
			if zero? n then p := p(c);
					else p := p("\left(")(c)("\right)")("");
		if zero? n and c = 1 then p := p(c);
		if n > 0 then {p := p v; if n > 1 then p := p("^{")(n)("}");}
		p;
	}

	apply(p:OutPort, x:%, v:String):OutPort == {
		zero? x => p(0$F);
		while x ~= 0 repeat {
			p := applyTerm(p, leadingCoefficient x, degree x, v);
			x := reductum x;
			if (x ~= 0) then p := p("+");
		}
		p;
	}

	coefficient(p:%, n:Z):F == {
		for t in rep p repeat { n = expt t => return coef t }
		0
	}

	(x:%) * (y:%):% == {
		zero? x => 0;
		a := leadingCoefficient x; n := degree x;
		reductum(x) * y + per [term(a*coef t, n+expt t) for t in rep y];
	}

}

UP(F:Ring, x:String): UPolyCat F == SUP F add {
		macro Rep == SUP F;
		import from Rep;

		apply(p:OutPort, q:%):OutPort == apply(p, rep q, x);
}

-- THIS SEEMS TO BE CAUSING TROUBLE
apply(F:Ring, l:List String): UPolyCat F == {
        empty? l => error "apply: expect at least one indeterminate";
        empty? rest l => UP(F, first l);
        error "apply: can only handle univariate polys for now";
}

main():Integer == {
        macro alpha == "\alpha";
        macro Z == Integer;

        import from {SingleInteger, Z, String,  List String};
        --import from UP(Z, alpha);  -- THIS ONE IS OK
	import from Z[alpha];        -- THIS ONE ISN'T

        a := monomial(1, 1);
        q := p := a + 1;
        for i in 1..5 repeat {
		print("$$")(q)("$$")();
                q := p * q;
        }
        1;
}

main()

