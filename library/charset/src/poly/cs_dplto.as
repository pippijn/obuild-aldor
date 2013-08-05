-------------------------------------------------------------------------
--
-- cs_dplto.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{introduces a ranking on polynomials}
+++The polynomial ring \adcode{PR} is extended by a ranking. Let $a$ and $b$ denote elements of \adthistype. $a<b$ if and only if the leading term of $a$ (see \adname[IndexedFreeModule]{leadingTerm} of \adtype{IndexedFreeModule}) is smaller than the leading term of $b$. The terms are compared by comparison function of \adcode{E} (\adtype{ExponentCategory} has \adtype{TotallyOrderedType}).
+++\end{addescription}
DistributivePolynomialRingLeadingTermOrderExtension(
  R: Ring,
  VARS: VariableType,
  E: ExponentCategory VARS,
  PR: with {
      IndexedFreeModule( R, E );
      PolynomialRing0( R, VARS );
  }
): with {
    RankedType;
    IndexedFreeModule( R, E );
    PolynomialRing0( R, VARS );
    if PR has CommutativeRing then
    {
	CommutativeRing;
    }
    if PR has IntegralDomain then
    {
	IntegralDomain;
    }
    if PR has GcdDomain then
    {
	GcdDomain;
    }

    +++\begin{addescription}{lifts a polynomial from the wrapped polynomial ring}
    +++\end{addescription}
    coerce: PR -> %;

    +++\begin{addescription}{pushes a polynomial back to the wrapped polynomial ring}
    +++\end{addescription}
    coerce: % -> PR;
    
} == (PR pretend with {
      RankedType;
      IndexedFreeModule( R, E );
      PolynomialRing0( R, VARS );
      if PR has CommutativeRing then
      {
	  CommutativeRing;
      }
      if PR has IntegralDomain then
      {
	  IntegralDomain;
      }
      if PR has GcdDomain then
      {
	  GcdDomain;
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

    <( a: %, b: % ): Boolean == {
	import from E;
	( ltAcoeff, ltA ) := leadingTerm a;
	( ltBcoeff, ltB ) := leadingTerm b;
	ltA < ltB;
    }

}

