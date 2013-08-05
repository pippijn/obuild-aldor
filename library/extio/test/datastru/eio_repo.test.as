-------------------------------------------------------------------------
--
-- eio_repo.test.as
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


TestSingletonRepository : TestCaseType with {

#include "eio_repo.test.signatures.as"

} == add {

    import from TestCaseTools;

    ----------------------------------------------------------------------

    
    testRepo():() == {

	RI == Record( t: IntegerType );
	import from RI;
	import from SingletonRepository( RI );
	import from String;
	import from Symbol;

	assertTrue register( -"mint", [ MachineInteger ] );

	assertException( find ( -"int" ), NotFoundExceptionType );
	dbgout << "trying to find _"mint_"" << newline;
	find( -"mint" );
	dbgout << "ok" << newline;
	
	local gen: Generator RI := generator();
	local mInt := failSafeRetract( RI, partialNext! gen );
	assertEquals( (name$Trace) ((mInt.t) pretend Type), "MachineInteger" );

	assertFailed( RI, partialNext! gen );
	
	
    }

    
    
}
