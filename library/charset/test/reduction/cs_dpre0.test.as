-------------------------------------------------------------------------
--
-- cs_dpre0.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local DFLD == DifferentialRational;
local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);
local DSYM0 == (-"s");
local DSYM1 == (-"t");
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );



local ORDER == DifferentialVariableOrderlyOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );
local EXP   == SortedListExponent( DVARS );
local PR    == DistributedMultivariatePolynomial1( DFLD, DVARS, EXP);
local DPR   == DifferentiallyExtendedPolynomialRing( DFLD, VARS, DVARS, PR );
local RT    == DifferentialPolynomialReductionTools( DFLD, VARS, DVARS, DPR );
local AS    == AutoreducedSet( DPR, RT );


TestDifferentialPolynomialReductionTools0 : TestCaseType with {

#include "cs_dpred.test.signatures.as"
#include "cs_dpre0.test.signatures.as"

} == TestDifferentialPolynomialReductionTools( DFLD, VARS, DSYMS, DVARS, DPR ) add {

    import from TestCaseTools;
    import from DPR;
    import from MachineInteger;
    import from Integer;
    import from Array Integer;
    import from DVARS;
    import from DFLD;
    import from RT;
    
    ----------------------------------------------------------------------    

    testReducedBy?Specialized1():() == {
	local var101: DPR := variable( 1, [ 0, 1 ] ) :: DPR;
	local var110: DPR := variable( 1, [ 1, 0 ] ) :: DPR;
	local var200: DPR := variable( 2, [ 0, 0 ] ) :: DPR;
	local var300: DPR := variable( 3, [ 0, 0 ] ) :: DPR;
	local var310: DPR := variable( 3, [ 1, 0 ] ) :: DPR;
	local reducedBy?Func := reducedBy?( var101*var110*var300+var310*var200 );
	assertFalse( reducedBy?Func( var101 ) );

    }

    
    ----------------------------------------------------------------------    

    
    testReducedBy?Specialized2():() == {
	local var101: DPR := variable( 1, [ 0, 1 ] ) :: DPR;
	local var110: DPR := variable( 1, [ 1, 0 ] ) :: DPR;
	local var111: DPR := variable( 1, [ 1, 1 ] ) :: DPR;
	local var200: DPR := variable( 2, [ 0, 0 ] ) :: DPR;
	local var300: DPR := variable( 3, [ 0, 0 ] ) :: DPR;
	local var310: DPR := variable( 3, [ 1, 0 ] ) :: DPR;
	local reducedBy?Func := reducedBy?( var101*var110*var300+var310*var200 );
	assertFalse( reducedBy?Func( var111*var300 ) );

    }

    
    ----------------------------------------------------------------------    


    testReduced?Specialized1():() == {
	local var101: DPR := variable( 1, [ 0, 1 ] ) :: DPR;
	local var110: DPR := variable( 1, [ 1, 0 ] ) :: DPR;
	local var200: DPR := variable( 2, [ 0, 0 ] ) :: DPR;
	local var300: DPR := variable( 3, [ 0, 0 ] ) :: DPR;
	local var310: DPR := variable( 3, [ 1, 0 ] ) :: DPR;
	assertFalse( reduced?( var101, var101*var110*var300+var310*var200 ) );

    }

    
    ----------------------------------------------------------------------    

    testReduced?Specialized2():() == {
	local var101: DPR := variable( 1, [ 0, 1 ] ) :: DPR;
	local var110: DPR := variable( 1, [ 1, 0 ] ) :: DPR;
	local var111: DPR := variable( 1, [ 1, 1 ] ) :: DPR;
	local var200: DPR := variable( 2, [ 0, 0 ] ) :: DPR;
	local var300: DPR := variable( 3, [ 0, 0 ] ) :: DPR;
	local var310: DPR := variable( 3, [ 1, 0 ] ) :: DPR;
	assertFalse( reduced?( var111*var300, var101*var110*var300+var310*var200 ) );
    }

    
    ----------------------------------------------------------------------    
    
    
     testReduceStepSpecialized1():() == {
	local var100: DPR := variable( 1, [ 0, 0 ] ) :: DPR;
	local var101: DPR := variable( 1, [ 0, 1 ] ) :: DPR;
	local var200: DPR := variable( 2, [ 0, 0 ] ) :: DPR;
	local var201: DPR := variable( 2, [ 0, 1 ] ) :: DPR;
	local var202: DPR := variable( 2, [ 0, 2 ] ) :: DPR;
	local var211: DPR := variable( 2, [ 1, 1 ] ) :: DPR;
	local var300: DPR := variable( 3, [ 0, 0 ] ) :: DPR;
	local var301: DPR := variable( 3, [ 0, 1 ] ) :: DPR;
	local reduceStepFunc : DPR -> DPR := reduceStep( var100*var200+(2::DFLD)*var201+var300 );
	assertEquals( DPR, reduceStepFunc( (5::DFLD)*var100*var211+var202*var202*var202*var100 ), (10::DFLD)*var100*var211-(var101*var200+var100*var201+var301)*var202*var202*var100 );

    }
        
        
    ----------------------------------------------------------------------    

    
}
