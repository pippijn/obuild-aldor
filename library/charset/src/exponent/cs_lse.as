-------------------------------------------------------------------------
--
-- cs_lse.as
--
-------------------------------------------------------------------------

#include "charset.as"

import from Integer;
import from MachineInteger;
import from String;

import from String;
import from Symbol;

+++\begin{addescription}{implements exponents via sorted lists}
+++\adthistype is represented by \adtype{List}, not \adtype{SortedList}. Nevertheless, the \adtype{List}{}s are kept sorted (in decreasing order).
+++\end{addescription}
+++\begin{adremarks}
+++An implementation of \adtype{ExponentCategory} using \adtype{SortedList} can be found in \adtype{SortedListExponent}.
+++\end{adremarks}
ListSortedExponent( 

  VARS: VariableType

) : with {

    ExponentCategory( VARS );
    CopyableType;

} == ExponentCategoryTools( VARS, % ) add {

    macro Rep == List VARS;
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

	per merge!( rep a, rep copy b, >$VARS ) 

    }


    -----------------------------------------------------------


    variables( a:% ):List VARS == {
	zero? a => [];
	import from VARS;
	local result := rep copy a;

	local head := result;
	local firstHead := first head;
	local restHead := rest head;
	empty? restHead => result;
	while ~ empty? restHead repeat
	{
	    if firstHead = first restHead then
	    {
		restHead := rest restHead;
		setRest!( head, restHead );
	    } else {		
		head := restHead;
		firstHead := first head;
		restHead := rest restHead;
	    }
	}

	result;
    }


    -----------------------------------------------------------


    <( a:%, b:% ):Boolean == {
	import from VARS;
	local repA := rep copy a;
	local repB := rep copy b;

	for elementA in repA for elementB in repB repeat {
	    if elementA ~= elementB then
	    {
		return elementA < elementB
	    }		
	}

	-- so the longer list equals the smaller list in every element of the smaller list
	# repA < # repB;
    }


    -----------------------------------------------------------


    cancel?( a:%, b:% ):Boolean == {

	import from VARS;

	zero? b => true;

	local repB := rep b;	    
	local firstB := first repB;
	local restB := rest repB;

	for elementA in rep a repeat
	{
	    if elementA = firstB then
	    {
		if empty? restB then
		{
		    return true;
		}
		firstB := first restB;
		restB := rest restB;

	    } else if elementA < firstB then {

		return false;
	    }
	}

	return false;

    }


    -----------------------------------------------------------


    cancel( a:%, b:% ):% == {

	import from VARS;

	zero? b => copy a;

	local repB := rep b;	    
	local firstA : VARS;
	local restA : Rep := rep a;
	local firstB := first repB;
	local restB := rest repB;
	local result : Rep := [];
	local resultTail := result;

	while ~ empty? restA and empty? result repeat
	{
	    firstA := first restA;
	    restA := rest restA;

	    if firstA = firstB then
	    {
		if empty? restB then
		{		    
		    return per copy restA;
		}
		firstB := first restB;
		restB := rest restB;

	    } else {
		-- this assert is justifiable, since the behaviour of
		-- cancel( a, b ) is only defined if cancel?( a, b ) yields true.
		-- This in turn leads to this assertion.

		assert( firstA > firstB );

		resultTail := result := [ firstA ];
	    }	    	    
	}

	while ~ empty? restA repeat
	{
	    firstA := first restA;
	    restA := rest restA;

	    if firstA = firstB then
	    {
		if empty? restB then
		{
		    setRest!( resultTail, copy restA );
		    return per result;
		}
		firstB := first restB;
		restB := rest restB;

	    } else {
		-- this assert is justifiable, since the behaviour of
		-- cancel( a, b ) is only defined if cancel?( a, b ) yields true.
		-- This in turn leads to this assertion.

		assert( firstA > firstB );

		resultTail := setRest!( resultTail, [ firstA ] );
	    }


	}

	never;

    }


    -----------------------------------------------------------


    cancelIfCan( a:%, b:% ):Partial % == {

	import from VARS;

	zero? b => [ copy a ];

	local repB := rep b;	    
	local restA : Rep := rep a;
	local firstA : VARS;
	local firstB := first repB;
	local restB := rest repB;
	local result : Rep := [];
	local resultTail := result;

	while ~ empty? restA and empty? result repeat
	{
	    firstA := first restA;
	    restA := rest restA;

	    if firstA = firstB then
	    {
		if empty? restB then
		{
		    return [ per copy restA ];
		}
		firstB := first restB;
		restB := rest restB;

	    } else if firstA < firstB then {

		return failed;

	    } else {

		resultTail := result := [ firstA ];

	    }	    	    
	}


	while ~ empty? restA repeat
	{
	    firstA := first restA;
	    restA := rest restA;

	    if firstA = firstB then
	    {
		if empty? restB then
		{
		    setRest!( resultTail, copy restA );
		    return [ per result ];
		}
		firstB := first restB;
		restB := rest restB;

	    } else if firstA < firstB then {

		return failed;

	    } else {

		resultTail := setRest!( resultTail, [ firstA ] );

	    }	   	    
	}

	return failed;

    }

    -----------------------------------------------------------


    exponent( v:VARS ):% == {
	per [ v ];
    }


    -----------------------------------------------------------


    exponent( dv: VARS, n: Integer): % == {
	assert( 0 <= n );
	assert( n <= coerce max );
	per new( machine n, dv );
    }


    -----------------------------------------------------------


    terms( a: % ): Generator( Cross( VARS, Integer ) ) == {
	import from VARS;
	local repA := rep a;
	generate 
	{
	    if ~ zero? a then
	    {
		local lastVar := repA.(firstIndex$Rep);
		local count: Integer := 0;
		for dv in repA repeat {			
		    if dv = lastVar then
		    { 
			count := next count;
		    } else {			    
			yield ( lastVar, count );
			lastVar := dv;
			count := 1;
		    }
		}
		yield ( lastVar, count );
	    }
	}
    }


    -----------------------------------------------------------


    mainVariable( a: % ): Partial VARS == {
	zero? a => failed;
	[ first rep a ];
    }


    -----------------------------------------------------------


    gcd( a: %, b: % ): % == {
	import from VARS;
	local repA := rep a;
	empty? repA => 0;

	local repB := rep b;
	empty? repB => 0;

	import from DoubleEndedList VARS;
	local firstA := first repA;
	local restA := rest repA;
	local firstB := first repB;
	local restB := rest repB;	
	local result : DoubleEndedList VARS := empty();

	while ~ empty? restA and ~ empty? restB repeat
	{
	    if firstA = firstB then
	    {
		result := concat!( result, firstA );
		firstA := first restA;
		restA := rest restA;
		firstB := first restB;
		restB := rest restB;
	    } else if firstA > firstB then {
		firstA := first restA;
		restA := rest restA;
	    } else {
		firstB := first restB;
		restB := rest restB;
	    }
	}

	if ~ empty? restB then
	{
	    while ~ empty? restB and firstB > firstA repeat
	    {
		firstB := first restB;
		restB := rest restB;
	    }
	} 

	if ~ empty? restA then
	{
	    while ~ empty? restA and firstA > firstB repeat
	    {
		firstA := first restA;
		restA := rest restA;
	    }
	} 

	if firstA = firstB then
	{
	    result := concat!( result, firstA );
	}
	per firstCell result;
    }


    -----------------------------------------------------------


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
        local vars := rep a;
	while ~ empty? vars and first vars ~= v repeat
	{
	    vars := rest vars;
	}
	empty? vars => 0;
	while ~ empty? vars and first vars = v repeat
	{
	    vars := rest vars;
	    result := next result;
	}
	result;
    }


    -----------------------------------------------------------


};
