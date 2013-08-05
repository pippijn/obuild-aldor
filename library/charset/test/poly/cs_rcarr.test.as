-------------------------------------------------------------------------
--
-- cs_rcarr.test.as
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
local PR    == RecursivePolynomialRingAllCoefficients( R, VARS );

TestRecursivePolynomialRingAllCoefficients: TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_rarr.test.signatures.as"

} == TestPolynomialImplementation( R, VARS, [ VAR1, VAR2, VAR3 ], PR ) add {
}