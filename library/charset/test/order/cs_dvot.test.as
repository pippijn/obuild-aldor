-------------------------------------------------------------------------
--
-- cs_dvot.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;


TestDifferentialVariableOrderToolsType(
  VARS  : FiniteVariableType, 
  ORDER : DifferentialVariableOrderToolsType,
  DVARS : DifferentialVariableType( VARS ),
  DVARSLIST : List DVARS
) : TestCaseType with {

#include "cs_dvot.test.signatures.as"

} == add {

	import from TestCaseTools;
	import from MachineInteger;
	import from DVARS;
	
	----------------------------------------------------------------------
	

	assertLess(left: DVARS, right:DVARS):() throw AldorUnitFailedExceptionType == {
	      import from Character;
	      import from ORDER;
	      dbgout << "assertLess( " << left << ", " << right << " ) ";

	      if (<( VARS, DVARS ))( left, right ) then 
	      {
		  dbgout << "succeeded" << newline;
	      } else {
		  dbgout << "failed" << newline;
		  fail "assertLess does not hold";
	      }
        }


	----------------------------------------------------------------------
	

	assertNotLess(left: DVARS, right:DVARS):() throw AldorUnitFailedExceptionType == {
	      import from Character;
	      import from ORDER;
	      dbgout << "assertNotLess( " << left << ", " << right << " ) ";

	      if (<( VARS, DVARS ))( left, right ) then 
	      {
		  dbgout << "failed" << newline;
		  fail "assertNotLess does not hold";
	      } else {
		  dbgout << "succeeded" << newline;
	      }
        }


	----------------------------------------------------------------------
	

        +++ Description: checkPosition( idx ) verifies that 
	+++   | DVARSLIST . idx is less than all succeding elements
	+++   | in DVARSLIST. If this fails, the calling test fails
	checkPosition( idx: MachineInteger ):() == {
	      import from List DVARS;
	      import from MachineInteger;

	      assertTrue( (firstIndex$(List DVARS)) <= idx );
	      assertTrue( idx < (firstIndex$(List DVARS)) + prev # DVARSLIST  );
	      for otherIdx in ( next idx ) .. (firstIndex$(List DVARS)) + prev # DVARSLIST repeat 
	      {
		  assertLess( DVARSLIST . idx, DVARSLIST . otherIdx );
		  assertNotLess( DVARSLIST . otherIdx, DVARSLIST . idx );
	      }
	}


	----------------------------------------------------------------------

	testOrder():() == {
	    import from List DVARS;
	    
	    if # DVARSLIST >= 2 then
	    {
		for otherIdx in firstIndex$(List DVARS) .. prev( firstIndex$(List DVARS) ) + prev # DVARSLIST repeat 
		{
		    checkPosition( otherIdx );
		} 
		();
	    } else {
		    fail "Less than two variables are supplied to the test";
		}
	}

	----------------------------------------------------------------------

}
