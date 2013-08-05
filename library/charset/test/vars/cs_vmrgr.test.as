-------------------------------------------------------------------------
--
-- cs_vmrgr.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;
local VAR11  == (-"y1");
local VAR12  == (-"y2");
local VAR13  == (-"y3");
local VARS1  == OrderedVariableList(reverse! [ VAR11, VAR12, VAR13 ]);	
local VAR21  == (-"y4");
local VAR22  == (-"y5");
local VAR23  == (-"y6");
local VARS2  == OrderedVariableList2(reverse! [ VAR21, VAR22, VAR23 ] );
--local VARS2  == OrderedVariableTuple( VAR23, VAR22, VAR21 );	
local VARS12 == VariableMerger( VARS1, VARS2 );

TestVariableMerger: TestCaseType with {

#include "cs_vmrgr.test.signatures.as"

} == add {

    import from TestCaseTools;
    import from VARS1;
    import from VARS2;
    import from VARS12;     
    
    ------------------------------------
    
    defineAsserts( VARS1 );
    defineAsserts( VARS2 );
    defineAsserts( VARS12 );
    defineAsserts( Symbol );

    ------------------------------------

    local var11: VARS1;
    local var12: VARS1;
    local var13: VARS1;
    local var21: VARS2;
    local var22: VARS2;
    local var23: VARS2;
    local var121: VARS12;
    local var122: VARS12;
    local var123: VARS12;
    local var124: VARS12;
    local var125: VARS12;
    local var126: VARS12;
    ------------------------------------

    setUp(): () == {
      import from Partial VARS1;
      import from Partial VARS2;
      free var11 := failSafeRetract variable VAR11;
      free var12 := failSafeRetract variable VAR12;
      free var13 := failSafeRetract variable VAR13;
      free var21 := failSafeRetract variable VAR21;
      free var22 := failSafeRetract variable VAR22;
      free var23 := failSafeRetract variable VAR23;

      free var121 := coerce var11;
      free var122 := coerce var12;
      free var123 := coerce var13;
      free var124 := coerce var21;
      free var125 := coerce var22;
      free var126 := coerce var23;
    }
    
    ------------------------------------
 
    testEquals(): () == {
	assertEquals( var121, var121 );
	assertEquals( var122, var122 );
	assertEquals( var123, var123 );
	assertEquals( var124, var124 );
	assertEquals( var125, var125 );
	assertEquals( var126, var126 );

	assertNotEquals( var121, var126 );
	assertNotEquals( var122, var121 );
	assertNotEquals( var123, var122 );
	assertNotEquals( var124, var123 );
	assertNotEquals( var125, var124 );
	assertNotEquals( var126, var125 );	
    }

    ------------------------------------

    testCoerce(): () == {
	assertEquals( coerce var121, var11 );
	assertEquals( coerce var122, var12 );
	assertEquals( coerce var123, var13 );
	assertEquals( coerce var124, var21 );
	assertEquals( coerce var125, var22 );
	assertEquals( coerce var126, var23 );
    }
    
    ------------------------------------
 
    testIsFromVar1?(): () == {
	assertTrue isFromVar1? var121;
	assertTrue isFromVar1? var122;
	assertTrue isFromVar1? var123;
	assertFalse isFromVar1? var124;
	assertFalse isFromVar1? var125;
	assertFalse isFromVar1? var126;
    }
    
    ------------------------------------
 
    testIsFromVar2?(): () == {
	assertFalse isFromVar2? var121;
	assertFalse isFromVar2? var122;
	assertFalse isFromVar2? var123;
	assertTrue isFromVar2? var124;
	assertTrue isFromVar2? var125;
	assertTrue isFromVar2? var126;
    }
    
    ------------------------------------
 
    testSymbol(): () == {
	assertEquals( symbol var121, VAR11 );
	assertEquals( symbol var122, VAR12 );
	assertEquals( symbol var123, VAR13 );
	assertEquals( symbol var124, VAR21 );
	assertEquals( symbol var125, VAR22 );
	assertEquals( symbol var126, VAR23 );
    }
    
    ------------------------------------
 
    testVariable(): () == {
	assertEquals( failSafeRetract variable VAR11, var121 );
	assertEquals( failSafeRetract variable VAR12, var122 );
	assertEquals( failSafeRetract variable VAR13, var123 );
	assertEquals( failSafeRetract variable VAR21, var124 );
	assertEquals( failSafeRetract variable VAR22, var125 );
	assertEquals( failSafeRetract variable VAR23, var126 );
	assertFailed( (variable$VARS12)( - "notExistingVariable" ) );
    }
    
    ------------------------------------

    testOrderVar121(): () == {
	assertFalse( var121 < var121 );
	assertTrue( var121 < var122 );
	assertTrue( var121 < var123 );
	assertTrue( var121 < var124 );
	assertTrue( var121 < var125 );
	assertTrue( var121 < var126 );
    }
    
    ------------------------------------

    testOrderVar122(): () == {
	assertFalse( var122 < var121 );
	assertFalse( var122 < var122 );
	assertTrue( var122 < var123 );
	assertTrue( var122 < var124 );
	assertTrue( var122 < var125 );
	assertTrue( var122 < var126 );
    }
    
    ------------------------------------

    testOrderVar123(): () == {
	assertFalse( var123 < var121 );
	assertFalse( var123 < var122 );
	assertFalse( var123 < var123 );
	assertTrue( var123 < var124 );
	assertTrue( var123 < var125 );
	assertTrue( var123 < var126 );
    }
    
    ------------------------------------

    testOrderVar124(): () == {
	assertFalse( var124 < var121 );
	assertFalse( var124 < var122 );
	assertFalse( var124 < var123 );
	assertFalse( var124 < var124 );
	assertTrue( var124 < var125 );
	assertTrue( var124 < var126 );
    }
    
    ------------------------------------
    
    testOrderVar125(): () == {
	assertFalse( var125 < var121 );
	assertFalse( var125 < var122 );
	assertFalse( var125 < var123 );
	assertFalse( var125 < var124 );
	assertFalse( var125 < var125 );
	assertTrue( var125 < var126 );
    }
    
    ------------------------------------

    testOrderVar126(): () == {
	assertFalse( var126 < var121 );
	assertFalse( var126 < var122 );
	assertFalse( var126 < var123 );
	assertFalse( var126 < var124 );
	assertFalse( var126 < var125 );
	assertFalse( var126 < var126 );
    }
    
    ------------------------------------

}