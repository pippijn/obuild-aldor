-------------------------------------------------------------------------
--
-- cs_dpcom.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{marks a polynomial ring to be commutative}
+++\end{addescription}
+++\begin{adremarks}
+++Some polynomial rings do not export \adtype{CommutativeRing}, although they are commutative polynomial rings. \LibAlgebra's domain \adtype{DistributedMultivariatePolynomial1} may serve as an example if its indeterminates act commutatively and its coefficient domain is a commutative ring. With the help of \adthistype, such commutative polynomial rings can be wrapped to export \adtype{CommutativeRing}.
+++\end{adremarks}
DistributivePolynomialRingCommutativeRingExtension(
  R: CommutativeRing,
  V: VariableType,
  E: ExponentCategory V,
  PR: with {
      IndexedFreeModule( R, E );
      PolynomialRing0( R, V );
  }
): with {
    IndexedFreeModule( R, E );
    PolynomialRing0( R, V );
    CommutativeRing;
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
      RankedType;
      IndexedFreeModule( R, E );
      PolynomialRing0( R, V );
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

    reciprocal( a: % ): Partial % == {
	import from R;
	zero? a or not ground? a => failed;
	rLCA: Partial R := reciprocal leadingCoefficient a;
	failed? rLCA => failed;
	[ (retract rLCA)::% ]
    }
}

