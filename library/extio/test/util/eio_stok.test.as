-------------------------------------------------------------------------
--
-- eio_stok.test.as
--
-------------------------------------------------------------------------
--
-- Copyright (C) 2005  Research Institute for Symbolic Computation, 
-- J. Kepler University, Linz, Austria
--
-- Written by Christian Aistleitner
-- 
-- This program is free software; you can redistribute it and/or          
-- modify it under the terms of the GNU General Public License version 2, 
-- as published by the Free Software Foundation.                          
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
-- MA  02110-1301, USA.
--

#include "extio"
#include "aldorunit"


TestStringTokenizer : TestCaseType with {

#include "eio_stok.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from StringTokenizer;
    import from String;
    import from Character;

    
    ----------------------------------------------------------------------

    
    assertEquals( lhs: Generator String, rhs: List String ):() throw AldorUnitFailedExceptionType == {
	local pLhsString : Partial String;
	
	for rhsString in rhs repeat 
	{
	    pLhsString := partialNext! lhs;
	    if failed? pLhsString then {
		dbgout << "generator does not yield another element, although _"" << rhsString << "_" is expected" << newline;
		fail "assertEquals does not hold";
	    } else {
		assertEquals( String, retract pLhsString, rhsString);
	    }
	}
	
	pLhsString := partialNext! lhs;
	if ~ failed? pLhsString then {
	    dbgout << "generator yields an additional token: _"" << (retract pLhsString ) << "_"" << newline;
	    fail "assertEquals does not hold";
	}	
	();
    }
	
    
    ----------------------------------------------------------------------

    
    testGenerator1():() == {

	assertEquals( tokenize( char ",", "" ), empty$(List String) );
	
    }


    ----------------------------------------------------------------------


    testGenerator2():() == {
	import from List String;

	assertEquals( tokenize( char ",", "abc" ), [ "abc" ] );
	
    }


    ----------------------------------------------------------------------


    testGenerator3():() == {

	assertEquals( tokenize( char ",", ",,,,," ), empty$(List String) );
	
    }


    ----------------------------------------------------------------------


    testGenerator4():() == {
	import from List String;

	assertEquals( tokenize( char ",", ",,this,,is,,,,,,,a,test" ), [ "this", "is", "a", "test" ] );
	
    }


    ----------------------------------------------------------------------

    testGenerator5():() == {
	import from List String;

	assertEquals( tokenize( char " ", "Indeed, another test" ), [ "Indeed,", "another", "test" ] );

    }


    ----------------------------------------------------------------------


    
    
}
