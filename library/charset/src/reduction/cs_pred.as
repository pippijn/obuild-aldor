-------------------------------------------------------------------------
--
-- cs_pred.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, % );

+++\begin{addescription}{implements polynomial reduction}
+++For the description of polynomial reduction, \adcode{T} denote a polynomial ring. Let $p, q, \text{ and } r$ be elements of \adcode{T}. $p$ \emph{is reduced with respect to} $q$ if and only if
+++\begin{itemize}
+++\item $q$ is zero,
+++\item $q$ is a non zero constant and $p$ is zero, or
+++\item $q$ is not a constant the coefficient of $p$ with respect to the leading term of $q$ is zero.
+++\end{itemize}
+++
+++If $q$ \emph{reduces} $p$ to $r$, one of the following conditions has to hold.
+++\begin{itemize}
+++\item $q$ is zero and $p$ = $r$.
+++\item $q$ is a non zero constant and $r$ is zero.
+++\item $q$ is not a constant, $r$ is reduced with respect to $q$ and 
+++$$p = r \text{ mod } ( q ),$$
+++where $( q )$ denotes the ideal generated by $q$.
+++\end{itemize}
+++
+++\adcode{consequences( p, q )} computes the S-polynomial of $p$ and $q$, i.e.:
+++$$-\frac{t}{lc(p) lpp(p)} p + \frac{t}{lc(q) lpp(q)} q,$$
+++where $lc$ denotes the leading coefficient of its parameter and $lpp$ denotes the leading term of its parameter. $t$ is used to denote the least common multiple of $lpp(p)$ and $lpp(q)$
+++\end{addescription}
+++\begin{adremarks}
+++The implementation of reduction uses division in the coefficient field \adcode{FLD}. If \adcode{FLD} is not a \adtype{Field}, \adtype{PolynomialReductionWithoutDivisionTools} can be used to obtain polynomial reduction.
+++\end{adremarks}
+++\begin{adseealso}
+++  \cite{Winkler1996}
+++\end{adseealso}
PolynomialReductionTools(
  FLD : with {
      Field;
      CharacteristicZero;
  },
  VARS: VariableType,
  EXP : ExponentCategory VARS,
  T   : with {
      RankedType;
      IndexedFreeModule( FLD, EXP );
      FreeLinearArithmeticType( FLD );
      Monoid;
      CopyableType;
  }
) : with {

    TriangularizationReductionType T;

} == add {

    import from T;

    reducedBy?( b: T ): T -> Boolean == {

	zero? b => ( a: T ): Boolean +-> { true; };
	ground? b => ( a: T ): Boolean +-> { zero? a; };

	local ltB := degree b;

	( a: T ): Boolean +-> {
	    ground? a => true;
	    assert( not ground? a );
	    for monomialA in terms a repeat 
	    {
		(monomialACoeff, monomialATerm) := monomialA;
		import from EXP;
		if cancel?( monomialATerm, ltB ) then 
		{
		    return false;
		}
	    }
	    true;
	}
    }

    -------------------------------------------

    reduceBy( b: T ): T -> ( T, Set T ) == {
	import from FLD;
	import from T;
	zero? b =>  ( a: T ): ( T, Set T ) +-> { ( a, empty ) };
	ground? b => {
	    invB := inv leadingCoefficient b;

	    ( a: T ): ( T, Set T ) +-> { 
		zero? a => ( 0, empty );
		( 0, [ - invB*a ] );
	    }

	};

	( lcB, ltB ) := leadingTerm b;
	invLcB := inv lcB;

	( a: T ): ( T, Set T ) +-> {
	    local premult: Set T := empty;

	    a := copy a;
	    reductionPerformed? := true;
	    while reductionPerformed? repeat 
	    {
		reductionPerformed? := false;

  		while ~ reductionPerformed? for monomialA in terms a repeat 
		{
		    (monomialACoeff, monomialATerm) := monomialA;
		    import from EXP;
		    local pCancellation: Partial EXP := cancelIfCan( monomialATerm, ltB );
		    if ~ failed? pCancellation then 
		    {
			import from T;
			local factor: T := term( -monomialACoeff*invLcB, retract pCancellation );
			a := add!( a, factor * b );
			premult := union!( premult, factor );
			reductionPerformed? := true;
		    }
		}
	    }
	    ( a, premult );
	}
    }

    -------------------------------------------

    reduceBy( as: AS ): T -> ( T, Set T ) == {
	import from T;
	import from MachineInteger;
	import from FLD;
	import from EXP;
	import from Array EXP;
        empty? as => ( a: T ): ( T, Set T ) +-> { ( copy a, empty ) };
	contradictory? as => {
	    assert( # as = 1 );
	    reductionFunction : T -> ( T, Set T ) := reduceBy(as.(firstIndex$AS));
	    ( a: T ): ( T, Set T ) +-> { reductionFunction(a); };
	};

	local slots := # as;
	local slotIdxs := firstIndex$(Array T) .. prev slots + firstIndex$(Array T );
	local invLeadingCoefficients : Array FLD := new( slots, 0 );
	local leadingTerms : Array EXP := new( slots, 0 );
	local asArray : Array T := new( slots, 0 );

	for elementAs in as for slotIdx in slotIdxs repeat
	{
	    ( leadCoeff, leadTerm ) := leadingTerm elementAs;
	    leadingTerms . slotIdx := leadTerm;
	    invLeadingCoefficients . slotIdx := inv leadCoeff;
	    asArray . slotIdx := elementAs;
	}

	( a: T ): ( T, Set T ) +-> {
	    a := copy a;
	    premult : Set T := empty;

	    reductionPerformed? := true;
	    while reductionPerformed? repeat 
	    {
		reductionPerformed? := false;

                -- generator gives elements in descending order
  		for monomialA in a while ~ reductionPerformed? repeat 
		{			
		    (monomialACoeff, monomialATerm) := monomialA;

		    for slotIdx in slotIdxs while ~ reductionPerformed? repeat 
		    {
			import from EXP;
			local pCancellation: Partial EXP := cancelIfCan( monomialATerm, leadingTerms . slotIdx );
			if ~ failed? pCancellation then 
			{
			    import from T;
			    local factor: T := term( -monomialACoeff*invLeadingCoefficients . slotIdx, retract pCancellation );
			    a := add!( a, factor * asArray . slotIdx );
			    premult := union!( premult, factor );
			    reductionPerformed? := true;
			}
		    }
		}
	    }
	    ( a, premult );
	}
    }

    -------------------------------------------

    consequences( a: T, b: T ): ( List T, Set T ) == {
        import from FLD;
	import from EXP;	
	
	invLcA := (inv$FLD) ((leadingCoefficient a)@FLD);
	invLcB := inv leadingCoefficient b;

	lppA := degree a;
	lppB := degree b;

	t := lcm( lppA, lppB );
	factA := term( -invLcA, cancel( t, lppA ) );
	factB := term( invLcB, cancel( t, lppB ) );

	( ([ factA * a + factB * b ])@(List T), ([ factA, factB ])@(Set T) );
    }

    -------------------------------------------

}
