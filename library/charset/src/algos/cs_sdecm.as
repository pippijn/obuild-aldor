-------------------------------------------------------------------------
--
-- cs_sdecm.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{collects functions for decomposition of more complex entities}
+++All functions of \adthistype (including the inhereted functions from \adtype{DecompositionAlgorithmType}) have to implement the same decomposition algorithm. The functions introduced by \adthistype take two parameters. These two parameters denote the entity that has to be decomposed.
+++
+++The first parameter of all \adname{decompose} functions have to share the same semantics. For \adname{decompose} functions of \adthistype taking two parameters, the second parameters have to share the same semantics.
+++To illustrate these conditions, let \adcode{l} denote a \adtype{List} and \adcode{s} denote a \adtype{Set}. Then
+++\begin{adsnippet}
+++decompose( l, s )
+++\end{adsnippet}
+++and
+++\begin{adsnippet}
+++decompose( generator l, generator s )
+++\end{adsnippet}
+++have to give the same result.
+++\end{addescription}
+++\begin{adremarks}
+++For the \adname{decompose} functions taking two parameters, these two parameters typically, but not necessarily, specify saturated ideals. There, the first parameter describes the generators of the ideal and the second parameter describes the elements by which is saturated.
+++\end{adremarks}
SaturatedDecompositionAlgorithmType(
  T: TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    DecompositionAlgorithmType( T, RT );
    
    +++\begin{addescription}{decomposes an entity specified by two \adtype{Generator}{}s}
    +++\end{addescription}
    decompose : ( Generator T, Generator T ) -> Set AS;
    
    +++\begin{addescription}{decomposes an entity specified by two \adtype{Generator}{}s}
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    decompose : ( Generator T, Generator T ) -> ( Set AS, Set T );
    
    +++\begin{addescription}{decomposes an entity specified by a \adtype{List} and a \adtype{Set}}
    +++\end{addescription}
    decompose : ( List T, Set T ) -> Set AS;

    +++\begin{addescription}{decomposes an entity specified by a \adtype{List} and a \adtype{Set}}
    +++The additional return value of type \adcode{Set T} holds those elements of \adcode{T} that have been used to multiply by.
    +++\end{addescription}
    decompose : ( List T, Set T ) -> ( Set AS, Set T );
    
    default {
	
	-------------------------------------
	
	decompose( a: List T, s: Set T ): Set AS == {
	    ( trs: Set AS, premult: Set T) := decompose( a, s );
	    trs;
	}

	-------------------------------------
	
	decompose( a: List T, s: Set T ): ( Set AS, Set T ) == {
	    decompose( generator a, generator s );
	}

	-------------------------------------
	
	decompose( a: Generator T, s: Generator T ): Set AS == {
	    ( trs: Set AS, premult: Set T) := decompose( a, s );
	    trs;
	}

	-------------------------------------
	
	decompose( a: Generator T ): ( Set AS, Set T ) == {
	    decompose( a, generator (empty$(Set T)) );
	}

	-------------------------------------
	
    }
    
}