-------------------------------------------------------------------------
--
-- tst_tctl.test.as
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

#include "aldorunit"

TestTestSuiteTools : TestCaseType with {

#include "tst_tctl.test.signatures.as"

  } == add {

	import from TestCaseTools;
	import from String;

	printWarningAboutFailing():() == {
	    import from Character;
	    dbgout << "The following test will produce a failure on purpose" << newline 
	           << "in order to test the functions of AldorUnit's" << newline 
		   << "TestCaseTools. Consider this test as failed only if" << newline 
		   << "it ends in a failure. Intermediate output of failures" << newline 
		   << "are intented." << newline;
	}

	----------------------------------------------------------------------
	
	testAssertException():() == {
	    import from CheckingList Integer;
	    assertException( rest [] , ListExceptionType );
	}

	----------------------------------------------------------------------	
	
	testAssertTrue1():() == {		
	    assertTrue true;
	}

	----------------------------------------------------------------------
	
	testAssertTrue2():() == {		
	    printWarningAboutFailing();
	    assertException( assertTrue false, AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------

        testAssertFalse1():() == {		
		assertFalse(false);
	}

	----------------------------------------------------------------------

        testAssertFalse2():() == {		
	    printWarningAboutFailing();
	    assertException( assertFalse(true), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertEqualsCurried1():() == {			
		assertEquals( MachineInteger ) ( 1$MachineInteger, 1$MachineInteger );
	}

	----------------------------------------------------------------------
	
	testAssertEqualsCurried2():() == {			
	    printWarningAboutFailing();
	    assertException( assertEquals( MachineInteger ) ( 1$MachineInteger, 0$MachineInteger ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertEqualsUncurried1():() == {			
		assertEquals( MachineInteger, 1$MachineInteger, 1$MachineInteger );
	}

	----------------------------------------------------------------------

        testAssertEqualsUncurried2():() == {			
	    printWarningAboutFailing();
	    assertException( assertEquals( MachineInteger, 1$MachineInteger, 0$MachineInteger ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
		
	testAssertEqualsMachineInteger1():() == {		
	    assertEquals( 1$MachineInteger, 1$MachineInteger );
	}

	----------------------------------------------------------------------
		
	testAssertEqualsMachineInteger2():() == {		
	    printWarningAboutFailing();
	    assertException( assertEquals( 1$MachineInteger, 0$MachineInteger ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertEqualsInteger1():() == {
	    assertEquals( 1$Integer, 1$Integer );
	}

	----------------------------------------------------------------------
		
	testAssertEqualsInteger2():() == {		
	    printWarningAboutFailing();
	    assertException( assertEquals( 1$Integer, 0$Integer ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertEqualsString1():() == {
	    assertEquals( "abc", "abc" );
	}

	----------------------------------------------------------------------
	
	testAssertEqualsString2():() == {		
	    printWarningAboutFailing();
	    assertException( assertEquals( "abc", "bbc" ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsCurried1():() == {			
		assertNotEquals( MachineInteger ) ( 0$MachineInteger, 1$MachineInteger );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsCurried2():() == {			
	    printWarningAboutFailing();
	    assertException( assertNotEquals( MachineInteger ) ( 1$MachineInteger, 1$MachineInteger ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsUncurried1():() == {			
		assertNotEquals( MachineInteger, 0$MachineInteger, 1$MachineInteger );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsUncurried2():() == {			
	    printWarningAboutFailing();
	    assertException( assertNotEquals( MachineInteger, 1$MachineInteger, 1$MachineInteger ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsMachineInteger():() == {		
	    assertNotEquals( 0$MachineInteger, 1$MachineInteger );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsMachineInteger2():() == {		
	    printWarningAboutFailing();
	    assertException( assertNotEquals( 1$MachineInteger, 1$MachineInteger ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsInteger1():() == {
	    assertNotEquals( 0$Integer, 1$Integer );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsInteger2():() == {		
	    printWarningAboutFailing();
	    assertException( assertNotEquals( 1$Integer, 1$Integer ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsString1():() == {
	    assertNotEquals( "abcd", "abc" );
	}

	----------------------------------------------------------------------
	
	testAssertNotEqualsString2():() == {		
	    printWarningAboutFailing();
	    assertException( assertNotEquals( "abc", "abc" ), AldorUnitFailedExceptionType );
	}

	----------------------------------------------------------------------
	
	testAssertFailedCurried1():() == {
	    import from Partial Integer;
	    assertFailed( Integer ) ( failed );

	}

	----------------------------------------------------------------------
	
	testAssertFailedCurried2():() == {
	    import from Partial Integer;
	    printWarningAboutFailing();
	    assertException( assertFailed( Integer ) ( [1$Integer] ), AldorUnitFailedExceptionType );
	    

	}

	----------------------------------------------------------------------
	
	testAssertFailedUncurried1():() == {
	    import from Partial Integer;
	    assertFailed( Integer ) ( failed );

	}

	----------------------------------------------------------------------
	
	testAssertFailedUncurried2():() == {
	    import from Partial Integer;
	    printWarningAboutFailing();
	    assertException( assertFailed( Integer, [1$Integer] ), AldorUnitFailedExceptionType );
	    
	}

	----------------------------------------------------------------------
	
	testFailSafeRetractCurried1():() == {
	    import from Partial Integer;
	    assertEquals( 1$Integer, failSafeRetract( Integer ) ( [ 1$Integer] ) );
			

	}
	----------------------------------------------------------------------
	
	testFailSafeRetractCurried2():() == {
	    import from Partial Integer;
	    printWarningAboutFailing();
	    assertException( failSafeRetract( Integer ) ( failed ) , AldorUnitFailedExceptionType );			

	}

	----------------------------------------------------------------------
	
	testFailSafeRetractUncurried1():() == {
	    import from Partial Integer;
	    assertEquals( 1$Integer, failSafeRetract( Integer, [ 1$Integer] ) );
			

	}

	----------------------------------------------------------------------
	
	testFailSafeRetractUncurried2():() == {
	    import from Partial Integer;
	    printWarningAboutFailing();
	    assertException( failSafeRetract( Integer, failed ) , AldorUnitFailedExceptionType );			

	}

	----------------------------------------------------------------------
	
#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertEqualsExpressionTree1():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    assertEquals( ExpressionTreePlus . [ extree "a", extree "b" ], ExpressionTreePlus . [ extree "a", extree "b" ] ); 
	}
#endif
	----------------------------------------------------------------------
	
#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertEqualsExpressionTree2():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertException( assertEquals( (ExpressionTreePrefix (-"a")) . [ extree "a", extree "b" ], (ExpressionTreePrefix (-"c")) . [ extree "a", extree "b" ] ) , AldorUnitFailedExceptionType ); 
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertEqualsExpressionTree3():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertException( assertEquals( ExpressionTreePlus . [ extree "a", extree "b" ], extree "a" ) , AldorUnitFailedExceptionType ); 
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertEqualsExpressionTree4():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertException( assertEquals( extree "a", ExpressionTreePlus . [ extree "a", extree "b" ] ) , AldorUnitFailedExceptionType ); 
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertEqualsExpressionTree5():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertException( assertEquals( ExpressionTreeTimes . [ extree "a", extree "b" ], ExpressionTreePlus . [ extree "a", extree "b" ] ) , AldorUnitFailedExceptionType );
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertEqualsExpressionTree6():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertEquals( extree "a", extree "a" );
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertNotEqualsExpressionTree1():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    assertNotEquals( (ExpressionTreePrefix (-"a")) . [ extree "a", extree "b" ], (ExpressionTreePrefix (-"b"))  . [ extree "a", extree "b" ] ); 
	}
#endif

	----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertNotEqualsExpressionTree2():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertException( assertNotEquals( (ExpressionTreePrefix (-"b")) . [ extree "a", extree "b" ], (ExpressionTreePrefix (-"b"))  . [ extree "a", extree "b" ] ) , AldorUnitFailedExceptionType ); 
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertNotEqualsExpressionTree3():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertNotEquals( ExpressionTreePlus . [ extree "a", extree "b" ], extree "a" ); 
	}
#endif

        ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertNotEqualsExpressionTree4():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertNotEquals( extree "a", ExpressionTreePlus . [ extree "a", extree "b" ] );
	}
#endif

	----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
	testAssertNotEqualsExpressionTree5():() == {
	    import from ExpressionTree;
	    import from List ExpressionTree;
	    import from Symbol;
	    printWarningAboutFailing();
	    assertNotEquals( ExpressionTreeTimes . [ extree "a", extree "b" ], ExpressionTreePlus . [ extree "a", extree "b" ] );
	}
#endif

	----------------------------------------------------------------------

}
