-------------------------------------------------------------------
--
-- errors.test.as
--
-------------------------------------------------------------------

#include "aldorunit"

TestErrors : TestCaseType with {
#include "errors.test.signatures.as"
} == add {

    import from TestCaseTools;
    ------------------------------------------------------------
    testFailing():() == {
        assertTrue(false);
    }
    ------------------------------------------------------------
    testThrowingException():() == {
        import from MachineInteger;
        import from CheckingList MachineInteger;
        rest rest rest [5,7];
    }
    ------------------------------------------------------------
    testAssertingException():() == {
        import from MachineInteger;
        import from CheckingList MachineInteger;
        assertException( rest rest rest [5,7], 
	  ListExceptionType );
    }
    ------------------------------------------------------------
    testSegFaulting():() == {
        import from MachineInteger, List MachineInteger, String;
        assertNotEquals( 3, 5 );
        [7,8,9].5;
        fail "a call to [7,8,9] did not segfault :-(";
    }

}