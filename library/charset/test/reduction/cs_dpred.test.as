-------------------------------------------------------------------------
--
-- cs_dpred.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;


macro RT    == DifferentialPolynomialReductionTools( DFLD, VARS, DVARS, DPR );
macro AS    == AutoreducedSet( DPR, RT );


TestDifferentialPolynomialReductionTools(
  DFLD  : with{ Field; DifferentialType; CharacteristicZero; },
  VARS  : FiniteVariableType,
  DSYMS : Array Symbol,
  DVARS : DifferentialVariableType( VARS ),
  DPR   : DifferentialPolynomialRingType( DFLD, VARS, DVARS )
 ) : TestCaseType with {

#include "cs_dpred.test.signatures.as"

} == TestTriangularizationReductionTools( DPR, RT ) add {

    import from TestCaseTools;

    import from Integer;
    import from Array Integer;
--    import from ExpressionTree;
--    import from List ExpressionTree;
--    import from DifferentialExpressionTreeOperatorTools;
    import from TestTriangularizationReductionTools( DPR, RT );


    import from DFLD;
    import from DVARS;
    import from Partial DVARS;
    import from DPR;
    import from Set DPR;
    import from List DPR;
    import from RT;
    import from AS;

    local dvar1: DVARS;
    local dvar2: DVARS;
    local dvar3: DVARS;

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

    ----------------------------------------------------------------------

    defineAsserts DPR;
    defineAsserts AS;
    
    ----------------------------------------------------------------------

    setUp():() == {
	import from MachineInteger;
	import from VARS;
	import from List VARS;
	import from Array Integer;

	free dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: DVARS;
	free dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: DVARS;
	free dvar3 := (minToMax$VARS).(firstIndex$(List VARS) + 2) :: DVARS;

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

    }

    
    ----------------------------------------------------------------------
    
    
    testReduced?WrtZero():() == {
    	reduced?Tester( 0, 0, true );
	reduced?Tester( 1, 0, true );
	reduced?Tester( var111, 0, true );
	reduced?Tester( var200 + (2::DPR)*var320, 0, true );
	reduced?Tester( var200 + (2::DPR)*var311*var311, 0, true );
    }

    ----------------------------------------------------------------------
    
    testReduced?WrtConstant1():() == {
	local const : DPR := 1;
    	reduced?Tester( 0, const, true );
	reduced?Tester( 1, const, false );
	reduced?Tester( var111, const, false );
	reduced?Tester( var200 + (2::DPR)*var320, const, false );
	reduced?Tester( var200 + (2::DPR)*var311*var311, const, false );
    }

    ----------------------------------------------------------------------
    
    testReduced?WrtConstant2():() == {
	local const : DPR :=  5 :: DPR;
    	reduced?Tester( 0, const, true );
	reduced?Tester( 1, const, false );
	reduced?Tester( var111, const, false );
	reduced?Tester( var200 + (2::DPR)*var320, const, false );
	reduced?Tester( var200 + (2::DPR)*var311*var311, const, false );
    }

    ----------------------------------------------------------------------
    
    
    testReduced?WrtPoly1():() == {
	import from Integer;
	local poly: DPR := (2::DPR)*var210*var200+var100;
	reduced?Tester( 0, poly, true );
	reduced?Tester( 1, poly, true );
	reduced?Tester( var100, poly, true );
	reduced?Tester( var120, poly, true );
	reduced?Tester( var200, poly, true );
	reduced?Tester( var210, poly, false );
	reduced?Tester( var220, poly, false );
	reduced?Tester( var201, poly, true );
	reduced?Tester( var300, poly, true );	
	reduced?Tester( var320, poly, true );	
	reduced?Tester( (3::DPR)*var300*var220+(5::DPR)*var200, poly, false );
    }

    
    ----------------------------------------------------------------------    

    
    testReduced?WrtPoly2():() == {
	import from Integer;
	local poly: DPR := (2::DPR)*var210*var210*var200+var100;
	reduced?Tester( 0, poly, true );
	reduced?Tester( 1, poly, true );
	reduced?Tester( var100, poly, true );
	reduced?Tester( var100, poly, true );
	reduced?Tester( var200, poly, true );
	reduced?Tester( var210, poly, true );
	reduced?Tester( var210*var201, poly, true );
	reduced?Tester( var210*var210, poly, false );
	reduced?Tester( var201, poly, true );
	reduced?Tester( var300, poly, true );	
	reduced?Tester( var320, poly, true );	
	reduced?Tester( (3::DPR)*var300*var220+(5::DPR)*var200, poly, false );
	reduced?Tester( (3::DPR)*var300*var210*var210+(5::DPR)*var200, poly, false );
	reduced?Tester( (3::DPR)*var300*var210+(5::DPR)*var200, poly, true );
    }
    
    
    ----------------------------------------------------------------------    
    
    testReduced?WrtEmptyAS():() == {
	reduced?TesterAS( 0, empty, true );
	reduced?TesterAS( 1, empty, true );
	reduced?TesterAS( var120, empty, true );
    }      
     
    ----------------------------------------------------------------------    

    testReduced?WrtAS1():() == {
	import from Integer;
	local as: AS := failSafeRetract [ (2::DPR)*var310*var310+(3::DPR)*var110 ];
	reduced?TesterAS( 0, as, true );
	reduced?TesterAS( 1, as, true );
	reduced?TesterAS( var100, as, true );
	reduced?TesterAS( var310*var310, as, false );
	reduced?TesterAS( var220, as, true );
	reduced?TesterAS( var310*var310*var200+var211, as, false );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtASn():() == {
	import from Integer;
	local as: AS := failSafeRetract [ var220, (2::DPR)*var310*var310+(3::DPR)*var110 ];
	reduced?TesterAS( 0, as, true );
	reduced?TesterAS( 1, as, true );
	reduced?TesterAS( var210, as, true );
	reduced?TesterAS( var220, as, false );
	reduced?TesterAS( var202, as, true );
	reduced?TesterAS( (3::DPR)*var310+var100, as, true );
	reduced?TesterAS( (3::DPR)*var310*var310+var100, as, false );
	reduced?TesterAS( (3::DPR)*var310*var220+var100, as, false );
    }
     
    ----------------------------------------------------------------------    
          
    testReduceWrtZero():() == {
	reduceTester( 0, 0, 0, empty );
	reduceTester( 1, 0, 1, empty );
	reduceTester( 5::DPR, 0, 5::DPR, empty );
	reduceTester( var100, 0, var100, empty );
	reduceTester( (3::DPR)*var200, 0, (3::DPR)*var200, empty );
	reduceTester( (3::DPR)*var300*var210+var100, 0, (3::DPR)*var300*var210+var100, empty );
    }
      
    
    ----------------------------------------------------------------------    

    testReduceWrtConst1():() == {
	local const := 1$DPR;
	reduceTester( 0, const, 0, empty );
	reduceTester( 1, const, 0, [ -1 ] );
	reduceTester( 6::DPR, const, 0, [ -6::DPR ] );
	reduceTester( var100, const, 0, [ -var100 ] );
	reduceTester( (3::DPR)*var200, const, 0, [ -(3::DPR)*var200 ] );
	reduceTester( (3::DPR)*var300*var210+var100, const, 0, [ -(3::DPR)*var300*var210-var100 ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtConst2():() == {
	local const := 5::DFLD::DPR;
	reduceTester( 0, const, 0, empty );
	reduceTester( 1, const, 0, [ -(1::DFLD/5::DFLD)::DPR ] );
	reduceTester( 6::DPR, const, 0, [ -(6::DFLD/5::DFLD)::DPR ] );
	reduceTester( var100, const, 0, [ -(1::DFLD/5::DFLD)*var100 ] );
	reduceTester( (3::DPR)*var200, const, 0, [ -(3::DFLD/5::DFLD)*var200 ] );
	reduceTester( (3::DPR)*var300*var210+var100, const, 0, [ -(3::DFLD/5::DFLD)*var300*var210-(1::DFLD/5::DFLD)*var100 ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtPoly1():() == {
	local poly := 2::DFLD*var210+var100;
	reduceTester( 0, poly, 0, empty );
	reduceTester( 2::DPR, poly, 2::DPR, empty );
	reduceTester( 5::DPR, poly, 5::DPR, empty );
	reduceTester( var100, poly, var100, empty );
	reduceTester( (4::DPR)*var200, poly, (4::DPR)*var200, empty );
	reduceTester( (6::DPR)*var200*var200+var100, poly, (6::DPR)*var200*var200+var100, empty );
	reduceTester( (4::DPR)*var210+(2::DPR)*var100, poly, 0, [ (-4::DPR), (2::DPR) ] );
	reduceTester( (4::DPR)*var210, poly, -(4::DPR)*var100, [ (-4::DPR), (2::DPR) ] );
	reduceTester( (4::DPR)*var210*var320+(3::DPR)*var210*var100+var200, poly, -4*var320*var100+2*var200-3*var100*var100, [ -4*var320-3*var100, 2::DPR ] );
    }

    ----------------------------------------------------------------------    
	
    testReduceWrtPoly2():() == {
	local poly := 2::DFLD*var210+var200;
	reduceTester( (4::DPR)*var220*var320+(3::DPR)*var210*var100+var200, poly, 4*var200+4*var320*var200-6*var200*var100, [ -4*var320,4*var320-6*var100, 2::DPR ] );
    }
    
    ----------------------------------------------------------------------    

    testReduceWrtEmptyList():() == {
	reduceTesterList( 0, empty, 0, empty );
	reduceTesterList( 2::DPR, empty, 2::DPR, empty );
	reduceTesterList( var100, empty, var100, empty );

    }
    
    ----------------------------------------------------------------------    

    testReduceWrtList1():() == {
	reduceTesterList( 
	  (4::DPR)*var220*var320+(3::DPR)*var210*var100+var200, 
	  [ 2::DFLD*var210+var200 ], 
	  4*var200+4*var320*var200-6*var200*var100, 
	  [ -4*var320,4*var320-6*var100, 2::DPR ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtListn():() == {
	reduceTesterList( (4::DPR)*var220*var320+(3::DPR)*var210*var100+var200, 
	  [ 2::DFLD*var210+var200, 2*var220*var320+var110 ], 
	  -16*var200*var110 -12*var200*var200*var100 +8*var200*var200,
	  [ -4*var320, 4*var320-6*var100, 2::DPR, 2*var220, -4*var200, 12*var200*var100 - 8*var200, -12*var200*var100+ 8*var200 , -4*var200, 2*var220 ] );
    }

    
    ----------------------------------------------------------------------    

    testReduceWrtEmptyAS():() == {
	reduceTesterAS( 0, empty, 0, empty );
	reduceTesterAS( 2::DPR, empty, 2::DPR, empty );
	reduceTesterAS( var100, empty, var100, empty );

    }
    
    ----------------------------------------------------------------------    

    testReduceWrtAS1():() == {
	reduceTesterAS( 
	  (4::DPR)*var220*var320+(3::DPR)*var210*var100+var200, 
	  failSafeRetract [ 2::DFLD*var210+var200 ], 
	  4*var200+4*var320*var200-6*var200*var100, 
	  [ -4*var320,4*var320-6*var100, 2::DPR ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtASn():() == {
	reduceTesterAS( (4::DPR)*var320+var110+var300,
	  failSafeRetract [ 2::DFLD*var310*var200, var100 ], 
	  4*var300*var200*var200,
	  [ -4::DPR*var200*var200, 1, 8*var210, -4::DPR, 2*var200 ] );

    }

    
        
    ----------------------------------------------------------------------    
    
    testDeltaPolynomial1():() == {
	deltaTTester( var100, var200, 0$DPR, empty );
    }

    ----------------------------------------------------------------------

    testDeltaPolynomial2():() == {

	local a := (5::DPR)*var101*var320*var320*var320+(2::DPR)*var320;
	local b := (7::DPR)*var200*differentiate(var302,-"s")*differentiate(var302,-"s") + (11::DPR)*var301;
	local delta : DPR := (separant b) * differentiate( a, [ 0, 2 ] ) - (separant a) * differentiate( b, [ 1, 0 ] );
	deltaTTester( a, b, delta, [ -15*var320*var320*var101 -2::DPR, 14*differentiate(var302,-"s")*var200 ] );
    }

    ----------------------------------------------------------------------    

    
}
