-------------------------------------------------------------------------
--
-- cs_dvleo.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{models a lexicographic elimination order.}
+++For the indeterminates $x$ and $y$ with $x<y$ and the derivations $s$, $t$, \adthistype gives the following ordering
+++\begin{gather*}
+++ x < x_{s} < x_{ss} < \ldots < x_{t} < x_{st} < x_{sst} < \ldots \\
+++ \ldots < y < y_{s} < y_{ss} < \ldots < y_{t} < y_{st} < y_{sst} < \ldots
+++\end{gather*}
+++\end{addescription}
DifferentialVariableLexicographicEliminationOrderTools: with {

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
	
	local orderLeft : Array Integer := order left;
	local orderRight: Array Integer := order right;
	assert( { import from MachineInteger; # orderLeft = # orderRight } );

	for idx in firstIndex$(Array Integer) + prev # orderLeft .. firstIndex$(Array Integer) by - 1 repeat {
	    
	    if orderLeft.idx < orderRight.idx then
	    {
		return true;
	    } else if orderLeft.idx > orderRight.idx then {
		return false;
	    }
	}
	
	return false;
	    
    }

};
