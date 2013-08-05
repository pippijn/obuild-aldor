-------------------------------------------------------------------------
--
-- cs_decom.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"

import from String;
import from Symbol;
import from List Symbol;


macro AS == AutoreducedSet( T, RT );

TestDecompositionAlgorithmType(  
  T    : TriangularizationTType,
  RT   : ReductionType T,
  DECALG: DecompositionAlgorithmType( T, RT )
) : with {

    decomposeTester: ( List T, Set AS, Set T ) -> ();
#include "cs_decom.test.signatures.as"

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
    defineAsserts( Set AS );

    ----------------------------------------------------------------------
    
    decomposeTester( a: List T, res: Set AS, premult: Set T == empty): () == {
	import from Character;
	import from DECALG;
	dbgout << "-- decomposeTester --" << newline;
	dbgout << " a: " << a << newline;

	local decRes: Set AS;
	local decPremult: Set T;
	
	-- List T -> Set AS
	assertEquals( decompose a, res);
	
	-- List T -> ( Set AS, Set T )
	( decRes, decPremult ) := decompose a;
	assertEquals( decRes, res );
	assertEquals( decPremult, premult );

	  
	-- Generator T -> Set AS
	assertEquals( decompose generator a, res);


	-- Generator T -> ( Set AS, Set T )
	( decRes, decPremult ) := decompose generator a;
	assertEquals( decRes, res );
	assertEquals( decPremult, premult );

	dbgout << "-- decomposeTester -- END" << newline;
    }

    
     ----------------------------------------------------------------------

    
    testStubDecompose1():() == {
	
	decomposeTester( empty, empty$(Set AS) );
	
    }

    
    ----------------------------------------------------------------------    
    
    
}
