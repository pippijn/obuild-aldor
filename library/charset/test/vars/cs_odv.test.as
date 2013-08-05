-------------------------------------------------------------------------
--
-- cs_odv.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;

local VARS == OrderedVariableList(reverse! [-"y1",-"y2",-"y3"]);	
local DSYM == -"u";
local ORDER == DifferentialVariableLexicographicEliminationOrderTools;
local DVARS == OrdinaryDifferentialVariable( VARS, DSYM );


TestOrdinaryDifferentialVariable : TestCaseType with {

#include "cs_odv.test.signatures.as"

    assertEquals: ( DVARS, DVARS ) -> () throw AldorUnitFailedExceptionType;
    assertNotEquals: ( DVARS, DVARS ) -> () throw AldorUnitFailedExceptionType;
    failSafeRetract: ( Partial DVARS ) -> DVARS throw AldorUnitFailedExceptionType;
    failSafeRetract: ( Partial VARS ) -> VARS throw AldorUnitFailedExceptionType;
    assertFailed: ( Partial DVARS ) -> () throw AldorUnitFailedExceptionType;

} == add {

    import from TestCaseTools;

    import from Integer;
    import from ExpressionTree;
    import from List ExpressionTree;
    import from DifferentialExpressionTreeOperatorTools;


    import from DVARS;
    import from Partial DVARS;

    local y1: DVARS;
    local y2: DVARS;
    local y3: DVARS;

    local ETy10: ExpressionTree;
    local ETy11: ExpressionTree;
    local ETy12: ExpressionTree;
    local ETy20: ExpressionTree;
    local ETy21: ExpressionTree;
    local ETy22: ExpressionTree;
    local ETy30: ExpressionTree;
    local ETy31: ExpressionTree;
    local ETy32: ExpressionTree;

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
	free y1 := variable 1;
	free y2 := variable 2;
	free y3 := variable 3;
	free ETy10 := (ExpressionTreePrefix (-"y1")) . [ extree DSYM ];
	free ETy20 := (ExpressionTreePrefix (-"y2")) . [ extree DSYM ];
	free ETy30 := (ExpressionTreePrefix (-"y3")) . [ extree DSYM ];
	free ETy11 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy10, extree DSYM ];
	free ETy21 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy20, extree DSYM ];
	free ETy31 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy30, extree DSYM ];
	free ETy12 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy11, extree DSYM ];
	free ETy22 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy21, extree DSYM ];
	free ETy32 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy31, extree DSYM ];

	assertEquals( ExpressionTree, ETy10, extree y1 );
	assertEquals( ExpressionTree, ETy20, extree y2 );
	assertEquals( ExpressionTree, ETy30, extree y3 );
    }

    ----------------------------------------------------------------------

    tearDown():() == {		
	assertEquals( ExpressionTree, ETy10, extree y1 );
	assertEquals( ExpressionTree, ETy20, extree y2 );
	assertEquals( ExpressionTree, ETy30, extree y3 );
    }

    ----------------------------------------------------------------------

    testEqual1():() == {

	assertTrue( y1 = y1 );

    }

    ----------------------------------------------------------------------

    testEqual2():() == {

	assertTrue( y2 = y2 );

    }

    ----------------------------------------------------------------------

    testEqual3():() == {

	assertTrue( differentiate y1 = differentiate y1 );

    }

    ----------------------------------------------------------------------

    testEqual4():() == {

	assertTrue( differentiate y2 = differentiate y2 );

    }

    ----------------------------------------------------------------------

    testEqual5():() == {

	assertFalse( y1 = differentiate y1 );

    }

    ----------------------------------------------------------------------

    testEqual6():() == {

	assertFalse( y2 = differentiate y2 );

    }

    ----------------------------------------------------------------------

    testEqual7():() == {

	assertFalse( differentiate y1 = differentiate y2 );

    }

    ----------------------------------------------------------------------

    testEqual8():() == {

	assertFalse( y1 = differentiate y1 );

    }

    ----------------------------------------------------------------------

    testEqual9():() == {

	assertFalse( y1 = differentiate y1 );

    }

    ----------------------------------------------------------------------

    testExtree():() == {

	assertEquals( extree y1, ETy10 );

    }

    ----------------------------------------------------------------------

    testDifferentiate1():() == {		

	assertEquals( extree differentiate y2, ETy21 );		

    }

    ----------------------------------------------------------------------

    testDifferentiate2():() == {

	assertEquals( extree differentiate( y3, 2 ), ETy32 );

    }

    ----------------------------------------------------------------------

    testPrimitiveType1():() == {

	assertEquals( differentiate y1, differentiate y1 );

    }

    ----------------------------------------------------------------------

    testPrimitiveType2():() == {

	assertNotEquals( differentiate y1, y1 );

    }

    ----------------------------------------------------------------------

    testPrimitiveType3():() == {

	assertNotEquals( differentiate y1, differentiate y2 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType1():() == {

	assertTrue( y1 < differentiate y1 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType2():() == {

	assertFalse( y1 <  y1 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType3():() == {
	assertTrue( y1 <  differentiate y1 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType4():() == {

	assertTrue( y1 < y2 );

    }

    ----------------------------------------------------------------------

    testTotallyOrderedType5():() == {

	assertFalse( y2 <  y1 );

    }

    ----------------------------------------------------------------------

    testSerializableType():() == {

	import from PrimitiveMemoryBlock;
	import from MachineInteger;

	local res:DVARS;

	PMB:PrimitiveMemoryBlock := new (60@MachineInteger);
	(PMB::BinaryWriter)  << differentiate(y2,5);
	res := << (PMB::BinaryReader);    

	assertEquals( res, differentiate(y2,5) );

    }

    ----------------------------------------------------------------------

    testLifting1():() == {

	assertFailed( variable (-"y4") );

    }

    ----------------------------------------------------------------------

    testLifting2():() == {

	assertFailed( variable (-"y2") );

    }

    ----------------------------------------------------------------------

    testLifting3():() == {

	assertFailed( variable (-"y2(t)") );

    }

    ----------------------------------------------------------------------

    testLifting4():() == {

	assertEquals( failSafeRetract variable (-"y3(u)"), y3 );

    }

    ----------------------------------------------------------------------

    testLifting5():() == {


	assertEquals( failSafeRetract variable (-"diff(y3(u),u)"), differentiate y3 );

    }

    ----------------------------------------------------------------------

    testLifting6():() == {


	assertEquals( failSafeRetract variable (-"diff(diff(y3(u),u),u)"), differentiate( y3, 2 ) );

    }

    ----------------------------------------------------------------------

    testLifting7():() == {


	assertFailed variable (-"diff(y3(u),t)");

    }

    ----------------------------------------------------------------------

    testLifting8():() == {


	assertEquals( variable 3, y3 );

    }

    ----------------------------------------------------------------------

    testVariableByNumber1():() == {

	assertEquals( variable 1, y1 );

    }

    ----------------------------------------------------------------------

    testVariableByNumber2():() == {
	assertException( variable 0, RuntimeException );

    }

    ----------------------------------------------------------------------

    testVariableByNumber3():() == {

	assertException( variable 4, RuntimeException );

    }

    ----------------------------------------------------------------------

    testSymbol1():() == {

	assertEquals( Symbol, symbol y3, -"y3(u)" );

    }

    ----------------------------------------------------------------------

    testSymbol2():() == {

	assertEquals( Symbol, symbol differentiate y3, -"diff(y3(u),u)" );

    }

    ----------------------------------------------------------------------

    testSymbol3():() == {

	assertEquals( Symbol, symbol differentiate( y3, 2) , -"diff(diff(y3(u),u),u)" );

    }

    ----------------------------------------------------------------------

    testCoerceFromVariable1():() == {

	assertEquals( ( failSafeRetract ( (variable$VARS) (-"y1") ) ) :: DVARS, y1 );

    }

    ----------------------------------------------------------------------

    testCoerceFromVariable2():() == {

	assertEquals( ( failSafeRetract ( (variable$VARS) (-"y3") ) ) :: DVARS, y3 );

    }

    ----------------------------------------------------------------------

    testClass1():() == {

	assertEquals( class y1, 1 );

    }

    ----------------------------------------------------------------------

    testClass2():() == {

	assertEquals( class y3, 3 );

    }

    ----------------------------------------------------------------------

    testOrder1():() == {

	assertEquals( order y3, 0 );

    }

    ----------------------------------------------------------------------

    testOrder2():() == {

	assertEquals( order( differentiate y3 ), 1 );

    }

    ----------------------------------------------------------------------

    testOrder3():() == {

	assertEquals( order( differentiate( y3, 37 ) ), 37 );

    }

    ----------------------------------------------------------------------

    testOrder4():() == {
	import from Array Integer;

	assertEquals( Array Integer, order y3, [ 0 ] );

    }

    ----------------------------------------------------------------------

    testOrder5():() == {
	import from Array Integer;

	assertEquals( Array Integer, order( differentiate y3 ), [ 1 ] );

    }

    ----------------------------------------------------------------------

    testOrder6():() == {
	import from Array Integer;

	assertEquals( Array Integer, order( differentiate( y3, 37 ) ), [ 37 ] );

    }

    ----------------------------------------------------------------------

    testDerivationSymbolsCount():() == {

	assertEquals( 1, derivationSymbolsCount );

    }

    ----------------------------------------------------------------------

    testDerivationSymbols():() == {
	import from Array Symbol;

	assertEquals( Array Symbol, derivationSymbols(), [ DSYM ] );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionSymbol1():() == {
	local dFunc := derivationFunction DSYM;

	assertEquals( extree dFunc y3, ETy31 );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionSymbol2():() == {
	local dFunc := derivationFunction DSYM;

	assertEquals( extree dFunc dFunc y1, ETy12 );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionInteger1():() == {
	local dFunc := derivationFunction 0;

	assertEquals( extree dFunc y3, ETy31 );

    }

    ----------------------------------------------------------------------

    testDerivationFunctionInteger2():() == {
	local dFunc := derivationFunction 0;

	assertEquals( extree dFunc dFunc y1, ETy12 );

    }

    ----------------------------------------------------------------------

    testDifferentiateArrayInteger1():() == {
	import from Array Integer;

	assertEquals( extree differentiate( y3, [ 1 ] ), ETy31 );

    }

    ----------------------------------------------------------------------

    testDifferentiateArrayInteger2():() == {
	import from Array Integer;

	assertEquals( extree differentiate( y1, [ 2 ] ), ETy12 );

    }

    ----------------------------------------------------------------------

    testDifferentiateInteger1():() == {

	assertEquals( extree differentiate( y3, 1 ), ETy31 );

    }

    ----------------------------------------------------------------------

    testDifferentiateInteger2():() == {

	assertEquals( extree differentiate( y1, 2 ), ETy12 );

    }

    ----------------------------------------------------------------------

    testEvalET1():() == {

	assertEquals( failSafeRetract eval ETy32, differentiate( y3, 2 ) );

    }

    ----------------------------------------------------------------------

    testEvalET2():() == {			
	assertEquals( failSafeRetract( eval ETy10), y1 );

    }

    ----------------------------------------------------------------------

    testEvalET3():() == {

	assertFailed eval ( (ExpressionTreePrefix PrefixSymbolDiff) . [ ETy31, extree (-"y") ] );


    }

    ----------------------------------------------------------------------

    testEvalET4():() == {

	assertFailed eval ( (ExpressionTreePrefix (-"y1")) . [ extree (-"y") ] );

    }

    ----------------------------------------------------------------------

    testEvalET5():() == {

	assertFailed eval ( (ExpressionTreePrefix (-"y0")) . [ extree DSYM ] );

    }

    ----------------------------------------------------------------------

    testEvalETL1():() == {
	import from ExpressionTreeLeaf;
	assertFailed eval leaf 2;

    }

    ----------------------------------------------------------------------

    testExtree1():() == {

	assertEquals( ExpressionTree, extree differentiate( y3, 2 ), ETy32 );

    }

    ----------------------------------------------------------------------

    testExtree2():() == {

	assertEquals( ExpressionTree, extree differentiate( y1, 1 ), ETy11 );

    }

    ----------------------------------------------------------------------

    testEvalMIET1():() == {

	assertFailed eval ( uniqueId$ExpressionTreePlus, [ extree 2, extree 1 ] );

    }

    ----------------------------------------------------------------------

    testVariableClassOrder1():() == {

	assertEquals( variable( 3, 2 ), differentiate( y3, 2 ) );

    }

    ----------------------------------------------------------------------

    testVariableClassOrder2():() == {

	assertEquals( variable( 1, 1 ), differentiate( y1, 1 ) );

    }

    ----------------------------------------------------------------------

    testVariableVarOrder1():() == {
	import from MachineInteger;

	assertEquals( variable( coerce variable 3, 2 ), differentiate( y3, 2 ) );

    }

    ----------------------------------------------------------------------

    testVariableVarOrder2():() == {
	import from MachineInteger;

	assertEquals( variable( coerce variable 1, 1 ), differentiate( y1, 1 ) );

    }

    ----------------------------------------------------------------------

    testCoerceToVariable():() == {

	assertEquals( VARS,  differentiate(y1,2)::VARS , failSafeRetract( VARS, ( (variable$VARS) (-"y1") ) ) );

    }

    ----------------------------------------------------------------------

}
