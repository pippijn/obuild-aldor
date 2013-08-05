-------------------------------------------------------------------------
--
-- cs_polyi.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;

TestPolynomialImplementation(
  R: with{ 
      CommutativeRing; 
      CopyableType;
      CharacteristicZero;
  },
  VARS: VariableType,
  VARSYMS: List Symbol,
  EPR: PolynomialRing0( R, VARS );
): TestCaseType with {

#include "cs_polyi.test.signatures.as"

} == add {

    import from TestCaseTools;
    import from EPR;
    import from R;
    import from VARS;
    import from Integer;

    ------------------------------------
    
    defineAsserts( R );
    defineAsserts( VARS );
    defineAsserts( EPR );

    ------------------------------------

    assertEquals!( leftGen: Generator Cross( R, EPR ), right: List Cross( R, EPR ) ):() == {
	import from TextWriter;
	import from String;
	import from Character;
	dbgout << "entering assertEquals for Cross( R, EPR )" << newline;
	left: List Cross( R, EPR ) := [ leftGen ];
	assertEquals( # left, # right );
	--Cannot compare left and right directly, as their order need not be the same.
	--Cannot easily remove elements, as Cross does not have PrimitiveType.
	--Therefore let rightIdxs denote those indices of right, that have not yet found an equivalent in left
	import from MachineInteger;
	local rightIdxs: List MachineInteger := [ i for i in 1 .. # right ];
	for leftIdx in 1 .. # left repeat
	{
	    local leftCoeff: R;
	    local leftTerm: EPR;
	    local foundEquivalent? : Boolean := false;
	    ( leftCoeff, leftTerm ) := left . leftIdx;
	    dbgout << "looking for equivalent equivalent of ";
	    if ( R has OutputType ) and ( EPR has OutputType ) then
	    {
	      dbgout << "( " << leftCoeff << ", " << leftTerm << " )." << newline;
	    } else {
		dbgout << "element at index " << leftIdx << newline;
	    }
	    
	    for rightIdxIdx in 1 .. # rightIdxs while ~ foundEquivalent? repeat
	    {
		local rightIdx := rightIdxs . rightIdxIdx;
		local rightCoeff: R;
		local rightTerm: EPR;
		( rightCoeff, rightTerm ) := right . rightIdx;
		dbgout << "   " ;
		if ( R has OutputType ) and ( EPR has OutputType ) then
		{
		    dbgout << "( " << rightCoeff << ", " << rightTerm << " )";
		} else {
		    dbgout << "element at index " << rightIdx;
		}
		if leftCoeff = rightCoeff and leftTerm = rightTerm then
		{
		    dbgout << " does match." << newline;
		    foundEquivalent? := true;
		    rightIdxs := remove( rightIdxIdx, rightIdxs );
		} else {
		    dbgout << " does not match." << newline;
		}		    
	    }
	    if ~ foundEquivalent? then
	    {
		fail "could not find equivalent"
	    }
	}
	dbgout << "leaving assertEquals for Cross( R, EPR )" << newline;
    }
    
    ------------------------------------

    assertEquals( leftGen: Generator Cross( VARS, Integer ), right: List Cross( VARS, Integer ) ):() == {
	import from TextWriter;
	import from String;
	import from Character;
	dbgout << "entering assertEquals for Cross( VARS, Integer )" << newline;
	macro CROSS == Cross( VARS, Integer );
	left: List CROSS := sort!( 
	  [ leftGen ],  
	  ( a: CROSS, b: CROSS ): Boolean +-> { 
	      local aV: VARS;
	      local aD: Integer;
	      local bV: VARS;
	      local bD: Integer;
	      ( aV, aD ) := a;
	      ( bV, bD ) := b;
	      aV > bV; 
	  } 
	);
	assertEquals( # left, # right );
	for leftElement in left for rightElement in right repeat
	{
	    local leftVar: VARS;
	    local rightVar: VARS;
	    local leftPower: Integer;
	    local rightPower: Integer;
	    ( leftVar, leftPower ) := leftElement;
	    ( rightVar, rightPower ) := rightElement;
	    assertEquals( leftVar, rightVar );
	    assertEquals( leftPower, rightPower );
	}
	dbgout << "leaving assertEquals for Cross( VARS, Integer )" << newline;
    }
    
    ------------------------------------

    assertEquals( left: ExpressionTree, rights: List ExpressionTree ):() == {
	import from TextWriter;
	import from String;
	import from Character;
	import from MachineInteger;
	dbgout << "comparing left: " << left << "to " << (# rights) << " other expression trees. If one them is equal to the left expression tree, this is considered a success - otherwise a failure" << newline;
	local noMatchFound? := true;
	for right in rights while noMatchFound? repeat
	{
	    try {
		assertEquals( left, right );
		noMatchFound? := false;
	    } catch E in {
 		E has AldorUnitFailedExceptionType => { 
		    -- an exception occurred. So left and right are not equal
		}
	    }
	}
	if noMatchFound? then
	{
	    fail "none of the expression trees matched the left one."
	}
	dbgout << "found a matching tree. assertEquals succeded." << newline;
    }
    
    ------------------------------------

    local var1: VARS;    
    local var2: VARS;
    local var3: VARS;

    local y1: EPR;    
    local y2: EPR;
    local y3: EPR;
    
    ------------------------------------

    setUp(): () == {
	import from MachineInteger;
	import from VARS;
	assertTrue( # VARSYMS >= 3 );
	free var1 := failSafeRetract variable ( VARSYMS . 1 );
	free var2 := failSafeRetract variable ( VARSYMS . 2 );
	free var3 := failSafeRetract variable ( VARSYMS . 3 );
	assertTrue( var1 < var2 );
	assertTrue( var2 < var3 );

	free y1 := var1 :: EPR;
	free y2 := var2 :: EPR;
	free y3 := var3 :: EPR;
    }
    
    ------------------------------------

    testEquality0():() == {
	assertEquals   ( 0, 0$EPR );
	assertNotEquals( 1, 0$EPR );
	assertNotEquals( 2::EPR, 0$EPR );
	assertNotEquals( y1, 0$EPR );
	assertNotEquals( y1*y1, 0$EPR );
	assertNotEquals( y2*y3, 0$EPR );
	assertNotEquals( 1+y2*y3, 0$EPR );
	assertNotEquals( y2*y3+(5::R)*y1*y1, 0$EPR );
	assertEquals   ( 0-0, 0$EPR );
	assertEquals   ( 1-1, 0$EPR );
	assertEquals   ( (2::EPR)-(2::EPR), 0 );
    }
    
    ------------------------------------
	
    testEquality1():() == {
	assertNotEquals( 0, 1$EPR );
	assertEquals   ( 1, 1$EPR );
	assertNotEquals( 2::EPR, 1$EPR );
    }
    
    ------------------------------------
	
    testEqualityConst():() == {
	assertNotEquals( 0, 2::EPR );
	assertNotEquals( 1, 2::EPR );
	assertEquals   ( 2::EPR, 2::EPR );
	assertNotEquals( 3::EPR, 2::EPR );
    }
    
    ------------------------------------
	
    testEqualityPoly():() == {
	assertNotEquals( 0, y3*y3 );
	assertNotEquals( 0, y3*y2 );
	assertNotEquals( 0, y3*y3+y3*y2 );
	assertNotEquals( 1, y3*y3+y3*y2 );
	assertNotEquals( 2::EPR, y3*y3+y3*y2 );
	assertNotEquals( 3::EPR, y3*y3+y3*y2 );
	assertNotEquals( y3*y3, y3*y3+y3*y2 );
	assertNotEquals( y3*y3+y3*y1, y3*y3+y3*y2 );
	assertEquals   ( (0$R)*y3, 0 );
	assertEquals   ( (0$R)*y3*y3*y3, 0 );
	assertEquals   ( (0$R)*y3*y3*y3+y3*y3+y3*y2, y3*y3+y3*y2 );
	assertEquals   ( (0$EPR)*y3*y3*y3+y3*y3+y3*y2, y3*y3+y3*y2 );
	assertEquals   ( y3*y3+y3*y2, y3*y3+y3*y2 );
	assertNotEquals( y3*y3+y3*y2*y1, y3*y3+y3*y2 );
	assertEquals( ((2::EPR)*y3*y3 + y3) * ((5::EPR)*y3*y3), (10::EPR)*y3*y3*y3*y3 + (5::EPR)*y3*y3*y3 );
    }
    
    ------------------------------------
	
    testExtree():() == {
	import from MachineInteger;
	import from ExpressionTree;
	import from List ExpressionTree;
	local ETy1 := extree var1;
	local ETy2 := extree var2;
	local ETy3 := extree var3;

	assertEquals( 
	  extree( y3*y3*y3*y3+2*y3*y3*y2+y3*y1 ), 
	  [
	    ExpressionTreePlus . [
	      ExpressionTreeTimes . [ ETy1, ETy3 ],
	      ExpressionTreeTimes . [ ExpressionTreeTimes . [ extree (2::R), ETy2 ], ExpressionTreeExpt[ ETy3, extree (2@Integer) ] ],
	      ExpressionTreeExpt[ ETy3, extree (4@Integer) ]
	    ],
	    ExpressionTreePlus . [
	      ExpressionTreeExpt[ ETy3, extree (4@Integer) ],
	      ExpressionTreeTimes . [  extree (2::R), ExpressionTreeTimes . [ ExpressionTreeExpt[ ETy3, extree (2@Integer) ], ETy2 ] ],
	      ExpressionTreeTimes . [ ETy3, ETy1 ]
	    ]
	  ]
	);
    }
    
    ------------------------------------
	
    testCoerceInteger():() == {
	import from Integer;
	assertEquals( (0@Integer)::EPR, 0 );
	assertEquals( (1@Integer)::EPR, 1 );
	assertEquals( (2@Integer)::EPR, 1+1 );
	assertEquals( (3@Integer)::EPR, 1+1+1 );
    }
    
    ------------------------------------
	
    testMinus():() == {
	assertEquals   ( -0  , 0$EPR );
	assertEquals   ( -1  , (-1::R)::EPR );
	assertEquals   ( -1-1, (-2)::EPR );
	assertNotEquals( y1-y2, 0$EPR );
	assertEquals   ( y1-y1, 0$EPR );
	assertEquals   ( 7*y2*y3-3*y2*y3, 4*y2*y3 );
	assertEquals   ( y3*y3+y3*y2-y3*y2, y3*y3 );
    }
    
    ------------------------------------
	
    testPlus():() == {
	assertNotEquals( 1+1, 0$EPR );
	assertEquals   ( y1*y2+y2*y1, 2*y1*y2 );
    	assertEquals   ( y3*y3+y3*y2, y3*y2+y3*y3 );
    	assertEquals   ( y3*y3+y3*y2-y3*y2, y3*y3 );
    	assertEquals   ( y3*y3+y3*y2-y3*y3, y3*y2 );
    	assertEquals   ( y3*y3+y3*y2-y3*y3-y3*y2, 0 );
	assertEquals   ( (y3+y2)+(-y2) , y3 );
	assertEquals   ( (-y2)+(y3+y2) , y3 );
    }
    
    ------------------------------------

    testCopy():() == {
	local a := y3*y3+y3*y2;
	local b := (copy a)+y3*y3;
	local c := (copy a)-y3*y2;
	assertEquals   ( a  , y3*y3+y3*y2 );
	assertEquals   ( b  , 2*y3*y3+y3*y2 );
	assertEquals   ( c  , y3*y3 );
    }
    
    ------------------------------------
	
    testVariable?():() == {
	assertFalse( variable? 0 );
	assertFalse( variable? 1 );
	assertTrue ( variable? y2 );
	assertTrue ( variable? ( y2 + 0 ) );
	assertFalse( variable? ( y2 + 1 ) );
	assertFalse( variable? ( y2 * y2 ) );
	assertFalse( variable? ( y2 * y2 + y3 ) );
    }
    
    ------------------------------------
	
    testVariable():() == {
	assertEquals( var1, variable y1 );
	assertEquals( var2, variable y2 );
	assertEquals( var3, variable y3 );
    }
    
    ------------------------------------
	
    testVariables():() == {
	import from List VARS;
	defineAsserts( List VARS );
	assertEquals( variables 0, empty );
	assertEquals( variables 1, empty );
	assertEquals( variables (2::EPR), empty );
	assertEquals( variables (y2), [ var2 ] );
	assertEquals( variables (y3*y3*y3), [ var3 ] );
	assertEquals( variables (y3*y3*y3*y2+y3*y2), [ var3, var2 ] );
	assertEquals( variables (y3*y3*y3*y1+y3*y1*y1), [ var3, var1 ] );
	assertEquals( variables (y3*y3*y3*y1+y3*y3*y2+y3*y1*y1), [ var3, var2, var1 ] );
	assertEquals( variables (y3+y1), [ var3, var1 ] );
	assertEquals( variables (y1+y3), [ var3, var1 ] );
    }
    
    ------------------------------------
	
    testMainVariable():() == {
	assertEquals( mainVariable y1, var1 );
	assertEquals( mainVariable( y1*y2+y1*y1*y1 ), var2 );
	assertEquals( mainVariable( y1*y2*y2+y1*y1*y1 ), var2 );
    }
    
    ------------------------------------
	
    testTrailingCoefficient():() == {
	assertEquals( trailingCoefficient 0, 0 );
	assertEquals( trailingCoefficient 1, 1 );
	assertEquals( trailingCoefficient (2::R::EPR), 2::R );
	assertEquals( trailingCoefficient y1, 1 );
	assertEquals( trailingCoefficient( y3*y3*y3 ), 1 );
	assertEquals( trailingCoefficient( (2::EPR)*y3*y3*y3+(5::EPR)*y3 ), 5::R );
	assertEquals( trailingCoefficient( (2::EPR)*y3*y3*y3+(5::EPR)*y2 ), 5::R );
	assertEquals( trailingCoefficient( (2::EPR)*y3*y3*y3+(5::EPR)*y2 + y1), 1 );
    }
    
    ------------------------------------
	
    testLeadingCoefficient():() == {
	assertEquals( leadingCoefficient 0, 0$R );
	assertEquals( leadingCoefficient 1, 1$R );
	assertEquals( leadingCoefficient (2::EPR), 2::R );
	assertEquals( leadingCoefficient y1, 1$R );
	assertEquals( leadingCoefficient( y3*y3*y3 ), 1$R );
	assertEquals( leadingCoefficient( (2::EPR)*y3*y3*y3+(5::EPR)*y3 ), 2::R );
	assertEquals( leadingCoefficient( (2::EPR)*y3*y3*y3+(5::EPR)*y2*y2*y2*y2*y3 ), 2::R );
	assertEquals( leadingCoefficient( (2::EPR)*y3*y3*y3+(5::EPR)*y2 + y1), 2::R );
    }
    
    ------------------------------------
	
    testReductum():() == {
	assertEquals( reductum 0, 0 );
	assertEquals( reductum 1, 0 );
	assertEquals( reductum (2::EPR), 0 );
	assertEquals( reductum y1, 0 );
	assertEquals( reductum( y1 + (2::EPR) ), 2::EPR );
	assertEquals( reductum( y3*y3*y3 + y3*y3 + 1 ), y3*y3 +1 );
	assertEquals( reductum( (2::EPR)*y3*y3*y3 + y3 + (5::EPR)*y2 + y1), y3+(5::EPR)*y2 + y1 );
    }
    
    ------------------------------------
	
    testSupport():() == {
	import from List Cross( R, EPR );
	assertEquals!( support 0, empty );
	assertEquals!( support 1, [ ( 1$R, 1$EPR )@Cross( R, EPR ) ] );
	assertEquals!( support (5::R::EPR), [ ( 5::R, 1$EPR )@Cross( R, EPR ) ] );
	assertEquals!( support( (5::R::EPR)*y3 ), [ ( 5::R, y3 )@Cross( R, EPR ) ] );
	assertEquals!( 
	  support( (5::EPR)*y3*y3*y2+(2::EPR)*y3*y1*y1*y1+y2*y1 ), 
	  [
	    ( 1$R, y2*y1 )@Cross( R, EPR ),
	    ( 2::R, y3*y1*y1*y1 )@Cross( R, EPR ),
	    ( 5::R, y3*y3*y2 )@Cross( R, EPR )
	  ] 
	);
    }
    
    ------------------------------------
	
    testVariableProduct():() == {
	import from List Cross( VARS, Integer );
	import from Integer;
	assertEquals( variableProduct y1, [ ( var1, 1@Integer )@Cross( VARS, Integer ) ] );
	assertEquals( 
	  variableProduct( y1*y2*y3*y2 ), 
	  [ 
	    ( var3, 1@Integer )@Cross( VARS, Integer ),
	    ( var2, 2@Integer )@Cross( VARS, Integer ),
	    ( var1, 1@Integer )@Cross( VARS, Integer )
	  ] 
	);
	assertEquals( 
	  variableProduct( y1*y3 ), 
	  [ 
	    ( var3, 1@Integer )@Cross( VARS, Integer ),
	    ( var1, 1@Integer )@Cross( VARS, Integer )
	  ] 
	);
    }
    
    ------------------------------------
	
    runTimesTests( testFunc: ( EPR, R, VARS, Integer, EPR) -> () ):() == {
	import from Integer;
	testFunc( y3*y1, 0::R, var2, 1@Integer, 0 );
	testFunc( y3*y1, 5::R, var2, 0@Integer, (5::R)*y3*y1 );
	testFunc( (2::R)::EPR, 5::R, var2, 2@Integer, (10::R)*y2*y2 );
	testFunc( (2::R)*y3*y3 + y3, 5::R, var3, 2@Integer, (10::R)*y3*y3*y3*y3 + (5::R)*y3*y3*y3 );
	testFunc( (2::R)*y2*y2 + y2, 3::R, var3, 1@Integer, (6::R)*y2*y2*y3 + (3::R)*y2*y3 );
	testFunc( y3*y3 + (2::R)*y3, 4::R, var2, 2@Integer, (4::R)*y3*y3*y2*y2 + (8::R)*y3*y2*y2 );
    }

    ------------------------------------

    testTimes():() == {
	local testFunc( a: EPR, r: R, v: VARS, d: Integer, res: EPR):() == {
	    local copyA := copy a;
	    assertEquals( times( a, r, v, d ), res );
	    assertEquals( a, copyA );
	}
        runTimesTests( testFunc );
    }
    
    ------------------------------------
	
    testTimes!():() == {
	local testFunc( a: EPR, r: R, v: VARS, d: Integer, res: EPR):() == {
	    assertEquals( times!( a, r, v, d ), res );
	}
        runTimesTests( testFunc );
    }    
    
    ------------------------------------
	
    testDegree():() == {
	import from Integer;
	assertEquals( degree( (2::R)::EPR, var1 ) , 0 );
	assertEquals( degree( (3::R)::EPR, var2 ) , 0 );
	assertEquals( degree( (4::R)::EPR, var3 ) , 0 );
	assertEquals( degree( (5::R)*y2, var1 ) , 0 );
	assertEquals( degree( (6::R)*y2, var2 ) , 1 );
	assertEquals( degree( (7::R)*y2, var3 ) , 0 );
	assertEquals( degree( (8::R)*y3*y3*y3*y2*y2 + y3*y2, var1 ) , 0 );
	assertEquals( degree( (9::R)*y3*y3*y3*y2*y2 + y3*y2, var2 ) , 2 );
	assertEquals( degree( (1::R)*y3*y3*y3*y2 + y3*y2*y2, var2 ) , 2 );
	assertEquals( degree( (2::R)*y3*y3*y3*y2*y2 + y3*y2, var3 ) , 3 );
    }
        
    ------------------------------------
	
    testCoefficient():() == {
	import from Integer;
	assertEquals( coefficient( (2::R)::EPR, var1, 0 ) , (2::R)::EPR );
	assertEquals( coefficient( (2::R)::EPR, var2, 0 ) , (2::R)::EPR );
	assertEquals( coefficient( (2::R)::EPR, var3, 0 ) , (2::R)::EPR );
	assertEquals( coefficient( (2::R)::EPR, var1, 1 ) , 0 );
	assertEquals( coefficient( (2::R)::EPR, var2, 1 ) , 0 );
	assertEquals( coefficient( (2::R)::EPR, var3, 1 ) , 0 );
	assertEquals( coefficient( y2, var1, 0 ) , y2 );
	assertEquals( coefficient( y2, var2, 0 ) , 0 );
	assertEquals( coefficient( y2, var3, 0 ) , y2 );
	assertEquals( coefficient( y2, var1, 1 ) , 0 );
	assertEquals( coefficient( y2, var2, 1 ) , 1 );
	assertEquals( coefficient( y2, var3, 1 ) , 0 );
	assertEquals( coefficient( y2, var1, 2 ) , 0 );
	assertEquals( coefficient( y2, var2, 2 ) , 0 );
	assertEquals( coefficient( y2, var3, 2 ) , 0 );
	assertEquals( coefficient( y3*y2, var2, 0 ) , 0 );
	assertEquals( coefficient( y3*y2, var2, 1 ) , y3 );
	assertEquals( coefficient( y3*y2, var2, 2 ) , 0 );
	assertEquals( coefficient( (2::R)*y3*y3*y2 + (4::R)*y2*y1+y2*y2 + (3::R)*y3*y2*y2*y1 + (3::R)*y3*y2*y1, var2, 1 ) , (2::R)*y3*y3 + (4::R)*y1 + (3::R)*y3*y1 );
    }
        
    ------------------------------------
	
    testTerm():() == {
	import from Integer;
	assertEquals( term( 5::R, var2, 0@Integer ), (5::R)::EPR );
	assertEquals( term( 0, var2, 0@Integer ), 0 );
	assertEquals( term( 0, var2, 1@Integer ), 0 );
	assertEquals( term( 5::R, var2, 4@Integer ), (5::R)*y2*y2*y2*y2 );
    }
    
    ------------------------------------	

}