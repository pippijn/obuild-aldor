#include "charset"

import from String, Symbol, List Symbol;

--R is the coefficient domain for the polynomials
local R == AldorInteger2;

--the indeterminates for the polynomial ring
local VARS  == OrderedVariableList( [ ( - "y2" ), ( - "y1" ) ] );

--the terms for the polynomial ring
local EXP == ListSortedExponent( VARS );

--PPR denotes the plain algebraic polynomial ring without a gcd 
--  algorithm
local PPR == DistributedMultivariatePolynomial1( R, VARS, EXP );

--adding a Ranking
local CPR == DistributivePolynomialRingLeadingTermOrderExtension( 
  R, VARS, EXP, PPR );

--lifting to Integral Domain
local OPR == DistributivePolynomialRingIntegralDomainExtension( 
  R, VARS, EXP, CPR );

local OPRRT == PseudoRemainderReductionTools( R, VARS, OPR );

--EPR holds the polynomail ring with GcdDomain
local GPR == PolynomialRingSubResultantPRSGcdDomainExtension( 
  R, VARS, OPR, OPRRT );

import from List VARS;
import from MachineInteger;
import from Integer;
import from VARS;
import from GPR;

local y1: GPR := (minToMax$VARS) . 1 :: GPR;
local y2: GPR := (minToMax$VARS) . 2 :: GPR;

local p: GPR := (4::GPR)*( y1 + y2 )*( y1 + (5::GPR)*y2*y2 );
local q: GPR := (6::GPR)*     y2    *( y1 + (5::GPR)*y2*y2 );

import from TextWriter, Character, StreamFormatter;

stdout << "p " << newline;
stdout << "  " << p << newline << newline;
stdout << "q " << newline;
stdout << "  " << q << newline << newline;
stdout << "gcd( p, q ) " << newline;
stdout << "  " << ( gcd( p, q ) ) << newline << newline;
