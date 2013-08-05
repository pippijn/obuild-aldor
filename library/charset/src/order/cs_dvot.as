-------------------------------------------------------------------------
--
-- cs_dvot.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{models orders for differential indeterminates}
+++\end{addescription}
DifferentialVariableOrderToolsType:Category == with {

    +++\begin{addescription}{gives a function to compare differential indeterminates}
    +++\adcode{DVARS} denotes the domain of the differential indeterminates to compare. \adcode{VARS} is only needed to describe the type of \adcode{DVARS} properly.
    +++The returned function \adcode{( DVARS, DVARS ) -> Boolean} gives \adname[Boolean]{true} if the first \adcode{DVARS} is smaller than the second one. Otherwise, the function yields \adname[Boolean]{false}.
    +++\end{addescription}
    <: ( VARS   : FiniteVariableType, DVARS  : DifferentialVariableType( VARS ) ) -> ( DVARS, DVARS ) -> Boolean;

};
