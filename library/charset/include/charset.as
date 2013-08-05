#include "aldor.as"
#include "algebra.as"
#include "extio.as"

#if BuildCharsetLib
#else
#library CharsetLib "charset"
#endif
{
	import from CharsetLib;
	inline from CharsetLib;
}

------------------------------------

--\begin{addescription}{collects necessary functions for elements of \adtype{AutoreducedSet}}
--These functions are \adname[FreeModule]{ground?} as defined in \adtype{FreeModule} and \adname[AdditiveType]{zero?} as defined in \adtype{AdditiveType} or \adtype{AbeleanMonoid}.
--\end{addescription}
macro AutoreducedSetTType == with 
{
    ground?: % -> Boolean;
    zero?: % -> Boolean;
};

------------------------------------

--\begin{addescription}{permits triangularizations of its elements}
--\adthismacro is \admacro{AutoreducedSetTType} extended by \adtype{PrimitiveType}.
--\end{addescription}
macro TriangularizationTType == AutoreducedSetTType with 
{
    PrimitiveType;
};

------------------------------------

--\begin{addescription}{permits triangularizations of its elements and provides a ranking}
--\adthismacro is \admacro{TriangularizationTType} extended by \adtype{RankedType}.
--\end{addescription}
macro RankedTriangularizationTType == TriangularizationTType with 
{    
    RankedType;
};

------------------------------------

--\begin{addescription}{provides functions to compute the separant and inital}
--For a polynomial ring implementation \adcode{PR} in the indeterminates \adcode{VARS}, \adthismacro provides the two functions
--\begin{itemize}
--\item[]\adcode{assuredInitial: PR -> PR} and
--\item[]\adcode{assuredSeparant: PR -> PR}.
--\end{itemize}
--Let $a$ be a polynomial. If $a$ is a constant, \adcode{assuredInitial(a)} gives $a$ and \adcode{assuredSeparant(a)} gives $0$. If $a$ is not a constant, let $x$ denote its main indeterminate. $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i$$ with $d$ denoting the degree of $a$ with respect to $x$ and each $c_i$ not containing $x$.
--Then \adcode{assuredInital(a)} gives $c_d$, while \adcode{assuredSeparant(a)} yields $$\sum_{i=1}^{d}ic_ix^{i-1}.$$
--\end{addescription}
--
--\begin{adremarks}
--\adthismacro provides genuine implementations to compute the separant and the initial. However, if the polynomial ring implementaiton \adcode{PR} already contains a function \adcode{initial: PR -> PR}, then \adcode{assuredInitial} is just a reference to \adcode{initial}. Similarly, if the polynomial ring implementation \adcode{PR} already contains a function \adcode{separant: PR -> PR}, \adcode{assuredSeparant} is just a reference to \adcode{separant}.
--\end{adremarks}
macro ASSURESEPIN( PR, VARS ) == {
    
    --- initial ---------------------
    
    local assuredInitial: PR -> PR;
    if PR has with { initial: PR -> PR; } then {
	assuredInitial := initial$PR;
    } else {
	assuredInitial: PR -> PR := ( t: PR ): PR +-> {
	    ground? t => t;
	    local mainVariableT := mainVariable t;
	    coefficient( t, mainVariableT, degree( t, mainVariableT ) );		    
	};
    }

    --- separant --------------------

    local assuredSeparant: PR -> PR;
    if PR has with { separant: PR -> PR; } then {
	assuredSeparant := separant$PR;
    } else {
	assuredSeparant: PR -> PR := ( t: PR ): PR +-> {
	    ground? t => 0;

	    import from Integer;
	    local ret: PR := 0;
	    local accumulatedVarPR: PR := 1;
	    local mainVar: VARS := mainVariable t;
	    local mainVarPR: PR := mainVar::PR;
	    for power in 1..degree( t, mainVar ) repeat 
	    {
		ret := ret + power*coefficient( t, mainVar, power )*accumulatedVarPR;
		accumulatedVarPR := mainVarPR * accumulatedVarPR;
	    }
	    ret;

	};
    }

};

------------------------------------
