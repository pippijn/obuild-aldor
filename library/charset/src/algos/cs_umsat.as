-------------------------------------------------------------------------
--
-- cs_umsat.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{encapsulates functions for medial set algorithms that can be updated}
+++ \adthistype extends \adtype{MedialSetAlgorithmType} by a new function 
+++ \adname{triangularize!} that allows to reuse information from previous computations.
+++\end{addescription}
+++\begin{adremarks}
+++ \adthistype is not to be confused with \adtype{UpdatableTriangularizationAlgorithmType}. Both categories encapsulate functions for triangularization algorithms. In applications, however, the use of arbitrary triangularization algorithms and medial set algorithms differ considerably and does not overlap. Therefore two seperate categories are introduced. This separation allows to model the requirements in a more appropriate way.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{MedialSetAlgorithmType},
+++  \adtype{BasicSetTools},
+++  \adtype{BasicSetSortedTools}
+++\end{adseealso}
UpdatableMedialSetAlgorithmType(

  T: TriangularizationTType,
  RT : ReductionType T
  
) : Category == with {

    MedialSetAlgorithmType( T, RT );

    +++\begin{addescription}{calculates an autoreduced set while reuseing information from previous computations}
    +++\adthisname takes four parameters. These parameters are an \adtype{AutoreducedSet} \adcode{C}, a \adtype{List} \adcode{F}, a \adtype{Set} \adcode{S}, and a \adtype{List} \adcode{R}. The result of \adthisname is an \adtype{AutoreducedSet} \adcode{C'}, a \adtype{List} \adcode{F'}, and a \adtype{Set} \adcode{S'}. \adcode{C}, \adcode{C'}, \adcode{F}, \adcode{F'}, \adcode{S}, \adcode{S'}, and \adcode{R} contain elements of \adcode{T}. \adthisname computes a medial set of the union of \adcode{C}, \adcode{F}, and \adcode{R}. The resulting medial set is returned in \adcode{C'}. \adcode{F'} contains those elements of the union of \adcode{C}, \adcode{F}, and \adcode{R} that do not belong to \adcode{C'}. \adcode{S'} contains elements T that have been used to premultiply during the computations.
    +++
    +++ This function can be used to compute a medial set or update an already computed medial set. In either case, \adthisname acts destructive on all parameters.
    +++
    +++ \begin{itemize}
    +++  \item Computing a new medial set
    +++  \begin{itemize}
    +++   \item \adcode{C} has to be empty.
    +++   \item \adcode{F} has to be empty.
    +++   \item \adcode{S} has to be empty.
    +++   \item \adcode{R} has to contain the elements to compute a medial set from
    +++  \end{itemize}
    +++  \item Updating a medial set 
    +++  \begin{itemize}
    +++   \item \adcode{C} has to be the old, unmodified \adcode{C'}
    +++   \item \adcode{F} has to be the old, unmodified \adcode{F'}
    +++   \item \adcode{S} has to be the old, unmodified \adcode{S'}
    +++   \item \adcode{C'}, \adcode{F'}, and \adcode{S'} have to be from the same computaiton.
    +++   \item \adcode{R} has to contain the additional elements to be taken into consideration.
    +++  \end{itemize}
    +++ \end{itemize}
    +++
    +++ \adthistype has to implement the same algorithm for computing a medial set as the \adcode{triangularize} functions from \adtype{MedialSetAlgorithmType}.
    +++\end{addescription}
    triangularize!: ( AS, List T, Set T, List T ) -> ( AS, List T, Set T );
    
}