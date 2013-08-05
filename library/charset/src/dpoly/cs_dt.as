-------------------------------------------------------------------------
--
-- cs_dt.as
--
-------------------------------------------------------------------------

#include "algebra"

+++\begin{addescription}{represents differential structure}
+++This differential structure is not limited to a single derivation (as for example in \LibAlgebra's \adtype{DifferentialRing}) but may consist of arbitrarily many derivations. With each of these derivations a unique \adtype{Symbol} and a unique \admacro{Integer} is associated. These associatied \adtype{Symbol}{}s and \admacro{Integer}{}s are used to refer to a derivation. The \admacro{Integer} associated to the first derivation is $0$. The second derivation is associated with $1$ and so on.
+++
+++Several functions involve the term ``to apply a derivation''. Thereby, is not necessarily meant that a derivation acts on an element. For example for derivatives, application of a derivation is merely aggregation (in the sense of juxtapositioning) of the derivation into the derivative. Of course, for differential (polynomial) rings application of a derivation means to let the derivation act on the element of the differential (polynomial) ring. Each domain implementing \adthistype has to clarify the concise meaning of the term ``to apply a derivation'' in the domain's documentation.
+++\end{addescription}
DifferentialType : Category == with {

    +++\begin{addescription}{gives a mapping that applies a derivation}
    +++\end{addescription}
    derivationFunction: Symbol ->  % -> %;

    +++\begin{addescription}{gives a mapping that applies a derivation}
    +++\end{addescription}
    derivationFunction: Integer ->  % -> %;

    +++\begin{addescription}{applies a derivation}
    +++\adcode{differentiate( a, s, n )} applies the derivation \adcode{s} \adcode{n} times to \adcode{a}. \adcode{n} has to be non negative.
    +++\end{addescription}
    differentiate: ( a:%, s: Symbol, n:Integer == 1 ) -> %;

    +++\begin{addescription}{applies a derivation}
    +++\adcode{differentiate( a, idx, n )} applies the derivation \adcode{idx} \adcode{n} times to \adcode{a}. \adcode{n} has to be non negative.
    +++\end{addescription}
    differentiate: ( a:%, idx: Integer, n:Integer ) -> %;

    +++\begin{addescription}{applies a derivation}
    +++\adcode{differentiate( a, ns )} applies the derivation $0$ \adcode{ns.0} times to \adcode{a}. To this result, the derivation $1$ is applied \adcode{ns.1} times. And so on. It is not allowed to drop trailing zero entries in the \adtype{Array}. The \adtype{Array} has to carry as many slots as there are derivations. Each entry in the \adtype{Array} has to be non negative.
    +++\end{addescription}    
    differentiate: ( %, Array Integer ) -> %;

    if % has Ring then {
	+++\begin{addescription}{gives a \adtype{Derivation}}
	+++\end{addescription}
	derivation: Integer -> Derivation (% pretend Ring);
    }
	
    if % has Ring then {
	+++\begin{addescription}{gives a \adtype{Derivation}}
	+++\end{addescription}
	derivation: Symbol  -> Derivation (% pretend Ring);
    }

    --------------------------------------------------------

    default {

	if % has Ring then {
	    derivation( idx: Integer ): Derivation (% pretend Ring) == {
		derivation derivationFunction idx;
	    }
	}

	------------------------------------------------

	if % has Ring then {
	    derivation( sym: Symbol ): Derivation (% pretend Ring) == {
		derivation derivationFunction sym;
	    }
	}

        ------------------------------------------------

	if % has CopyableType then
	{
	    differentiate( a:%, s: Symbol, n:Integer == 0) : % == {

		assert(n >= 0);
		n = 0 => copy a;

		local derivation: % -> % := derivationFunction s;
		local r:% := derivation a;
		local i := n-1;

		while (i>0) repeat {
		    r := derivation r;
		    i := i - 1;
		}

		r;

	    }
	}
	
	------------------------------------------------

	if % has CopyableType then 
	{
	    differentiate( a:%, idx: Integer, n:Integer == 0 ) : % == {

		assert(n >= 0);
		n = 0 => copy a;

		local derivation: % -> % := derivationFunction idx;
		local r:% := derivation a;
		local i := n-1;

		while (i>0) repeat {
		    r := derivation r;
		    i := i - 1;
		}

		r;
	    }
	}

        ------------------------------------------------

	if % has CopyableType then 
	{
	    differentiate( a:%, ns: Array Integer ) : % == {
		import from MachineInteger;
		import from Integer;

		local result := a;
		for idx in (firstIndex$(Array Integer)) .. (firstIndex$(Array Integer))+prev # ns repeat 
		{
		    local n: Integer := ns.idx;
		    if ~ zero? n then
		    {
			result := differentiate( result, coerce idx, n );
		    }
		}
		result;
	    }
	}

        ------------------------------------------------

    }


};
