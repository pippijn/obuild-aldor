------------------------------------------------------------------
--
-- listtool-with-aldoc.as
--
------------------------------------------------------------------

#include "aldor"

#if ALDOC
\thistype{ListTools}
\History{Christian Aistleitner}{01.10.2004}{created}
\Usage{import from \this~T}
\Descr{\this~provides a non-destructive version to merge sorted lists.}
#endif


ListTools(
  T: TotallyOrderedType
): with {

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
