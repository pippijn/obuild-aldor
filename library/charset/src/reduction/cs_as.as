-------------------------------------------------------------------------
--
-- cs_as.as
--
-------------------------------------------------------------------------

#include "charset.as"


+++\begin{addescription}{models sets of pairwise reduced elements}
+++\adthistype models sets of elements of \adcode{T} which are pairwise reduced with respect to the reduction specified by \adcode{RT}.
+++If \adcode{T} provides \adtype{PartiallyOrderedType}, the elements of \adthistype are get ordered in ascending order.
+++\end{addescription}
+++\begin{adremarks}
+++Although \adthistype can be considered as linear data structure, it does not export the category \adtype{LinearStructureType} of the \LibAldor library. \adtype{LinearStructureType}'s \adname[LinearStructureType]{set!} function maps to \adcode{%} and does not allow to restrict the values a slot can be set to. For \adthistype, such a function cannot be implemented, as setting slots to arbitrary values might demolish the property of being autoreduced. The semantic of \adtype{LinearStructureType}'s \adname[LinearStructureType]{set!} cannot be changed to meet further requirements. Therefore, \adtype{LinearStructureType} and its descendants cannot be exported by \adthistype.
+++
+++However, \adtype{LinearStructureType} and its descendants export several functions that are valid and useful for \adthistype. Therefore, these functions are exported explicitly.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{AutoreducedSetTools}
+++\end{adseealso}
AutoreducedSet(
  T: AutoreducedSetTType,
  RT : ReductionType T
): BoundedFiniteDataStructureType T with {

    if T has PrimitiveType then
    {
	PrimitiveType;
    }
    
    --von LinearStructureType
    +++\begin{addescription}{the index of the first entry of an autoreduced set}
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is similar to \adtype{LinearStructureType}'s \adname[LinearStructureType]{firstIndex}.
    +++\end{adremarks}
    firstIndex: MachineInteger ;
    
    +++\begin{addescription}{obtaining an element without removing it}
    +++The \adtype{MachineInteger} \adcode{n} denotes the position of the element to obtain. If \adcode{n} is \adname{firstIndex}, the first element of the given \adthistype is returned. \adcode{firstIndex+1} gives the second element and so on. This function does not perform bound checking--the caller has to assure that \adcode{n} is referring to a valid slot of \adthistype.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is similar to \adtype{LinearStructureType}'s \adname[LinearStructureType]{apply}.
    +++\end{adremarks}
    apply:( %, n: MachineInteger ) -> T;

    --von FiniteLinearStructureType
    +++\begin{addescription}{is an empty \adthistype}
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is similar to \adtype{FiniteLinearStructureType}'s \adname[FiniteLinearStructureType]{empty}.
    +++\end{adremarks}
    empty: % ;
       

    --eigene
    +++\begin{addescription}{generates an \adthistype from a \adtype{Generator}}
    +++If the result of \adthisname is \adname[Partial]{failed}, at the elements of the \adtype{Generator} are not pairwise reduced.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is similar to \adtype{FiniteLinearStructureType}'s \adname[FiniteLinearStructureType]{bracket}.
    +++\end{adremarks}
    bracket: Generator T -> Partial %;

    +++\begin{addescription}{generates an \adthistype from a \adtype{Tuple}}
    +++If the result of \adthisname is \adname[Partial]{failed}, at the elements of the \adtype{Tuple} are not pairwise reduced.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is similar to \adtype{LinearStructureType}'s \adname[LinearStructureType]{bracket}.
    +++\end{adremarks}
    bracket: Tuple T -> Partial %;

    +++\begin{addescription}{finding trivial autoreduced sets}
    +++If the given \adthistype consists of exactly one element and this element is a constant, \adthisname yields \adname[Boolean]{true}. Otherwise, \adname[Boolean]{false} is returned.
    +++\end{addescription}
    contradictory?: % -> Boolean;

    +++\begin{addescription}{decides whether or not an element of \adcode{T} can be inserted}
    +++If the given element of \adcode{T} can be inserted into the given \adthistype without ruining the autoreduced property, \adthisname results in \adname[Boolean]{true}. Otherwiso, \adthisname gives \adname[Boolean]{false}.
    +++\end{addescription}
    insertable?: ( T, % ) -> Boolean;
    
    +++\begin{addescription}{adds an element to an autoreduced set}
    +++If adding the given element of \adcode{T} destroys the autoreduced property of the given \adthistype, \adthisname returns \adname[Partial]{failed}. Otherwise, the result is a \adtype{Partial} value, wrapping an autoreduced set consisting of all the elements of the original \adthistype and additionally the given element of \adcode{T}. It is slower than \adname{insert!}, but does not act destructively on its elements.
    +++\end{addescription}
    insert: ( T, % ) -> Partial %;

    +++\begin{addescription}{adds an element to an autoreduced set}
    +++If adding the given element of \adcode{T} destroys the autoreduced property of the given \adthistype, \adthisname returns \adname[Partial]{failed}. Otherwise, the result is a \adtype{Partial} value, wrapping an autoreduced set consisting of all the elements of the original \adthistype and additionally the given element of \adcode{T}. This function acts destructively on its elements, but is in turn faster than \adname{insert}.
    +++\end{addescription}
    insert!: ( T, % ) -> Partial %;
    
} == List T add {

    --List gets sorted ascending order if possible
    Rep == List(T);
    import from T;
    import from RT;
    
    import from MachineInteger;

    -------------------------------------------

    contradictory?( a:% ) : Boolean == {
	import from Rep;
	~ empty? a and empty? rest rep a and ground? first rep a;
    }

    -------------------------------------------

    insert(t:T,a:%):Partial % == {
	insert!( t, copy a );
    }

    -------------------------------------------

    if T has PartiallyOrderedType or T has RankedType then 
    {
	insert!(t:T,a:%):Partial % == {
	    import from Rep;
	    import from Partial Rep;

	    insertable?( t, a ) => bracket per merge!( rep a, [t], > );
	    failed;
	}
    } else {
	insert!(t:T,a:%):Partial % == {
	    import from Rep;
	    import from Partial Rep;

	    insertable?( t, a ) => bracket per insert!( t, rep a );
	    failed;
	}
    }
    
    -------------------------------------------

    empty:% == per (empty$Rep);

    -------------------------------------------

    firstIndex:MachineInteger == firstIndex$Rep;

    -------------------------------------------

    apply( a:%, n:MachineInteger ): T == {
	import from Rep;
	( rep a ) . n ;	
    }

    -------------------------------------------

    insertable?(t:T,a:%):Boolean == {

	for aElem in a repeat {
	    if ~ ( reduced?( t, aElem ) and reduced?( aElem, t ) ) then {
		return false;
	    }
	}
	true;
    }
    
    -------------------------------------------

    bracket( ts: Tuple T ): Partial % == {
	import from Partial %;
	import from Rep;

	local ret: % := empty;
	for i in (1$MachineInteger) .. length ts repeat
	{
	    local pRet: Partial % := insert!( element( ts, i ), ret );
	    if failed? pRet then 
	    {
		return failed;
	    }
	    ret := retract pRet;
	}
	[ ret ];
    }
    
    -------------------------------------------

    bracket( gen: Generator T ): Partial % == {
	import from Partial %;
	import from Rep;

	local ret: % := empty;
	for elementGen in gen repeat
	{
	    local pRet: Partial % := insert!( elementGen, ret );
	    if failed? pRet then 
	    {
		return failed;
	    }
	    ret := retract pRet;
	}
	[ ret ];
    }

    -------------------------------------------

}