-------------------------------------------------------------------------
--
-- cs_bstls.as
--
-------------------------------------------------------------------------


#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{builds a lowest possible autoreduced set from given elements.}
+++This autoreduced set is built without reducing elements. So \adthistype only \emph{selects} an appropriate set of elements from the given elements. The \adcode{triangularize} functions of \adthistype implement the BasSet \cite{Wang2001} algortihm.
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{BasicSetSortedTools}
+++  \adtype{TriangularizationAlgorithmType}
+++  \adtype{UpdatableMedialSetAlgorithmType}
+++  \cite{Wang2001}
+++\end{adseealso}
BasicSetTools(
  T: RankedTriangularizationTType,
  RT : ReductionType T
): UpdatableMedialSetAlgorithmType( T, RT ) == add {

    -------------------------------------------

    triangularize!( oldC: AS, oldFwoC: List T, oldSat: Set T, R: List T ): ( AS, List T, Set T ) == {

	macro LT == List T;
	import from T;
	import from AS;
	import from Partial AS;
	import from RT;

	empty? R => ( oldC, oldFwoC, oldSat );
	
        -- FwoC contains those elements that are neither 
	-- in C nor F.
	local FwoC: LT := empty;
	local B: AS := empty;
	
        --Step B1.
	--F holds all posynomials of the previous computation
	local F: LT := append!( append!( [ generator oldC ], R ), oldFwoC );

        --Step B2.
	--loop until no elements are left to consider
        while ~ empty? F repeat 
	{
            --Step B2.1
	    --finding an element of lowest rank
	    local newElementB := first F;
	    for elementF in rest F repeat {
		if elementF < newElementB  then
		{
		    newElementB := elementF;
		}
	    }	    

            -- Step B2.2
	    partialB := insert!( newElementB, B );
	    assert( ~ failed? partialB );
            B := retract partialB;
	  
	    --Step B2.3.
	    if ground? newElementB then
	    {
		assert( (one?$MachineInteger) # B );
		--Bug 5: removeAll! may segfault, so removeAll is used
		FwoC := removeAll( newElementB, F );
		F := empty;
	    } else {
		local newF: LT := empty;
		--Bug 5: removeAll! may segfault, so removeAll is used
		for elementF in removeAll( newElementB, F ) repeat 
		{
		    if (reduced?$RT)( elementF, newElementB ) then 
		    {
			newF := insert!( elementF, newF );
		    } else {
			FwoC := insert!( elementF, FwoC );
		    }
		}
		F := newF;
	    }		
        }

	( B, FwoC, oldSat );
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
