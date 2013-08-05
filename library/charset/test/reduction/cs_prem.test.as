-------------------------------------------------------------------------
--
-- cs_prem.test.as
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
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);	
local EXP == ListSortedExponent( VARS );
local PR == DistributedMultivariatePolynomial1( R, VARS, EXP );


local TESTSTUB == TestReductionTools( PR, PseudoRemainderReductionTools( R, VARS, PR ) );

TestPseudoRemainder : TestCaseType with {

#include "cs_red.test.signatures.as"
#include "cs_prem.test.signatures.as"

} == TESTSTUB add {

    import from TESTSTUB;
    import from TestCaseTools;

    import from R;
    
    ------------------------------------

    defineAsserts( VARS );
    
    ------------------------------------

    local var1: PR;    
    local var2: PR;
    local var3: PR;
    
    ------------------------------------

    setUp(): () == {
	import from VARS;
	free var1 := ( failSafeRetract variable VAR1 ) :: PR;
	free var2 := ( failSafeRetract variable VAR2 ) :: PR;
	free var3 := ( failSafeRetract variable VAR3 ) :: PR;
    }
    
    ------------------------------------


    testReduced?WrtZero():() == {
	reduced?Tester( 0, 0, true );
	reduced?Tester( 1, 0, true );
	reduced?Tester( 3::PR, 0, true );
	reduced?Tester( var1*var3 + var2, 0, true );
    }
    
    ------------------------------------

    testReduced?WrtConst():() == {
	local const: PR := 5::PR;
	reduced?Tester( 0, const, true );
	reduced?Tester( 1, const, false );
	reduced?Tester( 3::PR, const, false );
	reduced?Tester( var1*var3 + var2, const, false );
    }
    
    ------------------------------------

    testReduced?WrtPoly1():() == {
	local poly: PR := 4*var2*var2+var1;
	reduced?Tester( 0, poly, true );
	reduced?Tester( 1, poly, true );
	reduced?Tester( 3::PR, poly, true );
	reduced?Tester( var1, poly, true );
	reduced?Tester( var3, poly, true );
	reduced?Tester( var1*var3 + var2, poly, true );
	reduced?Tester( var1*var3 + var2*var2, poly, false );
	reduced?Tester( var1*var3*var2*var2*var2 + var1, poly, false );
    }
    
    ------------------------------------

    testReduced?WrtPoly2():() == {
	local poly: PR := 4*var1*var2*var2+var1;
	reduced?Tester( 0, poly, true );
	reduced?Tester( 1, poly, true );
	reduced?Tester( 3::PR, poly, true );
	reduced?Tester( var1, poly, true );
	reduced?Tester( var3, poly, true );
	reduced?Tester( var2*var2, poly, false );
    }
    
    ------------------------------------

    testReduceWrtZero():() == {
	reduceTester( 0, 0, 0 );
	reduceTester( 1, 0, 1 );
	reduceTester( 3::PR, 0, 3::PR );
	reduceTester( var1, 0, var1 );
	reduceTester( var3, 0, var3 );
	reduceTester( var2*var2, 0, var2*var2 );
    }
    
    ------------------------------------

    testReduceWrtConst():() == {
	local const: PR := 5::PR;
	reduceTester( 0, const, 0 );
	reduceTester( 1, const, 0 );
	reduceTester( 3::PR, const, 0 );
	reduceTester( var1, const, 0 );
	reduceTester( var3, const, 0 );
	reduceTester( var2*var2, const, 0 );
    }
    
    ------------------------------------

    testReduceWrtPoly():() == {
	local poly: PR := 5*var1*var2*var2+var1*var1;
	reduceTester( 0, poly, 0 );
	reduceTester( 1, poly, 1 );
	reduceTester( 3::PR, poly, 3::PR );
	reduceTester( var1, poly, var1 );
	reduceTester( var3, poly, var3 );
	reduceTester( var2*var2, poly, -var1*var1 );
	reduceTester( 10*var3*var2*var2, poly, -10*var3*var1*var1 );
    }
    
    ------------------------------------

    
}
