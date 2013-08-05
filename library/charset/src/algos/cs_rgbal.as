-------------------------------------------------------------------------
--
-- cs_rgbal.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{encapsulates function for computation of reduced Gröbner bases}
+++The functions of \adthistype have to give Gröbner basis in the form of autoreduced sets. Such Gröbner bases are called \emph{reduced} Gröbner bases (see \cite{Winkler1996}).
+++
+++The \adname[GroebnerBasisAlgorithmType]{groebnerBasis} functions and the \adname[TriangularizationAlgorithmType]{triangularize} functions of \adthistype have to implement the same algorithm.
+++\end{addescription}
+++\begin{adremarks}
+++Even though the returned values of the \adname[GroebnerBasisAlgorithmType]{groebnerBasis} functions are not \adtype{AutoreducedSet}, the returned values still have to be autoreduced sets.
+++\end{adremarks}
ReducedGroebnerBasisAlgorithmType(
  T  : TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    GroebnerBasisAlgorithmType( T );
    TriangularizationAlgorithmType( T, RT );
    
    default {
	
	-------------------------------------

	groebnerBasis( a: Generator T ): ( List T, Set T ) == {
	    import from AS;
	    ( as: AS, premult: Set T ) := triangularize a;
	    ( [ generator as ] , premult)
	}
	
	-------------------------------------
	
    }

}