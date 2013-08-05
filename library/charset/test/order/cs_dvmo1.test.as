-------------------------------------------------------------------------
--
-- cs_dvmo.test.as
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
import from List Cross( DifferentialVariableOrderToolsType, Integer );

local VARS == OrderedVariableList(reverse! [ -"x", -"y", -"z", -"a" ] );
local DSYMS == (bracket$(Array Symbol)) ( -"s", -"t" );
local ORDER == DifferentialVariableMixedOrderTools( [
  ( DifferentialVariableLexicographicOrderTools, 2 ),
  ( DifferentialVariableLexicographicOrderTools, 2 )
] );
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
    local z   : DVARS == variable( 3, [ 0, 0 ] );
    local zs  : DVARS == variable( 3, [ 1, 0 ] );
    local zt  : DVARS == variable( 3, [ 0, 1 ] );
    local zss : DVARS == variable( 3, [ 2, 0 ] );
    local zst : DVARS == variable( 3, [ 1, 1 ] );
    local ztt : DVARS == variable( 3, [ 0, 2 ] );
    local a   : DVARS == variable( 4, [ 0, 0 ] );
    local as  : DVARS == variable( 4, [ 1, 0 ] );
    local at  : DVARS == variable( 4, [ 0, 1 ] );
    local ass : DVARS == variable( 4, [ 2, 0 ] );
    local ast : DVARS == variable( 4, [ 1, 1 ] );
    local att : DVARS == variable( 4, [ 0, 2 ] );
    [ x, y, xs, ys, xss, yss, xt, yt, xst, yst, xtt, ytt, 
      z, a, zs, as, zss, ass, zt, at, zst, ast, ztt, att
    ]$(List DVARS);
}



TestDifferentialVariableMixedOrderTools1: TestCaseType with {

#include "cs_dvmo1.test.signatures.as"
#include "cs_dvot.test.signatures.as"

} == TestDifferentialVariableOrderToolsType( VARS, ORDER, DVARS, DVARSLIST ) add {
    
};

