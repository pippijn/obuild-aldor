-------------------------------------------------------------------------
--
-- cs_pgcd.as
--
-------------------------------------------------------------------------

#include "charset.as"
--#assert USELOCALPREM

+++\begin{addescription}{extends a polynomial ring to a gcd domain}
+++\adcode{PR} denotes the polynomial ring to extend by a gcd algorithm.
+++The greatest common divisor is computed via a subresultant polynomial remainder sequence, as described for example in the algorithm PRS\_SR in \cite{Winkler1996}.
+++
+++\adcode{RT} has to be an implementation of pseudo reduction, as for example \adtype{PseudoRemainderReductionTools}.
+++\end{addescription}
+++\begin{adremarks}
+++For distributive polynomial rings it may be important to additionally export from \adtype{IndexedFreeModule}. This can be achieved via \adtype{DistributivePolynomialRingSubResultantPRSGcdDomainExtension}.
+++\end{adremarks}
PolynomialRingSubResultantPRSGcdDomainExtension(
  R: GcdDomain,
  V: VariableType,
  PR: with {
      PolynomialRing0( R, V );
      IntegralDomain;
  },
  RT: ReductionType PR
): with {
    if PR has PolynomialRing( R, V ) then
    {
	PolynomialRing( R, V );
    }
    PolynomialRing0( R, V );
    GcdDomain;
    if PR has RankedType then
    {
	RankedType;
    }

    +++\begin{addescription}{lifts a polynomial from the wrapped polynomial ring}
    +++\end{addescription}
    coerce: PR -> %;

    +++\begin{addescription}{pushes a polynomial back to the wrapped polynomial ring}
    +++\end{addescription}
    coerce: % -> PR;
    
} == (PR pretend with {
    if PR has PolynomialRing( R, V ) then
    {
	PolynomialRing( R, V );
    }
    PolynomialRing0( R, V );
    GcdDomain;
    if PR has RankedType then
    {
	RankedType;
    }
    coerce: PR -> %;
    coerce: % -> PR;
    IntegralDomain;
} ) add {

    
    ----------------------------------

    coerce( a: PR ): % == {
	a pretend %;
    }

    ----------------------------------

    coerce( a: % ): PR == {
	a pretend PR;
    }

    ----------------------------------

    content( a: %, var: V ): % == {
	local maxDeg: Integer := degree( a, var );
	local res: % := coefficient( a, var, 0 );
	for deg in 1 .. maxDeg repeat
	{
	    local coeff := coefficient( a, var, deg );
	    res := gcd( res, coeff );
	}
	res;
    }

    ----------------------------------
#if USELOCALPREM
    prem!( a: %, b: %, mainVar: V, degAMainVar: Integer, degBMainVar: Integer, lcB: % ): % == {

	assert( degAMainVar >= 0 );
	assert( degBMainVar >= 0 );
        assert( degree(b, mainVar ) = degBMainVar );
	assert( coefficient( b, mainVar, degBMainVar ) = lcB );
	assert( degree(a, mainVar ) = degAMainVar );

	degAMainVar < degBMainVar  => a;
	zero? degBMainVar => 0;

	assert( mainVar = mainVariable b );

	local degDiff: MachineInteger := machine( degAMainVar - degBMainVar );
	local mainVarPower: Array % := new next degDiff;
	local mainVarPercent: % := mainVar::%;
	mainVarPower . (firstIndex$(Array %)) := 1;
	for idx in (firstIndex$(Array %)) + 1 .. (firstIndex$(Array %)) + degDiff repeat
	{
	    mainVarPower . idx := mainVarPercent * mainVarPower . (prev idx);
	}	

	while ( degAMainVar >= degBMainVar ) repeat 
	{
            local negLcA := - coefficient( a, mainVar, degAMainVar );
	    a := add!( times!( a, lcB ), times!( times!( negLcA, b ), mainVarPower . ( (firstIndex$(Array %)) + machine ( degAMainVar - degBMainVar ) ) ) );
	    degAMainVar := degree( a, mainVar );
	}
	a;
    }

    ----------------------------------

    gcd( a: %, b: % ): % == {
        import from R;
	import from PR;
	import from RT;
	import from Integer;
	zero? a => copy b;
	zero? b => copy a;
	ground? a => (gcd$R) ( leadingCoefficient a, content b )::%;
	ground? b => (gcd$R) ( leadingCoefficient b, content a )::%;
	local mainVarA: V := mainVariable a;
	local mainVarB: V := mainVariable b;

	if mainVarA > mainVarB or ( mainVarA = mainVarB and degree( a, mainVarA ) > degree( b, mainVarB ) ) then
	{
	    f := a;
	    g := b;
	    mainVar := mainVarA;
	} else {
	    f := b;
	    g := a;
	    mainVar := mainVarB;
	}

	local contentF: % := content( f, mainVar );
	local contentG: % := content( g, mainVar );
	local d: % := gcd( contentF, contentG );
	import from Partial %;
	assert ~ failed? exactQuotient( f, contentF );
	f := retract exactQuotient( f, contentF );
	assert ~ failed? exactQuotient( g, contentG );
	g := retract exactQuotient( g, contentG );
	local lc: % := 1;
	local h: % := 1;	

	while not zero? g repeat
	{
	    local degGMainVar: Integer := degree ( g, mainVar );
	    local degFMainVar: Integer := degree ( f, mainVar );
	    local delta: Integer := degFMainVar - degGMainVar;
	    local lcG: % := coefficient( g, mainVar, degGMainVar );
	    assert( zero? h or one? h or delta >= 0 );
	    local pR: Partial % := exactQuotient( prem!( f, g, mainVar, degFMainVar, degGMainVar, lcG ), (lc*h^delta));
	    assert ~ failed? pR;
	    local r := (retract$(Partial %)) pR;
	    lc := lcG;
	    assert( zero? h or one? h or zero? delta or one? delta );
	    h := lc^delta*h^(1-delta);
	    f := g; g := r;
	}
	local contentFinalF: % := content( f, mainVar );
	local pPPF: Partial % := exactQuotient( f, contentFinalF );
	assert ~ failed? pPPF;
	times!( d, retract pPPF );
    }
    
#else

    gcd( a: %, b: % ): % == {
        import from R;
	import from PR;
	import from RT;
	import from Integer;
	zero? a => copy b;
	zero? b => copy a;
	ground? a => (gcd$R) ( leadingCoefficient a, content b )::%;
	ground? b => (gcd$R) ( leadingCoefficient b, content a )::%;
	local mainVarA: V := mainVariable a;
	local mainVarB: V := mainVariable b;
	mainVarA > mainVarB => gcd( content( a, mainVarA ), b);
	mainVarB > mainVarA => gcd( content( b, mainVarB ), a);
	assert( mainVarA = mainVarB );
	mainVar := mainVarA;
	if degree( a, mainVarA ) > degree( b, mainVarB ) then
	{
	    f := a;
	    g := b;
	} else {
	    f := b;
	    g := a;
	}

	local contentF: % := content( f, mainVar );
	local contentG: % := content( g, mainVar );
	local d: % := gcd( contentF, contentG );
	import from Partial %;
	assert ~ failed? exactQuotient( f, contentF );
	f := retract exactQuotient( f, contentF );
	assert ~ failed? exactQuotient( g, contentG );
	g := retract exactQuotient( g, contentG );
	local lc: % := 1;
	local h: % := 1;	

	local degGMainVar: Integer := degree ( g, mainVar );
	while not zero? degGMainVar repeat
	{
	    local degFMainVar: Integer := degree ( f, mainVar );
	    local delta: Integer := degFMainVar - degGMainVar;
	    local lcG: % := coefficient( g, mainVar, degGMainVar );
	    assert( degGMainVar > 0 and mainVariable g = mainVar );
	    local poweredH: %;	    
	    if zero? h or one? h then
	    {
		poweredH := h;
	    } else {
		assert( delta >= 0 );
		poweredH := h^delta;
	    }
	    local pR: Partial % := exactQuotient( (((reduce$RT)( f pretend PR, g pretend PR)) pretend %), lc*poweredH);
	    assert ~ failed? pR;
	    local r := (retract$(Partial %)) pR;
	    lc := lcG;
	    if zero? h or one? h then
	    {
		poweredH := h;
	    } else {
		assert( 1 - delta >= 0 );
		poweredH := h^( 1 - delta );
	    }
	    assert( delta >= 0 );
	    h := lc^delta*poweredH;
	    f := g; g := r;
	    degGMainVar := degree ( g, mainVar );
	}
	if ~ zero? g then
	{
	    f := g; 
	}
	local contentFinalF: % := content( f, mainVar );
	local pPPF: Partial % := exactQuotient( f, contentFinalF );
	assert ~ failed? pPPF;
	times!( d, retract pPPF );
    }

#endif
    
    ----------------------------------

    content( a: % ): R == {
	gcd( nonZeroCoefficients a );
    }

    ----------------------------------

    gcd( gen: Generator % ): % == {
	local res := 0;
	for elementGen in gen repeat 
	{
	    res := gcd( res, elementGen );
	}
	res;
    }

    ----------------------------------

}

