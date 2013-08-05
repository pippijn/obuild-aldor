-------------------------------------------------------------------------
--
-- cs_dvoeo.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{models an orderly elimination order.}
+++For the indeterminates $x$ and $y$ with $x<y$ and the derivations $s$, $t$, \adthistype gives the following ordering
+++\begin{gather*}
+++ x < x_{s} < x_{t} < x_{ss} < x_{st} < x_{tt} < \ldots \\ 
+++ \ldots < y < y_{s} < y_{t} < y_{ss} < y_{st} < y_{tt} < \ldots
+++\end{gather*}
+++\end{addescription}
DifferentialVariableOrderlyEliminationOrderTools: with {

    DifferentialVariableEliminationOrderToolsType;

} == add {

    <( VARS   : FiniteVariableType, DVARS  : DifferentialVariableType( VARS ) ): ( DVARS, DVARS ) -> Boolean == ( left: DVARS, right: DVARS ): Boolean +-> {
	import from Integer;
	import from Array Integer;

	local clsLeft := class left;
	local clsRight := class right;
	clsLeft < clsRight => true;
	clsLeft > clsRight => false;
	assert( clsLeft = clsRight );
	
	local totalOrderLeft := totalOrder left;
	local totalOrderRight := totalOrder right;
	totalOrderLeft < totalOrderRight => true;
	totalOrderLeft > totalOrderRight => false;
	
	for orderLeft in order left for orderRight in order right repeat {
	    if orderLeft > orderRight then
	    {
		return true;
	    } else if orderLeft < orderRight then {
		return false;
	    }
	}
	
	return false;
	    
    }

};
