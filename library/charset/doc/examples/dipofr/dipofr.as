#include "charset"

import from String, Symbol, List Symbol;
import from TextWriter, Character, Integer;

local SYM1 == ( - "y1" );
local SYM2 == ( - "y2" );
local PR  == DifferentialPolynomialFractionRing( 
  AldorInteger2, [ SYM1, SYM2 ] );

import from PR, List PR, MachineInteger;

local y1: PR := variables() . 1;
local y2: PR := variables() . 2;

local p: PR := (3*y1*y1*y1)/(5*(y2+y1)*y1);

stdout << "p" << newline;
stdout << "  " << p << newline;
stdout << "p differentiated with respect to y1" << newline;
stdout << "  " << derivationFunction( SYM1 )( p ) << newline;
