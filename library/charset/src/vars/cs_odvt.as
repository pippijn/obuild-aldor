-------------------------------------------------------------------------
--
-- cs_odvt.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{is a category for indeterminates for differential rings with only one derivation}
+++Some functions of \adtype{DifferentialVariableType} return values incorporating each of the possible derivations. For example \adname[DifferentialVariableType]{order} of \adtype{DifferentialVariableType} returns an \adtype{Array} of \admacro{Integer}{}s. For \adthistype, this \adtype{Array} has exactly one entry. Therefore, \adthistype implements an \adname{order} function that gives the corresponding slot right away, without the need for the wrapping \adtype{Array}.
+++
+++The other functians of \adthistype are motivated in the same manner.
+++\end{addescription}
OrdinaryDifferentialVariableType(

  VARS  : FiniteVariableType

): Category == with {

    DifferentialVariableType( VARS );
    
    +++\begin{addescription}{gives the order of a differential indeterminate}
    +++\end{addescription}
    order: % -> Integer;
    
    +++\begin{addescription}{applies the derivation several times}
    +++The \adcode{%} parameter specifies the element to which the deriwation has to be applied. The \admacro{Integer} parameter denotes how often the derivation has to be applied. The \admacro{Integer} parameter has to be non negative.
    +++\end{addescription}
    differentiate: ( %, Integer ) -> %;

    +++\begin{addescription}{applies the derivation once}
    +++\end{addescription}
    differentiate: % -> %;
    
    +++\begin{addescription}{creates a differential indeterminate}
    +++The \adcode{VARS} parameter denotes the indeterminate to lift to the ordinary differential indeterminate domain. The \admacro{Integer} parameter denotes the order of the lifted indeterminate with respect to the derivaiton. The \adtype{Integer} parameter has to be non negative.
    +++\end{addescription}
    variable: ( VARS, Integer ) -> %;
    
    +++\begin{addescription}{creates a differential indeterminate}
    +++The first \admacro{Integer} parameter denotes the class of the indeterminate to lift to the ordinary differential indeterminate domain. This \admacro{Integer} has to be positive and must not exceed the number of indeterminates in \adcode{VARS}. The second \admacro{Integer} parameter denotes the order of the lifted indeterminate with respect to the derivaiton. This \adtype{Integer} parameter has to be non negative.
    +++\end{addescription}
    variable: ( Integer, Integer ) -> %;
    
    
    default {


	----------------------------------------------------------


	=(a:%,b:%):Boolean == {
	    import from Integer;
	    
	    local classA := class a;
	    local classB := class b;
	    classA = classB and order( a ) = order ( b );
	}


	----------------------------------------------------------


	<<(p:BinaryWriter,a:%):BinaryWriter == {
	    import from Integer;
	    import from String;

	    p << (class a) << (order a);
	}


	----------------------------------------------------------


	<<(p:BinaryReader):% == {
	    import from Partial %;

	    local classA:Integer := << p;
	    local orderA:Integer := << p;

	    differentiate( variable classA, orderA );
	}


	----------------------------------------------------------


	variable( p: Integer, q: Integer ):% == {
	    differentiate( variable p, q );
	}


	----------------------------------------------------------


	variable( v: VARS, q: Integer ):% == {
	    differentiate( v::%, q );
	}

    
	----------------------------------------------------------

	
	totalOrder( a: % ): Integer == {
	    order a;
	}

    
	---------------------------------------------------------

	
	properDerivative?( a: %, b: % ): Boolean == {
	    import from Integer;

	    class a ~= class b => false;
	    order a > order b;
	}

    
	---------------------------------------------------------


    }
};
