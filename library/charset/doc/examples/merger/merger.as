#include "charset"

import from String, Symbol, List Symbol;

--the algebraic indeterminates
local VARS1  == OrderedVariableList( [ ( - "y2" ), ( - "y1" ) ] );

import from VariableMergerTools;
import from Integer;

local ( VARS2: FiniteVariableType, 
  VARS12: MergedVariableType( VARS1, VARS2 ) ) 
  == extension( VARS1, 3 );

import from List VARS1;
import from List VARS2;
import from MachineInteger;
import from TextWriter;
import from Character;


stdout << "VARS1 " << newline;
stdout << "  " <<  (minToMax$VARS1) << newline << newline;
stdout << "VARS2 " << newline;
stdout << "  " <<  (minToMax$VARS2) << newline << newline;

local someVar: VARS12 := ((variable$VARS2)( 2 )) :: VARS12;
stdout << "someVar " << someVar << newline;
stdout << "  from VARS1: " <<  (isFromVar1? someVar) << newline;
stdout << "  from VARS2: " <<  (isFromVar2? someVar) << newline;
