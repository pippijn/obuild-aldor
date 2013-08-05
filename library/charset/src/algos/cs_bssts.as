-------------------------------------------------------------------------
--
-- cs_bssts.as
--
-------------------------------------------------------------------------


#include "charset.as"

macro AS == AutoreducedSet( T, RT );

--the following assert does not check the
--autoreduced property by insertion, but
--via calling the reduced? functions directly
--#assert CHECKDIRECTLY

+++\begin{addescription}{builds a lowest possible autoreduced set from given elements.}
+++This autoreduced set is built without reducing elements. So \adthistype only \emph{selects} an appropriate set of elements from the given elements. The \adcode{triangularize} functions of \adthistype implement the BasSetSort algorithm as described in \cite{Aistleitner2005}. BasSetSorted is a variant of the BasSet \cite{Wang2001} algortihm that sorts the input before computing a basic set.
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{BasicSetTools}
+++  \adtype{TriangularizationAlgorithmType}
+++  \adtype{UpdatableMedialSetAlgorithmType}
+++  \cite{Aistleitner2005}
+++  \cite{Wang2001}
+++\end{adseealso}
BasicSetSortedTools(
  T: RankedTriangularizationTType,
  RT : ReductionType T
): UpdatableMedialSetAlgorithmType( T, RT ) == add {

    -------------------------------------------

    triangularize!( oldC: AS, oldFwoC: List T, oldSat: Set T, R: List T ): ( AS, List T, Set T ) == {

	macro LT == List T;
	import from T;
	import from AS;
	import from Partial AS;

	empty? R => ( oldC, oldFwoC, oldSat );
	
        -- FwoC contains those elements that are neither 
	-- in C nor in sortedA
	local FwoC: DoubleEndedList T := empty(); 
	

        -- sortedA holds all polynomials that are still to
	-- consider in ascending order
	local sortedA: LT := merge!( merge!( sort!( [ generator oldC ], < ), sort!( R, < ), < ), oldFwoC, < );

        -- the first element in sortedA is always the first element
	-- of the resulting autoreduced set
	local partialB: Partial AS := [ first sortedA ];
	assert ~ failed? partialB;
	local B: AS := retract partialB;

	--moving sortedA ahead
        sortedA := rest sortedA;
	
	--quick exit, if B is already contradictory
        contradictory? B => ( B, sortedA, oldSat );

#if CHECKDIRECTLY
        import from RT;
        --List for the reducedBy? functions of the elements in B
	local reducedBy?Funcs: List ( T -> Boolean ) := [ reducedBy? B . (firstIndex$AS) ];
#endif
	--loop until no elements are left to consider
        while ~ empty? sortedA repeat {

#if CHECKDIRECTLY
	    local firstSortedA := first sortedA;
	    local isReduced? := true;
	    for reducedBy?Func in reducedBy?Funcs while isReduced? repeat
	    {
		isReduced? := reducedBy?Func firstSortedA;
	    }
	    if isReduced? then
	    {
		reducedBy?Funcs := insert!(reducedBy? firstSortedA, reducedBy?Funcs );
		partialB := insert!(firstSortedA, B);
		assert( ~ failed? partialB );
                B := retract partialB;
	    } else {
		FwoC := concat!( FwoC, firstSortedA );
	    }
#else	    
            partialB := insert!(first sortedA, B);
            if ~ failed? partialB then {
                B := retract partialB;
            } else {
		FwoC := concat!( FwoC, first sortedA );
            }
#endif
            sortedA := rest sortedA;
        }

	( B, firstCell FwoC, oldSat );
    }


    -------------------------------------------

    triangularize( listA: List T ): ( AS, Set T ) == {
	( C: AS, F: List T, S: Set T ) := triangularize!( empty, empty, empty, copy listA );
	( C, S );
    }

    -------------------------------------------

    triangularize( genA: Generator T ): ( AS, Set T ) == {
	import from List T;
	( C: AS, F: List T, S: Set T ) := triangularize!( empty, empty, empty, [ genA ] );
	( C, S );
    }

    -------------------------------------------

}
