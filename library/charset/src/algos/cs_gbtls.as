-------------------------------------------------------------------------
--
-- cs_gbtls.as
--
-------------------------------------------------------------------------
#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{computes Gröbner bases}
+++\adcode{T} denotes the domain to compute Gröbner basis in. Typically, \adcode{T} denotes a polynomial ring. The used reduction is \adcode{RT} which has to implement polynomial reduction on the elements of \adcode{T}. \adname[TriangularizationReductionType]{consequences} of \adcode{RT} has to compute S-polynomials.
+++The Gröbner basis algorithm implemented by the \adname{groebnerBasis} functions of \adthistype implement the GROEBNER\_B algorithm, as presented in \cite{Winkler1996}.
+++\end{addescription}
GroebnerBasisTools(
  T : RankedTriangularizationTType,  
  RT : TriangularizationReductionType T
) : with {

    GroebnerBasisAlgorithmType( T );

} == add {


    -------------------------------------------

    macro GROEBNERBASIS( F ) == {

	import from RT;
	
	local G: List T := F;          -- will become a Groebner basis
	local C : List T := empty;     -- these S-polynomials are to be checked if they reduce to 0
	local premult: Set T := empty; -- these polynomials have been used to prmultiply
	local addPremult : Set T;      -- the premultiplication polynomials to union with premult
	local sPoly : T;               -- will hold an S-polynomial
	local sPolys : List T;         -- will hold a list of S-polynomials
	local red : T;                 -- the result of a reduction
	
	-- filling C with all necessary S-polynomials
	local lg1 := G;	
	while ~ empty? lg1 repeat
	{
	    local lg2 := rest lg1;
	    while ~ empty? lg2 repeat 
	    {
		( sPolys, addPremult ) := consequences( first lg1, first lg2 );
		C := append!( sPolys, C );
		premult := union!( premult, addPremult );
		lg2 := rest lg2;
	    }
	    lg1 := rest lg1;
	}
	
	-- starting to reduce, while some S-polynomials in C are left over
	while ~ empty? C repeat
	{
	    sPoly := first C;
	    C := rest C;
	    ( red, addPremult ) := reduce( sPoly, G );
	    premult := union!( premult, addPremult );
	    if ~ zero? red then
	    {
		-- did not reduce to zero.
		-- add all necessary consequences
		for g in G repeat 
		{
		    ( sPolys, addPremult ) := consequences( red, g );
		    C := append!( sPolys, C );
		    premult := union!( premult, addPremult );
		}
		G := insert!( red, G );
	    }
	}
	
	-- G is now a Groebner Basis
	
	( G, premult );
    }
	
    -------------------------------------------

    groebnerBasis( F: Generator T ): ( List T, Set T ) == {
	GROEBNERBASIS( [ F ] );
    }

    -------------------------------------------

    groebnerBasis( F: List T ): ( List T, Set T ) == {
	GROEBNERBASIS( copy F );
    }

    -------------------------------------------

}
