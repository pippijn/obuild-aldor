-------------------------------------------------------------------------
--
-- eio_matp.test.as
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

#if LibraryExtIORequiresLibraryAlgebra

TestMathematicaFullFormParser : TestCaseType with {

#include "eio_matp.test.signatures.as"

} == add {


    import from TestCaseTools;

    import from String;
    import from MathematicaFullFormParser;
    import from Partial ExpressionTree;
    import from ExpressionTree;
    import from List ExpressionTree;

    macro PARSE( STRING ) == failSafeRetract( ExpressionTree, parse! parser( (STRING) :: TextReader ) ); 
    macro PARSEFAILURE( STRING ) == assertFailed( ExpressionTree, parse! parser( (STRING) :: TextReader ) ); 


    ----------------------------------------------------------------------

    
    testInteger1():() == {
	import from Integer;
	
	assertEquals( PARSE( "1234567890" ), extree 1234567890 );
    }

    
    ----------------------------------------------------------------------

    
    testInteger2():() == {
	import from Integer;
	
	assertEquals( PARSE( "-10" ), ExpressionTreeMinus . [ extree 10  ] );
    }

    
    ----------------------------------------------------------------------

    
    testFloat1():() == {
#if GMP
	import from Float;
#else
	import from DoubleFloat;
#endif	

	assertEquals( PARSE( "1234." ), extree 1234.0 );
    }

    
    ----------------------------------------------------------------------

    
    testFloat2():() == {
#if GMP
	import from Float;	
	macro FLOATQ==float?;
	macro FLOAT==float;
#else
	import from DoubleFloat;
	macro FLOATQ==doubleFloat?;
	macro FLOAT==doubleFloat;
#endif	
	import from ExpressionTreeLeaf;
        local leftEt := PARSE( "1234.56`" );
	assertTrue leaf? leftEt;
        local leftEtl := leaf leftEt;
	assertTrue FLOATQ leftEtl;
	import from AldorInteger;
	assertEquals( AldorInteger, truncate ( (FLOAT leftEtl)* 10000. + 0.9), 12345600@AldorInteger );
    }


    ----------------------------------------------------------------------

    assertEquals( op1: ExpressionTreeOperator, op2: ExpressionTreeOperator ):() == {
	assertEquals( uniqueId$op1, uniqueId$op2 );
	assertEquals( Symbol, name$op1, name$op2 );
    }
        
    testFloat3():() == {
#if GMP
	import from Float;	
	macro FLOATQ==float?;
	macro FLOAT==float;
#else
	import from DoubleFloat;
	macro FLOATQ==doubleFloat?;
	macro FLOAT==doubleFloat;
#endif	
	import from ExpressionTreeLeaf;
	import from MachineInteger;
	import from List ExpressionTree;
        local leftEt := PARSE( "-55.66`" );
	assertFalse leaf? leftEt;
	assertEquals( operator leftEt, ExpressionTreeMinus );
	assertEquals( MachineInteger, # arguments leftEt, 1 );
	leftEt := (arguments ( leftEt ) ) . 1;
        local leftEtl := leaf leftEt;
	assertTrue FLOATQ leftEtl;
	import from AldorInteger;
	assertEquals( AldorInteger, truncate ( (FLOAT leftEtl)* 10000. + 0.9), 556600@AldorInteger );
    }


    ----------------------------------------------------------------------

    testString1():() == {
	import from String;
	
	assertEquals( PARSE( "_"123_"" ), extree "123" );
    }


    ----------------------------------------------------------------------


    testString2():() == {
	import from String;

	assertEquals( PARSE( "_"abc_"" ), extree "abc" );
    }

    
    ----------------------------------------------------------------------

    
    testString3():() == {
	PARSEFAILURE "_"abc";
    }


    ----------------------------------------------------------------------


    testList1():() == {
	PARSEFAILURE "{";
    }


    ----------------------------------------------------------------------

    
    testList2():() == {
	PARSEFAILURE "{ 1, 2, 3";
    }


    ----------------------------------------------------------------------

    
    testList3():() == {
	import from List Integer;

	assertEquals( PARSE( "{}" ), extree (empty$(List Integer)) );
    }

    
    ----------------------------------------------------------------------

    
    testList4():() == {
	import from List Integer;
	import from Integer;

	assertEquals( PARSE( "{ 1 }" ), extree [ 1 ] );
    }

    
    ----------------------------------------------------------------------
    

    testList5():() == {
	import from List Integer;
	import from Integer;

	assertEquals( PARSE( "{ 1, 2 }" ), extree [ 1, 2 ] );
    }

    
    ----------------------------------------------------------------------
    

    testList6():() == {
	import from List Integer;
	import from Integer;

	assertEquals( PARSE( "{ 1, 2, 5, 7, 9, 11 }" ), extree [ 1, 2, 5, 7, 9, 11 ] );
    }

    
    ----------------------------------------------------------------------


    testList7():() == {
	import from List Integer;
	import from Integer;

	assertEquals( PARSE( "List[ 1, 2, 5, 7, 9, 11 ]" ), extree [ 1, 2, 5, 7, 9, 11 ] );
    }

    ----------------------------------------------------------------------

    testList8():() == {
	import from List Symbol;
	import from Symbol;

	assertEquals( PARSE( "List[y1, y2, y3]" ), extree [ - "y1", - "y2", - "y3" ] );
    }

    
    ----------------------------------------------------------------------


    testPlus1():() == {
	import from Symbol;

	assertEquals( PARSE( "Plus" ), extree ( - "Plus" ) );
    }


    ----------------------------------------------------------------------

    
    testPlus2():() == {
	PARSEFAILURE "Plus[";
    }


    ----------------------------------------------------------------------

    
    testPlus3():() == {
	PARSEFAILURE "Plus[ 1, 2, 3" ;
    }


    ----------------------------------------------------------------------

    
    testPlus4():() == {

 	assertEquals( PARSE( "Plus[]" ), ExpressionTreePlus. [] );
    }

    
    ----------------------------------------------------------------------

    
    testPlus5():() == {
	import from Integer;

	assertEquals( PARSE( "Plus[1]" ), ExpressionTreePlus. [ extree 1 ] );
    }

    
    ----------------------------------------------------------------------
    

    testPlus6():() == {
	import from Integer;

	assertEquals( PARSE( "Plus[ 1, 2 ]" ), ExpressionTreePlus .  [ extree 1, extree 2 ] );
    }

    
    ----------------------------------------------------------------------
    

    testPlus7():() == {
	import from Integer;

	assertEquals( PARSE( "Plus[ 1, 2, 5, 7, 9, 11 ]" ), ExpressionTreePlus . [ extree 1, extree 2, extree 5, extree 7, extree 9, extree 11 ] );
    }

    
    ----------------------------------------------------------------------
    

    testDerivative1():() == {

	PARSEFAILURE "Derivative[";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative2():() == {

	PARSEFAILURE "Derivative[0";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative3():() == {

	PARSEFAILURE "Derivative[0]";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative4():() == {

	PARSEFAILURE "Derivative[0][y";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative5():() == {

	PARSEFAILURE "Derivative[0][y]";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative6():() == {

	PARSEFAILURE "Derivative[0][y][";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative7():() == {

	PARSEFAILURE "Derivative[0][y][s";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative8():() == {
	import from Symbol;
	local diffOp := ExpressionTreePrefix( - "diff" );
	local ET : ExpressionTree := ExpressionTreePrefix( - "y" ). [ extree ( -"s" ) ];
	assertEquals( PARSE( "Derivative[0][y][s]" ), ET );
    }

    
    ----------------------------------------------------------------------
    

    testDerivative9():() == {

	PARSEFAILURE "Derivative[0][y][s,t]";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative10():() == {

	PARSEFAILURE "Derivative[a][y][s]";

    }

    
    ----------------------------------------------------------------------
    
    
    testDerivative11():() == {
	import from Symbol;
	local diffOp := ExpressionTreePrefix( - "diff" );
	local ET : ExpressionTree := ExpressionTreePrefix( - "y" ). [ extree ( -"s" ) ];
	ET := diffOp . [ ET, extree ( - "s" ) ];
	assertEquals( PARSE( "Derivative[1][y][s]" ), ET );
    }

    
    ----------------------------------------------------------------------
    

    testDerivative12():() == {
	import from Symbol;
	local diffOp := ExpressionTreePrefix( - "diff" );
	local ET : ExpressionTree := ExpressionTreePrefix( - "y" ). [ extree ( -"s" ) ];
	ET := diffOp . [ ET, extree ( - "s" ) ];
	ET := diffOp . [ ET, extree ( - "s" ) ];
	ET := diffOp . [ ET, extree ( - "s" ) ];
	assertEquals( PARSE( "Derivative[3][y][s]" ), ET );
    }

    
    ----------------------------------------------------------------------
    

    testDerivative13():() == {
	import from Symbol;
	local diffOp := ExpressionTreePrefix( - "diff" );
	local ET : ExpressionTree := ExpressionTreePrefix( - "y" ). [ extree ( -"s" ), extree ( -"t" ), extree ( -"u" ) ];

	ET := diffOp . [ ET, extree ( - "s" ) ];
	ET := diffOp . [ ET, extree ( - "s" ) ];
	ET := diffOp . [ ET, extree ( - "u" ) ];
	
	assertEquals( PARSE( "Derivative[2,0,1][y][s,t,u]" ), ET );
    }

    
    ----------------------------------------------------------------------
    

    testDerivative14():() == {
	import from Symbol;
	local diffOp := ExpressionTreePrefix( - "diff" );
	local ET : ExpressionTree := ExpressionTreePrefix( - "y" ). [ extree ( -"s" ), extree ( -"t" ), extree ( -"u" ) ];

	ET := diffOp . [ ET, extree ( - "s" ) ];
	ET := diffOp . [ ET, extree ( - "s" ) ];
	ET := diffOp . [ ET, extree ( - "u" ) ];
	
	assertEquals( PARSE( "D[D[D[y[s,t,u],s],s],u]" ), ET );
    }

    
    ----------------------------------------------------------------------
    
    
    testVarious():() == {
	import from Integer;
	import from Symbol;
	local diffOp := ExpressionTreePrefix( - "diff" );
	local ET : ExpressionTree := ExpressionTreePrefix( - "xxd" ). [ extree ( -"a" ), extree ( -"b" ), extree ( -"c" ) ];

	ET := diffOp . [ ET, extree ( - "b" ) ];
	ET := diffOp . [ ET, extree ( - "c" ) ];
	
	ET := ExpressionTreePlus . [ ExpressionTreeTimes. [ extree 3, extree 4 ], ET ];
	assertEquals( PARSE( "Plus[ Times[ 3 ,4 ], Derivative[0,1,1][xxd][a,b,c] ]" ), ET );
    }

    
    ----------------------------------------------------------------------
    

    
}

#endif
