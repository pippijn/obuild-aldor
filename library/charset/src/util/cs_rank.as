------------------------------------------------------------------------
--
-- cs_rank.as
--
-------------------------------------------------------------------------

#include "aldor"

+++\begin{addescription}{is a category for rankings}
+++The comparison functions of \adthistype only have to be transitive.
+++
+++For example, for the comparison function \adname{<}
+++$$a < b \land b < c \implies a < c$$ 
+++has to hold for all $a$, $b$, and $c$.
+++\end{addescription}
RankedType: Category == with {
    
    +++\begin{addescription}{comares two elements}
    +++\adcode{a < b} gives \adname[Boolean]{true}, if \adcode{a} is smaller than \adcode{b} in the implemented ranking. Otherwise, \adname[Boolean]{false} is returned.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adcode{a < b} has to  yields the same result as \adcode{b > a}
    +++\end{adremarks}
    <: ( %, % ) -> Boolean;

    +++\begin{addescription}{comares two elements}
    +++\adcode{a > b} gives \adname[Boolean]{true}, if \adcode{a} is greater than \adcode{b} in the implemented ranking. Otherwise, \adname[Boolean]{false} is returned.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adcode{a > b} has to  yields the same result as \adcode{b < a}
    +++\end{adremarks}
    >: ( %, % ) -> Boolean;

    default {
	(>)( a: %, b: % ): Boolean == {
	    b < a
	}
    }
}