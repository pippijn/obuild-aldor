-------------------------------------------------------------------------
--
-- cs_sredu.as
--
-------------------------------------------------------------------------

#include "aldor"

+++\begin{addescription}{collects functions for reductions}
+++Each domain implementing \adthistype has to define what kind of reduction is implemented. Nevertheless, the same kind of reduction has to be used for the functions of \adthistype. For example, if \adname{reduce} implements \emph{polynomial reduction}, \adname{reduced?} has to decide whether elements are reduced with respect to \emph{polynomial reduction}.
+++\end{addescription}
ReductionType(
  T: Type
) : Category == with {

    +++\begin{addescription}{checks whether or not an element is reduced with respect to another one}
    +++\adcode{reduced?( a, b )} gives \adname[Boolean]{true}, if \adcode{a} is reduced with respect to \adcode{b}. Otherwise, \adname[Boolean]{false} is returned;
    +++\end{addescription}
    reduced? : ( T, T ) -> Boolean;
    
    +++\begin{addescription}{gives a function to decide reduced-ness}
    +++\adcode{reducedBy?( b )( a )} gives \adname[Boolean]{true}, if \adcode{a} is reduced with respect to \adcode{b}. Otherwise, \adname[Boolean]{false} is returned;
    +++\end{addescription}
    reducedBy?: T -> ( T -> Boolean );
    
    +++\begin{addescription}{reduces elements}
    +++After issuing \adcode{c := reduce( a, b )}, \adcode{b} reduces \adcode{a} to \adcode{c} holds.
    +++\end{addescription}
    +++\begin{adremarks}
    +++Especially, \adcode{c} is reduced with respect to $b$ has to hold.
    +++\end{adremarks}
    reduce: ( T, T ) -> T;

    +++\begin{addescription}{gives a function to reduce elements}
    +++After issuing \adcode{c := reduceBy( b )( a )}, \adcode{b} reduces \adcode{a} to \adcode{c} holds.
    +++\end{addescription}
    +++\begin{adremarks}
    +++Especially, \adcode{c} is reduced with respect to $b$ has to hold.
    +++\end{adremarks}
    reduceBy: T -> ( T -> T );

    default {


	-------------------------------------------

	
	reduced?( a: T, b: T ): Boolean == {
	    ( reducedBy? b ) a;
	}


	-------------------------------------------


	reduce( a: T, b: T ): T == {
	    ( reduceBy b ) a;
	}


	-------------------------------------------

    }
}