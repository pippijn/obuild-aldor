-------------------------------------------------------------------------
--
-- cs_resum.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, RT );

+++\begin{addescription}{encapsulates functions for triangularization algorithms that can be updated.}
+++ \adthistype extends \adtype{TriangularizationAlgorithmType} by 
+++ functions that allow to update a given triangularization. All \adcode{triagularize} functions have to implement the same algorithm.
+++\end{addescription}
+++\begin{adremarks}
+++ \adthistype is not to be confused with \adtype{UpdatableMedialSetAlgorithmType}. Both categories encapsulate functions for triangularization algorithms. In applications, however, the use of arbitrary triangularization algorithms and medial set algorithms differ considerably and does not overlap. Therefore two seperate categories are introduced. This separation allows to model the requirements in a more appropriate way.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{TriangularizationAlgorithmType},
+++  \adtype{UpdatableMedialSetAlgorithmType},
+++  \adtype{CoherentAutoreducedSetTools},
+++\end{adseealso}
UpdatableTriangularizationAlgorithmType(

  T: TriangularizationTType,
  RT : ReductionType T
  
) : Category == with {

    TriangularizationAlgorithmType( T, RT );
    
    +++\begin{addescription}{triangularizes a \adtype{Generator} and gives a state for further updates.}
    +++\adthisname takes two parameters. These parameters are a \adtype{Generator} \adcode{A} and a \adtype{Pointer} \adcode{P}. The result is an autoreduced set \adcode{C} and a pointer \adcode{P'}.
    +++
    +++ For a triangularization of \adcode{A}, set \adcode{P} to \adname[Pointer]{nil}. Then \adcode{C} is the result of the triangularization. \adcode{P'} represents the state of the algorithm when terminating.
    +++
    +++ For updating a triangularization, set \adcode{P} to the state of the triangularization to update (i.e.: a previous \adcode{P'}). Additionally, set \adcode{A} to the additional elements to take into consideration. Then \adcode{C} is the result of the updated triangularization. \adcode{P'} represents the state of the algorithm when terminating.
    +++\end{addescription}
    triangularize : ( Generator T, Pointer ) -> ( AS, Pointer );

    +++\begin{addescription}{triangularizes a \adtype{Generator} while collecting premultiplicants and gives a state for further updates.}
    +++\adthisname takes two parameters. These parameters are a \adtype{Generator} \adcode{A} and a \adtype{Pointer} \adcode{P}. The result is an autoreduced set \adcode{C}, a set \adcode{S}, and a pointer \adcode{P'}.
    +++
    +++ For a triangularization of \adcode{A}, set \adcode{P} to \adname[Pointer]{nil}. Then \adcode{C} is the result of the triangularization and \adcode{S} contains those elements, which have been used for premultiplication. \adcode{P'} represents the state of the algorithm when terminating.
    +++
    +++ For updating a triangularization, set \adcode{P} to the state of the triangularization to update (i.e.: a previous \adcode{P'}). Additionally, set \adcode{A} to the additional elements to take into consideration. Then \adcode{C} is the result of the updated triangularization and \adcode{S} contains those elements that have been used for premultiplication. \adcode{P'} represents the state of the algorithm when terminating.
    +++\end{addescription}
    triangularize : ( Generator T, Pointer ) -> ( AS, Set T, Pointer );

    +++\begin{addescription}{triangularizes a \adtype{List} and gives a state for further updates.}
    +++\adthisname takes two parameters. These parameters are a \adtype{List} \adcode{A} and a \adtype{Pointer} \adcode{P}. The result is an autoreduced set \adcode{C} and a pointer \adcode{P'}.
    +++
    +++ For a triangularization of \adcode{A}, set \adcode{P} to \adname[Pointer]{nil}. Then \adcode{C} is the result of the triangularization. \adcode{P'} represents the state of the algorithm when terminating.
    +++
    +++ For updating a triangularization, set \adcode{P} to the state of the triangularization to update (i.e.: a previous \adcode{P'}). Additionally, set \adcode{A} to the additional elements to take into consideration. Then \adcode{C} is the result of the updated triangularization. \adcode{P'} represents the state of the algorithm when terminating.
    +++\end{addescription}
    triangularize : ( List T, Pointer ) -> ( AS, Pointer );
    
    +++\begin{addescription}{triangularizes a \adtype{List} while collecting premultiplicants and gives a state for further updates.}
    +++\adthisname takes two parameters. These parameters are a \adtype{List} \adcode{A} and a \adtype{Pointer} \adcode{P}. The result is an autoreduced set \adcode{C}, a set \adcode{S}, and a pointer \adcode{P'}.
    +++
    +++ For a triangularization of \adcode{A}, set \adcode{P} to \adname[Pointer]{nil}. Then \adcode{C} is the result of the triangularization and \adcode{S} contains those elements, which have been used for premultiplication. \adcode{P'} represents the state of the algorithm when terminating.
    +++
    +++ For updating a triangularization, set \adcode{P} to the state of the triangularization to update (i.e.: a previous \adcode{P'}). Additionally, set \adcode{A} to the additional elements to take into consideration. Then \adcode{C} is the result of the updated triangularization and \adcode{S} contains those elements that have been used for premultiplication. \adcode{P'} represents the state of the algorithm when terminating.
    +++\end{addescription}
    triangularize : ( List T, Pointer ) -> ( AS, Set T, Pointer );
    
        default {
	
	-------------------------------------
	
	triangularize( a: List T, status: Pointer ): ( AS, Pointer ) == {
	    ( tr: AS, premult: Set T, newStatus: Pointer ) := triangularize( a, status );
	    ( tr, newStatus );
	}

	-------------------------------------
	
	triangularize( a: List T, status: Pointer ): ( AS, Set T, Pointer ) == {
	    triangularize( generator a, status );
	}

	-------------------------------------
	
	triangularize( a: Generator T, status: Pointer ): ( AS, Pointer ) == {
	    ( tr: AS, premult: Set T, newStatus: Pointer ) := triangularize( a, status );
	    ( tr, newStatus );
	}

	-------------------------------------
	
    }



}