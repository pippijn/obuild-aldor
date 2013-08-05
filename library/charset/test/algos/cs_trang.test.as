-------------------------------------------------------------------------
--
-- cs_trang.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;



macro AS    == AutoreducedSet( T, RT );


TestTriangularizationAlgorithmType(  
  T    : TriangularizationTType,
  RT   : ReductionType T,
  TRALG: TriangularizationAlgorithmType( T, RT )
) : with {

triangularizeTester!: ( List T, List T, Set T ) -> ();
#include "cs_trang.test.signatures.as"

} == add {

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
    
    triangularizeTester!( a: List T, res: List T, premult: Set T == empty): () == {
	import from Character;
	import from TRALG;
	dbgout << "-- triangularizeTester! --" << newline;
	dbgout << " a: " << a << newline;

	local resAs: AS := failSafeRetract [ generator res ];
	local trRes: AS;
	local trPremult: Set T;
	
	-- List T -> AS
	assertEquals( triangularize a, resAs);

	-- List T -> ( AS, Set T )
	( trRes, trPremult ) := triangularize a;
	assertEquals( trRes, resAs );
	assertEquals( trPremult, premult );
	  
	-- Generator T -> AS
	assertEquals( triangularize generator a, resAs);

	-- Generator T -> ( AS, Set T )
	( trRes, trPremult ) := triangularize generator a;
	assertEquals( trRes, resAs );
	assertEquals( trPremult, premult );
	  
	dbgout << "-- triangularizeTester! -- END" << newline;
    }

    
     ----------------------------------------------------------------------

    
    testStubTriangularize1():() == {
	
	triangularizeTester!( empty, empty );
	
    }

    
    ----------------------------------------------------------------------    
    
    
}
