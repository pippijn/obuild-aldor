-------------------------------------------------------------------------
--
-- tst_tctl.as
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

#include "aldorunit.as"

import from MachineInteger;
import from List MachineInteger;

+++\begin{addescription}{provides tools for writing tests.}
+++\end{addescription}
TestCaseTools : with {

    -----------------------------------------------------

    +++\begin{addescription}{checks if a \adtype{Boolean} is \adname[Boolean]{true}.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the passed \adtype{Boolean} parameter is \adname[Boolean]{false}.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{Boolean} value.
    +++\end{adremarks}
    assertTrue: Boolean -> () throw AldorUnitFailedExceptionType;

    +++\begin{addescription}{checks if a \adtype{Boolean} is \adname[Boolean]{false}.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the passed \adtype{Boolean} parameter is \adname[Boolean]{true}.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{Boolean} value.
    +++\end{adremarks}
    assertFalse: Boolean -> () throw AldorUnitFailedExceptionType;

    -----------------------------------------------------

    +++\begin{addescription}{gives a function for asserting equality to two values of the same type.}
    +++ \adthisname takes a \adtype{PrimitiveType} and gives a function that accepts two values of the specified \adtype{PrimitiveType}. The resulting function is used to assert that both passed values are equal. If these values are unequal, \adtype{AldorUnitFailedExceptionType} is thrown.
    +++\end{addescription}
    +++\begin{adremarks}
    +++ If the passed \adtype{PrimitiveType} has \adtype{OutputType}, the returned function prints the values it is comparing to the macro \adcode{dbgout}.
    +++\end{adremarks}
    assertEquals: ( T: PrimitiveType ) -> ( ( T, T ) -> () throw AldorUnitFailedExceptionType);
    
    +++\begin{addescription}{gives a function for asserting equality to two values of the same type.}
    +++ \adthisname takes three parameters. The first parameter is a \adtype{PrimitiveType} and is the type for the other two parameters. The function compares the second to the third parameter and asserts that they are equal.
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the second and third parameter are unequal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++ If the passed \adtype{PrimitiveType} has \adtype{OutputType}, the values that are compared are printed to the macro \adcode{dbgout}.
    +++\end{adremarks}
    assertEquals: ( T: PrimitiveType, T, T ) -> () throw AldorUnitFailedExceptionType;
    
    +++\begin{addescription}{gives a function for asserting equality to two \adtype{MachineInteger}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{MachineInteger}s are unequal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{MachineInteger} values.
    +++\end{adremarks}
    assertEquals: ( MachineInteger, MachineInteger ) -> () throw AldorUnitFailedExceptionType;

    +++\begin{addescription}{gives a function for asserting equality to two \adtype{Integer}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{Integer}s are unequal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{Integer} values.
    +++\end{adremarks}
    assertEquals: ( Integer, Integer ) -> () throw AldorUnitFailedExceptionType;

    +++\begin{addescription}{gives a function for asserting equality to two \adtype{String}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{String}s are unequal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{String} values.
    +++\end{adremarks}
    assertEquals: ( String, String ) -> () throw AldorUnitFailedExceptionType;

#if LibraryAldorUnitRequiresLibraryAlgebra
    +++\begin{addescription}{gives a function for asserting equality to two \adtype{ExpressionTree}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{ExpressionTree}s are unequal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{ExpressionTree} values.
    +++\end{adremarks}
    assertEquals: ( ExpressionTree, ExpressionTree ) -> () throw AldorUnitFailedExceptionType;
#endif

    -----------------------------------------------------

    +++\begin{addescription}{gives a function for asserting inequality to two values of the same type.}
    +++ \adthisname takes a \adtype{PrimitiveType} and gives a function that accepts two values of the specified \adtype{PrimitiveType}. The resulting function is used to assert that both passed values are unequal. If these values are equal, \adtype{AldorUnitFailedExceptionType} is thrown.
    +++\end{addescription}
    +++\begin{adremarks}
    +++ If the passed \adtype{PrimitiveType} has \adtype{OutputType}, the returned function prints the values it is comparing to the macro \adcode{dbgout}.
    +++\end{adremarks}
    assertNotEquals: ( T: PrimitiveType ) -> ( ( T, T ) -> () throw AldorUnitFailedExceptionType);

    +++\begin{addescription}{gives a function for asserting inequality to two values of the same type.}
    +++ \adthisname takes three parameters. The first parameter is a \adtype{PrimitiveType} and is the type for the other two parameters. The function compares the second to the third parameter and asserts that they are unequal.
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the second and third parameter are equal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++ If the passed \adtype{PrimitiveType} has \adtype{OutputType}, the values that are compared are printed to the macro \adcode{dbgout}.
    +++\end{adremarks}
    assertNotEquals: ( T: PrimitiveType, T, T ) -> () throw AldorUnitFailedExceptionType;

    +++\begin{addescription}{gives a function for asserting inequality to two \adtype{MachineInteger}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{MachineInteger}s are equal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{MachineInteger} values.
    +++\end{adremarks}
    assertNotEquals: ( MachineInteger, MachineInteger ) -> () throw AldorUnitFailedExceptionType;

    +++\begin{addescription}{gives a function for asserting inequality to two \adtype{Integer}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{Integer}s are equal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{Integer} values.
    +++\end{adremarks}
    assertNotEquals: ( Integer, Integer ) -> () throw AldorUnitFailedExceptionType;

    +++\begin{addescription}{gives a function for asserting inequality to two \adtype{String}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{String}s are equal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{String} values.
    +++\end{adremarks}
    assertNotEquals: ( String, String ) -> () throw AldorUnitFailedExceptionType;
#if LibraryAldorUnitRequiresLibraryAlgebra
    +++\begin{addescription}{gives a function for asserting inequality to two \adtype{ExpressionTree}s.}
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the two \adtype{ExpressionTree}s are equal.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++\adthisname uses the macro \adcode{dbgout} to output the passed \adtype{ExpressionTree} values.
    +++\end{adremarks}
    assertNotEquals: ( ExpressionTree, ExpressionTree ) -> () throw AldorUnitFailedExceptionType;
#endif

    -----------------------------------------------------

    +++\begin{addescription}{asserts that a \adtype{Partial} has a failed value.}
    +++\adthisname takes a \adcode{Type} and gives a function that acceps a \adtype{Partial} value of the passed \adcode{Type}. The resulting function asserts that \adname[Partial]{failed?} holds for the passed \adtype{Partial} value. If \adname[Partial]{failed?} does not holds for the passed \adtype{Partial} value, \adtype{AldorUnitFailedExceptionType} is thrown.
    +++\end{addescription}
    +++\begin{adremarks}
    +++ If the passed \adcode{Type} has \adtype{OutputType}, the returned function prints the passed \adtype{Partial} value to the macro \adcode{dbgout}.
    +++\end{adremarks}
    assertFailed: ( T: Type ) -> ( ( Partial T ) -> () throw AldorUnitFailedExceptionType );

    +++\begin{addescription}{asserts that a \adtype{Partial} has a failed value.}
    +++\adthisname takes two parameters. The first parameter is a \adcode{Type}. The second parameter has to be a \adtype{Partial} value in the first parameter. This function asserts that \adname[Partial]{failed?} holds for the passed \adtype{Partial} value.
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if \adname[Partial]{failed?} does not holds for the passed \adtype{Partial} value.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++ If the passed \adcode{Type} has \adtype{OutputType}, the passed \adtype{Partial} value is printed to the macro \adcode{dbgout}.
    +++\end{adremarks}
    assertFailed: ( T: Type, Partial T ) -> () throw AldorUnitFailedExceptionType;

    -----------------------------------------------------

    +++\begin{addescription}{retracts a \adtype{Partial} safely.}
    +++\adthisname takes a \adcode{Type} \adcode{T} and gives a function that maps a \adtype{Partial} value of the \adcode{T} to a value of \adcode{T}. The resulting function checks whether or not the passed \adtype{Partial} value is retractable. If it is retractable, the retracted value is returned. Otherwise, \adtype{AldorUnitFailedExceptionType} is thrown.
    +++\end{addescription}
    +++\begin{adremarks}
    +++ If the passed \adcode{Type} has \adtype{OutputType}, the returned function prints the passed \adtype{Partial} value to the macro \adcode{dbgout}.
    +++
    +++ In tests, \adtype{Partial} values are often have to be retracted to their base domain. This involves checking via \adname[Partial]{retractable?} and retracting via \adname[Partial]{retract}. With the help of \adthisname, these tasks are achieved by a single function call. Furthermore, by throwing \adtype{AldorUnitFailedExceptionType}, the current test is aborted if the regarded value is not retractable.
    +++\end{adremarks}
    failSafeRetract: ( T: Type) -> (( Partial T ) -> T throw AldorUnitFailedExceptionType);

    +++\begin{addescription}{retracts a \adtype{Partial} safely.}
    +++\adthisname takes two parameters. The first parameter is a \adcode{Type} \adcode{T}. The second parameter is a value of \adcode{Partial(T)}. \adthisname checks whether or not the passed \adtype{Partial} value is retractable. If it is retractable, the retracted value in \adcode{T} is returned.
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} if the passed \adtype{Partial} value is not retractable.
    +++\end{adexceptions}
    +++\begin{adremarks}
    +++ If the passed \adcode{Type} has \adtype{OutputType}, the passed \adtype{Partial} value is printed to the macro \adcode{dbgout}.
    +++
    +++ In tests, \adtype{Partial} values are often have to be retracted to their base domain. This involves checking via \adname[Partial]{retractable?} and retracting via \adname[Partial]{retract}. With the help of \adthisname, these tasks are achieved by a single function call. Furthermore, by throwing \adtype{AldorUnitFailedExceptionType}, the current test is aborted if the regarded value is not retractable.
    +++\end{adremarks}
    failSafeRetract: ( T: Type, Partial T ) -> T throw AldorUnitFailedExceptionType;

    -----------------------------------------------------

    +++\begin{addescription}{immediately fails a test.}
    +++\adthisname takes a \adtype{String} as parameter. This \adtype{String} denotes a description of the reason, why the running test is farced to fail.
    +++\end{addescription}
    +++\begin{adexceptions}
    +++ \adthrows{AldorUnitFailedExceptionType} in any case.
    +++\end{adexceptions}
    fail: String -> () throw AldorUnitFailedExceptionType;

    -----------------------------------------------------



} == add {



    import from Character;
    import from WriterManipulator;
    import from String;
    import from TextWriter;
    import from NamedTestCase;


    ----------------------------------------------------------------------

    
    assertTrue( booleanValue: Boolean ):() throw AldorUnitFailedExceptionType == {
	dbgout << "assertTrue( " << booleanValue << " )" << newline;
	if ~ booleanValue then 
	{
	    fail "assertTrue does not hold";
	}
	flush! dbgout;
    }

    ----------------------------------------------------------------------

    assertFalse( booleanValue: Boolean ):() throw AldorUnitFailedExceptionType == {
	dbgout << "assertFalse( " << booleanValue << " )" << newline;
	if booleanValue then 
	{
	    fail "assertFalse does not hold";
	}
	flush! dbgout;
    }

    ----------------------------------------------------------------------

    assertEquals(T: PrimitiveType): (( T, T )->() throw AldorUnitFailedExceptionType) == {
 	import from T;

        ( left: T, right: T ):() +-> {
	    dbgout << "assertEquals( ";
	    if T has OutputType then 
	    {
		local buf : StringBuffer := new();
		(<<$T) ( buf :: TextWriter, left);
		local bufString := string buf;
		if # bufString < 10 then
		{
		    (<<$T) ( dbgout << bufString << ", " , right);
		    dbgout << " ";
		} else {
		    dbgout << newline << bufString << newline << ", " << newline;
		    ((<<$T) ( dbgout , right)) << newline;
		    
		}
	    } else {
		dbgout << "??, ??";
	    }
	    dbgout << ") ";

	    if ~ ( left = right ) then
	    {
		dbgout << "failed";
		fail "assertEquals does not hold";
	    }
            dbgout << "succeeded" << newline;
	    flush! dbgout;
	}
    }

    ----------------------------------------------------------------------

    assertEquals(T: PrimitiveType, left: T, right: T ):() throw AldorUnitFailedExceptionType == assertEquals(T)(left,right);

    ----------------------------------------------------------------------

    assertEquals(left: MachineInteger, right: MachineInteger):() throw AldorUnitFailedExceptionType == assertEquals(MachineInteger)(left,right);

    ----------------------------------------------------------------------

    assertEquals(left: Integer, right: Integer):() throw AldorUnitFailedExceptionType == assertEquals(Integer)(left,right);

    ----------------------------------------------------------------------

    assertEquals(left: String, right: String):() throw AldorUnitFailedExceptionType == assertEquals(String)(left,right);

    ----------------------------------------------------------------------

    assertNotEquals(T: PrimitiveType): (( T, T )->() throw AldorUnitFailedExceptionType) == {
 	import from T;

        ( left: T, right: T ):() +-> {
	    dbgout << "assertNotEquals( ";
	    if T has OutputType then 
	    {
		local buf : StringBuffer := new();
		(<<$T) ( buf :: TextWriter, left);
		local bufString := string buf;
		if # bufString < 10 then
		{
		    (<<$T) ( dbgout << bufString << ", " , right);
		    dbgout << " ";
		} else {
		    dbgout << newline << bufString << newline << ", " << newline;
		    ((<<$T) ( dbgout , right)) << newline;
		    
		}
	    } else {
		dbgout << "??, ??";
	    }
	    dbgout << ") ";

	    if ~ ( left ~= right ) then
	    {
		dbgout << "failed";
		fail "assertNotEquals does not hold";
	    }
            dbgout << "succeeded" << newline;
	    flush! dbgout;
	}
    }

    ----------------------------------------------------------------------

    assertNotEquals(T: PrimitiveType, left: T, right: T ):() throw AldorUnitFailedExceptionType == assertNotEquals(T)(left,right);

    ----------------------------------------------------------------------

    assertNotEquals(left: MachineInteger, right: MachineInteger):() throw AldorUnitFailedExceptionType == assertNotEquals(MachineInteger)(left,right);

    ----------------------------------------------------------------------

    assertNotEquals(left: Integer, right: Integer):() throw AldorUnitFailedExceptionType == assertNotEquals(Integer)(left,right);

    ----------------------------------------------------------------------

    assertNotEquals(left: String, right: String):() throw AldorUnitFailedExceptionType == assertNotEquals(String)(left,right);

    ----------------------------------------------------------------------

    assertFailed(T: Type): (( Partial T )->() throw AldorUnitFailedExceptionType) == {
 	import from T;

        ( pT: Partial T ):() +-> {
	    if failed? pT then {
		dbgout << "assertFailed";
		if Partial T has OutputType then 
		{
		    dbgout << "( " << pT << " )";
		}
		dbgout << " succeeded" << newline;
	    } else {
		if Partial T has OutputType then 
		{
		    local strBuffer : StringBuffer := new();
		    ( strBuffer :: TextWriter ) << "argument of assertFailed (i.e.: " << pT << " ) is retractable, so assertFailed failed";
		    fail string strBuffer;
		}
		fail "argument to assertFailed is retractable";
	    }
	    flush! dbgout;
	}
    }

    ----------------------------------------------------------------------

    assertFailed( T: Type, pT: Partial T ):() throw AldorUnitFailedExceptionType == assertFailed(T)(pT);

    ----------------------------------------------------------------------

    failSafeRetract(T: Type): (( Partial T )-> T throw AldorUnitFailedExceptionType) == {
 	import from T;

        ( pT: Partial T ):T +-> {
	    if failed? pT then
	    {
		fail "argument to failSafeRetract is not retractable";
	    }
	    dbgout << "failSafeRetract";
	    if Partial T has OutputType then
	    {
		dbgout << " of " << pT;
	    }
	    dbgout << " succeeded" << newline;
	    flush! dbgout;
	    retract pT;
	}
    }

    ----------------------------------------------------------------------

    failSafeRetract( T: Type, pT: Partial T ):T throw AldorUnitFailedExceptionType == failSafeRetract(T)(pT);

    ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
    local expressionTreeFailReason: String;
    local expressionTreeFailPath: List Integer;
    
    ----------------------------------------------------------------------

    assertEquals( left : ExpressionTreeOperator, right : ExpressionTreeOperator ): Boolean == {

	import from Symbol;
	local buf: StringBuffer := new();
	
        (buf::TextWriter) << "The left (" << ( uniqueId$left ) << "," << ( name$left ) << ") and right (" << ( uniqueId$right ) << "," << ( name$right ) << ") operator differ";
	free expressionTreeFailReason := string buf;
	( uniqueId$left ) = ( uniqueId$right ) and ( name$left ) = ( name$right );
    }

    ----------------------------------------------------------------------

    leafType( leaf: ExpressionTreeLeaf ): String == {
	if boolean? leaf then
	{
	    "Boolean"	    
	} else if doubleFloat? leaf then {
	    "DoubleFloat"
#if GMP
	} else if float? leaf then {
	    "float"
#endif	    
	} else if integer? leaf then {
	    "Integer"	    
	} else if singleFloat? leaf then {
	    "SingleFloat"
	} else if machineInteger? leaf then {
	    "MachineInteger"	    
	} else if string? leaf then {
	    "String"
	} else if symbol? leaf then {
	    "Symbol"
	} else { 
	    "unknown"
	}	
    }

    ----------------------------------------------------------------------

    assertEqualsETRecursive( left : ExpressionTree, right : ExpressionTree ): Boolean == {
	import from MachineInteger;
	import from List ExpressionTree;

	leaf? left => { 
	    import from ExpressionTreeLeaf; 
	    leaf? right => {
		local buf: StringBuffer := new();

		(buf::TextWriter) << "The left (" << ( leafType( leaf left ) ) << "," << left << ") and right (" << ( leafType( leaf right ) ) << "," << right << ") leaves differ";
		free expressionTreeFailReason := string buf;
		leaf left = leaf right;
	    }
	    expressionTreeFailReason := "left argument contains leaf, right argument an expression tree";
	    false; 
	}
	leaf? right => {
	    expressionTreeFailReason := "left argument contains an expression tree, right argument a leaf";
	    false;
	}


 	local ret := assertEquals( operator left, operator right );
	
	if ret then {
	    expressionTreeFailReason := "the number of elements in the left and right expression tree differ";
	    ret := ( # arguments left = # arguments right );
	}

	local subtreeIdx: Integer := 1;
	for argumentLeft in arguments left for argumentRight in arguments right while ret repeat 
	{
	    free expressionTreeFailPath := cons( subtreeIdx, expressionTreeFailPath );
	    
	    ret := assertEqualsETRecursive( argumentLeft, argumentRight );
	    if ( ret ) then 
	    {
		expressionTreeFailPath := rest expressionTreeFailPath;
		subtreeIdx := next subtreeIdx;
	    }
	}
	ret;
    }

    ----------------------------------------------------------------------

    assertEquals( left: ExpressionTree, right: ExpressionTree):() throw AldorUnitFailedExceptionType == {
	free expressionTreeFailReason := empty;
	free expressionTreeFailPath :=empty;

	dbgout << "assertEquals(" << newline;
	dbgout << " " << left << ","<<newline;
	dbgout << " " << right << newline;
	dbgout << ") ";
	if assertEqualsETRecursive( left, right) then
	{
	    dbgout << "succeeded" << newline;
	} else {
	    dbgout << "failed" << newline;
	    dbgout << expressionTreeFailReason << " at " << ( reverse! expressionTreeFailPath ) << "." << newline;
	    fail "assertEquals does not hold";
	}
	flush! dbgout;
    }

#endif

    ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryAlgebra
    assertNotEquals(left: ExpressionTree, right: ExpressionTree):() throw AldorUnitFailedExceptionType == {	

	dbgout << "assertNotEquals(" << newline;
	dbgout << " " << left << ","<<newline;
	dbgout << " " << right << newline;
	dbgout << ") ";
	if assertEqualsETRecursive( left, right) then
	{
	    dbgout << "failed" << newline;
	    fail "assertNotEquals does not hold";
	} else {
	    dbgout << "succeeded" << newline;
	}
	flush! dbgout;
    }
#endif

    ----------------------------------------------------------------------	

    fail( reason: String == "of unspecified reason" ):() throw AldorUnitFailedExceptionType == {
	(failWithException$TestSuiteTools) reason ;
    }

    ----------------------------------------------------------------------	

}
