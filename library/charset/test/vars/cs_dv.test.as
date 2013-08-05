-------------------------------------------------------------------------
--
-- cs_dv.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;
local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);	
local DSYM0 == (-"s");
local DSYM1 == (-"t");
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );
local ORDER == DifferentialVariableLexicographicEliminationOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );




TestDifferentialvariable : TestCaseType with {

#include "cs_dv.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from Integer;
    import from Array Integer;
    import from ExpressionTree;
    import from List ExpressionTree;
    import from DifferentialExpressionTreeOperatorTools;


    import from DVARS;
    import from Partial DVARS;

    local var1: DVARS;
    local var2: DVARS;
    local var3: DVARS;

    local ETVar100: ExpressionTree;
    local ETVar110: ExpressionTree;
    local ETVar101: ExpressionTree;
    local ETVar120: ExpressionTree;
    local ETVar111: ExpressionTree;
    local ETVar102: ExpressionTree;
    local ETVar200: ExpressionTree;
    local ETVar210: ExpressionTree;
    local ETVar201: ExpressionTree;
    local ETVar220: ExpressionTree;
    local ETVar211: ExpressionTree;
    local ETVar202: ExpressionTree;
    local ETVar300: ExpressionTree;
    local ETVar310: ExpressionTree;
    local ETVar301: ExpressionTree;
    local ETVar320: ExpressionTree;
    local ETVar311: ExpressionTree;
    local ETVar302: ExpressionTree;

    local ETVar312: ExpressionTree;

    assertEquals(left: DVARS, right:DVARS):() throw AldorUnitFailedExceptionType == {	
 	assertEquals( DVARS, left, right );
    }

    assertNotEquals(left: DVARS, right:DVARS):() throw AldorUnitFailedExceptionType == {	
 	assertNotEquals( DVARS, left, right );
    }

    assertFailed( pT: Partial DVARS ):() throw AldorUnitFailedExceptionType == {
	assertFailed( DVARS, pT );
    }

    failSafeRetract( pDVARS : Partial DVARS ):DVARS throw AldorUnitFailedExceptionType == {	
 	failSafeRetract( DVARS, pDVARS );
    }

    failSafeRetract( pVARS : Partial VARS ):VARS throw AldorUnitFailedExceptionType == {	
 	failSafeRetract( VARS, pVARS );
    }

    setUp():() == {		
	free var1 := variable 1;
	free var2 := variable 2;
	free var3 := variable 3;
	free ETVar100 := (ExpressionTreePrefix VAR1) . [ extree DSYM0, extree DSYM1 ];
	free ETVar110 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar100, extree DSYM0 ];
	free ETVar101 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar100, extree DSYM1 ];
	free ETVar120 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar110, extree DSYM0 ];
	free ETVar111 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar110, extree DSYM1 ];
	free ETVar102 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar101, extree DSYM1 ];
	free ETVar200 := (ExpressionTreePrefix VAR2) . [ extree DSYM0, extree DSYM1 ];
	free ETVar210 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar200, extree DSYM0 ];
	free ETVar201 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar200, extree DSYM1 ];
	free ETVar220 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar210, extree DSYM0 ];
	free ETVar211 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar210, extree DSYM1 ];
	free ETVar202 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar201, extree DSYM1 ];
	free ETVar300 := (ExpressionTreePrefix VAR3) . [ extree DSYM0, extree DSYM1 ];
	free ETVar310 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar300, extree DSYM0 ];
	free ETVar301 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar300, extree DSYM1 ];
	free ETVar320 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar310, extree DSYM0 ];
	free ETVar311 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar310, extree DSYM1 ];
	free ETVar302 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar301, extree DSYM1 ];

	free ETVar312 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar311, extree DSYM1 ];

	assertEquals( ExpressionTree, ETVar100, extree var1 );
	assertEquals( ExpressionTree, ETVar200, extree var2 );
	assertEquals( ExpressionTree, ETVar300, extree var3 );
    }

    ----------------------------------------------------------------------

    tearDown():() == {		
	assertEquals( ExpressionTree, ETVar100, extree var1 );
	assertEquals( ExpressionTree, ETVar200, extree var2 );
	assertEquals( ExpressionTree, ETVar300, extree var3 );
    }

    ----------------------------------------------------------------------

    testExtree1():() == {

	assertEquals( extree var1, ETVar100 );

    }

    ----------------------------------------------------------------------

    testExtree2():() == {

	assertNotEquals( extree var1, ETVar200 );

    }

    ----------------------------------------------------------------------

    testExtree3():() == {

	assertNotEquals( extree var1, ETVar300 );

    }

    ----------------------------------------------------------------------

    testDifferentiate1():() == {		

	assertEquals( extree differentiate( var2, DSYM0 ), ETVar210 );		

    }

    ----------------------------------------------------------------------

    testDifferentiate2():() == {

	assertEquals( extree differentiate ( differentiate( var3, DSYM0) , DSYM1, 2 ), ETVar312 );

    }

    ----------------------------------------------------------------------

--    testDifferentiate3():() == {		
--
--	assertEquals( extree differentiate( var2, 1 ), ETVar201 );
--
--    }

    ----------------------------------------------------------------------

--    testDifferentiate4():() == {		
--
--	assertEquals( extree differentiate( var2, 0 ), ETVar210 );		
--
--    }

    ----------------------------------------------------------------------

--    testDifferentiate5():() == {
--
--	assertEquals( extree differentiate ( differentiate( var3, 0) , 1, 2 ), ETVar312 );
--
--    }

    ----------------------------------------------------------------------

    testDifferentiate6():() == {

	assertEquals( extree differentiate ( var3, [ 1, 2 ] ), ETVar312 );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionSymbol1():() == {

	local func1 := derivationFunction( DSYM0 );

	assertEquals( extree func1 var3 , ETVar310 );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionSymbol2():() == {
	local func1 := derivationFunction( DSYM0 );
	local func2 := derivationFunction( DSYM1 );
	assertEquals( extree func2 func1 func2 var3 , ETVar312 );


    }

    ----------------------------------------------------------------------

    testDerivationFunctionInteger1():() == {
	local func1 := derivationFunction( 0 );
	assertEquals( extree func1 var3 , ETVar310 );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionInteger2():() == {
	local func1 := derivationFunction( 0 );
	local func2 := derivationFunction( 1 );
	assertEquals( extree func2 func1 func2 var3 , ETVar312 );


    }

    ----------------------------------------------------------------------

    testPrimitiveType1():() == {

	assertEquals( differentiate( var1, DSYM1 ), differentiate( var1, DSYM1 ) );

    }

    ----------------------------------------------------------------------

    testPrimitiveType2():() == {

	assertNotEquals( differentiate( var1, DSYM1) , var1 );

    }

    ----------------------------------------------------------------------

    testPrimitiveType3():() == {

	assertNotEquals( differentiate( var1, DSYM1) , differentiate( var1, DSYM0) );

    }

    ----------------------------------------------------------------------

    testPrimitiveType4():() == {

	assertNotEquals( differentiate( var1, DSYM0 ), differentiate( var2, DSYM0 ) );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType1():() == {

	assertTrue( var1 < var2 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType2():() == {

	assertTrue( var2 < var3 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType3():() == {

	assertTrue( var1 < differentiate( var1, DSYM0 ) );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType4():() == {

	assertTrue( var1 < differentiate( var1, DSYM1 ) );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType5():() == {

	assertTrue( var2 < differentiate( var2, DSYM0 ) );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType6():() == {

	assertTrue( var2 < differentiate( var2, DSYM1 ) );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType7():() == {

	assertTrue( var3 < differentiate( var3, DSYM0 ) );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType8():() == {

	assertTrue( var3 < differentiate( var3, DSYM1 ) );

    }

    ----------------------------------------------------------------------

    testSerializableType():() == {

	import from PrimitiveMemoryBlock;
	import from MachineInteger;

	local res:DVARS;

	PMB:PrimitiveMemoryBlock := new (60@MachineInteger);
	(PMB::BinaryWriter)  << differentiate(var2, [ 5, 4 ] );
	res := << (PMB::BinaryReader);    

	assertEquals( res, differentiate(var2, [ 5, 4 ] ) );

    }

    ----------------------------------------------------------------------

    testLifting1():() == {

	assertFailed( variable (-"y4") );

    }

    ----------------------------------------------------------------------

    testLifting2():() == {

	import from Symbol;
	import from String;
	import from StringBuffer;

 	local sb : StringBuffer := new();
	( sb :: TextWriter ) << VAR3<<"("<<DSYM0<<","<<DSYM1<<")";

	assertEquals( failSafeRetract variable ( - string sb ), var3 );

    }

    ----------------------------------------------------------------------

    testvariableByNumber1():() == {

	assertEquals( variable 1, var1 );

    }

    ----------------------------------------------------------------------

    testvariableByNumber2():() == {
	assertException( variable 0, RuntimeException );

    }

    ----------------------------------------------------------------------

    testvariableByNumber3():() == {

	assertException( variable 4, RuntimeException );

    }

    ----------------------------------------------------------------------

    testSymbol1():() == {

	import from Symbol;
	import from String;
	import from StringBuffer;

 	local sb : StringBuffer := new();
	( sb :: TextWriter ) << VAR3<<"("<<DSYM0<<","<<DSYM1<<")";

	assertEquals( Symbol, symbol var3 , (- string sb ) );

    }

    ----------------------------------------------------------------------

    testSymbol2():() == {

	import from Symbol;
	import from String;
	import from StringBuffer;

 	local sb : StringBuffer := new();
	( sb :: TextWriter ) << "diff("<<VAR2<<"("<<DSYM0<<","<<DSYM1<<"),"<<DSYM0<<")";

	assertEquals( Symbol, symbol differentiate( var2, [ 1, 0 ]) , (- string sb ) );

    }

    ----------------------------------------------------------------------

    testSymbol3():() == {
	import from Symbol;
	import from String;
	import from StringBuffer;

 	local sb : StringBuffer := new();
	( sb :: TextWriter ) << "diff("<<"diff("<<"diff("<<VAR1<<"("<<DSYM0<<","<<DSYM1<<"),"<<DSYM0<<"),"<<DSYM1<<"),"<<DSYM1<<")";

	assertEquals( Symbol, symbol differentiate( var1, [ 1, 2 ]) , (- string sb ) );

    }

    ----------------------------------------------------------------------

    testCoerceFromvariable1():() == {

	assertEquals( ( failSafeRetract ( (variable$VARS) VAR1 ) ) :: DVARS, var1 );

    }

    ----------------------------------------------------------------------

    testCoerceFromvariable2():() == {

	assertEquals( ( failSafeRetract ( (variable$VARS) VAR3 ) ) :: DVARS, var3 );

    }

    ----------------------------------------------------------------------

    testClass1():() == {

	assertEquals( class var3, 3 );

    }

    ----------------------------------------------------------------------

    testClass2():() == {

	assertEquals( class differentiate( var3, [ 4, 5 ] ), 3 );

    }

    ----------------------------------------------------------------------

    testOrder2():() == {

	assertEquals( Array Integer, order( differentiate( var3, [ 4, 5 ] ) ), [ 4, 5 ] );

    }

    ----------------------------------------------------------------------

    testEval1():() == {

	assertEquals( failSafeRetract eval ETVar312, differentiate( var3, [ 1, 2 ] ) );

    }

    ----------------------------------------------------------------------

    testEval2():() == {

	assertEquals( failSafeRetract( eval ETVar100), var1 );

    }

    ----------------------------------------------------------------------

    testEval3():() == {

	assertFailed eval ( (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar310, extree (-"y") ] );

    }

    ----------------------------------------------------------------------

    testEval4():() == {

	assertFailed eval ( (ExpressionTreePrefix VAR1) . [ extree DSYM0, extree (-"y") ] );

    }

    ----------------------------------------------------------------------

    testEval5():() == {

	assertFailed eval ( (ExpressionTreePrefix VAR1) . [ extree (-"y"), extree DSYM1 ] );

    }

    ----------------------------------------------------------------------

    testEval6():() == {

	assertFailed eval ( (ExpressionTreePrefix VAR1) . [ extree DSYM1, extree DSYM0 ] );

    }

    ----------------------------------------------------------------------

    testEval7():() == {

	assertFailed eval ( (ExpressionTreePrefix (-"y0")) . [ extree DSYM0, extree DSYM1 ] );

    }

    ----------------------------------------------------------------------

    testEval8():() == {

	assertFailed eval ( (ExpressionTreePrefix VAR1 ) . [ extree DSYM0, extree DSYM1, extree ( -"z" ) ] );

    }

    ----------------------------------------------------------------------

    testEval9():() == {
	import from Symbol;
	import from ExpressionTreeLeaf;
	assertFailed eval ( (ExpressionTreePrefix VAR1 ) . [ extree DSYM0, extree name DSYM1 ] );

    }

    ----------------------------------------------------------------------

    testEval10():() == {
	local ALGDVARS == DifferentialVariable( VARS, empty$(Array Symbol), ORDER );

	import from ALGDVARS;
	assertEquals( ALGDVARS, failSafeRetract( ALGDVARS, (eval$ALGDVARS) ( extree VAR1 ) ), variable 1 );

    }

    ----------------------------------------------------------------------

    testEval11():() == {

	assertFailed eval ( extree VAR1 );

    }

    ----------------------------------------------------------------------

    testvariableClassOrder():() == {

	assertEquals( variable( 3, [ 2, 4 ] ), differentiate( var3, [ 2, 4 ] ) );

    }

    ----------------------------------------------------------------------

    testCoerceToVariable():() == {
	assertEquals( VARS,  differentiate( var1 , [ 2, 3 ] )::VARS , 
	  failSafeRetract( VARS, ( (variable$VARS) VAR1 ) ) 
	);

    }

    ----------------------------------------------------------------------

    testDerivationsSymbolsCount():() == {
	import from Array Symbol;
	import from Integer;
	assertEquals( Integer, derivationSymbolsCount, coerce # DSYMS );
    }

    ----------------------------------------------------------------------

    testDerivationsSymbols1():() == {
	import from Array Symbol;
	assertEquals( Array Symbol, derivationSymbols(), DSYMS );
    }

    ----------------------------------------------------------------------

    testDerivationsSymbols2():() == {
	import from Array Symbol;
	local origDSyms := copy DSYMS;
	local receivedDSyms := derivationSymbols();
	assertEquals( Array Symbol, receivedDSyms, origDSyms );
	receivedDSyms.(1$MachineInteger) := (-"z");
	assertEquals( Array Symbol, DSYMS, origDSyms );
    }

    ----------------------------------------------------------------------

    testProperDerivative1():() == {
	assertFalse properDerivative?( var1, var3 ); 
    }

    ----------------------------------------------------------------------

    testProperDerivative2():() == {
	assertFalse properDerivative?( var1, var1 ); 
    }

    ----------------------------------------------------------------------

    testProperDerivative3():() == {
	assertTrue properDerivative?( differentiate( var1, [ 1, 0 ] ), var1 ); 
    }

    ----------------------------------------------------------------------

    testProperDerivative4():() == {
	assertTrue properDerivative?( differentiate( var2, [ 0, 1 ] ), var2 ); 
    }

    ----------------------------------------------------------------------

    testProperDerivative5():() == {
	assertTrue properDerivative?( differentiate( var3, [ 3, 4 ] ), var3 ); 
    }

    ----------------------------------------------------------------------

    testProperDerivative6():() == {
	assertFalse properDerivative?( differentiate( var3, [ 3, 4 ] ), differentiate( var3, [ 4, 3 ] ) ); 
    }
    
    ----------------------------------------------------------------------

    testDifferentiateN1():() == {
	import from Integer;
	assertEquals( variable( 3, [ 2, 0 ] ), differentiate( var3, 0, 2 ) );
    }

    ----------------------------------------------------------------------

    testDifferentiateN2():() == {
	import from Integer;
	assertEquals( variable( 3, [ 0, 4 ] ), differentiate( var3, 1, 4 ) );
    }

    ----------------------------------------------------------------------

}
