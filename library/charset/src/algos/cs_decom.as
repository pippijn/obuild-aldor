-------------------------------------------------------------------------
--
-- cs_decom.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{collects functions for decomposition into autoreduced sets}
+++The \adname{decompose} functions take elements of \adcode{T} and form \adtype{AutoreducedSet}{}s. These \adtype{AutoreducedSet}{}s are autoreduced with respect to \adcode{RT}. All four \adname{decompose} functions have to implement the same decomposition algorithm.
+++\end{addescription}
DecompositionAlgorithmType(
  T  : TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    +++\begin{addescription}{decomposes a \adtype{Generator} into a set of \adtype{AutoreducedSet}{}s}
    +++\end{addescription}
    decompose : Generator T -> Set AS;

    +++\begin{addescription}{decomposes a \adtype{Generator} into a set of \adtype{AutoreducedSet}{}s}
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    decompose : Generator T -> ( Set AS, Set T );
    
    +++\begin{addescription}{decomposes a \adtype{List} into a set of \adtype{AutoreducedSet}{}s}
    +++\end{addescription}
    decompose : List T -> Set AS;
    
    +++\begin{addescription}{decomposes a \adtype{List} into a set of \adtype{AutoreducedSet}{}s}
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    decompose : List T -> ( Set AS, Set T );
    
    default {
	
	-------------------------------------

	decompose( a: List T ): Set AS == {
	    ( tr: Set AS, premult: Set T) := decompose a;
	    tr;
	}

	-------------------------------------
	
	decompose( a: List T ): ( Set AS, Set T ) == {
	    decompose generator a;
	}

	-------------------------------------
	
	decompose( a: Generator T ): Set AS == {
	    ( tr: Set AS, premult: Set T) := decompose a;
	    tr;
	}

	-------------------------------------

    }

}