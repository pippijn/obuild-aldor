-------------------------------------------------------------------------
--
-- cs_as.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

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
local DPR   == DifferentiallyExtendedPolynomialRing( DFLD, VARS, DVARS, PR );
local RT    == DifferentialPolynomialReductionTools( DFLD, VARS, DVARS, DPR );
local AS    == AutoreducedSet( DPR, RT );


TestAutoreducedSet : TestCaseType with {

#include "cs_as.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from Integer;
    import from Array Integer;
    import from MachineInteger;
    import from ExpressionTree;
    import from List ExpressionTree;

    import from DFLD;
    import from DVARS;
    import from Partial DVARS;
    import from DPR;
    import from RT;
    import from AS;

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

    local assertEquals( left: DPR, right: DPR):() throw AldorUnitFailedExceptionType == assertEquals( DPR )( left, right );
    local assertEquals( left: AS, right: List DPR):() throw AldorUnitFailedExceptionType == {
	import from List DPR;
	assertEquals( List DPR )( [ generator left ], right );
    }
    local assertFailed( pAS: Partial AS): () throw AldorUnitFailedExceptionType == assertFailed( AS )( pAS );
    local failSafeRetract( pAS: Partial AS):AS throw AldorUnitFailedExceptionType == failSafeRetract( AS )( pAS );

    ----------------------------------------------------------------------

    setUp():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;

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
    
    
    testEmpty1():() == {
	
	assertTrue empty? (empty$AS);
	
    }

    
    ----------------------------------------------------------------------    

    testEmpty2():() == {
	
	assertFalse contradictory? empty;
	
    }

    
    ----------------------------------------------------------------------    

    
    testInsertable?1():() == {
	assertTrue insertable?( 1, empty );
    }

    
    ----------------------------------------------------------------------    

    
    testInsertable?2():() == {
	assertTrue insertable?( var120, empty );
    }

    
    ----------------------------------------------------------------------    


    testInsertable?3():() == {
	assertTrue insertable?( var120, empty );
    }

    
    ----------------------------------------------------------------------    


    testInsertable?4():() == {
	local as := failSafeRetract( AS, insert!( var210, empty ));
	assertFalse insertable?( var200, as );
	assertTrue insertable?( var100, as );
	assertTrue insertable?( var110, as );
	assertTrue insertable?( var120, as );
	assertFalse insertable?( var210, as );
	assertFalse insertable?( var220, as );
	assertFalse insertable?( var220*var220, as );
	assertFalse insertable?( var220+var110, as );
    }

    
    ----------------------------------------------------------------------    

    testInsertable?5():() == {
	local as := failSafeRetract( AS, insert!( var210, empty ));
	as := failSafeRetract( AS, insert!( var101, as ));
	assertFalse insertable?( var100, as );
	assertFalse insertable?( var102, as );
	assertTrue insertable?( var110, as );
    }

        
    ----------------------------------------------------------------------    
    
    testInsertable?6():() == {
	assertTrue insertable?( (17::DFLD)::DPR, empty );
    }
    

    ----------------------------------------------------------------------    
    
    
    testInsertable?7():() == {
	local as := failSafeRetract( [ var101, var201, var301*var301*var300 ] );
	assertFalse insertable?( (17::DFLD)::DPR, as );
	assertFalse insertable?( var102, as );
	assertFalse insertable?( var101, as );
	assertFalse insertable?( var101*var101, as );
	assertFalse insertable?( var100, as );
	assertFalse insertable?( var202, as );
	assertFalse insertable?( var201, as );
	assertFalse insertable?( var201*var201, as );
	assertFalse insertable?( var200, as );
	assertTrue insertable?( var110, as );
	assertTrue insertable?( var110*var110, as );
	assertTrue insertable?( var110, as );
	assertFalse insertable?( var220*var101, as );
	assertTrue insertable?( var110*var310, as );
    }
    

    ----------------------------------------------------------------------    
    

    testApply():() == {
	local as := failSafeRetract( AS, insert!( var101, empty ));
	as := failSafeRetract( AS, insert!( var210, as ));
	as := failSafeRetract( AS, insert!( var311, as ));
	assertEquals( as.( firstIndex$AS), var311 );
	assertEquals( as.( next (firstIndex$AS) ), var101 );
	assertEquals( as.( (firstIndex$AS) + 2 ), var210 );
    }

        
    ----------------------------------------------------------------------    
    

    testContradictory?1():() == {
	local as := failSafeRetract( AS, insert!( var101, empty ));
	assertFalse contradictory? as;
    }

        
    ----------------------------------------------------------------------    
    

    testContradictory?2():() == {
	local as := failSafeRetract( AS, insert!( (2::DFLD)::DPR, empty ));
	assertTrue contradictory? as;
    }

        
    ----------------------------------------------------------------------    
    

    testContradictory?3():() == {
	local as := failSafeRetract( AS, insert!( (2::DFLD)::DPR+var101, empty ));
	assertFalse contradictory? as;
    }

        
    ----------------------------------------------------------------------    
        

    testInsert!():() == {
	import from List DPR;

	local as := failSafeRetract( insert!( (2::DFLD)::DPR+var101, empty ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101 ] );

	assertFailed( insert!( (2::DFLD)::DPR, as ));
	assertFailed( insert!( (2::DFLD)::DPR+var101, as ));
	assertFailed( insert!( var111, as ) );
	
	as := failSafeRetract( insert!( (2::DFLD)::DPR+var110, as ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101, (2::DFLD)::DPR+var110 ] );

	assertFailed( insert!( (2::DFLD)::DPR+var110, as ) );

	as := failSafeRetract( insert!( var200*var200*var100, as ) );

	assertEquals( as, [ (2::DFLD)::DPR+var101, (2::DFLD)::DPR+var110, var200*var200*var100 ] );

	assertFailed( insert!( var200, as ) );
	assertFailed( insert!( var200*var200*var200*var200, as ) );

	as := failSafeRetract( insert!( var300, as ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101, (2::DFLD)::DPR+var110, var300, var200*var200*var100 ] );
    }

    
    ----------------------------------------------------------------------    
    
    
    testInsert():() == {
	import from List DPR;
	
	local as := failSafeRetract( insert( (2::DFLD)::DPR+var101, empty ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101 ] );
	
	assertFailed( insert( (2::DFLD)::DPR, as ));
	assertFailed( insert( (2::DFLD)::DPR+var101, as ));
	assertFailed( insert( var111, as ) );
	
	as := failSafeRetract( insert( (2::DFLD)::DPR+var110, as ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101, (2::DFLD)::DPR+var110 ] );

	assertFailed( insert( (2::DFLD)::DPR+var110, as ) );

	as := failSafeRetract( insert( var200*var200*var100, as ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101, (2::DFLD)::DPR+var110, var200*var200*var100 ] );

	assertFailed( insert( var200, as ) );
	assertFailed( insert( var200*var200*var200*var200, as ) );

	as := failSafeRetract( insert( var300, as ) );
	assertEquals( as, [ (2::DFLD)::DPR+var101, (2::DFLD)::DPR+var110, var300, var200*var200*var100 ] );
    }

    
    ----------------------------------------------------------------------    
    
    
    testBracketTuple1():() == {

	assertFailed [ var101, var101 ];

    }
    

    ----------------------------------------------------------------------    
    
    
    testBracketTuple2():() == {

	assertFailed [ var101, var200*var101 ];

    }
    

    ----------------------------------------------------------------------    
    
    
    testBracketTuple3():() == {

	assertFailed [ var101, var211*var101 ];

    }
    

    ----------------------------------------------------------------------    
    
    
    testBracketTuple4():() == {
	import from List DPR;
	local as := failSafeRetract [ var210, var110*var200, var300, var201*var202 ];
	assertEquals( as, [ var201*var202, var210, var110*var200, var300 ] );

    }
    

    ----------------------------------------------------------------------    
    
    testBracketGenerator1():() == {
	import from List DPR;
	assertFailed [ generator [ var101, var101 ] ];

    }
    

    ----------------------------------------------------------------------    
    
    
    testBracketGenerator2():() == {
	import from List DPR;
	assertFailed [ generator [ var101, var200*var101 ] ];

    }
    

    ----------------------------------------------------------------------    
    
    
    testBracketGenerator3():() == {
	import from List DPR;
	assertFailed [ generator [ var101, var211*var101 ] ];

    }
    

    ----------------------------------------------------------------------    
    
    
    testBracketGenerator4():() == {
	import from List DPR;
	local as := failSafeRetract [ generator [ var210, var110*var200, var300, var201*var202 ] ];
	assertEquals( as, [ var201*var202, var210, var110*var200, var300 ] );

    }
    

    ----------------------------------------------------------------------    
    
    
}
