-------------------------------------------------------------------------
--
-- cs_polyi.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

TestPolynomialWrapper(
  R: with{ 
      CommutativeRing; 
      CopyableType;
      CharacteristicZero;
  },
  VARS: VariableType,
  VARSYMS: List Symbol,
  OPR: PolynomialRing0( R, VARS ),  -- the wrapped polynomial ring
  EPR: PolynomialRing0( R, VARS )
  with {                       -- the new polynomial ring
      
      coerce: % -> OPR;
      coerce: OPR -> %;
  }
): TestCaseType with {

#include "cs_polyi.test.signatures.as"
#include "cs_polyw.test.signatures.as"

} == TestPolynomialImplementation( R, VARS, VARSYMS, EPR ) add {

    import from TestCaseTools;
    import from Integer;
    import from OPR;
    import from EPR;
    import from R; 
    
    local oy1: OPR;    
    local oy2: OPR;
    local oy3: OPR;
    local ey1: EPR;    
    local ey2: EPR;
    local ey3: EPR;
    
    setUpCoerce(): () == {
	import from MachineInteger;
	defineAsserts( VARS );
	assertTrue( # VARSYMS >= 3 );
	local cvar1: VARS := failSafeRetract variable ( VARSYMS . 1 );
	local cvar2: VARS := failSafeRetract variable ( VARSYMS . 2 );
	local cvar3: VARS := failSafeRetract variable ( VARSYMS . 3 );
	assertTrue( cvar1 < cvar2 );
	assertTrue( cvar2 < cvar3 );
	free oy1 := cvar1 :: OPR;
	free oy2 := cvar2 :: OPR;
	free oy3 := cvar3 :: OPR;
	free ey1 := cvar1 :: EPR;
	free ey2 := cvar2 :: EPR;
	free ey3 := cvar3 :: EPR;
    }
    
    ------------------------------------

    testCoerce1():() == {
	setUpCoerce();
	local orp: OPR := (2::R)*oy1;
	local orq: OPR := oy1*oy2+(6::R)*oy3;
	local orr: OPR := oy3+(4::OPR); 
	local exp: EPR := (2::R)*ey1;
	local exq: EPR := ey1*ey2+(6::R)*ey3;
	local exr: EPR := ey3+(4::EPR); 
	assertEquals( OPR, coerce exp, orp );
	assertEquals( OPR, coerce exq, orq );
	assertEquals( OPR, coerce exr, orr );
	assertEquals( EPR, coerce orp, exp );
	assertEquals( EPR, coerce orq, exq );
	assertEquals( EPR, coerce orr, exr );
	assertEquals( OPR, coerce( exp * exq ), orp * orq );
	assertEquals( EPR, coerce( orp * orq ), exp * exq );
	assertEquals( OPR, coerce( exp * exq + exr ), orp * orq + orr );
	assertEquals( EPR, coerce( orp * orq + orr ), exp * exq + exr );
    }

    ------------------------------------

    testCoerce2():() == {
	setUpCoerce();
	local orp: OPR := (2::R)*oy1;
	local orq: OPR := 0;
	local orr: OPR := oy2*oy3+oy1*(3::OPR); 
	local exp: EPR := (2::R)*ey1;
	local exq: EPR := 0;
	local exr: EPR := ey2*ey3+ey1*(3::EPR); 
	assertEquals( OPR, coerce exp, orp );
	assertEquals( OPR, coerce exq, orq );
	assertEquals( OPR, coerce exr, orr );
	assertEquals( EPR, coerce orp, exp );
	assertEquals( EPR, coerce orq, exq );
	assertEquals( EPR, coerce orr, exr );
	assertEquals( OPR, coerce( exp * exq ), orp * orq );
	assertEquals( EPR, coerce( orp * orq ), exp * exq );
	assertEquals( OPR, coerce( exp * exq + exr ), orp * orq + orr );
	assertEquals( EPR, coerce( orp * orq + orr ), exp * exq + exr );
    }

    ------------------------------------

}