#include "charset"

import from String, Symbol, List Symbol;
import from TextWriter, Character, Integer;
import from List Cross( 
  DifferentialVariableOrderToolsType, Integer );

--the algebraic indeterminates
local VARS  == OrderedVariableList( [ ( - "y2" ), ( - "y1" ) ] );

--symbols for the derivations
local DSYM0 == ( - "s" );
local DSYM1 == ( - "t" );
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );

process( ORDER: DifferentialVariableOrderToolsType ): () == {
  --DVARS holds the differential indeterminates
    local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );

    import from DVARS;
    import from List DVARS;
    import from Array Integer;
    import from Trace;
    import from MachineInteger;
    
    local vars: List DVARS := sort!( [ 
variable( 1, [ 0, 0 ] ), variable( 1, [ 0, 1 ] ),
variable( 1, [ 1, 0 ] ), variable( 1, [ 1, 1 ] ),
variable( 1, [ 2, 0 ] ), variable( 2, [ 0, 0 ] ),
variable( 2, [ 0, 1 ] ), variable( 2, [ 1, 0 ] ),
variable( 2, [ 1, 1 ] ), variable( 2, [ 2, 0 ] )
	] );

      stdout << (shortName ORDER) <<  ":" << newline;
      for start in 1 .. # vars by 3 repeat { 
	  for idx in start .. start + 2 | idx <= # vars repeat { 
	      stdout << " " << (vars . idx) << "   ";
	  }
	  stdout << newline; 
      }
}

process( DifferentialVariableLexicographicEliminationOrderTools );
process( DifferentialVariableOrderlyEliminationOrderTools);
process( DifferentialVariableLexicographicOrderTools);
process( DifferentialVariableOrderlyOrderTools);
process( DifferentialVariableMixedOrderTools [ 
  ( DifferentialVariableLexicographicEliminationOrderTools , 1 ), 
  ( DifferentialVariableOrderlyEliminationOrderTools, 1 ) ] );
