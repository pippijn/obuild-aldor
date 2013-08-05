-------------------------------------------------------------------------
--
-- cs_dpidr.test.as
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
local EXP == ListSortedExponent( VARS );
local PPR == DistributedMultivariatePolynomial1( R, VARS, EXP );
local CPR == DistributivePolynomialRingLeadingTermOrderExtension( R, VARS, EXP, PPR );
local OPR == DistributivePolynomialRingIntegralDomainExtension( R, VARS, EXP, CPR );

TestDistributivePolynomialRingIntegralDomainExtensionRing: TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"
#include "cs_dpidt.test.signatures.as"
#include "cs_dpidr.test.signatures.as"
     
} == TestDistributivePolynomialRingIntegralDomainExtension( R, VARS, [ VAR1, VAR2, VAR3 ], EXP, CPR, OPR ) 
add {
    
    ------------------------------------
    
}