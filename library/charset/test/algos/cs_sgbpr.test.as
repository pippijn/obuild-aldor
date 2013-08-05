-------------------------------------------------------------------------
--
-- cs_sgbpr.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local COEFF == Fraction AldorInteger2;
macro MKCF( a, b ) == { ( /$COEFF ) ( a@AldorInteger2, b@AldorInteger2 ) };
local VAR1  == (-"x1");
local VAR2  == (-"x2");
local VAR3  == (-"x3");
local VAR4  == (-"x4");
local VARS  == OrderedVariableList( reverse! [ VAR1, VAR2, VAR3, VAR4 ] );
local EXP   == SortedListExponent( VARS );
local PR    == DistributedMultivariatePolynomial1( COEFF, VARS, EXP );
local OPR   == DistributivePolynomialRingLeadingTermOrderExtension( COEFF, VARS, EXP, PR );
local RT    == PolynomialReductionTools( COEFF, VARS, EXP, OPR );
local AS    == AutoreducedSet( OPR, RT );


TestSatuatedGroebnerBasisWrtPolynomialRingTools: TestCaseType with {

#include "cs_sgbpr.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from Character;

    import from AldorInteger2;
    import from MachineInteger;

    import from List OPR;
    import from Set OPR;
    import from AS;
    import from SaturatedGroebnerBasisWrtPolynomialReductionTools( COEFF, VARS, EXP, OPR, RT
#if NO__COMPILER__BUG
      ,   { 
      ( SOME__T : RankedTriangularizationTType, SOME__RT: TriangularizationReductionType SOME__T ): 
ReducedGroebnerBasisAlgorithmType( SOME__T, SOME__RT ) +-> { 
	  ReducedGroebnerBasisTools( SOME__T, SOME__RT, GroebnerBasisTools( SOME__T, SOME__RT ), AutoreducedSetTools( SOME__T, SOME__RT, BasicSetSortedTools( SOME__T, SOME__RT ) ) );
      }
  }
#endif
  );

    local x1 : OPR;
    local x2 : OPR;
    local x3 : OPR;
    local x4 : OPR;

    ----------------------------------------------------------------------

    defineAsserts( OPR );
    defineAsserts( List OPR );
    defineAsserts( Set OPR );
    defineAsserts( AS );

    ----------------------------------------------------------------------

    setUp():() == {
	import from List VARS;

	free x1 := (minToMax$VARS).(firstIndex$(List VARS)) :: OPR;
	free x2 := (minToMax$VARS).( next (firstIndex$(List VARS)) ) :: OPR;
	free x3 := (minToMax$VARS).( (firstIndex$(List VARS)) + 2 ) :: OPR;
	free x4 := (minToMax$VARS).( (firstIndex$(List VARS)) + 3 ) :: OPR;
    }

    ----------------------------------------------------------------------

    reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( a: List OPR, sat: Set OPR, res: List OPR, premult: Set OPR ): () == {
	dbgout << "-- reducedSaturatedGroebnerBasisWrtPolynomialReductionTester! --" << newline;
	dbgout << "   a: " << a << newline;
	dbgout << " sat: " << sat << newline;

	res := sort!( res, < );
	local resAs: AS := failSafeRetract [ generator res ];
	
	local gbRes: List OPR;
	local gbResAs: AS;
	local gbPremult: Set OPR;
	dbgout << "   a: " << a << newline;

	-- ( List OPR, Set OPR ) -> List OPR
	assertEquals( sort!( groebnerBasis( a, sat ), < ), res );
	dbgout << "   a: " << a << newline;

	-- ( List OPR, Set OPR ) -> ( List OPR, Set OPR )
	( gbRes, gbPremult ) := groebnerBasis( a, sat );
	assertEquals( sort!( gbRes, < ), res );
	assertEquals( gbPremult, premult );

	-- ( Generator OPR, Generator OPR ) -> List OPR
	assertEquals( sort!( groebnerBasis( a, sat ), < ), res );

	-- ( Generator OPR, Generator OPR ) -> ( List OPR, Set OPR )
	( gbRes, gbPremult ) := groebnerBasis( a, sat );
	assertEquals( sort!( gbRes, < ), res );
	assertEquals( gbPremult, premult );

	-- ( List OPR, Set OPR ) -> AS
	assertEquals( triangularize( a, sat ), resAs );

	-- ( List OPR, Set OPR ) -> ( AS, Set OPR )
	( gbResAs, gbPremult ) := triangularize( a, sat );
	assertEquals( gbResAs, resAs );
	assertEquals( gbPremult, premult );

	-- ( Generator OPR, Generator OPR ) -> AS
	assertEquals( triangularize( a, sat ), resAs );

	-- ( Generator OPR, Generator OPR ) -> ( AS, Set OPR )
	( gbResAs, gbPremult ) := triangularize( a, sat );
	assertEquals( gbResAs, resAs );
	assertEquals( gbPremult, premult );

	dbgout << "-- reducedSaturatedGroebnerBasisWrtPolynomialReductionTester! -- END" << newline;
    }

    ----------------------------------------------------------------------
        
    testReducedSaturatedGroebnerBasisWrtPolynomialReductionWithoutSaturation1():() == {
	
	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( empty, empty, empty, empty );
	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( [ 1$OPR ], empty, [ 1$OPR ], empty );
	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( [ x1, x2+x1 ], empty, [ x2, x1 ], [ -x2, x1, -x1, -1 ] );
	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( [ x1, x2+x1, 1 ], empty, [ 1 ], [ -x2, x1, -1, x2, 1, -x1 ] );
	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( [ x3+x1, x3+x2+x1 ], empty, [ x2, x3 + x1 ], [ -1, 1, -x3, x2, -x1, -x2 ] );

    }

    ----------------------------------------------------------------------

    testReducedSaturatedGroebnerBasisWrtPolynomialReductionWithoutSaturation2():() == {

	local x == x1;
	local y == x2;
	
	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( [ x*x*y*y+y-1, x*x*y+x ], empty, [ y-1, -x ], [ -1, x2, -x2*x1, 1, -x1, -x2*x1*x1, -x1*x1, -x2, x1*x1, x1,-x2*x2, x2*x1, x2*x2*x1, MKCF( -2, 1 )*x2, x2*x2 ] );

    }

    ----------------------------------------------------------------------

    testReducedSaturatedGroebnerBasisWrtPolynomialReductionWithSaturation1():() == {

	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( empty, [ 1 ], empty, empty );

    }

    ----------------------------------------------------------------------

    testReducedSaturatedGroebnerBasisWrtPolynomialReductionWithSaturation2():() == {

	import from COEFF;
	local J: List OPR := [ 2::COEFF*x1*x1+3::COEFF*x1+1, 2::COEFF*x1*x2+x2, x2*x2-2::COEFF*x1-2::COEFF::OPR ];
	local sat: Set OPR := [ 2::COEFF*x1+1 ];

	reducedSaturatedGroebnerBasisWrtPolynomialReductionTester!( J, sat, [ -4::COEFF*x1-4::COEFF::OPR, -64::COEFF* x2 ], empty);	

    }

    ----------------------------------------------------------------------

}
