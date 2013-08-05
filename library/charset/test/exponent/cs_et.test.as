-------------------------------------------------------------------------
--
-- cs_et.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"


import from String;
import from Symbol;
import from List Symbol;

TestExponentType(
  VARS  : FiniteVariableType, 
  DSYMS : Array Symbol,
  DVARS : DifferentialVariableType VARS,
  EXP   : ExponentCategory DVARS
):  with {

#include "cs_et.test.signatures.as"

} == add {

    import from TestCaseTools;
    import from Integer;
    import from MachineInteger;
    import from ExpressionTree;
    import from List ExpressionTree;
    import from DifferentialExpressionTreeOperatorTools;
    import from DVARS;
    import from List DVARS;
    import from EXP;
    import from Partial EXP;

    assert( (#$VARS) >= 3 );
    assert( (# DSYMS) >= 2 ); 

    local var100 : DVARS;
    local var110 : DVARS;
    local var101 : DVARS;
    local var120 : DVARS;
    local var111 : DVARS;
    local var102 : DVARS;
    local var130 : DVARS;
    local var200 : DVARS;
    local var210 : DVARS;
    local var201 : DVARS;
    local var220 : DVARS;
    local var211 : DVARS;
    local var202 : DVARS;
    local var230 : DVARS;
    local var300 : DVARS;
    local var310 : DVARS;
    local var301 : DVARS;
    local var320 : DVARS;
    local var311 : DVARS;
    local var302 : DVARS;
    local var330 : DVARS;

    local expVar100 : EXP;
    local expVar110 : EXP;
    local expVar101 : EXP;
    local expVar120 : EXP;
    local expVar111 : EXP;
    local expVar102 : EXP;
    local expVar130 : EXP;
    local expVar200 : EXP;
    local expVar210 : EXP;
    local expVar201 : EXP;
    local expVar220 : EXP;
    local expVar211 : EXP;
    local expVar202 : EXP;
    local expVar230 : EXP;
    local expVar300 : EXP;
    local expVar310 : EXP;
    local expVar301 : EXP;
    local expVar320 : EXP;
    local expVar311 : EXP;
    local expVar302 : EXP;
    local expVar330 : EXP;

    local assertEquals( left: EXP, right: EXP):() throw AldorUnitFailedExceptionType == assertEquals( EXP )( left, right );
    local assertNotEquals( left: EXP, right: EXP):() throw AldorUnitFailedExceptionType == assertNotEquals( EXP )( left, right );

    local assertEquals( left: List Cross( DVARS, Integer ), right: List Cross( DVARS, Integer ) ):() throw AldorUnitFailedExceptionType == {
	import from String;
	import from Character;
	import from MachineInteger;
	dbgout << "assertEquals ";
	# left ~= # right => {dbgout << "failed ("<<(# left)<<" vs. "<<(#right) <<" elements)"; fail "assertEquals does not hold";}
	dbgout << "is trying to assert equality on the elements" << newline;
	for leftElement in left for rightElement in right repeat {
	    (leftDv,  leftCount)  := leftElement;
	    (rightDv, rightCount) := rightElement;

	    dbgout << "checking (left: (" << leftDv << ", " << leftCount << ") right: (" << rightDv << ", " << rightCount << ")) ";
	    if leftDv ~= rightDv or leftCount ~= rightCount then 
	    {
		dbgout << "failed !";
		fail "assertEqual does not hold"
	    } else {
		dbgout << "succeeded" << newline;
	    }
	}
	dbgout << "succeeded" << newline;
    };

    ----------------------------------------------------------------------

    setUp():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;
	import from Character;

	-- class 1
    	free var100 := (minToMax$VARS).(firstIndex$(List VARS)     ) :: DVARS;
	free var110 := differentiate( var100, [ 1, 0 ] );
	free var101 := differentiate( var100, [ 0, 1 ] );
	free var120 := differentiate( var100, [ 2, 0 ] );
	free var111 := differentiate( var100, [ 1, 1 ] );
	free var102 := differentiate( var100, [ 0, 2 ] );
	free var130 := differentiate( var100, [ 3, 0 ] );
	free expVar100 := exponent( var100 );
	free expVar110 := exponent( var110 );
	free expVar101 := exponent( var101 );
	free expVar120 := exponent( var120 );
	free expVar111 := exponent( var111 );
	free expVar102 := exponent( var102 );
	free expVar130 := exponent( var130 );

	-- class 2
    	free var200 := (minToMax$VARS).(firstIndex$(List VARS) + 1 ) :: DVARS;
	free var210 := differentiate( var200, [ 1, 0 ] );
	free var201 := differentiate( var200, [ 0, 1 ] );
	free var220 := differentiate( var200, [ 2, 0 ] );
	free var211 := differentiate( var200, [ 1, 1 ] );
	free var202 := differentiate( var200, [ 0, 2 ] );
	free var230 := differentiate( var200, [ 3, 0 ] );
	free expVar200 := exponent( var200 );
	free expVar210 := exponent( var210 );
	free expVar201 := exponent( var201 );
	free expVar220 := exponent( var220 );
	free expVar211 := exponent( var211 );
	free expVar202 := exponent( var202 );
	free expVar230 := exponent( var230 );

	-- class 3
    	free var300 := (minToMax$VARS).(firstIndex$(List VARS) + 2 ) :: DVARS;
	free var310 := differentiate( var300, [ 1, 0 ] );
	free var301 := differentiate( var300, [ 0, 1 ] );
	free var320 := differentiate( var300, [ 2, 0 ] );
	free var311 := differentiate( var300, [ 1, 1 ] );
	free var302 := differentiate( var300, [ 0, 2 ] );
	free var330 := differentiate( var300, [ 3, 0 ] );
	free expVar300 := exponent( var300 );
	free expVar310 := exponent( var310 );
	free expVar301 := exponent( var301 );
	free expVar320 := exponent( var320 );
	free expVar311 := exponent( var311 );
	free expVar302 := exponent( var302 );
	free expVar330 := exponent( var330 );
	assertEquals( ExpressionTree, extree expVar100, extree var100 );
	assertEquals( ExpressionTree, extree expVar110, extree var110 );
	assertEquals( ExpressionTree, extree expVar101, extree var101 );
	assertEquals( ExpressionTree, extree expVar120, extree var120 );
	assertEquals( ExpressionTree, extree expVar111, extree var111 );
	assertEquals( ExpressionTree, extree expVar102, extree var102 );
	assertEquals( ExpressionTree, extree expVar130, extree var130 );
	assertEquals( ExpressionTree, extree expVar200, extree var200 );
	assertEquals( ExpressionTree, extree expVar210, extree var210 );
	assertEquals( ExpressionTree, extree expVar201, extree var201 );
	assertEquals( ExpressionTree, extree expVar220, extree var220 );
	assertEquals( ExpressionTree, extree expVar211, extree var211 );
	assertEquals( ExpressionTree, extree expVar202, extree var202 );
	assertEquals( ExpressionTree, extree expVar230, extree var230 );
	assertEquals( ExpressionTree, extree expVar300, extree var300 );
	assertEquals( ExpressionTree, extree expVar310, extree var310 );
	assertEquals( ExpressionTree, extree expVar301, extree var301 );
	assertEquals( ExpressionTree, extree expVar320, extree var320 );
	assertEquals( ExpressionTree, extree expVar311, extree var311 );
	assertEquals( ExpressionTree, extree expVar302, extree var302 );
	assertEquals( ExpressionTree, extree expVar330, extree var330 );

    }

    ----------------------------------------------------------------------

    
    tearDown():() == {
	assertEquals( ExpressionTree, extree expVar100, extree var100 );
	assertEquals( ExpressionTree, extree expVar110, extree var110 );
	assertEquals( ExpressionTree, extree expVar101, extree var101 );
	assertEquals( ExpressionTree, extree expVar120, extree var120 );
	assertEquals( ExpressionTree, extree expVar111, extree var111 );
	assertEquals( ExpressionTree, extree expVar102, extree var102 );
	assertEquals( ExpressionTree, extree expVar130, extree var130 );
	assertEquals( ExpressionTree, extree expVar200, extree var200 );
	assertEquals( ExpressionTree, extree expVar210, extree var210 );
	assertEquals( ExpressionTree, extree expVar201, extree var201 );
	assertEquals( ExpressionTree, extree expVar220, extree var220 );
	assertEquals( ExpressionTree, extree expVar211, extree var211 );
	assertEquals( ExpressionTree, extree expVar202, extree var202 );
	assertEquals( ExpressionTree, extree expVar230, extree var230 );
	assertEquals( ExpressionTree, extree expVar300, extree var300 );
	assertEquals( ExpressionTree, extree expVar310, extree var310 );
	assertEquals( ExpressionTree, extree expVar301, extree var301 );
	assertEquals( ExpressionTree, extree expVar320, extree var320 );
	assertEquals( ExpressionTree, extree expVar311, extree var311 );
	assertEquals( ExpressionTree, extree expVar302, extree var302 );
	assertEquals( ExpressionTree, extree expVar330, extree var330 );

    }

    
    ----------------------------------------------------------------------


    testZeroVariables():() == {
	assertEquals( List DVARS, variables 0, [] );
    }

    ----------------------------------------------------------------------

    testZero?1():() == {
        assertTrue zero? (0$EXP);
    }

    ----------------------------------------------------------------------

    testZero?2():() == {
        assertFalse zero? expVar310;
    }

    ----------------------------------------------------------------------

    testPlus1():() == {
        assertEquals( expVar301+expVar211+expVar110, expVar110+expVar211+expVar301);
    }

    ----------------------------------------------------------------------

    testPlus2():() == {
        assertNotEquals( expVar300+expVar110, expVar110+expVar301);
    }

    ----------------------------------------------------------------------

    testPlus3Variables():() == {
        assertEquals( List DVARS, variables( expVar301+expVar110 ), [ var301, var110 ] );
    }

    ----------------------------------------------------------------------

    testPlus4Extree():() == {
        assertEquals( extree( expVar301+expVar110+expVar110 ), ExpressionTreeTimes . [ extree var301, ExpressionTreeExpt . [ extree var110, extree (2@Integer) ]  ] );
    }

    ----------------------------------------------------------------------

    testPlus5():() == {
        assertEquals( extree( (expVar301+expVar310)+(expVar110+expVar211+expVar110) ), ExpressionTreeTimes . [ extree var301, extree var310, extree var211, ExpressionTreeExpt . [ extree var110, extree (2@Integer) ]  ] );
    }

    ----------------------------------------------------------------------

    testVariables1():() == {
        assertEquals( List DVARS, variables( expVar111 ), [ var111 ] );
    }

    ----------------------------------------------------------------------

    testVariables2():() == {
        assertEquals( List DVARS, variables( expVar111+expVar111 ), [ var111 ] );
    }

    ----------------------------------------------------------------------

    testVariables3():() == {
        assertEquals( List DVARS, variables( expVar110+expVar110+expVar120 ), [ var120, var110 ] );
    }

    ----------------------------------------------------------------------

    testVariables4():() == {
        assertEquals( List DVARS, variables( expVar100+expVar110+expVar110+expVar120 ), [ var120, var110, var100 ] );
    }

    ----------------------------------------------------------------------

    testVariables5():() == {
        assertEquals( List DVARS, variables( expVar100+expVar110+expVar110 ), [ var110, var100 ] );
    }

    ----------------------------------------------------------------------

    testVariables6():() == {
        assertEquals( List DVARS, variables( expVar111+expVar101+expVar310+expVar111 ), [ var310, var111, var101 ] );
    }

    ----------------------------------------------------------------------

    testLess1():() == {
        assertTrue( expVar310 + expVar220 < expVar310 + expVar310 );	
    }

    ----------------------------------------------------------------------

    testLess2():() == {
        assertFalse( expVar311 < expVar100 );	
    }

    ----------------------------------------------------------------------

    testLess3():() == {
        assertTrue( expVar310 < expVar310 + expVar100 );	
    }

    ----------------------------------------------------------------------

    testCancel?1():() == {
        assertTrue cancel?( expVar100+expVar220+expVar301, 0)
    }

    ----------------------------------------------------------------------

    testCancel?2():() == {
        assertTrue cancel?( expVar100+expVar211+expVar220+expVar310, expVar211+expVar310)
    }

    ----------------------------------------------------------------------

    testCancel?3():() == {
        assertFalse cancel?( expVar100+expVar211+expVar300, expVar211+expVar302)
    }

    ----------------------------------------------------------------------

    testCancel?4():() == {
        assertFalse cancel?( expVar301+expVar220, expVar100+expVar220)
    }

    ----------------------------------------------------------------------

    testCancel1():() == {
	assertEquals( cancel( expVar100+expVar211+expVar310+expVar302, 0 ), expVar100+expVar211+expVar310+expVar302 );
    }

    ----------------------------------------------------------------------

    testCancel2():() == {
	assertEquals( cancel( expVar100+expVar211+expVar310+expVar302, expVar100+expVar211+expVar310+expVar302 ), 0 );
    }

    ----------------------------------------------------------------------

    testCancel3():() == {
	assertEquals( cancel( expVar100+expVar211+expVar310+expVar302, expVar211+expVar310 ), expVar100+expVar302 );
    }

    ----------------------------------------------------------------------

    testCancel4():() == {
	assertEquals( cancel( expVar100+expVar211+expVar310+expVar302, expVar211+expVar100 ), expVar310+expVar302 );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?1():() == {
        local cancelled := failSafeRetract( EXP, cancelIfCan( expVar100+expVar211+expVar310+expVar302, 0 ) );
	assertEquals( cancelled, expVar100+expVar211+expVar310+expVar302 );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?2():() == {
        local cancelled := failSafeRetract( EXP, cancelIfCan( expVar202+expVar310, expVar202+expVar310 ) );
	assertEquals( cancelled, 0 );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?3():() == {
        local cancelled := failSafeRetract( EXP, cancelIfCan( expVar100+expVar211+expVar310+expVar302, expVar211+expVar310) );
	assertEquals( cancelled, expVar100+expVar302 );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?4():() == {
        assertFailed( EXP, cancelIfCan( expVar100+expVar201+expVar310, expVar220+expVar310 ) );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?5():() == {
        assertFailed( EXP, cancelIfCan( expVar220+expVar310, expVar100+expVar220+expVar310 ) );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?6():() == {
        assertFailed( EXP, cancelIfCan( expVar300+expVar310, expVar301+expVar310 ) );
    }

    ----------------------------------------------------------------------

    testCancelIfCan?7():() == {
        local cancelled := failSafeRetract( EXP, cancelIfCan( expVar100+expVar211+expVar301+expVar320, expVar100+expVar320 ) );
	assertEquals( cancelled, expVar301+expVar211 );
    }

    ----------------------------------------------------------------------

    testDegree1():() == {
	assertEquals( degree( expVar100+expVar102+expVar201+expVar201, var100 ) , 1 )
    }

    ----------------------------------------------------------------------

    testDegree2():() == {
	assertEquals( degree( expVar100+expVar302+expVar302+expVar320+expVar211+expVar302, var302 ), 3 )
    }

    ----------------------------------------------------------------------

    testExponentN1():() == {
	assertException( exponent( var100, -1 ), RuntimeException );
    }

    ----------------------------------------------------------------------

    testExponentN2():() == {
	assertEquals( exponent( var100, 0 ), 0 );
    }

    ----------------------------------------------------------------------

    testExponentN3():() == {
	assertEquals( exponent( var201, 3 ), expVar201+expVar201+expVar201 );
    }

    ----------------------------------------------------------------------

    testTerms1():() == {
	import from List Cross( DVARS, Integer );
	assertEquals( [ terms 0 ], [] );
    }

    ----------------------------------------------------------------------

    testTerms2():() == {
	macro CR == Cross( DVARS, Integer );
	import from CR;
	import from List CR;
	CrossSorter: ( CR, CR ) -> Boolean == ( left: CR, right: CR ) : Boolean +-> {
	    ( leftDv, leftPower ) := left;
	    ( rightDv, rightPower ) := right;
	    leftDv < rightDv or ( leftDv = rightDv and leftPower < rightPower );
	}		
	local a := expVar210+expVar101+expVar202+expVar101;
	assertEquals( sort!( [ terms( a ) ], CrossSorter), [ ( var101, 2 ), ( var210,1 ), ( var202,1 ) ] );
	assertEquals( a, expVar210+expVar101+expVar202+expVar101);
    }

    ----------------------------------------------------------------------

    testMainVariable1():() == {
	assertFailed( DVARS, mainVariable 0 );
    }

    ----------------------------------------------------------------------

    testMainVariable2():() == {
	local a := expVar101+expVar201+expVar311+expVar201;
	assertEquals( DVARS, failSafeRetract( DVARS, mainVariable( a )), var311 );
    }

    ----------------------------------------------------------------------

    testGCD1():() == {
	assertEquals( gcd( 0, 0 ), 0$EXP );
    }

    ----------------------------------------------------------------------

    testGCD2():() == {
	assertEquals( gcd( expVar100+expVar201, 0 ), 0 );
    }

    ----------------------------------------------------------------------

    testGCD3():() == {
	assertEquals( gcd( 0, expVar220+expVar101 ), 0 );
    }

    ----------------------------------------------------------------------

    testGCD4():() == {
	assertEquals( gcd( expVar100+expVar200+expVar310+expVar302+expVar200+expVar200, expVar200+expVar200+expVar200+expVar302+expVar302+expVar120+expVar110 ), expVar200+expVar200+expVar200+expVar302 );
    }

    ----------------------------------------------------------------------

    testGCD5():() == {
	assertEquals( gcd( expVar310+expVar202+expVar210+expVar100 , expVar202+expVar110+expVar100  ), expVar202+expVar100 );
    }

    ----------------------------------------------------------------------

    testGCD6():() == {
	assertEquals( gcd( expVar202+expVar110+expVar120, expVar311+expVar202+expVar210+expVar120 ), expVar202+expVar120 );
    }

    ----------------------------------------------------------------------

    testLCM1():() == {
	assertEquals( lcm( expVar110+expVar202, 0 ), expVar110+expVar202 );
    }

    ----------------------------------------------------------------------

    testLCM2():() == {
	assertEquals( lcm( expVar102+expVar210+expVar310+expVar320+expVar210+expVar210, expVar210+expVar210+expVar210+expVar320+expVar320+expVar120+expVar111 ), expVar102+expVar210+expVar210+expVar210+expVar310+expVar320+expVar120+expVar111+expVar320 );
    }

    ----------------------------------------------------------------------

    testLCM3():() == {
	assertEquals( lcm( expVar302+expVar210+expVar100, expVar302+expVar210 ), expVar302+expVar210+expVar100 );
    }

    ----------------------------------------------------------------------

    testLCM4():() == {
	assertEquals( lcm( expVar302+expVar210, expVar302+expVar210+expVar100 ), expVar302+expVar210+expVar100 );
    }

    ----------------------------------------------------------------------

    testLCM5():() == {
	assertEquals( lcm( expVar302+expVar100, expVar210+expVar100 ), expVar302+expVar210+expVar100 );
    }

    ----------------------------------------------------------------------

    testLCM6():() == {
	assertEquals( lcm( expVar210+expVar100, expVar302+expVar100 ), expVar302+expVar210+expVar100 );
    }

    ----------------------------------------------------------------------

    testSyzygy1():() == {
	(a, b) := syzygy( expVar100+expVar210, 0 );
	assertEquals( a, 0);
	assertEquals( b, expVar100+expVar210 );
    }

    ----------------------------------------------------------------------

    testSyzygexpVar2():() == {
        (a, b) := syzygy( expVar101+expVar210+expVar301+expVar311+expVar210+expVar202, expVar202+expVar210+expVar210+expVar311+expVar311+expVar120+expVar110 );
	assertEquals( a, expVar120+expVar110+expVar311 );
	assertEquals( b, expVar101+expVar301 );
    }

    ----------------------------------------------------------------------

    testExponentList1():() == {
	import from List DVARS;
	import from List Integer;
	assertException( exponent( [ var100 ], [] ), RuntimeException );
    }

    ----------------------------------------------------------------------

    testExponentList2():() == {
	import from List DVARS;
	import from List Integer;
	assertException( exponent( [ var100 ], [-1] ), RuntimeException );
    }

    ----------------------------------------------------------------------

    testExponentList3():() == {
	import from List DVARS;
	import from List Integer;
	assertEquals( exponent( [ var101,var200,var320 ], [1,0,2] ), expVar101+expVar320+expVar320 );
    }

    ----------------------------------------------------------------------

    testExponentGenerator1():() == {
	import from List DVARS;
	import from List Integer;
	assertException( exponent( generate { yield (var100,-2); } ) , RuntimeException );
    }

    ----------------------------------------------------------------------

    testExponentGenerator2():() == {
	import from List DVARS;
	import from List Integer;
	assertEquals( exponent( (generate { })@(Generator Cross(DVARS,Integer)) ) , 0 );
    }

    ----------------------------------------------------------------------

    testExponentGenerator3():() == {
	import from List DVARS;
	import from List Integer;
	assertEquals( exponent( generate { yield (var111,1); yield (var200,2); yield (var111,1);} ) , expVar111+expVar111+expVar200+expVar200 );
    }

    ----------------------------------------------------------------------

    testTotalDegree1():() == {
	assertEquals( totalDegree 0, 0 );
    }

    ----------------------------------------------------------------------

    testTotalDegree2():() == {
	assertEquals( totalDegree (expVar101+expVar120+expVar120+expVar211+expVar211+expVar302), 6 );
    }

    ----------------------------------------------------------------------

    testTotalDegreeList1():() == {
	import from List DVARS;
	assertEquals( totalDegree (expVar101+expVar120+expVar120+expVar211+expVar211+expVar302, []), 0 );
    }

    ----------------------------------------------------------------------

    testTotalDegreeList2():() == {
	import from List DVARS;
	assertEquals( totalDegree (expVar101+expVar120+expVar120+expVar211+expVar211+expVar302, [var101, var211]), 3 );
    }

    ----------------------------------------------------------------------

    testTotalDegreeList3():() == {
	import from List DVARS;
	assertEquals( totalDegree (expVar101+expVar120+expVar120+expVar211+expVar211+expVar302, [ var120 ]), 2 );
    }

    ----------------------------------------------------------------------

    if EXP has CopyableType then
    {
	testCopy1():() == {
	    local exp := expVar200+expVar202;
	    local exp2 := exp+expVar100+expVar201+expVar202+expVar300;	    
	    assertEquals( extree exp, ExpressionTreeTimes . [ extree var202, extree var200 ] );
	    assertEquals( extree exp2, ExpressionTreeTimes . [ extree var300, ExpressionTreeExpt . [ extree var202, extree (2@Integer) ], extree var201, extree var200, extree var100 ] );
	}
    }

    ----------------------------------------------------------------------

    testTimes1():() == {
	assertEquals( times( 0, expVar120 + expVar311 ), 0 );
    }

    ----------------------------------------------------------------------

    testTimes2():() == {
	assertEquals( times( 1, expVar120 + expVar311 ), expVar120 + expVar311 );
    }

    ----------------------------------------------------------------------

    testTimes3():() == {
	assertEquals( times( 2, expVar120 + expVar311 ), expVar120 + expVar311 + expVar120 + expVar311 );
    }

    ----------------------------------------------------------------------

    testTimes4():() == {
	assertEquals( times( 3, expVar120 + expVar311 ), expVar120 + expVar311 + expVar120 + expVar311 + expVar120 + expVar311 );
    }

    ----------------------------------------------------------------------

    if EXP has CopyableType then
    {
	testAdd!1():() == {
            assertEquals( add!( copy expVar100, expVar200 + expVar300 ), expVar100 + expVar200 + expVar300 );
	}
    }

    ----------------------------------------------------------------------


}
