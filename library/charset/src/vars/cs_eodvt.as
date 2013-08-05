-------------------------------------------------------------------------
--
-- cs_eodvt.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{marks differential indeterminates to carry an elimination order}
+++\end{addescription}
+++\begin{adremarks}
+++\adtype{DifferentialVariableEliminationOrderToolsType} defines ``elimination order'' and is typically used to represent such orders.
+++\end{adremarks}
EliminationOrderedDifferentialVariableType(

  VARS  : FiniteVariableType

): Category == with {

    DifferentialVariableType( VARS );

};
