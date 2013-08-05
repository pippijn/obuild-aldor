-------------------------------------------------------------------------
--
-- cs_mvt.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{is a category for merging indeterminate domains}
+++Domains implementing \adthistype result in a \adtype{VariableType} consisting of the indeterminates of \adcode{VAR1} and those of \adcode{VAR2}.
+++\end{addescription}
MergedVariableType(
  VAR1: VariableType,
  VAR2: VariableType
): Category == with {
    VariableType;
    
    +++\begin{addescription}{pushes an indeterminate back}
    +++If the given indeterminate comes from \adcode{VAR1}, its corresponding indeterminate in \adcode{VAR1} is returned by \adthisname. Otherwise, the behaviour of \adthisname is undefined.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adname{isFromVar1?} can be used to test whether or not an indeterminate comes from \adcode{VAR1}. 
    +++\end{adremarks}
    coerce: % -> VAR1;

    +++\begin{addescription}{pushes an indeterminate back}
    +++If the given indeterminate comes from \adcode{VAR2}, its corresponding indeterminate in \adcode{VAR2} is returned by \adthisname. Otherwise, the behaviour of \adthisname is undefined.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adname{isFromVar2?} can be used to test whether or not an indeterminate comes from \adcode{VAR2}. 
    +++\end{adremarks}
    coerce: % -> VAR2;
    
    +++\begin{addescription}{lifts an indeterminate}
    +++\end{addescription}
    coerce: VAR1 -> %;

    +++\begin{addescription}{lifts an indeterminate}
    +++\end{addescription}
    coerce: VAR2 -> %;
    
    +++\begin{addescription}{decides an indeterminate's origin}
    +++If the given indeterminate comes from \adcode{VAR1}, \adthistype yields \adname[Boolean]{true}. Otherwise, \adthistype gives \adname[Boolean]{false}.
    +++\end{addescription}
    isFromVar1?: % -> Boolean;

    +++\begin{addescription}{decides an indeterminate's origin}
    +++If the given indeterminate comes from \adcode{VAR2}, \adthistype yields \adname[Boolean]{true}. Otherwise, \adthistype gives \adname[Boolean]{false}.
    +++\end{addescription}
    isFromVar2?: % -> Boolean;
    
};