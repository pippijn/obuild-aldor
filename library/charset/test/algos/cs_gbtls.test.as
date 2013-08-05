-------------------------------------------------------------------------
--
-- cs_gbtls.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local DFLD  == DifferentialRational;
local VAR1  == (-"x1");
local VAR2  == (-"x2");
local VAR3  == (-"x3");
local VAR4  == (-"x4");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3, VAR4 ]);
local DSYMS == (bracket$(Array Symbol)) ();



local ORDER == DifferentialVariableOrderlyOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );
local EXP   == SortedListExponent( DVARS );
local PR    == DistributedMultivariatePolynomial1( DFLD, DVARS, EXP);
local DPR   == DifferentiallyExtendedDistributivePolynomialRing( DFLD, VARS, DVARS, EXP, PR );
local RT    == PolynomialReductionTools( DFLD, DVARS, EXP, DPR );
local AS    == AutoreducedSet( DPR, RT );


TestGroebnerBasisTools : TestCaseType with {

#include "cs_gbtls.test.signatures.as"

} == add {

    import from TestCaseTools;
    import from Character;
    
    import from Integer;
    import from MachineInteger;

    import from DFLD;
    import from DVARS;
    import from Partial DVARS;
    import from DPR;
    import from List DPR;
    import from Set DPR;
    import from RT;
    import from AS;
    import from GroebnerBasisTools( DPR, RT );

    local x1 : DPR;
    local x2 : DPR;
    local x3 : DPR;
    local x4 : DPR;
    
    ----------------------------------------------------------------------

    defineAsserts( DPR );
    defineAsserts( List DPR );
    defineAsserts( Set DPR );
    defineAsserts( AS );
    
    ----------------------------------------------------------------------

    setUp():() == {
	import from List VARS;
	
	free x1 := (minToMax$VARS).(firstIndex$(List VARS)) :: DVARS :: DPR;
	free x2 := (minToMax$VARS).( next (firstIndex$(List VARS)) ) :: DVARS :: DPR;
	free x3 := (minToMax$VARS).( (firstIndex$(List VARS)) + 2 ) :: DVARS :: DPR;
	free x4 := (minToMax$VARS).( (firstIndex$(List VARS)) + 3 ) :: DVARS :: DPR;
	
    }
    
    ----------------------------------------------------------------------

    groebnerBasisTester( a: List DPR, res: List DPR, premult: Set DPR ): () == {
	dbgout << "-- groebnerBasisTester --" << newline;
	dbgout << " a: " << a << newline;

	res := append!( res, copy a );
	
	local gbRes: List DPR;
	local gbPremult: Set DPR;
	
	-- List DPR -> List DPR
	assertEquals( groebnerBasis a, res );

	-- List DPR -> ( List DPR, Set DPR )
	( gbRes, gbPremult ) := groebnerBasis a;
	assertEquals( gbRes, res );
	assertEquals( gbPremult, premult );
	  
	-- Generator DPR -> List DPR
	assertEquals( groebnerBasis generator a, res );

	-- Generator DPR -> ( List DPR, Set DPR )
	( gbRes, gbPremult ) := groebnerBasis generator a;
	assertEquals( gbRes, res );
	assertEquals( gbPremult, premult );
	  
	dbgout << "-- groebnerBasisTester -- END" << newline;
    }
    
    ----------------------------------------------------------------------    

    testGroebnerBasis1():() == {
	
	groebnerBasisTester( empty, empty, empty );
	groebnerBasisTester( [ 1$DPR ], empty, empty );
	groebnerBasisTester( [ x1, x2+x1, 1 ], empty, [ -x1, x1, -x2, 1, x2, -1 ] );
	groebnerBasisTester( [ x1, x2+x1 ], empty, [ -x1, x1, -x2 ] );
	groebnerBasisTester( [ x3+x1, x3+x2+x1 ], [ x2 ], [ -x2, -x1, x2,-x3, 1, -1 ] );
    }
	
    ----------------------------------------------------------------------

    testGroebnerBasis2():() == {

	local x == x1;
	local y == x2;
	
	groebnerBasisTester( [ x*x*y*y+y-1, x*x*y+x ], [ -x, x*x+x, y-1, x*y-y+1 ], [ y*y,-2*y,y*y*x,y*x,-y*y,x,x*x,-y,-x*x,-y*x*x,-x,1,-y*x,y,-1 ] );	
	
    }

    
    ----------------------------------------------------------------------

    
}
