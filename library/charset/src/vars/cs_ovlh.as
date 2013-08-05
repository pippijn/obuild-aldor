-------------------------------------------------------------------------
--
-- cs_ovlh.as
--
-------------------------------------------------------------------------

#include "algebra"

+++\begin{addescription}{gives a proper hash function for \adtype{OrderedVariableList}}
+++\end{addescription}
+++\begin{adremarks}
+++\adtype{OrderedVariableType} exports a hash function. However, using this hash function in the release variant of the \LibAlgebra library causes \Aldor to look for the function \adname[MachineInteger]{machine} in \adtype{MachineInteger}. \Aldor cannot find this function (although it should, as it is implemented in the source code of \adtype{MachineInteger} and required by the export \adtype{IntegerType} of \adtype{MachineInteger}) and raises a runtime error. This bug is circumvented, by reimplementing the \adname[HashType]{hash} function.
+++
+++\adtype{OrderedVariableList2} uses the same strategy to overcome this bug.
+++\end{adremarks}
OrderedVariableListWithProperHash( SYMS: List Symbol ): with {
    FiniteVariableType;
} == OrderedVariableList( SYMS ) add {
    hash( a: % ): MachineInteger == {
	a pretend MachineInteger;
    }
}
