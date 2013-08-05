-------------------------------------------------------------------------
--
-- cs_depr.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{extends a polynomial ring to a differential polynomial ring}
+++The polynomial ring \adcode{PR} is extended by differential structure. This extension does not alter the representation of polynomials, but simply adds functions to apply dervations.
+++The differential structure (see \adtype{DifferentialType}) of \adcode{DIDOM} and \adcode{DVARS} have to correspond (i.e.: For every index $i$ of a derivation in \adcode{DVARS} or \adcode{DIDOM}, the \adtype{Symbol} of the derivation $i$ of \adcode{DIDOM} has to be the same \adtype{Symbol} as the \adtype{Symbol} of the derivation $i$ of \adcode{DVARS}. For example, if the derivation of index $2$ of \adcode{DIDOM} is denoted by the symbol \adcode{d}, the derivation of index $2$ of \adcode{DVARS} also has to be denoted by \adcode{d}.)
+++\end{addescription}
+++\begin{adremarks}
+++If \adcode{PR} exports \adtype{IndexedFreeModule}, \adtype{DifferentiallyExtendedDistributivePolynomialRing} can be used to keep \adtype{IndexedFreeModule} when extending \adcode{PR} to a differential polynomial ring.
+++\end{adremarks}
DifferentiallyExtendedPolynomialRing(
  DIDOM  : with{ IntegralDomain; DifferentialType; },
  VARS  : FiniteVariableType,
  DVARS : DifferentialVariableType( VARS ),
  PR : PolynomialRing0( DIDOM, DVARS )
) : with {
    if PR has PolynomialRing( DIDOM, DVARS ) then
    { 
	PolynomialRing( DIDOM, DVARS );
    }
    DifferentialPolynomialRingType( DIDOM, VARS, DVARS )
} == 
    (PR pretend (if PR has PolynomialRing( DIDOM, DVARS ) then
    { 
	 PolynomialRing( DIDOM, DVARS );
    } else {
	 PolynomialRing0( DIDOM, DVARS );
    }))  add {

    macro Rep == PR;
    import from Rep;

    -------------------------------------------

    if DIDOM has Parsable then
    {
	macro DPRPT == DifferentialPolynomialRingParsingTools( DIDOM, VARS, DVARS, %, (derivationSymbols$DVARS)()); 	                     

	eval(leaf: ExpressionTreeLeaf):Partial % == {
	    (eval$DPRPT) leaf;
	}
	eval( op: MachineInteger, exprs: List ExpressionTree): Partial % == {
	    import from DPRPT;
	    (eval$DPRPT) ( op, exprs );
	}
	eval( expr: ExpressionTree ): Partial % == 
	{
	    import from DPRPT;
	    (eval$DPRPT) ( expr );
	}
    }
}
