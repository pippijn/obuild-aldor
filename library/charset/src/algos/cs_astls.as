-------------------------------------------------------------------------
--
-- cs_astls.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{computes an autoreduced set without taking deltas into account}
+++ The \adcode{triangularize} functions of \adthistype implement the CharSetN algortihm of \cite{Wang2001}. The parameter \adcode{MSAT} is the subalgorithm of CharSetN to compute a medial set of some elements of \adcode{T}.
+++\end{addescription}
+++\begin{adremarks}
+++ If \adcode{MSAT} has \adtype{UpdatableMedialSetAlgorithmType}, then the medial set is not computed from scratch in each iteration, but the medial set gets only updated.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{TriangularizationAlgorithmType}
+++  \adtype{CoherentAutoreducedSetTools}
+++  \cite{Wang2001}
+++\end{adseealso}
AutoreducedSetTools(
  T    : RankedTriangularizationTType,  
  RT   : TriangularizationReductionType T,
  MSAT : MedialSetAlgorithmType( T, RT ) == BasicSetSortedTools( T, RT )
) : with {

    TriangularizationAlgorithmType( T, RT );

} == add {

    if MSAT has UpdatableMedialSetAlgorithmType( T, RT )  then 
    {
        --acts destructive on R
	triangularize!( R: List T, status: Pointer, buildStatus?: Boolean == false ): ( AS, Set T, Pointer ) == {	
	    import from RT;
	    macro STATUS == Record( C: AS, F: List T, premult: Set T, trPremult: Set T );
	    import from STATUS;

	    local C: AS;     -- the last autoreduced set
	    local F: List T; -- the elements not in C
	    
	    --there are two sets for holnding the premultiplicants, as UpdatableMedailSetAlgorithmType
	    --requires to be passed the premultiplicants of the previous step.
	    --so the premultiplicants from the medial set are collected in a seperate set (trPremult)
	    local premult : Set T; --the premultiplicants from deltas and reducing
	    local trPremult : Set T; --the premultiplicants from the medial set algorithm
	    
            --restoring the status
	    if nil? status then
	    {
		C := empty;
		F := empty;
		premult := empty;
		trPremult := empty;
	    } else {
		( C, F, premult, trPremult ) := explode( status pretend STATUS );
		C := copy C;
		F := copy F;
		premult := copy premult;
		trPremult := copy trPremult;
	    }

	    local stepPremult : Set T;

	    while ~ empty? R repeat
	    { 
		( C, F, trPremult ) := (triangularize!$MSAT) ( C, F, trPremult, R );

		R := empty;
		if ~ contradictory? C then
		{
		    --check if C reduces every element
		    local reduceFunc: T -> ( T, Set T ) := (reduceBy$RT) C;
                    --as F does not contain the elements of C the 
		    --triangularize! function of 
		    --UpdatableMedialSetAlgorithmType, there is no need for
                    --the member? check in
		    --  for elementF in F | ~ member?( elementF, C ) repeat
		    for elementF in F repeat
		    {
			import from RT;
			local red : T;
			( red, stepPremult ) := reduceFunc elementF;
			--Again, adjoin the premultiplicants, even in red is not
			--added to R. Since if one of stepPremult = 0, then
			--elementF could not be reduced to red in first place
			premult := union!( premult, stepPremult );
			if ~ ( zero? red or member?( red, F )  or member?( red, R ) ) then
			{
			    R := insert!( red, R );
			}
		    }
		}
	    }


	    if buildStatus? then
	    {
                --no need to copy F, as F is not returned directly
		status := record( copy C, F, copy premult, copy trPremult ) pretend Pointer;
	    } else {
		status := nil;
	    }	    
	    ( C, union!( premult, trPremult ), status );
	}
    } else {
	--so MSAT does not have UpdatableMedialSetAlgorithmType( T, RT )

	--acts destructive on R
	triangularize!( R: List T, status: Pointer, buildStatus?: Boolean == false ): ( AS, Set T, Pointer ) == {	
	    import from RT;

	    macro STATUS == Record( C: AS, F: List T, premult: Set T );
	    import from STATUS;

	    local C: AS;     -- the last autoreduced set
	    local F: List T; -- the elements to compute for C
	    local premult : Set T; --the premultiplicants
            --restoring the status
	    if nil? status then
	    {
		C := empty;
		F := empty;
		premult := empty;
	    } else {
		( C, F, premult ) := explode( status pretend STATUS );
		C := copy C;
		F := copy F;
		premult := copy premult;
	    }

	    local stepPremult : Set T;

            --R needs to be a subset of F
	    F := append!( F, R );
	    while ~ empty? R repeat
	    { 
		( C, stepPremult ) := (triangularize$MSAT) ( F );
		premult := union!( premult, stepPremult );

		R := empty;
		if ~ contradictory? C then
		{

		    --check if C reduces every element
		    local reduceFunc: T -> ( T, Set T ) := (reduceBy$RT) C;
		    for elementF in F | ~ member?( elementF, C ) repeat 
		    {
			import from RT;
			local red : T;
			( red, stepPremult ) := reduceFunc elementF;
			--Again, adjoin the premultiplicants, even in red is not
			--added to R. Since if one of stepPremult = 0, then
			--elementF could not be reduced to red in first place
			premult := union!( premult, stepPremult );
			if ~ ( zero? red or member?( red, F )  or member?( red, R ) ) then
			{
			    R := insert!( red, R );
			}
		    }

		    F := append!( F, R );
		}
	    }


	    if buildStatus? then
	    {
                --no need to copy F, as F is not returned directly
		status := record( copy C, F, copy premult ) pretend Pointer;
	    } else {
		status := nil;
	    }
	    ( C, premult, status );
	}
    }


    -------------------------------------------


    triangularize( R: List T ): ( AS, Set T ) == {
	local C: AS;
	local premult : Set T;
	local status: Pointer := nil;
	R := copy R;
	( C, premult, status ) := triangularize!( R, status );
	( C, premult );	      
    }


    -------------------------------------------


    triangularize( R: Generator T ): ( AS, Set T ) == {
	import from List T;
	local C: AS;
	local premult : Set T;
	local status: Pointer := nil;
	( C, premult, status ) := triangularize!( [ R ], status );
	( C, premult );	      
    }


    -------------------------------------------

    triangularize( R: List T, status: Pointer ): ( AS, Set T, Pointer ) == {
	triangularize!( copy R, status, true );
    }


    -------------------------------------------


    triangularize( R: Generator T, status: Pointer ): ( AS, Set T, Pointer ) == {
	import from List T;
	triangularize!( [ R ], status, true );
    }

}
