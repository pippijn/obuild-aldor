-------------------------------------------------------------------------
--
-- cs_srgba.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{collects functions to compute reduced Gr�bner bases of saturated ideals}
+++Implementations of \adthistype compute a Gr�bner basis for elements of \adcode{T} with respect to the reduction \adcode{RT}.
+++All functions of \adthistype have to implement the same Gr�bner basis algorithm. 
+++\end{addescription}
SaturatedReducedGroebnerBasisAlgorithmType(
  T: TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    SaturatedGroebnerBasisAlgorithmType( T, RT );
    ReducedGroebnerBasisAlgorithmType( T, RT );

    +++\begin{addescription}{computes a reduced Gr�bner basis of a saturated ideal}
    +++\adcode{triangularize( l, s )} computes a reduced Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++\end{addescription}
    triangularize : ( Generator T, Generator T ) -> AS;

        +++\begin{addescription}{computes a reduced Gr�bner basis of a saturated ideal}
    +++\adcode{triangularize( l, s )} computes a reduced Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    triangularize : ( Generator T, Generator T ) -> ( AS, Set T );
    
    +++\begin{addescription}{computes a reduced Gr�bner basis of a saturated ideal}
    +++\adcode{triangularize( l, s )} computes a reduced Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++\end{addescription}
    triangularize : ( List T, Set T ) -> AS;
    
    +++\begin{addescription}{computes a reduced Gr�bner basis of a saturated ideal}
    +++\adcode{triangularize( l, s )} computes a reduced Gr�bner basis for the ideal generated by \adcode{l} saturated by \adcode{s}.
    +++
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    triangularize : ( List T, Set T ) -> ( AS, Set T );

    default {
	
	-------------------------------------
	
	triangularize( a: List T, s: Set T ): AS == {
	    ( tr: AS, premult: Set T) := triangularize( a, s );
	    tr;
	}

	-------------------------------------
	
	triangularize( a: List T, s: Set T ): ( AS, Set T ) == {
	    triangularize( generator a, generator s );
	}

	-------------------------------------
	
	triangularize( a: Generator T, s: Generator T ): AS == {
	    ( tr: AS, premult: Set T) := triangularize( a, s );
	    tr;
	}

	-------------------------------------
	
	triangularize( a: Generator T ): ( AS, Set T ) == {
	    import from List T;
	    triangularize( a, generator (empty$(List T)) );
	}

	-------------------------------------

	groebnerBasis( a: Generator T, s: Generator T ): ( List T, Set T ) == {
	    import from AS;
	    ( as: AS, premult: Set T ) := triangularize( a, s );
	    ( [ generator as ] , premult)
	}
	
	-------------------------------------
	
    }
}    
