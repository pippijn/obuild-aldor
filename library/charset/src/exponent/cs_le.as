-------------------------------------------------------------------------
--
-- cs_le.as
--
-------------------------------------------------------------------------

#include "charset.as"

import from Integer;
import from MachineInteger;
import from String;

import from String;
import from Symbol;

+++\begin{addescription}{implements exponents via unsorted lists}
+++\end{addescription}
+++\begin{adremarks}
+++\adthistype is typically not performant. However, it serves as good reference implementation for other exponent implementation (e.g.: \adtype{ListSortedExponent}). With the help of \adthistype, the benefit that is due to sorting the lists cat be estimated.
+++\end{adremarks}
ListExponent( 

   VARS   : VariableType
   
  ) : with{
 
	  ExponentCategory( VARS );
	  CopyableType;

  } == ExponentCategoryTools( VARS, % ) add {

    macro Rep == List VARS;
    import from Rep;
        
    
    -----------------------------------------------------------

    
    =( a:%, b:% ):Boolean == {

        import from Partial %;
        local repA := rep a;
	local repB := rep b;

	# repA ~= # repB => false;

	--if they have the same number of elements, a cancels b
	--iff the are equivalent
	~ failed? cancelIfCan( a, b );

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

	local res := per append!( rep a, rep copy b );
	res;
	
    }

    
    -----------------------------------------------------------

    
    variables( a:% ):List VARS == {
	zero? a => [];
	import from VARS;
	local result := sort!( rep copy a, >$VARS );

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
	    local repA := sort!( rep copy a, >$VARS );
	    local repB := sort!( rep copy b, >$VARS );

	    for elementA in repA for elementB in repB
	    repeat {
		    if elementA ~= elementB then
		    {
			    return elementA < elementB;
		    }
	    }
	    -- so the longer list equals the smaller list in every element of the smaller list
	    # repA < # repB;
    }
    
    
    -----------------------------------------------------------

    
    cancel?( a:%, b:% ):Boolean == {
	    import from VARS;

	    zero? b => true;

	    local result:Rep := rep copy a;
	    for elementB in rep b repeat
	    {
		(found?, idx, var) := linearSearch( elementB, result );
		if ~ found? then
		{
		    return false;
		}

		result := delete!( result, idx );

	    }

	    return true;
    }

    
    -----------------------------------------------------------

    
    cancel( a:%, b:% ):% == {
	    local result := rep copy a;
	    for dVarB in rep b repeat {
		    result := remove!( dVarB, result );
	    }
	    per result;
    }

    
    -----------------------------------------------------------

    
    cancelIfCan( a:%, b:% ):Partial % == {
	    import from VARS;

	    zero? b => [ a ];

	    local result:Rep := rep copy a;
	    for elementB in rep b repeat
	    {
		(found?, idx, var) := linearSearch( elementB, result );
		if ~ found? then
		{
		    return failed;
		}

		result := delete!( result, idx );

	    }

	    return [ per result ];
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
	local repA := sort!( rep copy a, >$VARS );
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
	import from VARS;
	zero? a => failed;
	local ret := first rep a;
	for elementA in rest rep a repeat
	{
	    ret := max( ret, elementA );
	}
	[ ret ];
    }
    
    
    -----------------------------------------------------------

    
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
	while ~ empty? vars repeat
	{
	    if ( first vars = v ) then
	    {
		result := next result;
	    }
	    vars := rest vars;
	}
	result;
    }


    -----------------------------------------------------------

};
