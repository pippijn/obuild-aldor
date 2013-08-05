-------------------------------------------------------------------------
--
-- cs_trred.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( T, % );

+++\begin{addescription}{collects functions for reductions}
+++\adthistype extends \adtype{ReductionType} by additional functions for reductions by \adtype{AutoreducedSet}{}s and \adtype{List}{}s. Furthermore, the given reduction functions allow to obtain elements used for premultiplication via additional \adtype{Set} \adcode{T} return values.
+++\end{addescription}
TriangularizationReductionType(
  T: TriangularizationTType
) : Category == with {
        
    ReductionType T;

    ------------------------------------
    
    +++\begin{addescription}{gives a function to decide whether or not an element is reduced.}
    +++\adcode{reducedBy?( as )( a )} gives \adname[Boolean]{true}, if \adcode{a} is reduced with respect to the \adtype{AutoreducedSet} \adcode{as}. Otherwise, \adname[Boolean]{false} is returned.
    +++\end{addescription}
    reducedBy?: AS -> ( T -> Boolean );

    +++\begin{addescription}{decides whether or not an element is reduced.}
    +++\adcode{reducedBy?( a, as )} gives \adname[Boolean]{true}, if \adcode{a} is reduced with respect to the \adtype{AutoreducedSet} \adcode{as}. Otherwise, \adname[Boolean]{false} is returned.
    +++\end{addescription}
    reduced?: ( T, AS ) -> Boolean;

    ------------------------------------


    +++\begin{addescription}{gives a function for reduction}
    +++Let \adcode{c} be a variable of type \adcode{T} and \adcode{s} be a variable of type \adtype{Set} \adcode{T}.
    +++After issuing \adcode{( c, s ) := reduceBy( b )( a )}, the statement ``\adcode{b} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{b} and \adcode{s} contains those elements of \adcode{T} that have been used to multiply by during the reduction.
    +++\end{addescription}
    reduceBy: T -> ( T -> ( T, Set T ) );
    
    +++\begin{addescription}{gives a function for reduction}
    +++After issuing \adcode{ c := reduceBy( as )( a )}, the statement ``\adcode{as} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{as}.
    +++\end{addescription}
    reduceBy: AS -> ( T -> T );

    +++\begin{addescription}{gives a function for reduction}
    +++Let \adcode{c} be a variable of type \adcode{T} and \adcode{s} be a variable of type \adtype{Set} \adcode{T}.
    +++After issuing \adcode{( c, s ) := reduceBy( as )( a )}, the statement ``\adcode{as} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{as} and \adcode{s} contains those elements of \adcode{T} that have been used to multiply by during the reduction.
    +++\end{addescription}
    reduceBy: AS -> ( T -> ( T, Set T ) );

    +++\begin{addescription}{reduces an element}
    +++Let \adcode{c} be a variable of type \adcode{T} and \adcode{s} be a variable of type \adtype{Set} \adcode{T}.
    +++After issuing \adcode{( c, s ) := reduce( a, b )}, the statement ``\adcode{b} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{b} and \adcode{s} contains those elements of \adcode{T} that have been used to multiply by during the reduction.
    +++\end{addescription}
    reduce: ( T, T ) -> ( T, Set T ); 

    +++\begin{addescription}{reduces an element}
    +++After issuing \adcode{c := reduce( a, as )}, the statement ``\adcode{as} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{as}.
    +++\end{addescription}
    reduce: ( T, AS ) -> T;

    +++\begin{addescription}{reduces an element}
    +++Let \adcode{c} be a variable of type \adcode{T} and \adcode{s} be a variable of type \adtype{Set} \adcode{T}.
    +++After issuing \adcode{( c, s ) := reduce( a, as )}, the statement ``\adcode{as} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{as} and \adcode{s} contains those elements of \adcode{T} that have been used to multiply by during the reduction.
    +++\end{addescription}
    reduce: ( T, AS ) -> ( T, Set T );
    
    +++\begin{addescription}{reduces an element}
    +++After issuing \adcode{c := reduce( a, l )}, the statement ``\adcode{l} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{l}.
    +++\end{addescription}
    reduce: ( T, List T ) -> T;

    +++\begin{addescription}{reduces an element}
    +++Let \adcode{c} be a variable of type \adcode{T} and \adcode{s} be a variable of type \adtype{Set} \adcode{T}.
    +++After issuing \adcode{( c, s ) := reduce( a, l )}, the statement ``\adcode{l} reduces \adcode{a} to \adcode{c}'' holds. \adcode{c} is reduced with respect to \adcode{l} and \adcode{s} contains those elements of \adcode{T} that have been used to multiply by during the reduction.
    +++\end{addescription}
    reduce: ( T, List T ) -> ( T, Set T );

    ------------------------------------

    +++\begin{addescription}{computes consequences of adding elements to an autoreduced set}
    +++In intermediate steps of triangularization algorithms there are typically statements like ``if $a$ and $b$ will be part of the result of the triangularization, $c_1, c_2, \ldots$ have to be considered as well''. \adthisname computes these $c_1, c_2, \ldots$.
    +++\end{addescription}
    +++\begin{adremarks}
    +++For polynomial reduction, \adthisname typically refers to computing S-polynomials. For differential polynomial reduction, \adthisname usually denotes $\Delta$-polynomials.
    +++\end{adremarks}
    consequences: ( T, T ) -> List T;

    +++\begin{addescription}{computes consequences of adding elements to an autoreduced set}
    +++In intermediate steps of triangularization algorithms there are typically statements like ``if $a$ and $b$ will be part of the result of the triangularization, $c_1, c_2, \ldots$ have to be considered as well''. \adthisname computes these $c_1, c_2, \ldots$.
    +++
    +++Let \adcode{c} be a variable of type \adtype{List} \adcode{T} and \adcode{s} be a variable of type \adtype{Set} \adcode{T}. After issuing \adcode{( c, s ) := consequences( a, b )}, \adcode{c} holds the required $c_1, c_2, \ldots$. \adcode{s} contains those elements of \adcode{T} that have been used to multiply by during the reduction.
    +++\end{addescription}
    +++\begin{adremarks}
    +++For polynomial reduction, \adthisname typically refers to computing S-polynomials. For differential polynomial reduction, \adthisname usually denotes $\Delta$-polynomials.
    +++\end{adremarks}
    consequences: ( T, T ) -> ( List T, Set T );

    ------------------------------------

    default {


	-------------------------------------------


	consequences( a:T, b: T ): List T == {
	    ( red: List T, sat: Set T ) := consequences( a, b );
	    red;
	}


	-------------------------------------------

	
	reducedBy?( as: AS ): ( T -> Boolean ) == {
            --ToDo :reduced funktionen in array vorspeichern;
	    ( a: T ):Boolean +-> {
		for elementLst in as | ~ reduced?( a, elementLst ) repeat
		{
		    return false;
		}
		true;
	    }
	}


	-------------------------------------------


	reduce( a:T, b: T ): T == {
	    ( red: T, sat: Set T ) := reduce( a, b );
	    red;
	}

	-------------------------------------------

	reduce( a: T, lst: List T ): T == {
	    ( red: T, sat: Set T ) := reduce( a, lst );
	    red;
	}

	-------------------------------------------

	reduce( a: T, lst: List T ): ( T, Set T ) == {
	    local sats: Set T := empty;
	    local notReducedInLastStep? := false;
	    while ~ notReducedInLastStep? repeat 
	    {
		notReducedInLastStep? := true;
		while notReducedInLastStep? for elem in lst repeat {
		    if ~ reduced?( a, elem ) then
		    {
			( a: T, lSats: Set T ) := reduce( a, elem );
			sats := union!( sats, lSats);
			notReducedInLastStep? := false;
		    }
		}
	    }
	    ( a, sats );
	}

	-------------------------------------------

	
	reduceBy( b: T ): T -> T == {
	    local reductionFunction: T -> ( T, Set T ) := reduceBy b;
	    ( a: T ):T +-> {
		( red: T, sat: Set T ) := reductionFunction a;
		red;
	    }
	}


	-------------------------------------------


	reduce( a:T, b: AS ): T == {
	    ( red: T, sat: Set T ) := reduce( a, b );
	    red;
	}


	-------------------------------------------

	
	reduceBy( b: AS ): T -> T == {
	    local reductionFunction: T -> ( T, Set T ) := reduceBy b;
	    ( a: T ):T +-> {
		( red: T, sat: Set T ) := reductionFunction a;
		red;
	    }
	}


	-------------------------------------------

	
	reduce( a:T, b: T ): ( T, Set T ) == {
	    ( reduceBy( b ) ) a;
	}


	-------------------------------------------

	reduce( a:T, b: AS ): ( T, Set T ) == {
	    ( reduceBy( b ) ) a;
	}


	-------------------------------------------

	reduced?( a:T, as: AS ): Boolean == {
	    ( reducedBy? as ) a;
	}


	-------------------------------------------

    }
}