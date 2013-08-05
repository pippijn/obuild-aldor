-------------------------------------------------------------------------
--
-- cs_zdchi.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local COEFF == Fraction Integer;
local VAR1  == (-"x1");
local VAR2  == (-"x2");
local VARS  == OrderedVariableList( reverse! [ VAR1, VAR2 ] );
local EXP   == SortedListExponent( VARS );
local PR    == DistributedMultivariatePolynomial1( COEFF, VARS, EXP );
local OPR   == DistributivePolynomialRingLeadingTermOrderExtension( COEFF, VARS, EXP, PR );
local RT    == PolynomialReductionTools( COEFF, VARS, EXP, OPR );
local AS    == AutoreducedSet( OPR, RT );

local TESTSTUB == TestSaturatedDecompositionAlgorithmType( OPR, RT, ZeroDimensionalChiDecompositionTools( COEFF, VARS, EXP, OPR, RT, SaturatedGroebnerBasisWrtPolynomialReductionTools( COEFF, VARS, EXP, OPR, RT ) ) );

TestZeroDimensionalChiDecomposition : TestCaseType with {

#include "cs_decom.test.signatures.as"
#include "cs_sdecm.test.signatures.as"
#include "cs_zdchi.test.signatures.as"

} == TESTSTUB add {

    import from TestCaseTools;
    import from Character;

    import from Integer;
    import from MachineInteger;

    import from List OPR;
    import from Set OPR;
    import from AS;
    import from Set AS;
    import from TESTSTUB;

    local x1 : OPR;
    local x2 : OPR;

    ----------------------------------------------------------------------

    defineAsserts( AS );
    defineAsserts( Set AS );

    ----------------------------------------------------------------------

    setUp():() == {
	import from List VARS;
	free x1 := (minToMax$VARS).(firstIndex$(List VARS)) :: OPR;
	free x2 := (minToMax$VARS).( next (firstIndex$(List VARS)) ) :: OPR;
    }

    ----------------------------------------------------------------------

    testZeroDIrredundantChiDecomposition1():() == {
	import from COEFF;
	local J: List OPR := [ 2*x1*x1+3*x1+1, 2*x1*x2+x2, x2*x2-2*x1-2::OPR ];
	local sat: Set OPR := [ 2*x1+1 ];

	saturatedDecomposeTester( J, sat, [ failSafeRetract [ -4*x1-4::OPR, -64*x2 ] ], empty );

	macro MKCF( a, b ) == { ( a@Integer / b@Integer )@COEFF };
	saturatedDecomposeTester(  J, empty, [ failSafeRetract [ 2*x1+1, x2*x2-1 ], failSafeRetract [ -4*x1-4::OPR, -64*x2 ] ], [ -1, -x1, -x2, MKCF( 1, 2 )*x2, MKCF( 3, 4 )*x2*x2, MKCF( 1, 4 )::OPR, MKCF( -1, 2 )::OPR, MKCF( -1, 2 )*x1, MKCF( -1, 2 )*x2, MKCF( 1, 2 )*x1, MKCF( -1, 2 )::OPR*x2*x2, x1*x1, x1, MKCF( 1, 2 )::OPR, 1, MKCF( -1, 4 )::OPR, MKCF( 3, 4 )*x2, MKCF( -3, 2 )::OPR ] );
    }

    ----------------------------------------------------------------------

}
