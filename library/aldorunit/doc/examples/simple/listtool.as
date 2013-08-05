------------------------------------------------------------------
--
-- listtool.as
--
------------------------------------------------------------------

#include "aldor"

ListTools(
  T: TotallyOrderedType
): with {
    +++\begin{addescription}{
    +++  merges two sorted lists non-destructively}    
    +++ Both parameters have to be sorted in advance.
    +++\end{addescription}
    merge: ( List T, List T ) -> List T;    
} == add {
    ---------------------------------------------
    import from List T;
    ---------------------------------------------
    merge( lst1: List T, lst2: List T ): List T == {

      merge!( copy lst1, copy lst2 );
	
    }
    ---------------------------------------------
}
