-------------------------------------------------------------------------
--
-- cs_dplto.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;
local R == AldorInteger2;
local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableListWithProperHash( reverse! [ VAR1, VAR2, VAR3 ] );
local EXP   == MachineIntegerLexicographicalExponent( VARS );
local OPR: with { PolynomialRing0( R, VARS ); IndexedFreeModule( R, EXP ); } == DistributedMultivariatePolynomial1( R, VARS, EXP );
local EPR   == DistributivePolynomialRingLeadingTermOrderExtension( R, VARS, EXP, OPR );

TestDistributivePolynomialRingLeadingTermOrderExtension: TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_dplto.test.signatures.as"

} == TestPolynomialWrapper( R, VARS, [ VAR1, VAR2, VAR3 ], OPR, EPR ) add {
    
    import from TestCaseTools;
    import from EPR;

    ------------------------------------
    
    defineAsserts( EPR );
    defineAsserts( VARS );

    ------------------------------------

    local ltoVar1: EPR;    
    local ltoVar2: EPR;
    local ltoVar3: EPR;
    
    ------------------------------------

    LeadingTermSetUp(): () == {
	import from VARS;
	free ltoVar1 := ( failSafeRetract variable VAR1 ) :: EPR;
	free ltoVar2 := ( failSafeRetract variable VAR2 ) :: EPR;
	free ltoVar3 := ( failSafeRetract variable VAR3 ) :: EPR;
    }
    
    ------------------------------------

    testOrderConstConst(): () =={
	LeadingTermSetUp();
	assertFalse( 0 < 0 );
	assertFalse( 0 < 1 );
	assertFalse( 1 < 1 );
    }
    
    ------------------------------------

    testOrderConstPoly(): () =={
	LeadingTermSetUp();
	assertTrue( 0 < ltoVar1 );
	assertTrue( 1 < ltoVar1*ltoVar2*ltoVar2 + ltoVar3 );
    }
    
    ------------------------------------

    testOrderPolyConst(): () =={
	LeadingTermSetUp();
	assertFalse( ltoVar1 < 0 );
	assertFalse( ltoVar1*ltoVar2*ltoVar2 + ltoVar3 < 1 );
    }
    
    ------------------------------------

    testOrderPolyPoly1(): () =={
	LeadingTermSetUp();
	assertTrue( ltoVar1 < ltoVar2 );
	assertFalse( ltoVar2 < ltoVar1 );
	assertTrue( ltoVar1 < ltoVar3 );
	assertFalse( ltoVar3 < ltoVar1 );
	assertTrue( ltoVar2 < ltoVar3 );
	assertFalse( ltoVar3 < ltoVar2 );
    }
    
    ------------------------------------

    testOrderPolyPoly2(): () =={
	LeadingTermSetUp();
	assertFalse( ltoVar1*ltoVar1 + ltoVar3 < ltoVar2 );
	assertTrue( ltoVar1*ltoVar1 + ltoVar3 > ltoVar2 );
    }
    
    ------------------------------------
    
}
