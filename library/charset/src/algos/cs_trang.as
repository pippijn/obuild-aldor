-------------------------------------------------------------------------
--
-- cs_trang.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{encapsulates functions for triangularizaiton algorithms.}
+++ Domains that implement \adthistype represent algorithms to triangularize given elements of \adcode{T} with respect to \adcode{RT}. All four functions of \adthistype have to implement the same algorithm. However, different criteria on input and output has to be met for each function, as can bee seen in the functions' description.
+++\end{addescription}
TriangularizationAlgorithmType(
  T  : TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    +++\begin{addescription}{computes an autoreduced set from a \adtype{Generator} without collecting premultiplicants.}
    +++\end{addescription}
    triangularize : Generator T -> AS;

    +++\begin{addescription}{computes an autoreduced set from a \adtype{Generator} and collects premultiplicants.}
    +++  The \adcode{Set T} part of the output contains those elements, which have been used to premultiply when executing 
    +++  the algorithm.
    +++\end{addescription}
    triangularize : Generator T -> ( AS, Set T );

    +++\begin{addescription}{computes an autoreduced set from a \adtype{List} without collecting premultiplicants.}
    +++\end{addescription}
    triangularize : List T -> AS;

    +++\begin{addescription}{computes an autoreduced set from a \adtype{List} and collects premultiplicants.}
    +++  The \adcode{Set T} part of the output contains those elements, which have been used to premultiply when executing 
    +++  the algorithm.
    +++\end{addescription}
    triangularize : List T -> ( AS, Set T );
    
    default {
	
	-------------------------------------
	
	triangularize( a: List T ): AS == {
	    ( tr: AS, premult: Set T) := triangularize a;
	    tr;
	}

	-------------------------------------
	
	triangularize( a: List T ): ( AS, Set T ) == {
	    triangularize generator a;
	}

	-------------------------------------
	
	triangularize( a: Generator T ): AS == {
	    ( tr: AS, premult: Set T) := triangularize a;
	    tr;
	}

	-------------------------------------
	
    }

}