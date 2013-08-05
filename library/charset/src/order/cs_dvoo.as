-------------------------------------------------------------------------
--
-- cs_dvoo.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{models an orderly order.}
+++For the indeterminates $x$, $y$, and $z$ with $x<y<z$ and the derivations $s$, $t$, \adthistype gives the following ordering
+++\begin{gather*}
+++ x < y < z < x_{s} < y_{s} < z_{s} < x_{t} < y_{t} < z_{t} < \\
+++ < x_{ss} < y_{ss} < z_{ss} < x_{st} < y_{st} < z_{st} < x_{tt} < \ldots
+++\end{gather*}
+++\end{addescription}
DifferentialVariableOrderlyOrderTools: with {

    DifferentialVariableOrderToolsType;

} == add {

    <( VARS   : FiniteVariableType, DVARS  : DifferentialVariableType( VARS ) ): ( DVARS, DVARS ) -> Boolean == ( left: DVARS, right: DVARS ): Boolean +-> {
	import from Integer;
	import from Array Integer;

	local totalOrderLeft := totalOrder left;
	local totalOrderRight := totalOrder right;
	totalOrderLeft < totalOrderRight => true;
	totalOrderLeft > totalOrderRight => false;
	
	assert( { import from MachineInteger; # order left = # order right } );
	
	for orderLeft in order left for orderRight in order right repeat {
	    if orderLeft > orderRight then
	    {
		return true;
	    } else if orderLeft < orderRight then {
		return false;
	    }
	}
	
	class left < class right;
	    
    }

};
