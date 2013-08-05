-------------------------------------------------------------------------
--
-- cs_dpidm.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{marks a polynomial ring to be an integral domain}
+++\end{addescription}
+++\begin{adremarks}
+++Some polynomial rings do not export \adtype{IntegralDomain}, although they are integral domains. \LibAlgebra's domain \adtype{DistributedMultivariatePolynomial1} may serve as an example if its indeterminates act commutatively and its coefficient domain is an integral domain. With the help of \adthistype, such polynomial rings can be wrapped to export \adtype{IntegralDomain}.
+++
+++Typically, polynomial rings that are integral domain but lack the \adtype{IntegralDomain} export are missing \adtype{CommutativeRing} as well. In such situations, \adtype{DistributivePolynomialRingCommutativeRingExtension} can be used to get the proper exports.
+++\end{adremarks}
DistributivePolynomialRingIntegralDomainExtension(
  R: IntegralDomain,
  V: VariableType,
  E: ExponentCategory V,
  PR: with {
      IndexedFreeModule( R, E );
      PolynomialRing0( R, V );
      CommutativeRing;
  }
): with {
    IndexedFreeModule( R, E );
    PolynomialRing0( R, V );
    IntegralDomain;
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
      IndexedFreeModule( R, E );
      PolynomialRing0( R, V );
      CommutativeRing;
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

    exactQuotient( dividend:%, divisor:% ): Partial % == {
	import from R;
	import from Integer;
	import from MachineInteger;
	
	one? divisor => [ dividend ];
	zero? divisor => failed;
	zero? dividend => [ 0 ];

	ground? divisor => {
	    import from R;
            local lCDivisor: R := leadingCoefficient divisor;
            local pReciLCDivisor: Partial R := reciprocal lCDivisor;
	    ~ failed? pReciLCDivisor => [ (retract pReciLCDivisor) * dividend ];
	    
	    local result: % := 0;
	    for monomialDividend in dividend repeat
	    {
		( coeffDividend: R, termDividend: E ) := monomialDividend;
		local pDividedCoeff: Partial R := exactQuotient( coeffDividend, lCDivisor );
		if failed? pDividedCoeff then
		{
		    return failed;
		}
		result := add!( result, term( retract pDividedCoeff, termDividend ) );
	    }
	    
	    [ result ]
	}
	
	ground? dividend => failed;
	
	local mainVariableDivisor := mainVariable divisor;
 	local degreeDivisor  := degree( divisor, mainVariableDivisor);
 	local degreeDividend := degree( dividend, mainVariableDivisor);

	degreeDividend < degreeDivisor => failed;
		
	
	-- Main Variable        is a
	-- Degree Dividend in a is n
	-- Degree Divisor in a  is m
	--
	-- Dividend_n*a^n + c_{n-1}*a^{n-1} + ...
	--     
	-- Divisor
	--   d_m*a^m + d_{m-1}*a^{m-1} + ...
        --
	-- Quotient:
	--   e_{n-m}*a^{n-m} + e_{e-m-1}*a^{n-m-1} + ...
        --
 	
	-- the negDivisorCoeffs array stores the NEGATIVE coefficients
	-- of the divisor
	--   -d_2 is stored in negDivisorCoeffs.( next next (firstIndex$(Array %)) )
	local negDivisorCoeffs: Array % := new next machine degreeDivisor;
	
	macro degToIdx( deg ) == { ( (machine$Integer) deg ) + (firstIndex$(Array %)) };
	macro idxToDeg( idx ) == { (idx - (firstIndex$(Array %))) :: Integer };


	for negDivisorDeg in 0 .. degreeDivisor repeat
	{
	    negDivisorCoeffs . ( degToIdx negDivisorDeg ) := coefficient( divisor, mainVariableDivisor, negDivisorDeg );
	}
	local dm: % := negDivisorCoeffs . ( degToIdx degreeDivisor );

	
 	-- quotientCoeffs array stores the coefficients of the quotientr
	--   -e_2 is stored in quotient.( next next (firstIndex$(Array %)) )
	local quotientCoeffs: Array % := new next machine ( degreeDividend - degreeDivisor );
	local quotient: % := 0;

	for quotientIdx in degToIdx( degreeDividend - degreeDivisor ) .. degToIdx( 0 ) by -1 repeat
	{

	    -- in this loop
	    -- quotient . quotientIdx is set
	    local degForC := idxToDeg( quotientIdx ) + degreeDivisor;
	    local subDividend: % := coefficient( dividend, mainVariableDivisor, degForC );
	    -- subtract all possibilities that fit the degree
            for degDivisorAdd in 0 .. prev degreeDivisor repeat
	    {  
		local degQuotientAdd := idxToDeg( quotientIdx ) - degDivisorAdd;
		if degQuotientAdd >= 0 then
		{
		    subDividend := add!( subDividend, 
		      negDivisorCoeffs . ( degToIdx degDivisorAdd )
		      * quotientCoeffs . ( degToIdx degQuotientAdd )
		  );
	      }
	    
	    }
	    partE: Partial % := exactQuotient( subDividend, dm );
	    if failed? partE then
	    {
		return failed;
	    }
	    quotientCoeffs . quotientIdx  := retract partE;
	    local accumulatedMainVar := (mainVariableDivisor::%)^(idxToDeg quotientIdx);
	    quotient := add!( quotient, quotientCoeffs . quotientIdx * accumulatedMainVar );
	    dividend := dividend - quotientCoeffs . quotientIdx * divisor * accumulatedMainVar;
	    
	}
	zero? dividend => [ quotient ];
	failed;
   }
   
}

