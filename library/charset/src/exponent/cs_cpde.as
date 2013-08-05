-------------------------------------------------------------------------
--
-- cs_cpde.as
--
-------------------------------------------------------------------------

#include "charset.as"

import from Integer;
import from MachineInteger;
import from String;

import from String;
import from Symbol;


+++\begin{addescription}{stores terms in buckets of indeterminates of the same class}
+++Each term is dissected into subterms containing only indeterminates of the same class. Each of these subterms is stored by \adcode{EXP}. For example if \adcode{DVARS} denotes the derivatives in $y_1,y_2,y_3$, the term $$y_1y_3\delta_1y_1$$ is separated into $$y_1 \delta_1y_1, 0, \text{ and } y_3.$$ Each of these three terms ($0$ is the term in of class $2$) is stored using \adcode{EXP}.
+++\end{addescription}
ClassPresortedDifferentialExponent( 
  VARS  : FiniteVariableType,
  DVARS : EliminationOrderedDifferentialVariableType VARS,
  EXP   : with { 
      ExponentCategory DVARS; 
      CopyableType; 
  }
) : with {
    ExponentCategory( DVARS );
    CopyableType;
} == ExponentCategoryTools( DVARS, % ) add {

    macro Rep == Array EXP;
    import from Rep;
    import from EXP;

    -- Note that arrays are starting with integer 0. but in order not to have to
    -- bother with calculating the index for a class, the element of index 0 is
    -- empty and ignored.
    assert( 0$MachineInteger <= (#$VARS) );
    assert( (#$VARS) < max$MachineInteger);
    local maxIdx     := (#$VARS);
    local nextMaxIdx := next maxIdx;
    local idxs       := 1 .. (maxIdx);
    local revIdxs    := high idxs .. low idxs by -1;
    
    -----------------------------------------------------------
    
    =( a:%, b:% ):Boolean == {	
	zero? a => zero? b;
	zero? b => false;
	rep a = rep b;
    }

    
    -----------------------------------------------------------

    
    0:% == {
	per empty;
    }
    
    -----------------------------------------------------------

    
    zero?( a:% ):Boolean == {
	empty? rep a;
    }

    
    -----------------------------------------------------------

    
    copy( a:% ):% == {
	zero? a => 0;
	local result := new( nextMaxIdx, 0 );
	copy!( per result, a );
    }

    
    -----------------------------------------------------------

    
    copy!( a:%, b:% ):% == {
	zero? a => copy b;
	zero? b => 0;
	local repA := rep a;
	local repB := rep b;
	for idx in idxs repeat
	{
	    repA.idx := copy repB.idx;
	}
	per repA;
    }

    
    -----------------------------------------------------------

    
    add!( a: %, b: % ): % == {

        zero? b => a;
	zero? a => copy b;
	
        --Note that no check is necessary, if the entry for all classes gets 0,
	--since both a and b are not zero and also alements cannot cancel 
	--other ones in exponents-
	local repA := rep a;
	local repB := rep b;
	for idx in idxs repeat
	{
	    
	    repA.idx := add!( repA.idx, repB.idx );
	}
	per repA;
    }

    
    -----------------------------------------------------------

    
    variables( a: % ): List DVARS == {
	zero? a => empty;
	
	local repA := rep a;
	local result: List DVARS := empty;
	for idx in idxs repeat
	{
	    result :=  append! ( variables (repA.idx), result );
	}
	
	result;
	
    }

    
    -----------------------------------------------------------

    
    <( a:%, b:% ):Boolean == {
	zero? a => ( zero? b => false; true );
	zero? b => false;
	local repA := rep a;
	local repB := rep b;
	for idx in revIdxs repeat {
	    local repAIdx := repA.idx;
	    local repBIdx := repB.idx;
	    if repAIdx < repBIdx then 
	    {
		return true;
	    } else if repAIdx > repBIdx  then {
		return false;
	    }
	}
	assert( a = b );
	return false;
    }
    
    
    -----------------------------------------------------------

    
    cancel?( a:%, b:% ): Boolean == {
	zero? b => true;
	zero? a => false;
	
	local repA := rep a;
	local repB := rep b;
	for idx in idxs repeat
	{
	    if ~ cancel?( repA.idx, repB.idx ) then
	    {
		return false;
	    }
	}
	return true;
    }

    
    -----------------------------------------------------------

    
    cancel( a: %, b: % ): % == {
	zero? b => copy a;
	
	assert( ~ zero? a );
	
	local repA := rep a;
	local repB := rep b;
	local result := new( nextMaxIdx, 0 );
	local isZero? := true;
	for idx in idxs repeat
	{
	    isZero? := zero? ( result.idx := cancel( repA.idx, repB.idx ) ) and isZero?;
	}
	isZero? => 0;
	per result;
    }

    
    -----------------------------------------------------------

    
    cancelIfCan( a:%, b:% ):Partial % == {
	zero? b => [ copy a ];
	zero? a => failed;
	
	import from Partial %;

	local repA := rep a;
	local repB := rep b;
	local result := new( nextMaxIdx, 0 );
	local isZero? := true;
	for idx in idxs repeat
	{
	    import from Partial EXP;
	    local pCancel := cancelIfCan( repA.idx, repB.idx );
	    if failed? pCancel then
	    {
		return failed;
	    }
	    isZero? := zero? ( result.idx := retract pCancel ) and isZero?;
	}
	isZero? => [ 0 ];
	[ per result ];
    }
    
    -----------------------------------------------------------

    
    exponent( dv: DVARS ):% == {
	local result := new( nextMaxIdx, 0 );
	result.(machine class dv) := (exponent$EXP) dv;
	per result;
    }

    
    -----------------------------------------------------------

    
    exponent( dv: DVARS, n: Integer): % == {
	assert( n >= 0 );
	zero? n => 0;
	local result := new( nextMaxIdx, 0 );
	result.(machine class dv) := exponent( dv, n );
	per result;
    }

    
    -----------------------------------------------------------


    terms( a: % ): Generator( Cross( DVARS, Integer ) ) == {
	zero? a => generate {};
	local repA := rep a;
	generate {
	    
	    for idx in revIdxs repeat
	    {
		for cross in terms (repA.idx) repeat
		{
		    yield cross;
		}
	    }
	    
	}
    }

    
    -----------------------------------------------------------

    
    mainVariable( a: % ): Partial DVARS == {
	zero? a => failed;

	local repA := rep a;
	for idx in revIdxs repeat
	{
	    local pMainVariable: Partial DVARS;
	    pMainVariable := mainVariable (repA.idx);
	    if ~ failed? pMainVariable then
	    {
		return pMainVariable;
	    }
	}
	failed;
    }
    
    
    -----------------------------------------------------------

    
    gcd( a: %, b: % ): % == {
	zero? b => 0;
	zero? a => 0;
	
	local isZero? := true;
	local repA := rep a;
	local repB := rep b;
	local result := new( nextMaxIdx, 0 );
	for idx in idxs repeat
	{
	    isZero? := zero? (result.idx := gcd( repA.idx, repB.idx )) and isZero?;
	}
	isZero? => 0;
	per result;
    }

   
    -----------------------------------------------------------

    
    lcm( a: %, b: % ): % == {
	zero? a => b;
	zero? b => a;
	
	local repA := rep a;
	local repB := rep b;
	local result := new( nextMaxIdx, 0 );
	for idx in idxs repeat
	{
	    result.idx := lcm( repA.idx, repB.idx );
	}
	per result;
    }

    
    -----------------------------------------------------------

    totalDegree( a: % ): Integer == {
	zero? a => 0;

	local result: Integer := 0;
	for idx in idxs repeat
	{
	    result := add!( result, totalDegree ((rep a).idx) );
	}
	result;
    }

    -----------------------------------------------------------
    
    degree( a: %, dv: DVARS ): Integer == {
	zero? a => 0;
	degree( (rep a).(machine class dv), dv);
    }


    -----------------------------------------------------------

    
};
