-------------------------------------------------------------------------
--
-- cs_vmtls.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{implements useful functions for merging indeterminates}
+++\end{addescription}
VariableMergerTools: with {

    +++\begin{addescription}{incorporates an indeterminate domain ond adjoins new indeterminates}
    +++Let $n$ refer to the \admacro{Integer} parameter of \adthisname. $n$ has to be non negative. \adthisname creates an indeterminate domain of $n$ new indeterminates that are not contained in \adcode{VAR1}. This new indeterminate domain is returned as \adcode{VAR2}. If \adcode{VARS1} is of type \adtype{OrderedVariableList}, \adcode{VARS2} is of type \adtype{OrderedVariableList2}. Otherwise, \adcode{VARS2} is of type{OrderedVariableList}. The returned \adtype{MergedVariableType} simply merges \adcode{VARS1} and \adcode{VARS2}.
    +++\end{addescription}
    +++\begin{adremarks}
    +++The indeterminates of \adcode{VARS2} are labelled ``ext'' followed by an increasing number.
    +++For example, assume \adcode{VARS1} consists of the indeterminates \adcode{x}, \adcode{y}, and \adcode{ext1}. Calling
    +++\begin{adsnippet}
    +++extension( VARS1, 3 )
    +++\end{adsnippet}
    +++gives \adcode{VARS2} consisting of \adcode{ext0}, \adcode{ext2}, \adcode{ext3}.
    +++\end{adremarks}
    extension: ( VARS1: VariableType, Integer ) -> ( VARS2: FiniteVariableType, MergedVariableType( VARS1, VARS2 ) );
    
} == add {
    
    -----------------------------------

    extension( VARS1: VariableType, exts: Integer ): ( VARS2: FiniteVariableType, MergedVariableType( VARS1, VARS2 ) ) == {
	assert( exts >= 0 );
	import from Trace;
	import from Symbol;
	import from VARS1;
	local prefix: String := "ext";
	local idx: Integer := 0;
	local newVars: List Symbol := empty;
	while ~ zero? exts repeat {
	    local sb: StringBuffer := new();
	    ( sb :: TextWriter ) << prefix << idx;
	    while ~ ((failed?$(Partial VARS1)) (variable( - string sb ))) repeat {
		idx := next idx;
		( sb :: TextWriter ) << prefix << idx;
	    }
	    idx := next idx;
	    newVars := insert!( - string sb, newVars );
	    exts := prev exts;
	}
	local listToDomain: List Symbol -> FiniteVariableType := OrderedVariableList;
	if shortName VARS1 = "OrderedVariableList(*)" then {
	    listToDomain := OrderedVariableList2;
	}
	retVARS2: FiniteVariableType := listToDomain newVars;
	( retVARS2, VariableMerger( VARS1, retVARS2 ) );
    } 
    
    -----------------------------------
    
}