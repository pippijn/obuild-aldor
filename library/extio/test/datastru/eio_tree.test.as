-------------------------------------------------------------------------
--
-- eio_tree.test.as
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


TestTree : TestCaseType with {

#include "eio_tree.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from Integer;
    macro TREE == Tree Integer;
    import from TREE;
    import from List TREE;

    local assertEquals( left: TREE, right: TREE):() throw AldorUnitFailedExceptionType == assertEquals( TREE )( left, right );

    local assertEquals( left: List TREE, right: List TREE):() throw AldorUnitFailedExceptionType == assertEquals( List TREE )( left, right );
   
    local assertNotEquals( left: TREE, right: TREE):() throw AldorUnitFailedExceptionType == assertNotEquals( TREE )( left, right );

    ----------------------------------------------------------------------

    testEmpty?1():() == {
	assertTrue empty? (empty$TREE);
    }
	
    ----------------------------------------------------------------------

    testEmpty?2():() == {
	assertFalse empty? tree 10;
    }
	
    ----------------------------------------------------------------------

    testEmpty?3():() == {
	assertFalse empty? tree( 10, [ tree 101 ] );
    }
	
    ----------------------------------------------------------------------

    testIsLeaf?1():() == {
	assertTrue isLeaf? tree 10 ;
    }
	
    ----------------------------------------------------------------------

    testIsLeaf?2():() == {
	assertFalse isLeaf? tree( 10, [ tree 101 ] );
    }
	
    ----------------------------------------------------------------------

    testIsLeaf?3():() == {
	assertTrue isLeaf? (empty$TREE);
    }
	
    ----------------------------------------------------------------------

    testChildren1():() == {
	assertEquals( children tree( 10, [ tree( 101, [ tree 2 ] ), tree 777 ] ), [ tree( 101, [ tree 2 ] ), tree 777 ] );
    }
	
    ----------------------------------------------------------------------

    testChildren2():() == {
	assertEquals( children tree 10, empty );
    }
	
    ----------------------------------------------------------------------

    testChildren3():() == {
	assertEquals( children empty , empty );
    }
	
    ----------------------------------------------------------------------

    testValue1():() == {
	assertEquals( Integer )( value tree( 10 ), 10 );
    }
	
    ----------------------------------------------------------------------

    testValue2():() == {
	assertEquals( Integer )( value tree( 10, [ tree 2 ] ), 10 );
    }
	
    ----------------------------------------------------------------------

    testMap1!():() == {
	import from Integer;
	
	assertEquals( (map! factorial) tree( 3, [ tree 4 ] ), tree( 6, [ tree 24 ] ) );
    }
	
    ----------------------------------------------------------------------

    testMap2!():() == {
	import from Integer;
	
	assertEquals( (map! factorial) empty, empty );
    }
	
    ----------------------------------------------------------------------

    testPrimitiveType1():() == {
	assertEquals( tree 10, tree 10 );
    }
	
    ----------------------------------------------------------------------

    testPrimitiveType2():() == {
	assertNotEquals( tree 10, tree 101 );
    }
	
    ----------------------------------------------------------------------

    testPrimitiveType3():() == {
	assertEquals( tree( 10, [ tree 2 ] ), tree( 10, [ tree 2 ] ) );
    }
	
    ----------------------------------------------------------------------

    testPrimitiveType4():() == {
	assertNotEquals( tree 10, tree( 10, [ tree 2 ] ) );
    }
	
    ----------------------------------------------------------------------

    testPrimitiveType5():() == {
	assertNotEquals( tree( 10, [ tree 2 ] ), tree 10 );
    }
	
    ----------------------------------------------------------------------

}
