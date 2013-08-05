-------------------------------------------------------------------------
--
-- eio_expl.test.as
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


TestExpressionTreeLeaf : TestCaseType with {

#include "eio_expl.test.signatures.as"

  } == add {

	import from TestCaseTools;

	import from String;
	import from MachineInteger;
	import from List MachineInteger;
#if LibraryExtIORequiresLibraryAlgebra
	import from Partial ExpressionTree;
	
	macro ET  == ExpressionTree;
	macro ETL == ExpressionTreeLeaf;

	import from ET;
	import from List ET;
	import from ETL;
	import from List ETL;

	local assertEquals( left: ETL, right: ETL):() throw AldorUnitFailedExceptionType == assertEquals( ETL )( left, right );

	local assertNotEquals( left: ETL, right: ETL):() throw AldorUnitFailedExceptionType == assertNotEquals( ETL )( left, right );

#endif
	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafBoolean():() == {
	    
	    macro PRIMARYVALUE == false;
	    macro TYPE == Boolean;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    val1 := true;
	    assertEquals( etl, leaf val2 );

	}
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafDoubleFloat():() == {
	    
	    macro PRIMARYVALUE == 0.345;
	    macro TYPE == DoubleFloat;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    val1 := add!( val1, 3.5 );
	    assertEquals( etl, leaf val2 );

	}
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
#if GMP
	testCopyLeafFloat():() == {
	    macro PRIMARYVALUE == 0.345;
	    macro TYPE == Float;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    val1 := add!( val1, 3.5 );
	    assertEquals( etl, leaf val2 );
	}
#endif	
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafInteger():() == {
	    
	    macro PRIMARYVALUE == 3;
	    macro TYPE == Integer;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    val1 := add!( val1, 5 );
	    assertEquals( etl, leaf val2 );

	}
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafSingleFloat():() == {
	    
	    macro PRIMARYVALUE == 3.125;
	    macro TYPE == SingleFloat;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    val1 := add!( val1, 3.5 );
	    assertEquals( etl, leaf val2 );
	    
	}
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafmachineInteger():() == {
	    
	    macro PRIMARYVALUE == 3;
	    macro TYPE == MachineInteger;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    val1 := add!( val1, 5 );
	    assertEquals( etl, leaf val2 );

	}
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafString():() == {
	    
	    macro PRIMARYVALUE == "abc";
	    macro TYPE == String;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;

	    val1.1 := char "Y" ;
	    assertEquals( etl, leaf val2 );

	}
#endif

	
	----------------------------------------------------------------------

	
#if LibraryExtIORequiresLibraryAlgebra
	testCopyLeafSymbol():() == {
	    
	    local str: String := "abc";
	    
	    macro PRIMARYVALUE == (- str);
	    macro TYPE == Symbol;
	    
	    local val1: TYPE := PRIMARYVALUE;
	    local val2: TYPE := PRIMARYVALUE;
	    local etl := copy leaf val1;
	    
	    str.1 := char "Y" ;	    
	    val1 := (- str);
	    assertEquals( etl, leaf val2 );
	}
#endif

	
	----------------------------------------------------------------------


}
