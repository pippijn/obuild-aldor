-------------------------------------------------------------------------
--
-- cs_pre0.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

local DFLD == DifferentialRational;
local VAR1  == (-"y1");
local VAR2  == (-"y2");
local VAR3  == (-"y3");
local VARS  == OrderedVariableList(reverse! [ VAR1, VAR2, VAR3 ]);
local DSYM0 == (-"s");
local DSYM1 == (-"t");
local DSYMS == (bracket$(Array Symbol)) ( DSYM0, DSYM1 );



local ORDER == DifferentialVariableOrderlyOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );
local EXP   == SortedListExponent( DVARS );
local PR    == DistributedMultivariatePolynomial1( DFLD, DVARS, EXP);
local DPR   == DifferentiallyExtendedDistributivePolynomialRing( DFLD, VARS, DVARS, EXP, PR );
local RT    == PolynomialReductionTools( DFLD, DVARS, EXP, DPR );

import from Integer;
import from Array Integer;
import from DPR;
import from Array DPR;
import from DVARS;
local VARP == [ variable( 1, [ 0, 0 ] ) :: DPR, variable( 2, [ 0, 0 ] ) :: DPR, variable( 3, [ 0, 0 ] ) :: DPR, variable( 3, [ 1, 0 ] ) :: DPR ];

TestPolynomialReductionTools0 : TestCaseType with {

#include "cs_pred.test.signatures.as"
#include "cs_pre0.test.signatures.as"

} == 
TestPolynomialReductionTools( DFLD, DVARS, DPR, RT, VARP ) 
add {
  
    ----------------------------------------------------------------------    

        
    ----------------------------------------------------------------------    

    
}
