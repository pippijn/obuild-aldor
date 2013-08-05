-------------------------------------------------------------------------
--
-- eio_list.test.as
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


TestListExtensionParsable : TestCaseType with {

#include "eio_list.test.signatures.as"

  } == add {

	macro PL == List MachineInteger;

	import from TestCaseTools;

	import from String;
	import from MachineInteger;
#if LibraryExtIORequiresLibraryAlgebra
	import from Partial ExpressionTree;
	import from ExpressionTree;
	import from List ExpressionTree;
#endif
        import from PL;
	
	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testEvalLeaf():() == {
	  assertFailed( PL, eval extree "t" );
	}
#endif

	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testEval1():() == {
		assertFailed( PL, eval ExpressionTreePlus . [ extree "2", extree "1" ] );
	}
#endif

	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testEval2():() == {
		local parseString := "[1,2,3]";
		local iEParser : InfixExpressionParser := (parser$InfixExpressionParser)(parseString::TextReader);
		local expTree : ExpressionTree := failSafeRetract( ExpressionTree, (parse!$InfixExpressionParser) iEParser );
		local pList : PL := failSafeRetract( PL, eval expTree);
		assertEquals( PL, pList, [ 1, 2, 3 ] );
	}
#endif

	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testExtree1():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    assertEquals( ExpressionTree, extree (empty$PL), ExpressionTreeList . empty );
	}
#endif

	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testExtree2():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    assertEquals( ExpressionTree, extree [ 1 ], ExpressionTreeList . [ extree 1 ] );
	}
#endif

	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testExtree3():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from List MachineInteger;
	    assertEquals( ExpressionTree, extree [ 1, 4, 7, 16 ], ExpressionTreeList . [ extree 1, extree 4, extree 7, extree 16 ] );
	}
#endif

	----------------------------------------------------------------------

#if LibraryExtIORequiresLibraryAlgebra
	testCondenseRuns!():() == {
	    defineAsserts( List MachineInteger );
	    import from List MachineInteger;
	    assertEquals( condenseRuns! [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] );
	    assertEquals( condenseRuns! [ 1, 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] );
	    assertEquals( condenseRuns! [ 1, 1 ], [ 1 ] );
	    assertEquals( condenseRuns! [ 1, 1, 2, 3, 3, 4 ], [ 1, 2, 3, 4 ] );
	    assertEquals( condenseRuns! [ 1, 3, 3 ], [ 1, 3 ] );
	    assertEquals( condenseRuns! [ 1, 1, 3, 3 ], [ 1, 3 ] );
	}
#endif

	----------------------------------------------------------------------


}
