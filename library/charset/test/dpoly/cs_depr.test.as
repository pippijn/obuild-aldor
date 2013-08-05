-------------------------------------------------------------------------
--
-- cs_depr.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);
local DSYM0 == (-"s");
local DSYM1 == (-"t");
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );
local ORDER == DifferentialVariableLexicographicEliminationOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );
local DIDOM == DifferentialRational;
local PR    == RecursivePolynomialRingViaPercentArray( DIDOM, DVARS );
local DPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, DVARS, PR );


TestDifferentiallyExtendedPolynomialRing : TestCaseType with {

#include "cs_dprt.test.signatures.as"
#include "cs_depr.test.signatures.as"

} == TestDifferentialPolynomialRingType( DIDOM, VARS, DSYMS, DVARS, DPR ) add {

    import from TestCaseTools;    
    import from Array Integer;
    import from MachineInteger;
    import from Integer;
    import from DIDOM;
    import from VARS;
    import from List VARS;

    
    ----------------------------------------------------------------------

    
    testSeparantDifferentialVariableOrderlyOrderTools():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;
	import from MachineInteger;
	import from Integer;
	import from DIDOM;
	
	local OORDER == DifferentialVariableOrderlyOrderTools;
	local ODVARS == DifferentialVariable( VARS, DSYMS, OORDER );
	local OPR    == RecursivePolynomialRingViaPercentArray( DIDOM, ODVARS );
	local ODPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, ODVARS, OPR );
	
	local dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: ODVARS;
	local dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: ODVARS;
	local oVar100 := ( dvar1 :: ODPR);
	local oVar200 := ( dvar2 :: ODPR);
	local oVar110 := differentiate( oVar100, [ 1, 0 ] );
	local oVar210 := differentiate( oVar200, [ 1, 0 ] );
	local oVar101 := differentiate( oVar100, [ 0, 1 ] );
	local oVar201 := differentiate( oVar200, [ 0, 1 ] );
	local oVar120 := differentiate( oVar110, [ 1, 0 ] );
	local oVar220 := differentiate( oVar210, [ 1, 0 ] );
	local oVar111 := differentiate( oVar110, [ 0, 1 ] );
	local oVar211 := differentiate( oVar210, [ 0, 1 ] );
	local oVar102 := differentiate( oVar101, [ 0, 1 ] );
	local oVar202 := differentiate( oVar201, [ 0, 1 ] );

        assertEquals( ODPR, separant( 0 ), 0 );
        assertEquals( ODPR, separant( 1 ), 0 );
        assertEquals( ODPR, separant( oVar210 ), 1 );
        assertEquals( ODPR, separant( (3::DIDOM)*oVar210*oVar210+oVar111 ), 1 );
        assertEquals( ODPR, separant( (6::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+oVar110+oVar101 ), (18::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar110 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar102*oVar111*oVar102*oVar200 ), (8::DIDOM)*oVar102*oVar111*oVar200 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar102*oVar111*oVar102 ), (8::DIDOM)*oVar102*oVar111 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar101*oVar110*oVar200 ), (4::DIDOM)*oVar200*oVar110 );
        assertEquals( ODPR, separant( (5::DIDOM)*oVar101*oVar110 ), (5::DIDOM)*oVar110 );
    }

    
    ----------------------------------------------------------------------
    
    
    testSeparantDifferentialVariableLexicographicEliminationOrderTools():() == {

	local OORDER == DifferentialVariableLexicographicEliminationOrderTools;
	local ODVARS == DifferentialVariable( VARS, DSYMS, OORDER );
	local OPR    == RecursivePolynomialRingViaPercentArray( DIDOM, ODVARS );
	local ODPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, ODVARS, OPR );
	
	local dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: ODVARS;
	local dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: ODVARS;
	local oVar100 := ( dvar1 :: ODPR);
	local oVar200 := ( dvar2 :: ODPR);
	local oVar110 := differentiate( oVar100, [ 1, 0 ] );
	local oVar210 := differentiate( oVar200, [ 1, 0 ] );
	local oVar101 := differentiate( oVar100, [ 0, 1 ] );
	local oVar201 := differentiate( oVar200, [ 0, 1 ] );
	local oVar120 := differentiate( oVar110, [ 1, 0 ] );
	local oVar220 := differentiate( oVar210, [ 1, 0 ] );
	local oVar111 := differentiate( oVar110, [ 0, 1 ] );
	local oVar211 := differentiate( oVar210, [ 0, 1 ] );
	local oVar102 := differentiate( oVar101, [ 0, 1 ] );
	local oVar202 := differentiate( oVar201, [ 0, 1 ] );

        assertEquals( ODPR, separant( 0 ), 0 );
        assertEquals( ODPR, separant( 1 ), 0 );
        assertEquals( ODPR, separant( oVar210 ), 1 );
        assertEquals( ODPR, separant( (3::DIDOM)*oVar210*oVar210+oVar111 ), (6::DIDOM)*oVar210 );
        assertEquals( ODPR, separant( (6::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+oVar110+oVar101 ), (18::DIDOM)*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+1 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar102*oVar111*oVar102*oVar200 ), (4::DIDOM)*oVar102*oVar111*oVar102 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar102*oVar111*oVar102 ), (8::DIDOM)*oVar111*oVar102 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar101*oVar110*oVar200 ), (4::DIDOM)*oVar101*oVar110 );
        assertEquals( ODPR, separant( (5::DIDOM)*oVar101*oVar110 ), (5::DIDOM)*oVar110 );

    }

    
    ----------------------------------------------------------------------

    
    testSeparantDifferentialVariableOrderlyEliminationOrderTools():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;
	import from MachineInteger;
	import from Integer;
	import from DIDOM;
	
	local OORDER == DifferentialVariableOrderlyEliminationOrderTools;
	local ODVARS == DifferentialVariable( VARS, DSYMS, OORDER );
	local OPR    == RecursivePolynomialRingViaPercentArray( DIDOM, ODVARS );
	local ODPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, ODVARS, OPR );
	
	local dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: ODVARS;
	local dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: ODVARS;
	local oVar100 := ( dvar1 :: ODPR);
	local oVar200 := ( dvar2 :: ODPR);
	local oVar110 := differentiate( oVar100, [ 1, 0 ] );
	local oVar210 := differentiate( oVar200, [ 1, 0 ] );
	local oVar101 := differentiate( oVar100, [ 0, 1 ] );
	local oVar201 := differentiate( oVar200, [ 0, 1 ] );
	local oVar120 := differentiate( oVar110, [ 1, 0 ] );
	local oVar220 := differentiate( oVar210, [ 1, 0 ] );
	local oVar111 := differentiate( oVar110, [ 0, 1 ] );
	local oVar211 := differentiate( oVar210, [ 0, 1 ] );
	local oVar102 := differentiate( oVar101, [ 0, 1 ] );
	local oVar202 := differentiate( oVar201, [ 0, 1 ] );

        assertEquals( ODPR, separant( 0 ), 0 );
        assertEquals( ODPR, separant( 1 ), 0 );
        assertEquals( ODPR, separant( oVar210 ), 1 );
        assertEquals( ODPR, separant( (3::DIDOM)*oVar210*oVar210+oVar111 ), (6::DIDOM)*oVar210 );
        assertEquals( ODPR, separant( (6::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+oVar110+oVar101 ), (18::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar110 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar102*oVar111*oVar102*oVar200 ), (4::DIDOM)*oVar102*oVar111*oVar102 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar102*oVar111*oVar102 ), (8::DIDOM)*oVar111*oVar102 );
        assertEquals( ODPR, separant( (4::DIDOM)*oVar101*oVar110*oVar200 ), (4::DIDOM)*oVar101*oVar110 );
        assertEquals( ODPR, separant( (5::DIDOM)*oVar101*oVar110 ), (5::DIDOM)*oVar110 );
    }

    
    ----------------------------------------------------------------------

    
    testInitialDifferentialVariableOrderlyOrderTools():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;
	import from MachineInteger;
	import from Integer;
	import from DIDOM;
	
	local OORDER == DifferentialVariableOrderlyOrderTools;
	local ODVARS == DifferentialVariable( VARS, DSYMS, OORDER );
	local OPR    == RecursivePolynomialRingViaPercentArray( DIDOM, ODVARS );
	local ODPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, ODVARS, OPR );
	
	local dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: ODVARS;
	local dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: ODVARS;
	local oVar100 := ( dvar1 :: ODPR);
	local oVar200 := ( dvar2 :: ODPR);
	local oVar110 := differentiate( oVar100, [ 1, 0 ] );
	local oVar210 := differentiate( oVar200, [ 1, 0 ] );
	local oVar101 := differentiate( oVar100, [ 0, 1 ] );
	local oVar201 := differentiate( oVar200, [ 0, 1 ] );
	local oVar120 := differentiate( oVar110, [ 1, 0 ] );
	local oVar220 := differentiate( oVar210, [ 1, 0 ] );
	local oVar111 := differentiate( oVar110, [ 0, 1 ] );
	local oVar211 := differentiate( oVar210, [ 0, 1 ] );
	local oVar102 := differentiate( oVar101, [ 0, 1 ] );
	local oVar202 := differentiate( oVar201, [ 0, 1 ] );

        assertEquals( ODPR, initial( 0 ), 0 );
        assertEquals( ODPR, initial( 1 ), 1 );
        assertEquals( ODPR, initial( oVar210 ), 1 );
        assertEquals( ODPR, initial( (2::DIDOM)*oVar200*oVar210 ), (2::DIDOM)*oVar200 );
        assertEquals( ODPR, initial( (3::DIDOM)*oVar210*oVar210+oVar111 ), 1 );
        assertEquals( ODPR, initial( (6::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+oVar110+oVar101 ), (6::DIDOM)*oVar101*oVar101*oVar101*oVar110 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar102*oVar111*oVar102*oVar200 ), (4::DIDOM)*oVar111*oVar200 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar102*oVar111*oVar102 ), (4::DIDOM)*oVar111 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar101*oVar110*oVar200 ), (4::DIDOM)*oVar200*oVar110 );
        assertEquals( ODPR, initial( (5::DIDOM)*oVar101*oVar110 ), (5::DIDOM)*oVar110 );
    }

    
    ----------------------------------------------------------------------
    
    
    testInitialDifferentialVariableLexicographicEliminationOrderTools():() == {

	local OORDER == DifferentialVariableLexicographicEliminationOrderTools;
	local ODVARS == DifferentialVariable( VARS, DSYMS, OORDER );
	local OPR    == RecursivePolynomialRingViaPercentArray( DIDOM, ODVARS );
	local ODPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, ODVARS, OPR );
	
	local dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: ODVARS;
	local dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: ODVARS;
	local oVar100 := ( dvar1 :: ODPR);
	local oVar200 := ( dvar2 :: ODPR);
	local oVar110 := differentiate( oVar100, [ 1, 0 ] );
	local oVar210 := differentiate( oVar200, [ 1, 0 ] );
	local oVar101 := differentiate( oVar100, [ 0, 1 ] );
	local oVar201 := differentiate( oVar200, [ 0, 1 ] );
	local oVar120 := differentiate( oVar110, [ 1, 0 ] );
	local oVar220 := differentiate( oVar210, [ 1, 0 ] );
	local oVar111 := differentiate( oVar110, [ 0, 1 ] );
	local oVar211 := differentiate( oVar210, [ 0, 1 ] );
	local oVar102 := differentiate( oVar101, [ 0, 1 ] );
	local oVar202 := differentiate( oVar201, [ 0, 1 ] );

        assertEquals( ODPR, initial( 0 ), 0 );
        assertEquals( ODPR, initial( 1 ), 1 );
        assertEquals( ODPR, initial( oVar210 ), 1 );
        assertEquals( ODPR, initial( (3::DIDOM)*oVar210*oVar210+oVar111 ), (3::DIDOM)::ODPR );
        assertEquals( ODPR, initial( (6::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+oVar110+oVar101 ), (6::DIDOM)*oVar120*oVar120*oVar120*oVar110 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar102*oVar111*oVar102*oVar200 ), (4::DIDOM)*oVar102*oVar111*oVar102 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar102*oVar111*oVar102 ), (4::DIDOM)*oVar111 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar101*oVar110*oVar200 ), (4::DIDOM)*oVar101*oVar110 );
        assertEquals( ODPR, initial( (5::DIDOM)*oVar101*oVar110 ), (5::DIDOM)*oVar110 );

    }

    
    ----------------------------------------------------------------------
    
    testInitialDifferentialVariableOrderlyEliminationOrderTools():() == {
	import from VARS;
	import from List VARS;
	import from Array Integer;
	import from MachineInteger;
	import from Integer;
	import from DIDOM;
	
	local OORDER == DifferentialVariableOrderlyEliminationOrderTools;
	local ODVARS == DifferentialVariable( VARS, DSYMS, OORDER );
	local OPR    == RecursivePolynomialRingViaPercentArray( DIDOM, ODVARS );
	local ODPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, ODVARS, OPR );
	
	local dvar1 := (minToMax$VARS).(firstIndex$(List VARS)) :: ODVARS;
	local dvar2 := (minToMax$VARS).(firstIndex$(List VARS) + 1) :: ODVARS;
	local oVar100 := ( dvar1 :: ODPR);
	local oVar200 := ( dvar2 :: ODPR);
	local oVar110 := differentiate( oVar100, [ 1, 0 ] );
	local oVar210 := differentiate( oVar200, [ 1, 0 ] );
	local oVar101 := differentiate( oVar100, [ 0, 1 ] );
	local oVar201 := differentiate( oVar200, [ 0, 1 ] );
	local oVar120 := differentiate( oVar110, [ 1, 0 ] );
	local oVar220 := differentiate( oVar210, [ 1, 0 ] );
	local oVar111 := differentiate( oVar110, [ 0, 1 ] );
	local oVar211 := differentiate( oVar210, [ 0, 1 ] );
	local oVar102 := differentiate( oVar101, [ 0, 1 ] );
	local oVar202 := differentiate( oVar201, [ 0, 1 ] );

        assertEquals( ODPR, initial( 0 ), 0 );
        assertEquals( ODPR, initial( 1 ), 1 );
        assertEquals( ODPR, initial( oVar210 ), 1 );
        assertEquals( ODPR, initial( (3::DIDOM)*oVar210*oVar210+oVar111 ), (3::DIDOM)::ODPR );
        assertEquals( ODPR, initial( (6::DIDOM)*oVar101*oVar101*oVar101*oVar120*oVar120*oVar120*oVar110+oVar110+oVar101 ), (6::DIDOM)*oVar101*oVar101*oVar101*oVar110 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar102*oVar111*oVar102*oVar200 ), (4::DIDOM)*oVar102*oVar111*oVar102 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar102*oVar111*oVar102 ), (4::DIDOM)*oVar111 );
        assertEquals( ODPR, initial( (4::DIDOM)*oVar101*oVar110*oVar200 ), (4::DIDOM)*oVar101*oVar110 );
        assertEquals( ODPR, initial( (5::DIDOM)*oVar101*oVar110 ), (5::DIDOM)*oVar110 );
    }

    
    ----------------------------------------------------------------------
    

    
}