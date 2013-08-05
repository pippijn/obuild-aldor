-------------------------------------------------------------------------
--
-- cs_dprt.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;
import from Array Symbol;


TestDifferentialPolynomialRingType(
  DIDOM : with{ IntegralDomain; DifferentialType; },
  VARS  : FiniteVariableType,
  DSYMS : Array Symbol,
  DVARS : DifferentialVariableType( VARS ),
  DPR   : DifferentialPolynomialRingType( DIDOM, VARS, DVARS )
) : TestCaseType with {

#include "cs_dprt.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from Integer;
    import from Array Integer;
    import from MachineInteger;
    import from ExpressionTree;
    import from List ExpressionTree;
    import from DifferentialExpressionTreeOperatorTools;

    import from DIDOM;
    import from DVARS;
    import from Partial DVARS;
    import from DPR;

    assert( (#$VARS) >= 3 );
    assert( (# DSYMS) >= 2 );

    local dvar1: DVARS;
    local dvar2: DVARS;
    local dvar3: DVARS;

    local ETVar100: ExpressionTree;
    local ETVar110: ExpressionTree;
    local ETVar101: ExpressionTree;
    local ETVar120: ExpressionTree;
    local ETVar111: ExpressionTree;
    local ETVar102: ExpressionTree;
    local ETVar130: ExpressionTree;
    local ETVar200: ExpressionTree;
    local ETVar210: ExpressionTree;
    local ETVar201: ExpressionTree;
    local ETVar220: ExpressionTree;
    local ETVar211: ExpressionTree;
    local ETVar202: ExpressionTree;
    local ETVar230: ExpressionTree;
    local ETVar300: ExpressionTree;
    local ETVar310: ExpressionTree;
    local ETVar301: ExpressionTree;
    local ETVar320: ExpressionTree;
    local ETVar311: ExpressionTree;
    local ETVar302: ExpressionTree;
    local ETVar330: ExpressionTree;
    local var100 : DPR;
    local var110 : DPR;
    local var101 : DPR;
    local var120 : DPR;
    local var111 : DPR;
    local var102 : DPR;
    local var130 : DPR;
    local var200 : DPR;
    local var210 : DPR;
    local var201 : DPR;
    local var220 : DPR;
    local var211 : DPR;
    local var202 : DPR;
    local var230 : DPR;
    local var300 : DPR;
    local var310 : DPR;
    local var301 : DPR;
    local var320 : DPR;
    local var311 : DPR;
    local var302 : DPR;
    local var330 : DPR;

    local assertEquals( left: DPR, right: DPR):() throw AldorUnitFailedExceptionType == assertEquals( DPR )( left, right );

    setUp():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;

	free dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: DVARS;
	free dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: DVARS;
	free dvar3 := (minToMax$VARS).(firstIndex$(List VARS) + 2) :: DVARS;

	free ETVar100 := (ExpressionTreePrefix ( symbol (dvar1::VARS) ) ) . [ extree ( DSYMS . 0 ), extree ( DSYMS . 1 ) ];
	free ETVar200 := (ExpressionTreePrefix ( symbol (dvar2::VARS) ) ) . [ extree ( DSYMS . 0 ), extree ( DSYMS . 1 ) ];
	free ETVar300 := (ExpressionTreePrefix ( symbol (dvar3::VARS) ) ) . [ extree ( DSYMS . 0 ), extree ( DSYMS . 1 ) ];
	free ETVar110 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar100, extree DSYMS . 0 ];
	free ETVar210 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar200, extree DSYMS . 0 ];
	free ETVar310 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar300, extree DSYMS . 0 ];
	free ETVar101 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar100, extree DSYMS . 1 ];
	free ETVar201 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar200, extree DSYMS . 1 ];
	free ETVar301 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar300, extree DSYMS . 1 ];
	free ETVar120 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar110, extree DSYMS . 0 ];
	free ETVar220 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar210, extree DSYMS . 0 ];
	free ETVar320 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar310, extree DSYMS . 0 ];
	free ETVar111 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar110, extree DSYMS . 1 ];
	free ETVar211 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar210, extree DSYMS . 1 ];
	free ETVar311 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar310, extree DSYMS . 1 ];
	free ETVar102 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar101, extree DSYMS . 1 ];
	free ETVar202 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar201, extree DSYMS . 1 ];
	free ETVar302 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar301, extree DSYMS . 1 ];
	free ETVar130 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar120, extree DSYMS . 0 ];
	free ETVar230 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar220, extree DSYMS . 0 ];
	free ETVar330 := (ExpressionTreePrefix PrefixSymbolDiff) . [ ETVar320, extree DSYMS . 0 ];

	free var100 := ( dvar1 :: DPR);
	free var200 := ( dvar2 :: DPR);
	free var300 := ( dvar3 :: DPR);
	free var110 := differentiate( var100, [ 1, 0 ] );
	free var210 := differentiate( var200, [ 1, 0 ] );
	free var310 := differentiate( var300, [ 1, 0 ] );
	free var101 := differentiate( var100, [ 0, 1 ] );
	free var201 := differentiate( var200, [ 0, 1 ] );
	free var301 := differentiate( var300, [ 0, 1 ] );
	free var120 := differentiate( var110, [ 1, 0 ] );
	free var220 := differentiate( var210, [ 1, 0 ] );
	free var320 := differentiate( var310, [ 1, 0 ] );
	free var111 := differentiate( var110, [ 0, 1 ] );
	free var211 := differentiate( var210, [ 0, 1 ] );
	free var311 := differentiate( var310, [ 0, 1 ] );
	free var102 := differentiate( var101, [ 0, 1 ] );
	free var202 := differentiate( var201, [ 0, 1 ] );
	free var302 := differentiate( var301, [ 0, 1 ] );
	free var130 := differentiate( var120, [ 1, 0 ] );
	free var230 := differentiate( var220, [ 1, 0 ] );
	free var330 := differentiate( var320, [ 1, 0 ] );

	assertEquals( extree var100, ETVar100 );
	assertEquals( extree var110, ETVar110 );
	assertEquals( extree var101, ETVar101 );
	assertEquals( extree var120, ETVar120 );
	assertEquals( extree var111, ETVar111 );
	assertEquals( extree var102, ETVar102 );
	assertEquals( extree var130, ETVar130 );
	assertEquals( extree var200, ETVar200 );
	assertEquals( extree var210, ETVar210 );
	assertEquals( extree var201, ETVar201 );
	assertEquals( extree var220, ETVar220 );
	assertEquals( extree var211, ETVar211 );
	assertEquals( extree var202, ETVar202 );
	assertEquals( extree var230, ETVar230 );
	assertEquals( extree var300, ETVar300 );
	assertEquals( extree var310, ETVar310 );
	assertEquals( extree var301, ETVar301 );
	assertEquals( extree var320, ETVar320 );
	assertEquals( extree var311, ETVar311 );
	assertEquals( extree var302, ETVar302 );
	assertEquals( extree var330, ETVar330 );

    }

    ----------------------------------------------------------------------

    testDifferentiate1():() == {

        assertEquals( differentiate ( (2::DIDOM)*var100*var210+(4::DIDOM)*var301*var301*var301, (DSYMS.0) ), (2::DIDOM)*var110*var210+(2::DIDOM)*var100*var220+(12::DIDOM)*var311*var301*var301 );

    }

    ----------------------------------------------------------------------

    testDifferentiate2():() == {

        assertEquals( differentiate ( (2::DIDOM)*var100*var210+(4::DIDOM)*var301*var301*var301, (DSYMS.1) ), (2::DIDOM)*var101*var210+(2::DIDOM)*var100*var211+(12::DIDOM)*var302*var301*var301 );

    }

    ----------------------------------------------------------------------

    testDifferentiate3():() == {

        assertEquals( differentiate ( (2::DIDOM)*var100*var100, 0, 2 ), (4::DIDOM)*(var120*var100+var110*var110) );

    }

    ----------------------------------------------------------------------

    testDifferentiate4():() == {

        assertEquals( differentiate ( (2::DIDOM)*var200*var200*var200, 1, 2 ), (6::DIDOM)*var202*var200*var200+(12::DIDOM)*var201*var201*var200 );

    }

    ----------------------------------------------------------------------

    testDifferentiate5():() == {

        assertEquals( differentiate ( (2::DIDOM)*var100*var100, DSYMS.0, 2 ), (4::DIDOM)*(var120*var100+var110*var110) );

    }

    ----------------------------------------------------------------------

    testDifferentiate6():() == {

        assertEquals( differentiate ( (2::DIDOM)*var200*var200*var200, DSYMS.1, 2 ), (6::DIDOM)*var202*var200*var200+(12::DIDOM)*var201*var201*var200 );

    }

    ----------------------------------------------------------------------

    testDifferentiate7():() == {

        assertEquals( differentiate ( (2::DIDOM)*var100*var100, [ 2, 0 ] ), (4::DIDOM)*(var120*var100+var110*var110) );

    }

    ----------------------------------------------------------------------

    testDifferentiate8():() == {

        assertEquals( differentiate ( (2::DIDOM)*var200*var200*var200, [ 0, 2 ] ), (6::DIDOM)*var202*var200*var200+(12::DIDOM)*var201*var201*var200 );

    }

    ----------------------------------------------------------------------

    testDifferentiate9():() == {

	local func: DPR -> DPR := derivationFunction DSYMS.0;
        assertEquals( func func ( (2::DIDOM)*var100*var100 ), (4::DIDOM)*(var120*var100+var110*var110) );

    }

    ----------------------------------------------------------------------

    testDifferentiate10():() == {

	local func: DPR -> DPR := derivationFunction DSYMS.1;
        assertEquals( func func ( (2::DIDOM)*var200*var200*var200 ), (6::DIDOM)*var202*var200*var200+(12::DIDOM)*var201*var201*var200 );

    }

    ----------------------------------------------------------------------

    testDifferentiate11():() == {

	local func: DPR -> DPR := derivationFunction 0;
        assertEquals( func func ( (2::DIDOM)*var100*var100 ), (4::DIDOM)*(var120*var100+var110*var110) );

    }

    ----------------------------------------------------------------------

    testDifferentiate12():() == {

	local func: DPR -> DPR := derivationFunction 1;
        assertEquals( func func ( (2::DIDOM)*var200*var200*var200 ), (6::DIDOM)*var202*var200*var200+(12::DIDOM)*var201*var201*var200 );

    }

    ----------------------------------------------------------------------

    testDifferentiate13():() == {

        assertEquals( differentiate( (4::DIDOM)*var111*var111*var111*var210+var111*var300*var300+var201, differentiate( dvar1, [ 1, 1 ] ) ), (12::DIDOM)*var111*var111*var210+var300*var300);

    }

    ----------------------------------------------------------------------

    testDifferentiate14():() == {

        assertEquals( differentiate( (4::DIDOM)*var111*var111*var111*var210+var111*var300*var300+var201, differentiate( dvar3, [ 0, 1 ] ) ), 0 );

    }

    ----------------------------------------------------------------------

    testDifferentiate15():() == {

        assertEquals( differentiate( (4::DIDOM)*var111*var111*var111*var210+var111*var300*var300+var201, differentiate( dvar3, [ 0, 0 ] ) ), (2::DIDOM)*var111*var300 );

    }

    ----------------------------------------------------------------------

    testDifferentiate16():() == {

        assertEquals( differentiate( (4::DIDOM)*var111*var111*var111*var210+var111*var300*var300+var201, differentiate( dvar2 , [ 0, 1 ] ) ) , 1$DPR );

    }


    ----------------------------------------------------------------------

    testDifferentiate17():() == {

        assertEquals( differentiate( (4::DIDOM)::DPR , differentiate( dvar2 , [ 0, 1 ] ) ) , 0$DPR );

    }


    ----------------------------------------------------------------------

    testQuotientDVAR1():() == {

        local expectedQuo : DPR := 0;
        local expectedRem : DPR := 0;
	local divisor : DVARS := differentiate( dvar2, [ 2, 0 ] );
        local quo : DPR;
	quo := quotient( expectedQuo*(divisor::DPR) + expectedRem, divisor );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientDVAR2():() == {

        local expectedQuo : DPR := (3::DIDOM)*var210*var210*var210*var301+var210;
        local expectedRem : DPR := var302+(7::DIDOM)*var101*var220;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
        local quo : DPR;
	quo := quotient( expectedQuo*(divisor::DPR) + expectedRem, divisor );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientDVAR3():() == {

        local expectedQuo : DPR := var210*var210*var210*var301+var210;
        local expectedRem : DPR := 0;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
        local quo : DPR;
	quo := quotient( expectedQuo*(divisor::DPR) + expectedRem, divisor );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientDVAR4():() == {

        local expectedQuo : DPR := 0;
        local expectedRem : DPR := var200;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
        local quo : DPR;
	quo := quotient( expectedQuo*(divisor::DPR) + expectedRem, divisor );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientByDVAR1():() == {

        local expectedQuo : DPR := 0;
        local expectedRem : DPR := 0;
	local divisor : DVARS := differentiate( dvar2, [ 2, 0 ] );
        local quo : DPR;
	local divideFunc :=quotientBy( divisor );
	quo := divideFunc( expectedQuo*(divisor::DPR) + expectedRem );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientByDVAR2():() == {

        local expectedQuo : DPR := var210*var210*var210*var301+var210;
        local expectedRem : DPR := var302+var101*var220;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
        local quo : DPR;
	local divideFunc :=quotientBy( divisor );
	quo := divideFunc( expectedQuo*(divisor::DPR) + expectedRem );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientByDVAR3():() == {

        local expectedQuo : DPR := var210*var210*var210*var301+var210;
        local expectedRem : DPR := var302+var101*var220;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
        local quo : DPR;
	local divideFunc :=quotientBy( divisor );
	quo := divideFunc( expectedQuo*(divisor::DPR) + expectedRem );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientByDVAR4():() == {

        local expectedRem : DPR := var200;
        local expectedQuo : DPR := 0;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
        local quo : DPR;
	local divideFunc :=quotientBy( divisor );
	quo := divideFunc( expectedQuo*(divisor::DPR) + expectedRem );

        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testQuotientByDVARn1():() == {

        local poly : DPR := var200*var200*var200*var200*(var310+var200+var110)+var200*var200*var200+var111;
	local divisor : DVARS := differentiate( dvar2, [ 1, 0 ] );
	local n : Integer := 1;

        local quo : DPR;
	local expectedQuo : DPR;

	local divideFunc :=quotientBy( divisor, n );
	quo := divideFunc( poly );
	expectedQuo := poly;
	for i in 1 .. n repeat
	{
	    expectedQuo := quotient( expectedQuo, divisor );
	}		    
        assertEquals( quo, expectedQuo );
    }

    ----------------------------------------------------------------------

    testReciprocal1():() == {

	assertFailed( DPR, reciprocal var320);

    }

    ----------------------------------------------------------------------

    testReciprocal2():() == {

        assertEquals( failSafeRetract( DPR, reciprocal 1), 1);

    }

    ----------------------------------------------------------------------

    testReciprocal3():() == {

	local pReciprocal14: Partial DIDOM := reciprocal(14::DIDOM);
	if ~ failed? pReciprocal14 then
	{
            assertEquals( failSafeRetract( DPR, reciprocal (14::DPR)), retract pReciprocal14::DPR);
	} else {
	    import from Character;
	    dbgout << "There is no reciprocal for 14 in the ground domain. No check is made." << newline;
	}

    }

    ----------------------------------------------------------------------

    testDifferentialEvalLeaf1():() == {
	if DIDOM has Parsable then
	{
	    import from ExpressionTreeLeaf;
	    assertFailed( DPR , eval( leaf "abc" ));
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}

    }

    ----------------------------------------------------------------------

    testDifferentialEvalLeaf2():() == {
	if DIDOM has Parsable then
	{
	    import from ExpressionTreeLeaf;
	    assertEquals( failSafeRetract( DPR , eval( leaf (2@Integer) )), (2::DPR));
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}

    }

    ----------------------------------------------------------------------

    testDifferentialEval1():() == {
	if DIDOM has Parsable then
	{
	    local a: DPR := var102+(3::DPR)*var311*var110;
	    assertEquals( failSafeRetract( DPR , eval( extree( a ))), a);
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    testDifferentialEvalOpEx1():() == {
	if DIDOM has Parsable then
	{
	    import from DifferentialExpressionTreeOperatorTools;
	    import from List ExpressionTree;
	    local a: DPR := var102;
	    local b: DPR := (3::DPR)*var311*var110;
	    assertEquals( failSafeRetract( DPR , eval( ExpressionTreePlusId, [ extree( a ), extree( b ) ] )), a+b);
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    testDifferentialEvalOpEx2():() == {
	if DIDOM has Parsable then
	{
	    import from DifferentialExpressionTreeOperatorTools;
	    import from List ExpressionTree;
	    local a: DPR := var120;
	    local b: DPR := (3::DPR)*var310*var120;
	    assertEquals( failSafeRetract( DPR , eval( ExpressionTreeMinusId, [ extree( a ), extree( b ) ] )), a-b);
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    testDifferentialEvalOpEx3():() == {
	if DIDOM has Parsable then
	{
	    import from DifferentialExpressionTreeOperatorTools;
	    import from List ExpressionTree;
	    local b: DPR := (3::DPR)*var301*var102;
	    assertEquals( failSafeRetract( DPR , eval( ExpressionTreeMinusId, [ extree( b ) ] )), -b);
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    testDifferentialEvalOpEx4():() == {
	if DIDOM has Parsable then
	{
	    import from DifferentialExpressionTreeOperatorTools;
	    import from List ExpressionTree;
	    local a: DPR := (2::DPR)*var120;
	    local b: DPR := (3::DPR)*var301*var110;
	    assertEquals( failSafeRetract( DPR , eval( ExpressionTreeTimesId, [ extree( a ), extree( b ) ] )), a*b);
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    testDifferentialEvalOpEx5():() == {
	if DIDOM has Parsable then
	{
	    import from DifferentialExpressionTreeOperatorTools;
	    import from List ExpressionTree;
	    local a: DPR := (5::DPR)*var120;
	    local b: DPR := (3::DPR);
	    assertEquals( failSafeRetract( DPR , eval( ExpressionTreeQuotientId, [ extree( a ), extree( b ) ] )), a*failSafeRetract( DPR, reciprocal b));
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    testDifferentialEvalOpEx6():() == {
	if DIDOM has Parsable then
	{
	    import from DifferentialExpressionTreeOperatorTools;
	    import from List ExpressionTree;
	    local a: DPR := (5::DPR)*var102;
	    local b: DPR := (3::DPR);
	    assertEquals( failSafeRetract( DPR , eval( ExpressionTreeExptId, [ extree( a ), extree( b ) ] )), a*a*a);
	} else {
	    fail "R is not Parsable (eval functions are only implemented for Parsable R)";
	}
    }

    ----------------------------------------------------------------------

    
}
