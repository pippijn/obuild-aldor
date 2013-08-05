-----------------------------------------------------------------------
--
-- listtool.test.as
--
-------------------------------------------------------------------------

#include "aldorunit"

#library listlib "listtool.ao"
import from listlib;


TestListTools : TestCaseType with {

#include "listtool.test.signatures.as"

} == add {

    macro Z  == MachineInteger;
    macro LZ == List Z;
    macro LT == ListTools Z;

    ----------------------------------------------------------------------

    import from TestCaseTools;
    import from Z;
    import from LZ;
    import from LT;

    ----------------------------------------------------------------------

    testMerge1():() == {
        assertEquals( LZ, merge( empty, empty ), empty );
    }

    ----------------------------------------------------------------------

    testMerge2():() == {
        assertEquals( LZ, merge( [ 1,3,5 ], [ 2,4 ] ) , [ 1, 2, 3, 4, 5 ] );
    }

    ----------------------------------------------------------------------

#if SOME_FANCY_EXPRESSION

    testConditional():() == {
        import from String;
        import from Character;

        dbgout << "conditional test included" << newline;
    }

#endif

    ----------------------------------------------------------------------

}
