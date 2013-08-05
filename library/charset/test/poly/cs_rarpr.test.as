-------------------------------------------------------------------------
--
-- cs_plain.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;
local R == AldorInteger2;
local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableListWithProperHash( reverse! [ VAR1, VAR2, VAR3 ] );
local EXP   == MachineIntegerLexicographicalExponent( VARS );
local PR: PolynomialRing0( R, VARS )    == DistributedMultivariatePolynomial1( R, VARS, EXP );
local DPR   == RecursivePolynomialRingViaPolynomialRingArray( R, VARS, PR );

TestRecursivePolynomialRingViaPolynomialRingArray: TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_rarpr.test.signatures.as"

} == TestPolynomialWrapper( R, VARS, [ VAR1, VAR2, VAR3 ], PR, DPR ) add {
}