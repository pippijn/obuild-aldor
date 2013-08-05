-------------------------------------------------------------------------
--
-- cs_dpcom.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

TestPolynomialRingGCDWrapper(
  R: with{ 
      CommutativeRing; 
      CopyableType;
      CharacteristicZero;
  },
  VARS: VariableType,
  VARSYMS: List Symbol,
  OPR: PolynomialRing0( R, VARS ),  -- the wrapped polynomial ring
  EPR: with {                       -- the new polynomial ring
      PolynomialRing0( R, VARS );
      GcdDomain;
      coerce: % -> OPR;
      coerce: OPR -> %;
  }
): TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_gcd.test.signatures.as"

} == TestPolynomialWrapper( R, VARS, VARSYMS, OPR, EPR ) add {

    import from TestCaseTools;
    import from EPR;
    import from R;
    import from Integer;

    ------------------------------------
    
    defineAsserts( EPR );
    defineAsserts( VARS );

    ------------------------------------

    local gcdVar1: EPR;    
    local gcdVar2: EPR;
    local gcdVar3: EPR;
    
    ------------------------------------

    gcdSetUp(): () == {
	import from VARS;
	import from MachineInteger;
	free gcdVar1 := ( failSafeRetract variable ( VARSYMS . 1 ) ) :: EPR;
	free gcdVar2 := ( failSafeRetract variable ( VARSYMS . 2 ) ) :: EPR;
	free gcdVar3 := ( failSafeRetract variable ( VARSYMS . 3 ) ) :: EPR;
    }
    
    ------------------------------------

    gcdTester( a: EPR, b: EPR, divisor: EPR ): () == {
	assertEquals( gcd( a, b ), divisor );
	assertEquals( gcd( b, a ), divisor );
    }
    
    ------------------------------------
	
    testGCDZero(): () =={
	gcdSetUp();
	gcdTester( 0, 0, 0 );
	gcdTester( 1, 0, 1 );
	gcdTester( gcdVar1, 0, gcdVar1 );
	gcdTester( 7*gcdVar1*gcdVar3+9*gcdVar2, 0, 7*gcdVar1*gcdVar3+9*gcdVar2 );
    }

    ------------------------------------

    testGCDOne(): () =={
	gcdSetUp();
	gcdTester( 0, 1, 1 );
	gcdTester( 1, 1, 1 );
	gcdTester( gcdVar1, 1, 1 );
	gcdTester( 7*gcdVar1*gcdVar3+9*gcdVar2, 1, 1 );
    }

    ------------------------------------

    testGCDConst(): () =={
	gcdSetUp();
	gcdTester( 0, 6::EPR, 6::EPR );
	gcdTester( 1, 6::EPR, 1 );
	gcdTester( gcdVar1, 6::EPR, 1 );
	gcdTester( 15*gcdVar1, 6::EPR, 3::EPR );
	gcdTester( 15*gcdVar1*gcdVar3+14*gcdVar2, 6::EPR, 1 );
	gcdTester( 15*gcdVar1*gcdVar3+21*gcdVar2, 6::EPR, 3::EPR );
    }

    ------------------------------------

    testGCDPoly1(): () =={
	gcdSetUp();
	gcdTester( 0, gcdVar1, gcdVar1 );
	gcdTester( 1, gcdVar1, 1 );
	gcdTester( gcdVar1, gcdVar1, gcdVar1 );
	gcdTester( 6*gcdVar1, 15*gcdVar1, 3*gcdVar1 );
	gcdTester( gcdVar2, gcdVar1, 1 );
	gcdTester( gcdVar3, gcdVar1, 1 );
	gcdTester( gcdVar2*(gcdVar1+gcdVar3*gcdVar3), gcdVar2, gcdVar2 );
	gcdTester( gcdVar3*gcdVar3*gcdVar3*gcdVar3*gcdVar3*gcdVar3+gcdVar3, gcdVar3*gcdVar3*gcdVar3*gcdVar1, gcdVar3 );
    }

    ------------------------------------

    testGCDPoly2(): () =={
	gcdSetUp();
	gcdTester( gcdVar2*(gcdVar1+gcdVar3*gcdVar3), gcdVar2+gcdVar1, 1 );
	gcdTester( (gcdVar2+gcdVar1)*(gcdVar1+gcdVar3*gcdVar3), gcdVar2+gcdVar1, gcdVar2+gcdVar1 );
	gcdTester( (gcdVar3*gcdVar3+gcdVar2+gcdVar1*gcdVar1)*(gcdVar1+gcdVar3*gcdVar3), (gcdVar3*gcdVar3+gcdVar2+gcdVar1*gcdVar1)*(gcdVar1+gcdVar2+gcdVar3),  (gcdVar3*gcdVar3+gcdVar2+gcdVar1*gcdVar1) );
    }

    ------------------------------------

}