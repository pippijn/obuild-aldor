-------------------------------------------------------------------------
--
-- cs_pdcom.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;
local COEFF == DifferentialRational;
local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);	
local EXP == ListSortedExponent( VARS );
local OPR == DistributedMultivariatePolynomial1( COEFF, VARS, EXP );
local EPR == DistributivePolynomialRingCommutativeRingExtension( COEFF, VARS, EXP, OPR );

TestDistributivePolynomialRingCommutativeExtension: TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_dpcom.test.signatures.as"

} == TestPolynomialWrapper( COEFF, VARS, [ VAR1, VAR2, VAR3 ], OPR, EPR ) add {

    import from TestCaseTools;
    import from EPR;
    import from Integer;
    import from COEFF;

    ------------------------------------
    
    defineAsserts( EPR );
    defineAsserts( VARS );

    ------------------------------------

    local localVar1: EPR;    
    local localVar2: EPR;
    local localVar3: EPR;
    
    ------------------------------------

    localComSetUp(): () == {
	import from VARS;
	free localVar1 := ( failSafeRetract variable VAR1 ) :: EPR;
	free localVar2 := ( failSafeRetract variable VAR2 ) :: EPR;
	free localVar3 := ( failSafeRetract variable VAR3 ) :: EPR;
    }
    
    ------------------------------------

    testUnitNormalize1(): () =={
	localComSetUp();
	( y: EPR, u: EPR, invU: EPR ) := unitNormal( 2::COEFF*localVar2 + localVar1 );
	assertEquals( y, 2::COEFF * localVar2 + localVar1);
	assertEquals( u, 1 );
	assertEquals( invU, 1 );
    }
    
    ------------------------------------

    testUnitNormal1(): () =={
	localComSetUp();
	( y: EPR, invUz: EPR ) := unitNormalize( 2*localVar2 + 3*localVar1, localVar3 );
	assertEquals( y, 2 * localVar2 + 3 * localVar1);
	assertEquals( invUz, localVar3 );
    }
    
    ------------------------------------

    testCanonicalUnitNormal1(): () =={
	localComSetUp();
	assertFalse( canonicalUnitNormal?$EPR );
    }
    
    ------------------------------------

    testCommutative?(): () =={
	localComSetUp();
	assertTrue (commutative?$EPR);
    }
    
    ------------------------------------

    testUnit?(): () =={
	localComSetUp();
	assertTrue unit? (1$EPR);
	assertFalse unit? localVar1;
    }
    
    ------------------------------------

    testReciprocal(): () =={
	localComSetUp();
	assertFailed reciprocal (0$EPR);
	assertEquals( failSafeRetract reciprocal (1$EPR), 1);
	assertEquals( failSafeRetract reciprocal (3::EPR), inv( 3::COEFF ) :: EPR);
	assertFailed reciprocal localVar1;
	assertFailed reciprocal( 4*localVar1*localVar3+2*localVar2*localVar2 );
    }
    
    ------------------------------------

}