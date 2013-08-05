-------------------------------------------------------------------------
--
-- cs_cumde.as
--
-------------------------------------------------------------------------

#include "charset.as"


+++\begin{addescription}{stores terms as pairs of indeterminate and degree}
+++For example if \adcode{VARS} denotes the indeterminates $y_1,y_2,y_3$, the term $$y_1^2y_3$$ is represented by the pairs $$(y_1,2), (y_3,0).$$ Indeterminates not occurring in a term are not stored.
+++\end{addescription}
+++\begin{adremarks}
+++For terms involving the indeterminates only with small degrees (say smaller than ten), other implementations of \adtype{ExponentCategory} (e.g.: \adtype{ListExponent}) are considerably faster than \adthistype. However, as the degrees of indeterminates in terms rise, \adthistype quickly outperforms other implementations.
+++\end{adremarks}
CumulatedExponent(

  VARS  : VariableType

) : with {

    ExponentCategory( VARS );
    CopyableType;

} == ExponentCategoryTools( VARS, % ) add {

    macro Pair == Record( var: VARS, deg: Integer );
    macro Rep == List Pair;
    
    import from VARS;
    import from Pair;
    import from Rep;
        
    
    -----------------------------------------------------------

    
    =( a:%, b:% ):Boolean == {
	    local lstA := rep a;
	    local lstB := rep b;
	    while ~ (empty? lstA or empty? lstB) repeat
	    {
		local firstA := first lstA;
		local firstB := first lstB;
		if firstA . var ~= firstB . var or firstA . deg ~= firstB . deg then
		{
		    return false;
		}
		lstA := rest lstA;
		lstB := rest lstB;
	    }
	    return empty? lstA and empty? lstB;
    }

    
    -----------------------------------------------------------

    
    0:% == per empty;

    
    -----------------------------------------------------------

    
    zero?( a:% ):Boolean == {
	empty? rep a;
    }

    
    -----------------------------------------------------------

    
    copy( a:% ):% == {
	per [ record( elemA . var, elemA . deg ) for elemA in rep a ];
    }

    
    -----------------------------------------------------------

    
    add!( a:%, b:% ):% == {

	zero? a => copy b;
	zero? b => a;
	
	local lstA := rep a;
	local varA := (first lstA) . var;
	local lstAProcessed? := false;
	
	local lstB := rep b;	
	local varB := ( first lstB ) . var;
	    	    
	local result := lstA;

	local catListB: List Pair := empty;
	while varB > varA repeat
	{
	    catListB := insert( record( varB, (first lstB) . deg ), catListB );
	    lstB := rest lstB;
	    if empty? lstB then
	    {
		return per append!( reverse catListB, result );
	    }
	    varB := ( first lstB ) . var;
	}
	result := append!( reverse catListB, result );
	
	for pairB in lstB repeat {

	    varB := pairB . var;
	    	    
	    while ~ lstAProcessed? and varB < varA repeat
	    {
		if empty? rest lstA then {
		    lstAProcessed? := true;
		} else {
		    lstA := rest lstA;
		    varA := (first lstA) . var;
		}
	    }

	    if lstAProcessed? then
	    {
		
		lstA := append!( lstA, record( varB, pairB . deg ) );
		lstA := rest lstA;
		
	    } else if varB > varA then {

		local firstLstA := first lstA;
		setFirst!( lstA, record( varB, pairB . deg ) );
		lstA := setRest!( lstA, cons( firstLstA, rest lstA ) );

	    } else {
		assert( varB = varA );
		if varB = varA then {
		
		    local firstA := first lstA;
		    firstA . deg := firstA . deg + pairB . deg;
		}
	    }
	}
	return per result;
    }
    
    -----------------------------------------------------------

    
    variables( a:% ):List VARS == {
	
	[ elementA . var for elementA in rep a ];

    }

    
    -----------------------------------------------------------

    
    <( a:%, b:% ):Boolean == {
import from MachineInteger;
	local repA := rep a;
	    local repB := rep b;

	    for elementA in repA for elementB in repB repeat {
		local varA := elementA . var;
		local varB := elementB . var;
		
		if varA = varB then {
		    local degA := elementA.deg;
		    local degB := elementB.deg;
		    if degA ~= degB then 
		    {
			return degA < degB
		    }
		} else {
		    return varA < varB ;
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
	local varB := firstB . var;
	local degB := firstB . deg;
	local restB := rest repB;

	for elementA in rep a repeat
	{
	    local varA := elementA . var;
	    local degA := elementA . deg;
	    if varA = varB then
	    {
		if degA >= degB then
		{
		    if empty? restB then
		    {
			return true;
		    }
		    firstB := first restB;
		    varB := firstB . var;
		    degB := firstB . deg;
		    restB := rest restB;
		}

	    } else if varA < varB then {

		return false;
	    }
	}

	return false;

    }

    
    -----------------------------------------------------------

    cancel( a:%, b:% ):% == {

	zero? b => copy a;
	assert( ~ zero? a );
	
	local repA : Rep := rep a;
	local firstA := first repA;
	local varFirstA := ( firstA ) . var;
	local degFirstA := ( firstA ) . deg;
	local restA := rest repA;
	local result : DoubleEndedList Pair := empty();
	local handledFirstA := false;
	
	for elementB in rep b repeat {
	    local varFirstB := elementB . var;
	    local degFirstB := elementB . deg;

	    while varFirstA > varFirstB repeat {
		result := concat!( result, record( varFirstA, degFirstA ) );
		firstA := first restA;
		varFirstA := ( firstA ) . var;
		degFirstA := ( firstA ) . deg;
		restA := rest restA;
	    }
	    
	    assert( varFirstA = varFirstB );
	    assert( degFirstB <= degFirstA );
	    
	    if degFirstB < degFirstA then
	    {
		result := concat!( result, record( varFirstA, degFirstA - degFirstB ) );
	    }
            --NB if empty? restA, then elementB has to be the
	    --last element in rep b
	    if ~ empty? restA then
	    {
		firstA := first restA;
		varFirstA := ( firstA ) . var;
		degFirstA := ( firstA ) . deg;
		restA := rest restA;
	    } else {
		handledFirstA := true;
	    }
	}
	
	if ~ empty? restA then {

	    result := concat!( result, record( varFirstA, degFirstA ) );
	    result := concat!( result, [ rep copy per restA ] );
		
	} else 	if ~ handledFirstA then {
	    
	    result := concat!( result, record( varFirstA, degFirstA ) );

	}

	per firstCell result;
    }

    
    -----------------------------------------------------------

    
    cancelIfCan( a:%, b:% ):Partial % == {

	zero? b => [ copy a ];
	zero? a => failed;
	
	local repA := rep a;
	local firstA := first repA;
	local varFirstA := ( firstA ) . var;
	local degFirstA := ( firstA ) . deg;
	local restA := rest repA;
	local result : DoubleEndedList Pair := empty();
	local handledFirstA := false;
	
	for elementB in rep b repeat {
	    if handledFirstA then 
	    {
		return failed;
	    }
	    local varFirstB := elementB . var;
	    local degFirstB := elementB . deg;

	    while varFirstA > varFirstB repeat {
		result := concat!( result, record( varFirstA, degFirstA ) );
		if empty? restA then 
		{
		    return failed;
		}
		
		firstA := first restA;
		varFirstA := ( firstA ) . var;
		degFirstA := ( firstA ) . deg;
		restA := rest restA;
	    }
	    
	    if varFirstA < varFirstB or degFirstB > degFirstA then
	    {
		return failed;
	    }
	    
	    if degFirstB < degFirstA then
	    {
		result := concat!( result, record( varFirstA, degFirstA - degFirstB ) );
	    }
            --NB if empty? restA, then elementB has to be the
	    --last element in rep b
	    if ~ empty? restA then
	    {
		firstA := first restA;
		varFirstA := ( firstA ) . var;
		degFirstA := ( firstA ) . deg;
		restA := rest restA;
	    } else {
		handledFirstA := true;
	    }
	    
	}
	
	if ~ empty? restA then {

	    result := concat!( result, record( varFirstA, degFirstA ) );
	    result := concat!( result, [ rep copy per restA ] );
		
	} else 	if ~ handledFirstA then {
	    
	    result := concat!( result, record( varFirstA, degFirstA ) );

	}

	[ per firstCell result ];
    }
    
    -----------------------------------------------------------

    
    exponent( v:VARS ):% == {
	    per [ record( v, 1$Integer ) ];
    }

    
    -----------------------------------------------------------

    
    exponent( dv: VARS, n: Integer): % == {
	zero? n => 0;
	assert( 0 < n );
	per [ record( dv, n ) ];
    }

    
    -----------------------------------------------------------


    terms( a: % ): Generator( Cross( VARS, Integer ) ) == {
	generate 
	{
	    for pair in rep a repeat 
	    {
		yield ( pair . var, pair . deg );
	    }
	}
    }

    
    -----------------------------------------------------------

    
    mainVariable( a: % ): Partial VARS == {
	zero? a => failed;
	[ (first rep a) . var ];
    }
    
    
    -----------------------------------------------------------

    
    gcd( a: %, b: % ): % == {

	local repA := rep a;
	empty? repA => 0;

	local repB := rep b;
	empty? repB => 0;
	
	local firstA := first repA;
	local varFirstA := firstA . var;
	local restA := rest repA;
	local firstB := first repB;
	local varFirstB := firstB . var;
	local restB := rest repB;	
	local result : DoubleEndedList Pair := empty();
	  
	while ~ empty? restA and ~ empty? restB repeat
	{
	    if varFirstA = varFirstB then
	    {
		result := concat!( result, record( varFirstA, min( firstA . deg, firstB . deg ) ) );

		firstA := first restA;
		varFirstA := firstA . var;
		restA := rest restA;
		firstB := first restB;
		varFirstB := firstB . var;
		restB := rest restB;
	    } else if varFirstA > varFirstB then {
		firstA := first restA;
		varFirstA := firstA . var;
		restA := rest restA;
	    } else {
		assert( varFirstA < varFirstB );
		firstB := first restB;
		varFirstB := firstB . var;
		restB := rest restB;
	    }
	}
	
	if ~ empty? restB then
	{
	    while ~ empty? restB and varFirstB > varFirstA repeat
	    {
		firstB := first restB;
		varFirstB := firstB . var;
		restB := rest restB;
	    }
	} 
	    
	if ~ empty? restA then
	{
	    while ~ empty? restA and varFirstA > varFirstB repeat
	    {
		firstA := first restA;
		varFirstA := firstA . var;
		restA := rest restA;
	    }
	} 
	    
	if varFirstA = varFirstB then
	{
	    result := concat!( result, record( varFirstA, min( firstA . deg, firstB . deg ) ) );
	}
	per firstCell result;
    }

   
    -----------------------------------------------------------

    
    lcm( a: %, b: % ): % == {

	local lstA := rep a;
	empty? lstA => per copy rep b;

	local lstB := rep b;
	empty? lstB => per copy lstA;
	
	local firstA := first lstA;
	local varFirstA := firstA . var;
	local degFirstA := firstA . deg;
	local advanceA := false;

	local firstB := first lstB;
	local varFirstB := firstB . var;
	local degFirstB := firstB . deg;
	local advanceB := false;

	local result : DoubleEndedList Pair := empty();
	local gcdPair : Pair;
	
	while ~ ( empty? lstA and empty? lstB ) repeat
	{
	    if varFirstA > varFirstB then
	    {
		gcdPair := record( varFirstA, degFirstA );
		advanceA := true;
	    } else if varFirstA = varFirstB then {
		gcdPair := record( varFirstB, max( degFirstA, degFirstB ) );
		advanceA := true;
		advanceB := true;
	    } else {
		assert( varFirstA < varFirstB );
		gcdPair := record( varFirstB, degFirstB );
		advanceB := true;
	    }		
	    
	    result := concat!( result, gcdPair );

	    if advanceA then {
		lstA := rest lstA;
		if empty? lstA then {
		    if advanceB then
		    {
			result := concat!( result, [ rep copy per rest lstB ] );
		    } else {
			result := concat!( result, [ rep copy per lstB ] );
		    }
		    return per firstCell result;
		} else {
		    firstA := first lstA;
		    varFirstA := firstA . var;
		    degFirstA := firstA . deg;
		}
		advanceA := false;
	    }
	    if advanceB then {
		lstB := rest lstB;
		if empty? lstB then {
		    result := concat!( result, [ rep copy per lstA ] );
		    return per firstCell result;
		} else {
		    firstB := first lstB;
		    varFirstB := firstB . var;
		    degFirstB := firstB . deg;
		}
		advanceB := false;
	    }
	}
	
	per firstCell result;
    }

   

    
    -----------------------------------------------------------


    totalDegree( a: % ): Integer == {
	local result : Integer := 0;
	for elementA in rep a repeat 
	{
	    result := result + elementA . deg;
	}
	result;
    }


    -----------------------------------------------------------
    
    
    degree( a: %, v: VARS ): Integer == {
	local lstA := rep a;
	
	while ~ empty? lstA and ( first lstA ) . var > v repeat
	{
	    lstA := rest lstA;
	}
	~ empty? lstA and ( first lstA ) . var = v => (first lstA) . deg;
	0;
    }


    -----------------------------------------------------------

    
};
