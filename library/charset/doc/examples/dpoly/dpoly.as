#include "charset"

import from String, Symbol, List Symbol;

--DIDOM is the coefficient domain for the polynomials
local DIDOM == DifferentialRational;

local VARS  == OrderedVariableList( [ ( - "y2" ), ( - "y1" ) ] );
local DSYM0 == ( - "s" );
local DSYM1 == ( - "t" );
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );
local ORDER == DifferentialVariableLexicographicEliminationOrderTools;

--DVARS holds the differential indeterminates
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );


--PR denotes the algebraic polynomial ring
local PR    == RecursivePolynomialRingViaPercentArray( DIDOM, DVARS );

--DPR is the differential polynomial ring
local DPR   == DifferentiallyExtendedPolynomialRing( DIDOM, VARS, 
  DVARS, PR );

import from List VARS;
import from MachineInteger;
import from Integer;
import from DVARS;
import from DPR;

local y1: DPR := (minToMax$VARS) . 1 :: DVARS :: DPR;
local y2: DPR := (minToMax$VARS) . 2 :: DVARS :: DPR;

local p: DPR := (4::DPR)*differentiate( y1, DSYM0 )*y1*y2+2::DPR;

import from TextWriter, Character, StreamFormatter;

stdout << "p " << newline;
stdout << "  " << p << newline << newline;
stdout << "p differentiated w.r.t. " << DSYM0 <<newline;
lineBreaker( stdout, 70 ) 
  << "  " << ( differentiate( p, DSYM0 ) ) << newline
  << newline;
stdout << "p differentiated w.r.t. " << DSYM1 <<newline;
lineBreaker( stdout, 70 ) 
  << "  " << ( differentiate( p, DSYM1 ) ) << newline
  << newline;
