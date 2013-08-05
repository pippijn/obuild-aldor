#include "charset"

import from String, Symbol, List Symbol;

--the algebraic indeterminates
local VARS  == OrderedVariableList( [ ( - "y2" ), ( - "y1" ) ] );

--symbols for the derivations
local DSYM0 == ( - "s" );
local DSYM1 == ( - "t" );
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );

--the order of the differential indeterminates
local ORDER == DifferentialVariableLexicographicEliminationOrderTools;

--DVARS holds the differential indeterminates
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );

import from MachineInteger;
import from List VARS;
import from TextWriter;
import from Character;
import from Integer;
import from Array Integer;

local y1: DVARS := variable( 1, [ 0, 0 ] );
local y2stt: DVARS := variable( 2, [ 1, 2 ] );

stdout << "y1 " << newline;
stdout << "  " << y1 << newline << newline;
stdout << "differentiate y1 once w.r.t. t and twice w.r.t. s" 
  << newline;
stdout << "  " 
  << ( differentiate( differentiate( y1, DSYM1 ), DSYM0, 2 ) ) 
  << newline << newline;
stdout << "or equivalently" << newline;
stdout << "  " 
  << ( differentiate( differentiate( y1, 1, 1 ), 0, 2 ) ) 
    << newline << newline;
stdout << "or equivalently" << newline;
stdout << "  " << ( differentiate( y1, [ 2, 1 ] ) ) 
  << newline << newline;
stdout << "The order of y2stt" << newline;
stdout << "  "  << ( order y2stt ) << newline << newline;
