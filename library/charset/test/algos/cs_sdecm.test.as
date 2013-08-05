-------------------------------------------------------------------------
--
-- cs_sdecm.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"
#include "testcases"

import from String;
import from Symbol;
import from List Symbol;

macro AS    == AutoreducedSet( T, RT );

macro TESTSTUB == TestDecompositionAlgorithmType( T, RT, SDECALG );

TestSaturatedDecompositionAlgorithmType(  
  T    : TriangularizationTType,
  RT   : ReductionType T,
  SDECALG: SaturatedDecompositionAlgorithmType( T, RT )
) : with {

    saturatedDecomposeTester: ( List T, Set T, Set AS, Set T ) -> ();
    decomposeTester: ( List T, Set AS, Set T ) -> ();
#include "cs_decom.test.signatures.as"
#include "cs_sdecm.test.signatures.as"

} == TESTSTUB add {

    import from TestCaseTools;
    import from TESTSTUB;

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
    
    saturatedDecomposeTester( a: List T, sats: Set T, res: Set AS, premult: Set T == empty): () == {
	import from Character;
	import from SDECALG;
	dbgout << "-- saturatedDecomposeTester --" << newline;
	if T has OutputType then
	{
	    dbgout << " a   : " << a << newline;
	    dbgout << " sats: " << sats << newline;
	}

	local decRes: Set AS;
	local decPremult: Set T;
	
	-- ( List T, Set T ) -> Set AS
	assertEquals( decompose( a, sats ), res);

	-- ( List T, Set T ) -> ( Set AS, Set T )
	( decRes, decPremult ) := decompose( a, sats );
	assertEquals( decRes, res );
	assertEquals( decPremult, premult );
	  
	-- ( Generator T, Generator T ) -> Set AS
	assertEquals( decompose( generator a, generator sats), res);

	-- ( Generator T, Generator T ) -> ( Set AS, Set T )
	( decRes, decPremult ) := decompose( generator a, generator sats );
	assertEquals( decRes, res );
	assertEquals( decPremult, premult );
	  
	dbgout << "-- saturatedDecomposeTester -- END" << newline;
    }

    
     ----------------------------------------------------------------------

    
    testStubSaturatedDecompose1():() == {
	
	saturatedDecomposeTester( empty, empty$(Set T), empty$(Set AS) );
	
    }

    
    ----------------------------------------------------------------------    
    
    
}
