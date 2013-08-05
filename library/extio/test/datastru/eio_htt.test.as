-------------------------------------------------------------------------
--
-- eio_htt.test.as
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

macro Value == String;

HashTableTester(
  Key: IntegerType,
  Table: TableType( Key, Value ) with {
      PrimitiveType;
      contained?:( %, % ) -> Boolean;
  }
) : TestCaseType with {

#include "eio_htt.test.signatures.as"

  } == add {

	macro PL == List MachineInteger;

	import from TestCaseTools;

	import from MachineInteger;
	import from Key;
	import from Value;
	import from Table;
	import from KeyEntry( Key, Value );
	import from List KeyEntry( Key, Value );

	------------------------------------------------------

	defineAsserts( Table );
	defineAsserts( Value );
	------------------------------------------------------
	
	assertEquals( gen: Generator( Cross( Key, Value )), lst : List KeyEntry( Key, Value )): () == {
	    import from String;
	      for genItem in gen repeat {
		  ( genKey, genValue ) := genItem;
		  ( found?, foundIndex, found ) := linearSearch( [ genKey, genValue ], lst );
		  ~ found? => fail "Generator yields unexpected elements";
		  assertEquals( Value, genValue, entry found );
		  lst := remove!( found, lst );
	      }
	      ~ empty? lst => fail "Generator did not yield all required elements"
	  }
	  
	------------------------------------------------------
	
	testCopy():() == {
	    local t1 := table();
	    local t2 := copy t1;
	    t2 . 1 := "eins";
	    assertNotEquals( t1, t2 );
	    
	}

	------------------------------------------------------

	testPrimitiveType1():() == {
	    
	    assertEquals( table(), table() );
	    
	}

	------------------------------------------------------

	testPrimitiveType2():() == {
	    
	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertNotEquals( table(), table2 );
	}

	------------------------------------------------------

	testPrimitiveType3():() == {
	    
	    local table1 := table();
	    table1 . 2 := "zwei";
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertEquals( table1, table2 );
	}

	------------------------------------------------------

	testPrimitiveType4():() == {
	    
	    local table1 := table();
	    table1 . 1 := "zwei";
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertNotEquals( table1, table2 );
	}

	------------------------------------------------------

	testPrimitiveType5():() == {
	    
	    local table1 := table();
	    table1 . 1 := "eins";
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertNotEquals( table1, table2 );
	}

	------------------------------------------------------

	testContained?1():() == {
	    
	    assertTrue contained?( table(), table() );
	    
	}

	------------------------------------------------------

	testContained?2():() == {
	    
	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertTrue contained?( table(), table2 );
	    assertFalse contained?( table2, table() );
	}

	------------------------------------------------------

	testContained?3():() == {
	    
	    local table1 := table();
	    table1 . 2 := "zwei";
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertTrue contained?( table1, table2 );
	    assertTrue contained?( table1, table2 );
	}

	------------------------------------------------------

	testContained?4():() == {
	    
	    local table1 := table();
	    table1 . 1 := "zwei";
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertFalse contained?( table1, table2 );
	    assertFalse contained?( table2, table1 );
	}

	------------------------------------------------------

	testContained?5():() == {
	    
	    local table1 := table();
	    table1 . 1 := "eins";
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertFalse contained?( table1, table2 );
	    assertFalse contained?( table2, table1 );
	}

	------------------------------------------------------

	testContained?6():() == {
	    
	    local table1 := table();
	    table1 . 3 := "drei";

	    local table2 := table();
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertTrue contained?( table1, table2 );
	    assertFalse contained?( table2, table1 );
	}

	------------------------------------------------------

	testTable1():() == {
	    
	    local table1 := table( 0@MachineInteger );
	    table1 . 1 := "eins";
	    table1 . 2 := "zwei";
	    table1 . 3 := "drei";

	    local table2 := table( 1@MachineInteger );
	    table2 . 1 := "eins";
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertEquals( table1, table2 );
	}

	------------------------------------------------------

	testTable2():() == {
	    
	    local table1 := table( 0@MachineInteger );
	    table1 . 1 := "eins";
	    table1 . 2 := "zwei";
	    table1 . 3 := "drei";

	    local table2 := table( 1@MachineInteger );
	    table2 . 1 := "eins";
	    table2 . 2 := "zwei";
	    table2 . 3 := "drei";
	    
	    assertEquals( table1, table2 );
	}

	------------------------------------------------------

	testTable3():() == {
	    
	    local table1 := table( 10@MachineInteger );
	    table1 . 1 := "eins";
	    table1 . 22 := "zweiundzwanzig";
	    table1 . 43 := "dreiundvierzig";

	    local table2 := table( );
	    table2 . 1 := "eins";
	    table2 . 22 := "zweiundzwanzig";
	    table2 . 43 := "dreiundvierzig";
	    
	    assertEquals( table1, table2 );
	}

	------------------------------------------------------

	testEmpty?1():() == {	    
	    local table1 := table();

	    assertTrue empty? table1;

	    table1 . 1 := "eins";
	    
	    assertFalse empty? table1;
	}

	------------------------------------------------------

	testNEntries1():() == {
	    
	    local table1 := table();
	    
	    assertEquals( MachineInteger, 0, numberOfEntries table1 );

	    table1 . 2 := "zwei";
	    assertEquals( MachineInteger, 1, numberOfEntries table1 );

	    table1 . 3 := "drei";
	    assertEquals( MachineInteger, 2, numberOfEntries table1 );
	}

	------------------------------------------------------

	testHashMark1():() == {
	    
	    local table1 := table();
	    
	    assertEquals( MachineInteger, 0, # table1 );

	    table1 . 2 := "zwei";
	    assertEquals( MachineInteger, 1, # table1 );

	    table1 . 3 := "drei";
	    assertEquals( MachineInteger, 2, # table1 );
	}

	------------------------------------------------------

	testFind1():() == {
	    
	    local table1 := table();
	    
	    assertFailed( find( 0, table1 ) );
	    assertFailed( find( 1, table1 ) );
	    assertFailed( find( 2, table1 ) );
	    assertFailed( find( 3, table1 ) );
	}

	------------------------------------------------------

	testFind2():() == {
	    
	    local table1 := table();
	    table1 . 2 := "zwei";
	    
	    assertFailed( find( 0, table1 ) );
	    assertFailed( find( 1, table1 ) );
	    assertEquals( Value, failSafeRetract find( 2, table1 ), "zwei" );
	    assertFailed( find( 3, table1 ) );
	}

	------------------------------------------------------

	testFind3():() == {
	    
	    local table1 := table( 10@MachineInteger );
	    table1 . 2 := "zwei";
	    table1 . 23 := "dreiundzwanzig";
	    
	    assertFailed( find( 0, table1 ) );
	    assertFailed( find( 1, table1 ) );
	    assertEquals( Value, failSafeRetract find( 2, table1 ), "zwei" );
	    assertEquals( Value, failSafeRetract find( 23, table1 ), "dreiundzwanzig" );
	    assertFailed( find( 3, table1 ) );

	    table1 . 2 := "zwei-neu";
	    
	    assertFailed( find( 0, table1 ) );
	    assertFailed( find( 1, table1 ) );
	    assertEquals( Value, failSafeRetract find( 2, table1 ), "zwei-neu" );
	    assertEquals( Value, failSafeRetract find( 23, table1 ), "dreiundzwanzig" );
	    assertFailed( find( 3, table1 ) );
	}

	------------------------------------------------------

	testGenerator1():() == {
	    
	    local table1 := table( 10@MachineInteger );
	    
	    assertEquals( generator table1, empty );
	}

	------------------------------------------------------

	testGenerator2():() == {
	    
	    local table1 := table( 10@MachineInteger );
	    
	    table1 . 1 := "eins";
	    table1 . 2 := "zwei-alt";
	    table1 . 2 := "zwei";
	    table1 . 3 := "drei";
	    table1 . 23 := "dreiundzwanzig";
	    assertEquals( generator table1, [
		[ 1, "eins" ],
		[ 2, "zwei" ],
		[ 3, "drei" ],
		[ 23, "dreiundzwanzig" ]
		] );
	}

	------------------------------------------------------

	testHash():() == {
	    
	    local table1 := table( 10@MachineInteger );
	    table1 . 1 := "eins";
	    table1 . 2 := "zwei-alt";
	    table1 . 2 := "zwei";
	    table1 . 3 := "drei";
	    table1 . 23 := "dreiundzwanzig";
	    assertEquals( generator table1, [
		[ 1, "eins" ],
		[ 2, "zwei" ],
		[ 3, "drei" ],
		[ 23, "dreiundzwanzig" ]
		] );
	}

	------------------------------------------------------

}
