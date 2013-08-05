-------------------------------------------------------------------------
--
-- cs_msat.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{encapsulates functions for medial set algorithms}
+++ \adthistype extends \adtype{TriangularizationAlgorithmType} by 
+++ asserting that the output of the \adcode{triangularize} functions form
+++ a medial set.
+++
+++ Let $P$ be a set of elements in \adcode{T}. An autoreduced set which is contained in the ideal generated by $P$ and is not higher than any basic set (see \adtype{BasicSetTools} or \cite{Wang2001}) of $P$ is called medial set.
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{TriangularizationAlgorithmType},
+++  \adtype{UpdatableMedialSetAlgorithmType},
+++  \adtype{BasicSetTools},
+++  \cite{Wang2001}
+++\end{adseealso}
MedialSetAlgorithmType(
  T: TriangularizationTType,
  RT : ReductionType T
) : Category == with {

    TriangularizationAlgorithmType( T, RT );
    
}