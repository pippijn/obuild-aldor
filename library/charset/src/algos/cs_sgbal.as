-------------------------------------------------------------------------
--
-- cs_sgbal.as
--
-------------------------------------------------------------------------

#include "charset.as"


+++\begin{addescription}{collects functions to compute Gr�bner basis of saturated ideals}
+++Implementations of \adthistype compute a Gr�bner basis for elements of \adcode{T} with respect to the reduction \adcode{RT}.
+++
+++All functions of \adthistype (including the inhereted functions from \adtype{GroebnerBasisAlgorithmType}) have to implement the same Gr�bner basis algorithm. 
+++
+++The functions introduced by \adthistype take two parameters. There, the first parameter denotes the generetor of the ideal to compute a Gr�bner basis for. The second parameter denotes those elements of \adcode{T} by which the ideal is separated.
+++\end{addescription}
SaturatedGroebnerBasisAlgorithmType(
  T: TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    GroebnerBasisAlgorithmType( T );
    
    +++\begin{addescription}{computes a Gr�bner basis of a saturated ideal}
    +++\adcode{groebnerBasis( l, s )} computes a Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++\end{addescription}
    groebnerBasis : ( Generator T, Generator T ) -> List T;
    
    +++\begin{addescription}{computes a Gr�bner basis of a saturated ideal}
    +++\adcode{groebnerBasis( l, s )} computes a Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    groebnerBasis : ( Generator T, Generator T ) -> ( List T, Set T );

    +++\begin{addescription}{computes a Gr�bner basis of a saturated ideal}
    +++\adcode{groebnerBasis( l, s )} computes a Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++\end{addescription}
    groebnerBasis : ( List T, Set T ) -> List T;
    
    +++\begin{addescription}{computes a Gr�bner basis of a saturated ideal}
    +++\adcode{groebnerBasis( l, s )} computes a Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    groebnerBasis : ( List T, Set T ) -> ( List T, Set T );
    
    default {
	
	-------------------------------------
	
	groebnerBasis( a: List T, s: Set T ): List T == {
	    groebnerBasis( generator a, generator s );
	}

	-------------------------------------
	
	groebnerBasis( a: List T, s: Set T ): ( List T, Set T ) == {
	    groebnerBasis( generator a, generator s );
	}

	-------------------------------------
	
	groebnerBasis( a: Generator T, s: Generator T ): List T == {
	    ( gb: List T, premult: Set T) := groebnerBasis( a, s );
	    gb;
	}

	-------------------------------------
	
	groebnerBasis( a: Generator T ): ( List T, Set T ) == {
	    groebnerBasis( a, generator (empty$(List T)) );
	}

	-------------------------------------
	
    }
    
}