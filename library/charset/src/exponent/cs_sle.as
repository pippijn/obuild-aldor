-------------------------------------------------------------------------
--
-- cs_sle.as
--
-------------------------------------------------------------------------

#include "charset.as"

import from Integer;
import from MachineInteger;
import from String;

import from String;
import from Symbol;

+++\begin{addescription}{implements exponents via sorted lists}
+++\adthistype is represented by \adtype{SortedList}{}s of \adcode{VARS}. Therefore, the elements are stored in increasing order.
+++\end{addescription}
+++\begin{adremarks}
+++An implementation of \adtype{ExponentCategory} using \adtype{List} representation but dercreasing order can be found in \adtype{ListSortedExponent}.
+++\end{adremarks}
SortedListExponent( 

   VARS: VariableType

  ) : with{
 
	  ExponentCategory( VARS );
	  CopyableType;

  } == ExponentCategoryTools( VARS, % ) add {

    macro Rep == SortedList VARS;
    import from Rep;


    -----------------------------------------------------------


    =( a:%, b:% ):Boolean == {
	rep a = rep b;
    }


    -----------------------------------------------------------


    0:% == per empty;


    -----------------------------------------------------------


    zero?( a:% ):Boolean == {
	    empty? rep a;
    }


    -----------------------------------------------------------


    copy( a:% ):% == {
	    per copy rep a;
    }


    -----------------------------------------------------------


    copy!( a:%, b:% ):% == {
	    per copy!( rep a, rep b );
    }


    -----------------------------------------------------------


    add!( a:%, b:% ):% == {
	local result := rep a;

	for dVarB in rep b repeat 
	{
		result := insert!( dVarB, result );
	}

	per result;
    }


    -----------------------------------------------------------


    variables( a:% ):List VARS == {
	zero? a => [];
	import from VARS;
	import from Generator VARS;
	local generatorRepA := generator rep a;
	local lastInserted := next! generatorRepA;
	local result : List VARS := [ lastInserted ];
	for dVarA in generatorRepA repeat
	{
	    if dVarA ~= lastInserted then
	    {
		result := insert!( dVarA, result );
		lastInserted := dVarA;
	    }
	} 
	result;
    }


    -----------------------------------------------------------


    <( a:%, b:% ):Boolean == {
	    import from VARS;

	    local repA := rep a;
	    local repB := rep b;

	    for dVarAIdx in ( prev (# repA) + firstIndex$Rep) .. (firstIndex$Rep) by -1
	    for dVarBIdx in ( prev (# repB) + firstIndex$Rep) .. (firstIndex$Rep) by -1
	    repeat {
		    local dVarA := repA . dVarAIdx;
		    local dVarB := repB . dVarBIdx;

		    if dVarA < dVarB then
		    {
			    return true;
		    }
		    if dVarA > dVarB then
		    {
			    return false;
		    }		
	    }

	    -- so the longer list equals the smaller list in every element of the smaller list
	    # repA < # repB;
    }


    -----------------------------------------------------------

    
    cancel?( a:%, b:% ):Boolean == {
	    zero? b => true;

	    local found?:Boolean;
	    local repA := rep a;

	    --note the prev, since a next is used even on first search in loop
	    local i := prev (firstIndex$Rep);
	    
	    
	    for dVarB in rep b repeat 
	    {
		    local foundVARSar:VARS;

		    (found?, i, foundVARSar) := linearSearch( dVarB, repA, next i );					     
		    if ~ found? then 
		    {
			    return false;
		    }		    
	    }
	    
	    true;
    }

    cancel( a:%, b:% ):% == {
	    local result := rep copy a;
	    for dVarB in rep b repeat {
		    result := remove!( dVarB, result );
	    }
	    per result;
    }

    cancelIfCan( a:%, b:% ):Partial % == {
	    import from VARS;
	    zero? b => [ a ];
	    local repB := rep b;
	    local idxB := firstIndex$Rep;
	    local dVarB := repB.idxB;

	    local result:Rep := empty;
	    for dVarA in rep a repeat
	    {
		    if dVarA < dVarB or idxB > firstIndex$Rep + (prev # repB) then
		    {
			    result := insert!( dVarA, result );
		    } else if dVarA = dVarB then {
			    idxB := next idxB;
			    if idxB <= firstIndex$Rep + (prev # repB) then
			    {
				    dVarB := repB.idxB;
			    }
		    } else {
			    return failed;
		    }
	    }

	    idxB <= firstIndex$Rep + (prev # repB) => failed;

	    return [ per result ];
    }

    exponent( v:VARS ):% == {
	    per [ v ];
    }

    exponent( dv: VARS, n: Integer): % == {
	    assert( 0 <= n );
	    assert( n <= coerce max );
	    per new( machine n, dv );
    }

    terms( a: % ): Generator( Cross( VARS, Integer ) ) == {
	import from VARS;
	macro CROSS == Cross( VARS, Integer );
	local accumulatedCross: List CROSS := empty;
	
	if ~ zero? a then
	{
	    local lastVar := (rep a).(firstIndex$Rep);
	    local count: Integer := 0;
	    for dv in rep a repeat 
	    {			
		if dv = lastVar then
		{ 
		    count := next count;
		} else {			    
		    accumulatedCross := cons( ( lastVar, count ), accumulatedCross );
		    lastVar := dv;
		    count := 1;
		}
	    }
	    accumulatedCross := cons( ( lastVar, count ), accumulatedCross );
	}
	generator accumulatedCross;
    }

    mainVariable( a: % ): Partial VARS == {
	zero? a => failed;
	[ (rep a).(firstIndex$Rep+(# rep a-1)) ];
    }
    
    gcd( a: %, b: % ): % == {
	local repB := rep b;
	local ret: Rep := [];
	for cross in terms a repeat
	{
	    ( dv, n ) := cross;
	    ( found?, foundPos, foundElem) := linearSearch( dv, repB );
	    if n > 0 then
	    {
		while found? repeat
		{ 
		    ret := insert!( dv, ret );
		    n := prev n;
		    if zero? n then
		    {
			found? := false;
		    } else {  
			( found?, foundPos, foundElem) := linearSearch( dv, repB, next foundPos );
		    }
		}
	    }
	}
	per ret;
    }

    lcm( a: %, b: % ): % == {
	local repB := rep copy b;
	for dv in rep a repeat
	{
	    repB := remove!( dv, repB );
	}
	add!( per repB, copy a );	
    }


    -----------------------------------------------------------
    
    
    totalDegree( a: % ): Integer == {
	coerce # rep a
    }


    -----------------------------------------------------------
    
    
    degree( a: %, v: VARS ): Integer == {
	import from List VARS;
	local result : Integer := 0;
        local varsGen := generator rep a;
	for var in rep a repeat
	{
	    if var = v then 
	    {
		result := next result;
	    } else if var > v then {
		return result;
	    }
	}
	result;
    }


    -----------------------------------------------------------

    
};
