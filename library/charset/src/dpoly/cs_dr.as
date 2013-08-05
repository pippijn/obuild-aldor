-------------------------------------------------------------------------
--
-- cs_dr.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{implements rational numbers with trivial derivations}
+++For any \adthistype $r$ and any \admacro{Integer} $idx$, \adcode{differentiate( r, idx )} gives $0$. For any \adthistype $r$ and any \adtype{Symbol} $s$, \adcode{differentiate( r, s )} gives $0$.
+++\end{addescription}
+++\begin{adremarks}
+++\adthistype is represented by a \adtype{Fraction} of \admacro{Integer}. Therefore, for large numerators or denominators, considerable speedup may be achieved by using the {\tt gmp} variant of \LibCharSet.
+++\end{adremarks}
DifferentialRational : with {
    Field; 
    DifferentialType; 
    CharacteristicZero;
    Parsable;
    CopyableType;
} == Fraction Integer add {    

    
    --------------------------------------------------------------

    copy( a: % ): % == {
	--to get a proper copy, a has to be manipulated nondestructivly by a trivial function.
	--We use adding 1 and subtracting 1
	( a + 1 ) - 1;
    }
    
    --------------------------------------------------------------

    derivationFunction( sym: Symbol ): % -> % == {
        ( a: % ): % +-> {               
            0;
        }
    }


    --------------------------------------------------------------


    derivationFunction( idx: Integer ): % -> % == {
        ( a: % ): % +-> {               
            0;
        }
    }

    
    --------------------------------------------------------------

    
};
