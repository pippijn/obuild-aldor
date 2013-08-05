-------------------------------------------------------------------------
--
-- cs_pred.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

TestPolynomialReductionTools(
  FLD : Field,
  VARS: VariableType,
  PR  : PolynomialRing0( FLD, VARS ),
  RT  : TriangularizationReductionType PR,
  VARP: Array PR -- some variables as polynomials
) : TestCaseType with {

#include "cs_trred.test.signatures.as"
#include "cs_pred.test.signatures.as"

} == TestTriangularizationReductionTools( PR, RT ) add {
    
    import from MachineInteger;
    import from Array PR;
    -- W < X < Y < Z;
    local W == VARP.0;
    local X == VARP.1;
    local Y == VARP.2;
    local Z == VARP.3;

    local AS == AutoreducedSet( PR, RT );


    import from TestCaseTools;
    import from TestTriangularizationReductionTools( PR, RT );
    import from PR;
    import from RT;
    import from Set PR;
    
    ----------------------------------------------------------------------    

    defineAsserts( AS );
    defineAsserts( PR );

    ----------------------------------------------------------------------    
    
    testReduced?WrtZero1():() == {
	reduced?Tester( 0, 0, true );
	reduced?Tester( 1, 0, true );
	reduced?Tester( X, 0, true );
	reduced?Tester( Y + (1+1)*Z, 0, true );
	reduced?Tester( Y + (1+1)*Z*Z, 0, true );
    }

      
    ----------------------------------------------------------------------    

    testReduced?WrtConstant1():() == {
	local const: PR := 1;
	reduced?Tester( 0, const, true );
	reduced?Tester( 1, const, false );
	reduced?Tester( X, const, false );
	reduced?Tester( Y + (1+1)*Z, const, false );
	reduced?Tester( Y + (1+1)*Z*Z, const, false );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtConstant2():() == {
	import from Integer;
	local const: PR := 5::PR;
	reduced?Tester( 0, const, true );
	reduced?Tester( 1, const, false );
	reduced?Tester( X, const, false );
	reduced?Tester( Y + (2 :: PR)*Z, const, false );
	reduced?Tester( Y + (4::PR)*Z*Z, const, false );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtPoly1():() == {
	import from Integer;
	local poly: PR := (2::PR)*Y*Y+(3::PR)*X;
	reduced?Tester( 0, poly, true );
	reduced?Tester( 1, poly, true );
	reduced?Tester( Y, poly, true );
	reduced?Tester( Y*Y, poly, false );	
	reduced?Tester( (2::PR)*Y*Y*X+Y*W, poly, false );
	reduced?Tester( (2::PR)*Y*Y*X*Y+Y*X, poly, false );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtPoly2():() == {
	import from Integer;
	local poly: PR := (2::PR)*X*X+(3::PR)*Z;
	reduced?Tester( 0, poly, true );
	reduced?Tester( 1, poly, true );
	reduced?Tester( W, poly, true );
	reduced?Tester( X, poly, true );
	reduced?Tester( Y, poly, true );
	reduced?Tester( Z, poly, false );
	reduced?Tester( X*X, poly, true );	
	reduced?Tester( (2::PR)*W*Z, poly, false );
	reduced?Tester( (2::PR)*Z*Z, poly, false );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtEmptyAS():() == {
	import from AS;
	reduced?TesterAS( 0, empty, true );
	reduced?TesterAS( 1, empty, true );
	reduced?TesterAS( W, empty, true );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtAS1():() == {
	import from Integer;
	local as: AS := failSafeRetract [ (2::PR)*X*X+(3::PR)*Y ];
	reduced?TesterAS( 0, as, true );
	reduced?TesterAS( 1, as, true );
	reduced?TesterAS( X, as, true );
	reduced?TesterAS( Y*Y, as, false );
	reduced?TesterAS( Z, as, true );
	reduced?TesterAS( Y*Y*Z+Z, as, false );
    }
      
    ----------------------------------------------------------------------    

    testReduced?WrtASn():() == {
	import from Integer;
	local as: AS := failSafeRetract [ W, (2::PR)*Z*Z+(3::PR)*X, Y ];
	reduced?TesterAS( 0, as, true );
	reduced?TesterAS( 1, as, true );
	reduced?TesterAS( X, as, true );
	reduced?TesterAS( Z*Z, as, false );
	reduced?TesterAS( Z+Y, as, false );
	reduced?TesterAS( Z+W, as, false );
	reduced?TesterAS( Z+X, as, true );
    }
      
    ----------------------------------------------------------------------    

    testReduceWrtZero():() == {
	import from Integer;
	reduceTester( 0, 0, 0, empty );
	reduceTester( 1, 0, 1, empty );
	reduceTester( 5::PR, 0, 5::PR, empty );
	reduceTester( Y, 0, Y, empty );
	reduceTester( (3::PR)*Y, 0, (3::PR)*Y, empty );
	reduceTester( (3::PR)*Y*X+W, 0, (3::PR)*Y*X+W, empty );
	reduceTester( (3::PR)*Y*Y+W, 0, (3::PR)*Y*Y+W, empty );
	reduceTester( (3::PR)*Y*Y*Z+X, 0, (3::PR)*Y*Y*Z+X, empty );
	reduceTester( (3::PR)*Y*Y*Z*X+X, 0, (3::PR)*Y*Y*Z*X+X, empty );
    }
      
    ----------------------------------------------------------------------    

    testReduceWrtConst():() == {
	import from Integer;
	local const := (1::PR);
	reduceTester( 0, const, 0, empty );
	reduceTester( 1, const, 0, [ -1 ] );
	reduceTester( 6::PR, const, 0, [ -6::PR ] );
	reduceTester( Y, const, 0, [ -Y ] );
	reduceTester( (3::PR)*Y, const, 0, [ -(3::PR)*Y ] );
	reduceTester( (3::PR)*Y*X+W, const, 0, [ -(3::PR)*Y*X-W ] );
	reduceTester( (3::PR)*Y*Y+W, const, 0, [ -(3::PR)*Y*Y-W ] );
	reduceTester( (3::PR)*Y*Y*Z+X, const, 0, [ -(3::PR)*Y*Y*Z-X ] );
	reduceTester( (3::PR)*Y*Y*Z*X+X, const, 0, [ -(3::PR)*Y*Y*Z*X-X ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtPoly():() == {
	import from FLD;
	import from Integer;
	local poly := 2::FLD*Y*Y+W;
	reduceTester( 0, poly, 0, empty );
	reduceTester( 2::PR, poly, 2::PR, empty );
	reduceTester( 5::PR, poly, 5::PR, empty );
	reduceTester( Y, poly, Y, empty );
	reduceTester( (4::PR)*Y, poly, (4::PR)*Y, empty );
	reduceTester( (6::PR)*Y*X+W, poly, (6::PR)*Y*X+W, empty );
	reduceTester( (4::PR)*Y*Y+W, poly, (-1::FLD)*W, [ (-2::PR) ] );
	reduceTester( (3::PR)*Y*Y*Z+X, poly, ((-3::FLD/2::FLD))*Z*W+X, [ (-(3::FLD/2::FLD))*Z ] );
	reduceTester( (3::PR)*Y*Y*Z*X+X, poly, ((-3::FLD/2::FLD))*Z*X*W+X, [ (-(3::FLD/2::FLD))*Z*X ] );
	reduceTester( X^4@Integer+W, X+W, W^4@Integer+W, [ -X^3@Integer, W*X^2@Integer, -W^2@Integer*X, W^3@Integer ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtList():() == {
	import from FLD;
	import from Integer;
	import from List PR;
	reduceTesterList( 0, empty, 0, empty );
	reduceTesterList( 2::PR, empty, 2::PR, empty );
	reduceTesterList( Y, empty, Y, empty );
	reduceTesterList( (3::PR)*Y*Y*Z+X, [ 2::PR ], 0, [ (-(3::FLD/2::FLD))*Y*Y*Z+(-(1::FLD/2::FLD))*X ] );
	reduceTesterList( Y^4@Integer+X+5::PR, [ Y+X, X ], 5::PR, [ -Y^3@Integer, Y^2@Integer*X, -Y*X^2@Integer, -X^3@Integer, X^3@Integer, -1 ] );
	reduceTesterList( 2::PR*X*Y*Y+5::PR, [ Z*X, W*W*W, Y*X, X*X*X ], 5::PR, [ -2::PR*Y ] );
    }

    ----------------------------------------------------------------------    

    testReduceWrtAS():() == {
	import from FLD;
	import from Integer;
	import from AS;
	reduceTesterAS( 0, empty, 0, empty );
	reduceTesterAS( 2::PR, empty, 2::PR, empty );
	reduceTesterAS( Y, empty, Y, empty );
	reduceTesterAS( (3::PR)*Y*Y*Z+X, failSafeRetract [ 2::PR ], 0, [ (-(3::FLD/2::FLD))*Y*Y*Z+(-(1::FLD/2::FLD))*X ] );
	reduceTesterAS( (4::PR)*Z*Y*X+Y^4@Integer+X+5::PR, failSafeRetract [ (2::PR)*Z*X, Y+X ], X^4@Integer+X+5::PR, [ -Y^3@Integer, Y^2@Integer*X, -Y*X^2@Integer, X^3@Integer, -(2::PR)*Y ] );
	reduceTesterAS( 2::PR*X*Y*Y+5::PR, failSafeRetract [ Z*X, W*W*W, Y*X, X*X*X ], 5::PR, [ -2::PR*Y ] );
    }

    ----------------------------------------------------------------------    

    testDeltaTWithConst():() == {
	import from FLD;
	import from Integer;
	import from List PR;
	deltaTTester( 1, 1, 0, [ -1, 1 ] );
	deltaTTester( 4::PR, 3::PR, 0, [ -inv (4::FLD) :: PR,  inv (3::FLD) :: PR ] );
	deltaTTester( 4::PR, 3*X, 0, [ -inv (4::FLD) :: PR * X,  inv (3::FLD) :: PR ] );
	deltaTTester( 4::PR, Z*Y+3*X*Y, 3*X*Y, [ -inv (4::FLD) :: PR * Z * Y,  1 ] );
    }

    ----------------------------------------------------------------------    

    testDeltaTWithPolynomials():() == {
	import from FLD;
	import from Integer;
	import from List PR;
	deltaTTester( 7::PR*X*X*Z*Z+2::PR*W, 3::PR*Y*X+12::PR, -(2::FLD/7::FLD)*Y*W + 4::PR*Z*Z*X, [ -inv (7::FLD) :: PR * Y,  inv( 3::FLD )*Z*Z*X ] );
    }

    ----------------------------------------------------------------------    

}