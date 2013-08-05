-------------------------------------------------------------------------
--
-- cs_dvlo.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{models a lexicographic order.}
+++For the indeterminates $x$ and $y$ with $x<y$ and the derivations $s$, $t$, \adthistype gives the following ordering
+++\begin{gather*}
+++  x < y < x_{s} < y_{s} < x_{ss} < y_{ss} < \ldots \\
+++  \ldots < x_{t} < y_{t} < x_{st} < y_{st} < x_{sst} < y_{sst} < \ldots
+++\end{gather*}
+++\end{addescription}
DifferentialVariableLexicographicOrderTools: with {

    DifferentialVariableOrderToolsType;

} == add {

    <( VARS   : FiniteVariableType, DVARS  : DifferentialVariableType( VARS ) ): ( DVARS, DVARS ) -> Boolean == ( left: DVARS, right: DVARS ): Boolean +-> {
	import from Integer;
	import from Array Integer;

	local clsLeft := class left;
	local clsRight := class right;
	
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
	
	clsLeft < clsRight => true;
	false;
	    
    }

};
