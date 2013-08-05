-------------------------------------------------------------------------
--
-- cs_ccomp.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local DFLD  == DifferentialRational;
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
local DPR   == DifferentiallyExtendedDistributivePolynomialRing( DFLD, VARS, DVARS, EXP, PR );
local RT   == DifferentialPolynomialReductionTools( DFLD, VARS, DVARS, DPR );
local AS   == AutoreducedSet( DPR, RT );

local TESTSTUB == TestDecompositionAlgorithmType( DPR, RT, CoherentComponentsDecompositionTools( DFLD, DVARS, EXP, DPR, RT, CoherentAutoreducedSetTools( DPR, RT, BasicSetSortedTools( DPR, RT ) ) ) );

TestCoherentComponentsDecompositionTools: TestCaseType with {

#include "cs_decom.test.signatures.as"
#include "cs_ccomp.test.signatures.as"

} == TESTSTUB add {
    import from TestCaseTools;
    import from TESTSTUB;
    
    import from Character;
    import from Integer;
    import from Array Integer;
    import from MachineInteger;

    import from DFLD;
    import from DVARS;
    import from Partial DVARS;
    import from DPR;
    import from List DPR;
    import from Set DPR;
    import from RT;
    import from AS;
    import from Set AS;

    local dvar1: DVARS;
    local dvar2: DVARS;
    local dvar3: DVARS;

    local var100 : DPR;
    local var110 : DPR;
    local var101 : DPR;
    local var120 : DPR;
    local var111 : DPR;
    local var102 : DPR;
    local var130 : DPR;
    local var200 : DPR;
    local var210 : DPR;
    local var201 : DPR;
    local var220 : DPR;
    local var211 : DPR;
    local var202 : DPR;
    local var230 : DPR;
    local var300 : DPR;
    local var310 : DPR;
    local var301 : DPR;
    local var320 : DPR;
    local var311 : DPR;
    local var302 : DPR;
    local var330 : DPR;

    ----------------------------------------------------------------------

    defineAsserts( AS );
    
    ----------------------------------------------------------------------

    setUp():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;
	import from MachineInteger;
	
	free dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: DVARS;
	free dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: DVARS;
	free dvar3 := (minToMax$VARS).(firstIndex$(List VARS) + 2) :: DVARS;

	free var100 := ( dvar1 :: DPR);
	free var200 := ( dvar2 :: DPR);
	free var300 := ( dvar3 :: DPR);
	free var110 := differentiate( var100, [ 1, 0 ] );
	free var210 := differentiate( var200, [ 1, 0 ] );
	free var310 := differentiate( var300, [ 1, 0 ] );
	free var101 := differentiate( var100, [ 0, 1 ] );
	free var201 := differentiate( var200, [ 0, 1 ] );
	free var301 := differentiate( var300, [ 0, 1 ] );
	free var120 := differentiate( var110, [ 1, 0 ] );
	free var220 := differentiate( var210, [ 1, 0 ] );
	free var320 := differentiate( var310, [ 1, 0 ] );
	free var111 := differentiate( var110, [ 0, 1 ] );
	free var211 := differentiate( var210, [ 0, 1 ] );
	free var311 := differentiate( var310, [ 0, 1 ] );
	free var102 := differentiate( var101, [ 0, 1 ] );
	free var202 := differentiate( var201, [ 0, 1 ] );
	free var302 := differentiate( var301, [ 0, 1 ] );
	free var130 := differentiate( var120, [ 1, 0 ] );
	free var230 := differentiate( var220, [ 1, 0 ] );
	free var330 := differentiate( var320, [ 1, 0 ] );

    }

    ----------------------------------------------------------------------

    testCoherentComponents1(): () == {
	local x1 == var100;
	local x2 == var201;
	local J: List DPR := [ 2*x1*x1+3*x1+1, 2*x1*x2+x2, x2*x2-2*x1-2::DPR ];
	decomposeTester( J, [ failSafeRetract [ 2*x1*x1+3*x1+1, 2*x1*x2+x2 ], failSafeRetract [ 2*x1+1, 2*x2*x2-2::DPR ] ], [ -2::DPR, -2*x1-3::DPR, -2*x2, -4*x2, 4*x2, -1, -x2, 2::DPR, 4::DPR, 4*x1+3::DPR, -4*x1-3::DPR, 2*x1+1, -2*x1-1 ] );	
    }
    
    -------------------------------------------

    testCoherentComponents2(): () == {
	decomposeTester( [ var200*var200 ], [ failSafeRetract [ 2*var200 ], failSafeRetract [ var200*var200 ] ], [ -2::DPR, 2::DPR, -var200, 2*var200, -2*var200 ] );
    }
    
    -------------------------------------------

}
