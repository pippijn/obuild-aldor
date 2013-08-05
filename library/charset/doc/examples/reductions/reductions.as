#include "charset"

import from String;
import from Symbol;
import from List Symbol;
local R == Fraction AldorInteger2;
local VAR1  == (-"u");
local VAR2  == (-"v");
local VAR3  == (-"x");
local VAR4  == (-"y");
local VARS  == OrderedVariableList( [ VAR4, VAR3, VAR2, VAR1 ]);	
local EXP   == ListSortedExponent( VARS );
local PR    == DistributedMultivariatePolynomial1( R, VARS, EXP );
local OPR   == DistributivePolynomialRingLeadingTermOrderExtension(
  R, VARS, EXP, PR );

local PREM  == PseudoRemainderReductionTools( R, VARS, OPR );
local PRWD  == PolynomialReductionWithoutDivisionTools(
  R, VARS, EXP, OPR );
local PRED  == PolynomialReductionTools( R, VARS, EXP, OPR );

import from VARS;
import from Partial VARS;
local u := ( retract variable ( VAR1 ) ) :: OPR;
local v := ( retract variable ( VAR2 ) ) :: OPR;
local x := ( retract variable ( VAR3 ) ) :: OPR;
local y := ( retract variable ( VAR4 ) ) :: OPR;

import from TextWriter;
import from Character;
import from Integer;

local p:OPR := (4::OPR)*u*x*y+2::OPR;
local q:OPR := (3::OPR)*x*y+(2::OPR)*v*y+(4::OPR);

stdout << "p " << p << newline;
stdout << "q " << q << newline;
stdout << "PseudoRemainderReductionTools:" <<newline;
stdout << "  " << ((reduce$PREM)( p, q )) << newline;
stdout << "PolynomialReductionWithoutDivisionTools:" <<newline;
stdout << "  " << ((reduce$PRWD)( p, q )) << newline;
stdout << "PolynomialReductionTools:" <<newline;
stdout << "  " << ((reduce$PRED)( p, q )) << newline;
