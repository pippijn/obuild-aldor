-------------------------------------------------------------------------
--
-- cs_red.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;


TestReductionTools(
  T: PrimitiveType, 
  RT : ReductionType T
) : TestCaseType with {

    reduced?Tester: ( T, T, Boolean ) -> ();
    reduceTester: ( T, T, T ) -> ();
#include "cs_red.test.signatures.as"

} == add {
    

    import from TestCaseTools;
    import from RT;

    ----------------------------------------------------------------------    

    defineAsserts( T );

    ----------------------------------------------------------------------    

    reduced?Tester( a: T, b: T, red?: Boolean ):() == {
	
	local assertFunc: ( Boolean ) -> () throw AldorUnitFailedExceptionType;
	
	if red? then
	{
	    assertFunc := assertTrue;
	} else {
	    assertFunc := assertFalse;
	}
	assertFunc reduced?( a, b );
	assertFunc( (reducedBy? b)(a) );
    }
       
    ----------------------------------------------------------------------    

    reduceTester( a: T, b: T, res: T ):() == {	
	assertEquals( reduce( a, b ), res );
	assertEquals( ( reduceBy b ) a, res );
    }
    
    ----------------------------------------------------------------------    

}