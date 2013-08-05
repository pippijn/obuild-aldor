-------------------------------------------------------------------------
--
-- eio_expt.test.as
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


TestExpressionTree : TestCaseType with {

#include "eio_expt.test.signatures.as"

  } == add {

	import from TestCaseTools;

	import from String;
	import from MachineInteger;
#if LibraryExtIORequiresLibraryAlgebra
	import from Partial ExpressionTree;
	
	macro ET  == ExpressionTree;

	import from ET;
	import from List ET;

#endif
	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopy1():() == {

	    import from List MachineInteger;
	    import from List List MachineInteger;
	    
	    local ext1 := extree [ [1,2,3], [4,5,6], [7,8,9] ];
	    local ext2 := copy ext1;
	    arguments( ext1 ) . 2 := extree [0];
	    
	    assertEquals( ext1, extree [ [1,2,3], [0], [7,8,9] ] );
	    assertEquals( ext2, extree [ [1,2,3], [4,5,6], [7,8,9] ] );

	}
#endif	


	----------------------------------------------------------------------


#if LibraryExtIORequiresLibraryAlgebra
	testCopy2():() == {

	    import from List String;
	    import from List List String;
	    
	    local str: String := "mno";
	    local ext1 := extree [ [ "abc", "def", "ghi" ], [ "jkl", str ] ];
	    local ext2 := copy ext1;

	    str . 1 := char "N";
	    
	    assertEquals( ext1, extree [ [ "abc", "def", "ghi" ], [ "jkl", "mNo" ] ] );
	    assertEquals( ext2, extree [ [ "abc", "def", "ghi" ], [ "jkl", "mno" ] ] );

	}
#endif	


	----------------------------------------------------------------------


}
