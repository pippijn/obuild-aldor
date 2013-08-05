-------------------------------------------------------------------------
--
-- cs_trang.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;




macro TESTSTUB == TestTriangularizationAlgorithmType( T, RT, TRALG );

TestUpdatableTriangularizationAlgorithmType(  
  T    : TriangularizationTType with Ring,
  RT   : ReductionType T,
  TRALG: UpdatableTriangularizationAlgorithmType( T, RT )
) : with {

triangularizeTester!: ( List T, List T, Set T ) -> ();
#include "cs_trang.test.signatures.as"
#include "cs_resum.test.signatures.as"

} == TESTSTUB add {

    local AS    == AutoreducedSet( T, RT );
    
    import from TestCaseTools;

    import from Integer;
    import from Array Integer;
    import from MachineInteger;

    import from T;
    import from List T;
    import from RT;
    import from AS;

    ----------------------------------------------------------------------

    defineAsserts( Set T );
    defineAsserts( AS );

    ----------------------------------------------------------------------

    negAssertEquals( a: AS, b: AS ): () == {
	import from Character;
	dbgout << "assertEquals( " << newline;
	dbgout << "  "<<a << newline;
	dbgout << " ," << newline;
	dbgout << "  "<<b << newline;
	for elementA in a for elementB in b repeat 
	{
	    assertTrue( elementA = elementB or elementA = - elementB );
	}
	dbgout << ")" << newline;
    }
    
    ----------------------------------------------------------------------
    
    triangularizeTester!( a: List T, res: List T, premult: Set T == empty): () == {
	import from Character;
	import from TRALG;
	import from Pointer;
	(triangularizeTester!$(TestTriangularizationAlgorithmType(T, RT, TRALG)))( a, res, premult );
	dbgout << "-- triangularizeTester! (resumed) --" << newline;
	dbgout << " a: " << a << newline;


	local resAs: AS := failSafeRetract [ generator res ];
	local trRes: AS;
	local trPremult: Set T;	
	local trPremultStep: Set T;	
	local status: Pointer := nil;
	
	-- List T -> AS
	( trRes, status ) := triangularize( a, nil );
	negAssertEquals( trRes, resAs );
	( trRes, status ) := triangularize( { empty? a => empty; [ first a ]; }, status );
	negAssertEquals( trRes, resAs );
	status := nil;
	for elementA in a repeat {
	    ( trRes, status ) := triangularize( [ elementA ], status );
	}
	negAssertEquals( trRes, resAs );
	
	-- List T -> ( AS, Set T )
	( trRes, trPremult, status ) := triangularize( a, nil );
	negAssertEquals( trRes, resAs );
	assertEquals( trPremult, premult );
	( trRes, trPremult, status ) := triangularize( { empty? a => empty; [ first a ]; }, status );
	negAssertEquals( trRes, resAs );
	status := nil;
	trPremult := empty;
	for elementA in a repeat {
	    ( trRes, trPremultStep, status ) := triangularize( [ elementA ], status );
	    trPremult := union!( trPremult, trPremultStep );
	}
	negAssertEquals( trRes, resAs );
--	assertEquals( trPremult, premult );

	-- Generator T -> AS
	( trRes, status ) := triangularize( generator a, nil );
	negAssertEquals( trRes, resAs );
	( trRes, status ) := triangularize( { empty? a => generator (empty@(List T)); generator ([ first a ]@(List T)); }, status );
	negAssertEquals( trRes, resAs );
	status := nil;
	for elementA in a repeat {
	    ( trRes, status ) := triangularize( generator ([ elementA ]@(List T)), status );
	}
	negAssertEquals( trRes, resAs );
	
	-- List T -> ( AS, Set T )
	( trRes, trPremult, status ) := triangularize( generator a, nil );
	negAssertEquals( trRes, resAs );
	assertEquals( trPremult, premult );
	( trRes, trPremult, status ) := triangularize( { empty? a => generator (empty@(List T)); generator ([ first a ]@(List T)); }, status );
	negAssertEquals( trRes, resAs );
	status := nil;
	trPremult := empty;
	for elementA in a repeat {
	    ( trRes, trPremultStep, status ) := triangularize( generator ([ elementA ]@(List T)), status );
	    trPremult := union!( trPremult, trPremultStep );
	}
	negAssertEquals( trRes, resAs );
--	assertEquals( trPremult, premult );

	dbgout << "-- triangularizeTester! (resumed) -- END" << newline;
    }

    
     ----------------------------------------------------------------------

    
    testStubTriangularize1():() == {
	
	triangularizeTester!( empty, empty );
	
    }

    
    ----------------------------------------------------------------------    
    
    
}
