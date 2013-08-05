-------------------------------------------------------------------------
--
-- cs_dvt.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{is a category for differential indeterminates}
+++The indeterminates of \adcode{VARS} are extended by differential structure. The derivations of this differential structure are described in the corresponding implementation of \adthistype.
+++
+++For \adthistype, the term ``to apply a derivation'', as used in the description of \adtype{DifferentialType}, refers to juxtaposing derivations.
+++\end{addescription}
DifferentialVariableType(

  VARS  : FiniteVariableType

): Category == with {

    CopyableType;
    VariableType;
    DifferentialType;

    +++\begin{addescription}{denotes the number of dervations}
    +++\end{addescription}
    derivationSymbolsCount : Integer;

    +++\begin{addescription}{gives the \adtype{Symbol}{}s for the derivations}
    +++The index of the \adtype{Symbol}{}s in this \adtype{Array} has corresponds to the \adname[DifferentialType]{differentiate} functions of \adtype{DifferentialType}.
    +++
    +++ In other words, let \adcode{ai} denote an \adtype{Integer}, \adcode{mi} an \adtype{MachineInteger} and \adcode{s} a \adtype{Symbol}. If \adcode{mi} and \adcode{ai} denote the same integer value and \adcode{derivationFunctien(ai)} refers to the same function as \adcode{derivationFunction(s)}, then the element with index \adcode{mi} is \adcode{s}.
    +++\end{addescription}
    derivationSymbols : () -> Array Symbol;
    
    +++\begin{addescription}{returns the underived variable of the given class}
    +++The only parameter to this function is an \adtype{Integer} denoting the class.
    +++\end{addescription}
    variable: Integer -> %;


    +++\begin{addescription}{lifts an element of \adcode{VARS}}
    +++\end{addescription}
    coerce: VARS -> %;

    +++\begin{addescription}{pushes an element back to \adcode{VARS}}
    +++Pushing back elements to \adcode{VARS} is not limited to differential indeterminates of total order $0$. If the total order of the given element is not $0$, its order is ignored. Therefore, all elements of the same class are mapped to the same element in \adcode{VARS}.
    +++\end{addescription}
    coerce: % -> VARS;

    +++\begin{addescription}{returns the class of a differential indeterminates}
    +++\end{addescription}
    class: % -> Integer;

    +++\begin{addescription}{creates a differential indeterminate}
    +++The \adtype{Integer} parameter denotes the class of the new differential indeterminate and the \adtype{Array} parameter denotes the orders. The \admacro{Integer} parameter has to be positive and must not exceed the number of indeterminates in \adcode{VARS}. The \adtype{Array} element at index $0$ denotes the order with respect to the derivation of index $0$. The element at index $1$ denotes the order with respect to the derivation of index $1$, and so on. If \adthistype has $n$ derivations, the \adtype{Array} parameter must have $n$ slots. It is not allowed to drop trailing $0$ entries.
    +++
    +++For example, if the variable of class $1$ is $y$, and the \adtype{Symbol}{}s for the derivations are $s$, $t$, and $u$, \adcode{variable( 1, [ 2, 0, 1 ] )} gives $y_{ssu}$.
    +++\end{addescription}
    variable: (Integer, Array Integer) -> %;

    +++\begin{addescription}{creates a differential indeterminate}
    +++The \adcode{VARS} parameter denotes the indeterminate to lift to the differential indeterminate domain. The \adtype{Array} parameter denotes the orders of this new indeterminate. The \adtype{Array} element at index $0$ denotes the order with respect to the derivation of index $0$. The element at index $1$ denotes the order with respect to the derivation of index $1$, and so on. If \adthistype has $n$ derivations, the \adtype{Array} parameter must have $n$ slots. It is not allowed to drop trailing $0$ entries.
    +++
    +++For example, if \adcode{var} denotes the indeterminatee $y$, and the \adtype{Symbol}{}s for the derivations are $s$, $t$, and $u$, \adcode{variable( var, [ 2, 0, 1 ] )} gives $y_{ssu}$.
    +++\end{addescription}
    variable: (VARS, Array Integer) -> %;

    +++\begin{addescription}{gives the orders of a differential indeterminate}
    +++The \adtype{Array} has as many slots, as there are derivations. The element at index $0$ denotes the order with respect to the derivation of index $0$. The element at index $1$ denotes the order with respect to the derivation of index $1$, and so on. Trailing $0$ entries are not dropped.
    +++\end{addescription}
    order: % -> Array Integer;

    +++\begin{addescription}{gives the total order of a differential indeterminate}
    +++\end{addescription}
    totalOrder: % -> Integer;

    +++\begin{addescription}{decides whether or not the first argument is a proper derivative of the second one}
    +++For the description of \adthisname, consider the statement{properDerivative?( u, v )}. If there is an element $\theta$ in the semigroup generated by the domain's derivations, such that $u = \theta v$, the statement gives \adname[Boolean]{true}. Otherwise it gives \adname[Boolean]{false}.
    +++\end{addescription}
    properDerivative?: ( %, % ) -> Boolean;

    default {


	----------------------------------------------------------


	=(a:%,b:%):Boolean == {
	    import from Integer;
	    import from Array Integer;
	    
	    local classA := class a;
	    local classB := class b;
	    classA = classB and order( a ) = order ( b );
	}


	----------------------------------------------------------


	<<(p:BinaryWriter,a:%):BinaryWriter == {
	    import from Integer;
	    import from Array Integer;
	    import from String;

	    p << (class a) << (order a);
	}


	----------------------------------------------------------


	<<(p:BinaryReader):% == {
	    import from Partial %;

	    local classA:Integer := << p;
	    local orderA:Array Integer := << p;

	    differentiate( variable classA, orderA );
	}


	----------------------------------------------------------


	hash(a:%):MachineInteger == {
	    import from Integer;
	    import from Array Integer;
	    (next (#$VARS)) * ( hash order a ) +( (machine$Integer) ((class a)@Integer) ) ;
	}


	----------------------------------------------------------


	<<(p:TextWriter,a:%):TextWriter == {
	    import from ExpressionTree;
	    aldor( p, extree a );
	}


	----------------------------------------------------------


	variable( p: Integer, q: Array Integer ):% == {
	    differentiate( variable p, q );
	}


	----------------------------------------------------------


	variable( v: VARS, q: Array Integer ):% == {
	    differentiate( v::%, q );
	}


	----------------------------------------------------------


	coerce( a:% ): VARS == {
	    import from List VARS;
	    import from MachineInteger;
	    
	    assert( 0 <= class a );
	    assert( class a <= max::Integer );

	    (minToMax$VARS) . ( machine class a - prev (firstIndex$(List VARS)));

	}


	----------------------------------------------------------
	
	
	totalOrder( a: % ): Integer == {
	    import from Array Integer;
	    local total := 0;
	    for ord in order( a ) repeat 
	    {
		total := total + ord;
	    }
	    total;

	}

    
	---------------------------------------------------------

	properDerivative?( a: %, b: % ): Boolean == {
	    import from Array Integer;

	    class a ~= class b => false;
	    local greater? : Boolean := false;
	    
	    for elementOrderA in order a 
	    for elementOrderB in order b repeat 
	    {
		if elementOrderA > elementOrderB then
		{
		    greater? := true;
		} else if elementOrderA < elementOrderB then {
		    return false;
		}
		
	    }
	    greater? ;
	    
	}

    
	---------------------------------------------------------


    }
};
