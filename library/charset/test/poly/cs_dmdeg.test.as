-------------------------------------------------------------------------
--
-- cs_dmdeg.test.as
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
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);	
local EXP   == MachineIntegerLexicographicalExponent( VARS );
local OPR: PolynomialRing0( R, VARS )    == DistributedMultivariatePolynomial1( R, VARS, EXP );
local EPR   == PolynomialRingWithMainVariableAndDegree( R, VARS, OPR );

TestPolynomialRingWithMainVariableAndDegree: TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_dmdeg.test.signatures.as"

} == TestPolynomialWrapper( R, VARS, [ VAR1, VAR2, VAR3 ], OPR, EPR ) add {
}