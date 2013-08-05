-------------------------------------------------------------------------
--
-- cs_dvleo.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;
import from Integer;
import from Array Integer;

local VARS == OrderedVariableList(reverse! [-"x",-"y"]);
local DSYMS == (bracket$(Array Symbol)) ( -"s", -"t" );
local ORDER == DifferentialVariableLexicographicOrderTools;
local DVARS == DifferentialVariable( VARS, DSYMS, ORDER );
import from DVARS;

local  DVARSLIST == {
    local x   : DVARS == variable( 1, [ 0, 0 ] );
    local xs  : DVARS == variable( 1, [ 1, 0 ] );
    local xt  : DVARS == variable( 1, [ 0, 1 ] );
    local xss : DVARS == variable( 1, [ 2, 0 ] );
    local xst : DVARS == variable( 1, [ 1, 1 ] );
    local xtt : DVARS == variable( 1, [ 0, 2 ] );
    local y   : DVARS == variable( 2, [ 0, 0 ] );
    local ys  : DVARS == variable( 2, [ 1, 0 ] );
    local yt  : DVARS == variable( 2, [ 0, 1 ] );
    local yss : DVARS == variable( 2, [ 2, 0 ] );
    local yst : DVARS == variable( 2, [ 1, 1 ] );
    local ytt : DVARS == variable( 2, [ 0, 2 ] );
    [ x, y, xs, ys, xss, yss, xt, yt, xst, yst, xtt, ytt ]$(List DVARS);
}



TestDifferentialVariableLexicographicOrderTools : TestCaseType with {

#include "cs_dvlo.test.signatures.as"
#include "cs_dvot.test.signatures.as"

} == TestDifferentialVariableOrderToolsType( VARS, ORDER, DVARS, DVARSLIST ) add {
    
};

