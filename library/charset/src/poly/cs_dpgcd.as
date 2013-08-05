-------------------------------------------------------------------------
--
-- cs_dpgcd.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{extends a distributive polynomial ring to a gcd domain}
+++\adcode{PR} denotes the polynomial ring to extend by a gcd algorithm.
+++The greatest common divisor is computed via a subresultant polynomial remainder sequence, as described for example in the algorithm PRS\_SR in \cite{Winkler1996}.
+++
+++\adcode{RT} has to be an implementation of pseudo reduction, as for example \adtype{PseudoRemainderReductionTools}.
+++\end{addescription}
+++\begin{adremarks}
+++For polynomial rings that are not stored distributively, the parameter \adcode{E} is obstructive. Therefore, \adtype{PolynomialRingSubResultantPRSGcdDomainExtension} provides a gcd algorithm for such polynomial rings, without having to state an \adtype{ExponentCategory}.
+++\end{adremarks}
DistributivePolynomialRingSubResultantPRSGcdDomainExtension(
  R: GcdDomain,
  V: VariableType,
  E: ExponentCategory V,
  PR: with {
      PolynomialRing0( R, V );
      IntegralDomain;
  },
  RT: ReductionType PR
): with {
    if PR has IndexedFreeModule( R, E ) then
    {
	IndexedFreeModule( R, E );
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

      if PR has IndexedFreeModule( R, E ) then
      {
	  IndexedFreeModule( R, E );
      }
      PolynomialRing0( R, V );
      IntegralDomain;
      if PR has RankedType then
      {
	  RankedType;
      }
  } 
) add {

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

