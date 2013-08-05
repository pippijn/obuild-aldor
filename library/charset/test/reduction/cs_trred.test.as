-------------------------------------------------------------------------
--
-- cs_trred.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;


macro AS == AutoreducedSet( T, RT );
macro HEADER == {
	if T has OutputType then 
	{
	    dbgout << " a: " << a << newline;
	    dbgout << " b: " << b << newline;
	    dbgout << newline;
	}
}

TestTriangularizationReductionTools(
  T: TriangularizationTType,
  RT : TriangularizationReductionType T
) : TestCaseType with {

    reduced?Tester: ( T, T, Boolean ) -> ();
    reduced?TesterAS: ( T, AS, Boolean ) -> ();
    reduceTester: ( T, T, T, Set T ) -> ();
    reduceTesterList: ( T, List T, T, Set T ) -> ();
    reduceTesterAS: ( T, AS, T, Set T ) -> ();
    deltaTTester: ( T, T, T, Set T ) -> ();
#include "cs_trred.test.signatures.as"

} == TestReductionTools( T, RT ) add {
    

    import from TestCaseTools;
    import from TestReductionTools( T, RT );
    import from RT;
    import from AS;
    import from Character;
    import from TextWriter;

    ----------------------------------------------------------------------    

    defineAsserts( T );
    defineAsserts( AS );
    defineAsserts( Set T );
    defineAsserts( List T );

    ----------------------------------------------------------------------    

    reduced?Tester( a: T, b: T, red?: Boolean ):() == {	
	dbgout << "-- reduced?Tester --" << newline;
	HEADER;
	(reduced?Tester$TestReductionTools( T, RT ))( a, b, red? );

	local assertFunc: ( Boolean ) -> () throw AldorUnitFailedExceptionType;
	
	if red? then
	{
	    assertFunc := assertTrue;
	} else {
	    assertFunc := assertFalse;
	}
	assertFunc reduced?( a, failSafeRetract [ b ] );
	assertFunc( (reducedBy? failSafeRetract [ b ] )(a) );
	dbgout << "-- reduced?Tester -- END" << newline;
    }
       
    ----------------------------------------------------------------------    

    reduced?TesterAS( a: T, b: AS, red?: Boolean ):() == {	
	dbgout << "-- reduced?ASTester --" << newline;
	HEADER;
	local assertFunc: ( Boolean ) -> () throw AldorUnitFailedExceptionType;	
	if red? then
	{
	    assertFunc := assertTrue;
	} else {
	    assertFunc := assertFalse;
	}
	assertFunc reduced?( a, b );
	assertFunc( (reducedBy? b)(a) );
	dbgout << "-- reduced?ASTester -- END" << newline;
    }
       
    ----------------------------------------------------------------------    

    reduceTester( a: T, b: T, res: T, premult: Set T ):() == {	
	dbgout << "-- reduceTester --" << newline;
	HEADER;
	(reduceTester$TestReductionTools( T, RT ))( a, b, res );

	local redRes: T;
	local redPremult: Set T;
	
	-- ( T, T ) -> ( T, Set T )
	( redRes, redPremult ) := reduce( a, b );
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	-- ( T, AS ) -> T
	assertEquals( reduce( a, failSafeRetract( [ b ] ) ), res );
	
	-- ( T, AS ) -> ( T, Set T )
	( redRes, redPremult ) := reduce( a, failSafeRetract( [ b ] ) );
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	-- ( T, List T ) -> T
	assertEquals( reduce( a, (bracket$(List T)) b ), res );
	
	-- ( T, List T ) -> ( T, Set T )
	( redRes, redPremult ) := reduce( a, (bracket$(List T)) b );
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	-- T -> T -> ( T, Set T )
	( redRes, redPremult ) := (reduceBy b) a;
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	-- AS -> T -> T
	assertEquals( (reduceBy failSafeRetract [ b ] ) a, res );
	  
	-- AS -> T -> ( T, Set T )
	( redRes, redPremult ) := (reduceBy failSafeRetract [ b ] ) a;
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	dbgout << "-- reduceTester -- END" << newline;
    }
       
    ----------------------------------------------------------------------    

    reduceTesterList( a: T, b: List T, res: T, premult: Set T ):() == {	
	dbgout << "-- reduceTesterList --" << newline;
	HEADER;

	local redRes: T;
	local redPremult: Set T;
	  
	-- ( T, List T ) -> T
	assertEquals( reduce( a, b ), res );
	
	-- ( T, List T ) -> ( T, Set T )
	( redRes, redPremult ) := reduce( a, b );
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	dbgout << "-- reduceTesterList -- END" << newline;
    }
       
    ----------------------------------------------------------------------    

    reduceTesterAS( a: T, b: AS, res: T, premult: Set T ):() == {	
	dbgout << "-- reduceTesterAS --" << newline;
	HEADER;

	local redRes: T;
	local redPremult: Set T;
		  
	-- ( T, AS ) -> T
	assertEquals( reduce( a, b ), res );
	
	-- ( T, AS ) -> ( T, Set T )
	( redRes, redPremult ) := reduce( a, b );
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	-- ( T, List T ) -> T
	assertEquals( reduce( a, (bracket$(List T)) generator b ), res );
	
	-- ( T, List T ) -> ( T, Set T )
	( redRes, redPremult ) := reduce( a, (bracket$(List T)) generator b );
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	-- AS -> T -> T
	assertEquals( (reduceBy b) a, res );
	  
	-- AS -> T -> ( T, Set T )
	( redRes, redPremult ) := (reduceBy b) a;
	assertEquals( redRes, res );
	assertEquals( redPremult, premult );
	  
	dbgout << "-- reduceTesterAS -- END" << newline;
    }

    ----------------------------------------------------------------------    

    deltaTTester( a: T, b: T, res: T, premult: Set T ):() == {	
	dbgout << "-- deltaTesterAS --" << newline;
	HEADER;

	local redRes: List T;
	local redPremult: Set T;
	-- ( T, T ) -> List T
	redRes := consequences( a, b );
	assertEquals( # redRes, 1$MachineInteger );
	assertEquals( first redRes, res );
	
	-- ( T, T ) -> ( List T, Set T )
	( redRes, redPremult ) := consequences( a, b );
	assertEquals( # redRes, 1$MachineInteger );
	assertEquals( first redRes, res );
	assertEquals( redPremult, premult );
	  
	  
	dbgout << "-- deltaTTester -- END" << newline;
    }

    ----------------------------------------------------------------------    

}