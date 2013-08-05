-------------------------------------------------------------------------
--
-- cs_dpidt.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

TestDistributivePolynomialRingIntegralDomainExtension(
  R: with{ 
      IntegralDomain;
      CharacteristicZero;
      CopyableType;
  },
  VARS: FiniteVariableType,
  VARSYMS: List Symbol,
  EXP: ExponentCategory VARS,
  OPR: PolynomialRing0( R, VARS ),
  PR: with {
      IndexedFreeModule( R, EXP );
      PolynomialRing0( R, VARS );
      IntegralDomain;
      coerce: OPR -> %;
      coerce: % -> OPR;
  }
) : with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_dpidt.test.signatures.as"

} == TestPolynomialWrapper( R, VARS, VARSYMS, OPR, PR ) add {

    import from TestCaseTools;

    import from PR;
    import from R;
    import from Integer;

    ------------------------------------
    
    defineAsserts( PR );
    defineAsserts( VARS );

    ------------------------------------

    local intDomVar1: PR;    
    local intDomVar2: PR;
    local intDomVar3: PR;
    
    ------------------------------------

    intDomSetUp(): () == {
	import from VARS;
	import from List VARS;
	local minToMaxVars: List VARS := minToMax; 
	free intDomVar1 := ( first minToMaxVars ) :: PR;
	minToMaxVars := rest minToMaxVars;
	free intDomVar2 := ( first minToMaxVars ) :: PR;
	minToMaxVars := rest minToMaxVars;
	free intDomVar3 := ( first minToMaxVars ) :: PR;
    }
    
    ------------------------------------
    exactQuotientTester( divisor: PR, quotient: PR ): () == {
	assertEquals( failSafeRetract exactQuotient( divisor * quotient, divisor ), quotient ); 
    }
    
    ------------------------------------

    testExactDivideByZero(): () =={
	intDomSetUp();
	assertFailed exactQuotient( 0, 0 );
	assertFailed exactQuotient( 2::PR, 0 );
	assertFailed exactQuotient( 2*intDomVar1, 0 );
	assertFailed exactQuotient( 2*intDomVar1*intDomVar3+5*intDomVar2, 0 );
    }
    
    ------------------------------------

    testExactDivideByConst(): () =={
	intDomSetUp();
	exactQuotientTester( 3::PR, 0 );
	exactQuotientTester( 2::PR, 6::PR );
	exactQuotientTester( 2::PR, intDomVar1*intDomVar3 + intDomVar2 );
	exactQuotientTester( 6::PR, intDomVar1 );
    }
    
    ------------------------------------

    testExactDivideByPoly1(): () =={
	intDomSetUp();
	exactQuotientTester( intDomVar1, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
	exactQuotientTester( intDomVar2, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
	exactQuotientTester( intDomVar3, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
	exactQuotientTester( intDomVar3*intDomVar3, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
	exactQuotientTester( intDomVar3*intDomVar3+intDomVar2, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
	exactQuotientTester( intDomVar1*intDomVar2+intDomVar2, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
	exactQuotientTester( (intDomVar1+intDomVar2)*intDomVar3*intDomVar3, 3*intDomVar3*intDomVar3*intDomVar3+intDomVar1 );
    }
    
    ------------------------------------

    testExactDivideByPoly2(): () =={
	intDomSetUp();
	exactQuotientTester( intDomVar1^3, intDomVar3^3 );
	exactQuotientTester( intDomVar3^7, intDomVar3^3 );
	exactQuotientTester( intDomVar3^3, intDomVar3^7 );
	exactQuotientTester( intDomVar3^7+intDomVar1, intDomVar3^3 );
	exactQuotientTester( intDomVar3^3+intDomVar1, intDomVar3^7 );
	exactQuotientTester( intDomVar3^7*intDomVar1+intDomVar1, intDomVar3^3 );
	exactQuotientTester( intDomVar3^3*intDomVar1+intDomVar1, intDomVar3^7 );
	exactQuotientTester( intDomVar3^7, intDomVar3^3+intDomVar1 );
	exactQuotientTester( intDomVar3^3, intDomVar3^7+intDomVar1 );
	exactQuotientTester( intDomVar3^7, intDomVar3^3*intDomVar1+intDomVar1 );
	exactQuotientTester( intDomVar3^3, intDomVar3^7*intDomVar1+intDomVar1 );
	exactQuotientTester( intDomVar3^7*intDomVar1+intDomVar1, intDomVar3^3*intDomVar1+intDomVar1 );
	exactQuotientTester( intDomVar3^3*intDomVar1+intDomVar1, intDomVar3^7*intDomVar1+intDomVar1 );
    }
    
    ------------------------------------

}