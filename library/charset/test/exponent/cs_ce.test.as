-------------------------------------------------------------------------
--
-- cs_cumde.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);
local DSYM0 == (-"s");
local DSYM1 == (-"t");
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );
local ORDER == DifferentialVariableLexicographicEliminationOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );
local EXP == CumulatedExponent( DVARS );
    
TestCumulatedExponent : TestCaseType with {

#include "cs_ce.test.signatures.as"
#include "cs_et.test.signatures.as"

} == TestExponentType( VARS, DSYMS, DVARS, EXP ) add {
   
}
