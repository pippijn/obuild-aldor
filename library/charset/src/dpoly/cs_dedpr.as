-------------------------------------------------------------------------
--
-- cs_dedpr.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{extends a distributive polynomial ring to a differential polynomial ring}
+++The polynomial ring \adcode{PR} is extended by differential structure. This extension does not alter the representation of polynomials, but simply adds functions to apply dervations.
+++The differential structure (see \adtype{DifferentialType}) of \adcode{DIDOM} and \adcode{DVARS} have to correspond (i.e.: For every index $i$ of a derivation in \adcode{DVARS} or \adcode{DIDOM}, the \adtype{Symbol} of the derivation $i$ of \adcode{DIDOM} has to be the same \adtype{Symbol} as the \adtype{Symbol} of the derivation $i$ of \adcode{DVARS}. For example, if the derivation of index $2$ of \adcode{DIDOM} is denoted by the symbol \adcode{d}, the derivation of index $2$ of \adcode{DVARS} also has to be denoted by \adcode{d}.)
+++\end{addescription}
+++\begin{adremarks}
+++If \adcode{PR} does not export \adtype{IndexedFreeModule}, \adtype{DifferentiallyExtendedPolynomialRing} can be used to extend \adcode{PR} to a differential polynomial ring.
+++\end{adremarks}
DifferentiallyExtendedDistributivePolynomialRing(
  DIDOM : with{ IntegralDomain; DifferentialType; },
  VARS  : FiniteVariableType,
  DVARS : DifferentialVariableType VARS,
  EXP   : ExponentCategory DVARS,
  PR    : with {
      PolynomialRing0( DIDOM, DVARS );
      IndexedFreeModule( DIDOM, EXP );
  }
) : with {
    if PR has GcdDomain then
    { 
	GcdDomain;
    }
    if PR has PolynomialRing( DIDOM, DVARS ) then
    { 
	PolynomialRing( DIDOM, DVARS );
    }
    DifferentialPolynomialRingType( DIDOM, VARS, DVARS );
    IndexedFreeModule( DIDOM, EXP );
} == (DifferentiallyExtendedPolynomialRing( DIDOM, VARS, DVARS, PR ) pretend with 
  {
      if PR has GcdDomain then
      { 
	  GcdDomain;
      }
      if PR has PolynomialRing( DIDOM, DVARS ) then
      { 
	  PolynomialRing( DIDOM, DVARS );
      }
      DifferentialPolynomialRingType( DIDOM, VARS, DVARS );
      IndexedFreeModule( DIDOM, EXP );
  }
)
add {
    
    macro Rep == PR;
    
    -------------------------------------------	  

    differentiate( a:%, dv:DVARS ): % == {
	local ret: Rep := 0;
	local dvExp: EXP := exponent dv;

	for monomial in terms( rep a ) repeat
	{
	    local coeffMonomialA: DIDOM;	    
	    local termMonomialA: EXP;
	    ( coeffMonomialA, termMonomialA ) := monomial;

	    local pCancelled: Partial EXP := cancelIfCan( termMonomialA, dvExp );	    
	    if ~ failed? pCancelled then
	    {
		import from Integer;
		local cancelled := retract pCancelled;
                --the "times!" and "::" instead of "*" decreases performance
		--ret := add!( ret, term( times!( (next degree( cancelled, dv ))::DIDOM, coeffMonomialA ), cancelled ) );
		ret := add!( ret, term( next degree( cancelled, dv ) * coeffMonomialA, cancelled ) );	    
	    }
	}
	per ret;
    }           

    -------------------------------------------	  

    derivationFunction( idx: Integer ): % -> % == {
	local varDerivation: DVARS -> DVARS := (derivationFunction$DVARS) idx;
	local fldDerivation: DIDOM -> DIDOM := (derivationFunction$DIDOM) idx;
	( a: % ): % +-> {		      
	    import from List DVARS;
	    import from DVARS;
	    local ret : % := 0;
	    for monomialA in terms a repeat
	    {
		local coeffMonomialA: DIDOM;
		local termMonomialA: EXP;				
		( coeffMonomialA, termMonomialA ) := monomialA;

		local dCoeff := fldDerivation coeffMonomialA;
		ret := add!( ret, term( dCoeff, termMonomialA ) );

		for dvWithDeg in terms termMonomialA repeat
		{
		    local dv: DVARS;
		    local deg: Integer;
		    ( dv, deg ) := dvWithDeg;
		    ret := add! ( ret, term( deg * coeffMonomialA, add!( cancel( termMonomialA, exponent dv ), exponent varDerivation dv ) ) );
		    
		}
	    }
	    ret;		  
	}
    };


    -------------------------------------------


    derivationFunction( sym: Symbol ): % -> % == {
	local varDerivation: DVARS -> DVARS := (derivationFunction$DVARS) sym;
	local fldDerivation: DIDOM -> DIDOM := (derivationFunction$DIDOM) sym;
	( a: % ): % +-> {		      
	    import from List DVARS;
	    import from DVARS;
	    local ret : % := 0;
	    for monomialA in terms a repeat
	    {
		local coeffMonomialA: DIDOM;
		local termMonomialA: EXP;				
		( coeffMonomialA, termMonomialA ) := monomialA;

		local dCoeff := fldDerivation coeffMonomialA;
		ret := add!( ret, term( dCoeff, termMonomialA ) );

		for dvWithDeg in terms termMonomialA repeat
		{
		    local dv: DVARS;
		    local deg: Integer;
		    ( dv, deg ) := dvWithDeg;
		    ret := add! ( ret, term( deg * coeffMonomialA, add!( cancel( termMonomialA, exponent dv ), exponent varDerivation dv ) ) );
		    
		}
	    }
	    ret;		  
	}
    };

    -------------------------------------------

    separant( a: % ): % == {
	ground? a => 0;
	differentiate( a, mainVariable a);
    }

    -------------------------------------------

    initial( a: % ): % == {
	ground? a => a;
	local mainVariableA := mainVariable a;
	coefficient( a, mainVariableA, degree( a, mainVariableA ) );
    }

    -------------------------------------------

    if PR has GcdDomain then 
    {
	gcd( a: %, b: % ): % == {
	    import from Rep;
	    per gcd( rep a, rep b );
	}
    }

    -------------------------------------------

}
      
  
