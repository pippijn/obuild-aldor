-------------------------------------------------------------------------
--
-- cs_ovl2.as
--
-------------------------------------------------------------------------

#include "charset.as"

--needed solely for workaround of compiler bug with VariableMerger
+++\begin{addescription}{is a clone of \adtype{OrderedVariableList}}
+++Additionally, the compiler bug concerning the hash function of \adtype{OrderedVariableList} is corrected, as described in \adtype{OrderedVariableListWithProperHash}
+++\end{addescription}
+++\begin{adremarks}
+++The \Aldor compiler produces faulty code for \adtype{VariableMerger}, when both arguments of \adtype{VariableMerger} are of the same type. 
+++
+++For the \LibCharSet library, the second parameter to \adtype{VariableMerger} is typically \adtype{OrderedVariableList}. If the first parameter is also of \adtype{OrderedVariableType}, the described compiler bug comes into play. To avoid such situations, \adthistype is implemented. In combination with the \adtype{Trace} package of the \LibAldor library, it is possible to determine situations where both parameters would be of \adtype{OrderedVariableList}. Then one of the two parameters can be switched to \adthistype. The parameters still share the same behaviour but are different domains for the compiler. This procedure allows to work around the presented compiler bug.
+++
+++The source code of \adtype{VariableMergerTools} illustrates the used work around.
+++\end{adremarks}
OrderedVariableList2(

  VARS: List Symbol

): with {

    FiniteVariableType;

} == OrderedVariableList VARS add {

    hash( a: % ): MachineInteger == {
	a pretend MachineInteger;
    }
    
}