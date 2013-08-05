#include "aldor.as"
#if LibraryAldorUnitRequiresLibraryAlgebra
#include "algebra.as"
#endif
#if LibraryAldorUnitRequiresLibraryExtIO
#include "extio.as"
#endif

#if BuildAldorunitLib
#else
#library AldorunitLib "aldorunit"
#endif
{
	import from AldorunitLib;
	inline from AldorunitLib;
}

--\begin{addescription}{gives a \adtype{TextWriter} to output debugging information to.}
--\adthismacro is a shorter notation for \adname[TestSuiteTools]{acquireDbgout} of \adtype{TestSuiteTools}.
--\end{addescription}
macro dbgout == { (acquireDbgout$TestSuiteTools)() }

--\begin{addescription}{provides a data structure for a test case.}
--\end{addescription}
macro NamedTestCase == Record( name:String, testCase:()->Integer );

--\begin{addescription}{constructs a \admacro{NamedTestCase} data structure.}
--\end{addescription}
macro generateNamedTestCase( NAME, TESTCASE ) == (record$NamedTestCase) ( NAME, TESTCASE );

--\begin{addescription}{provides a data structure for a test.}
--\end{addescription}
macro NamedTest == Record( name:String, test:()->() );

--\begin{addescription}{constructs a \admacro{NamedTest} data structure.}
--\end{addescription}
macro generateNamedTest( NAME, TEST ) == (record$NamedTest) ( NAME, TEST );

--\begin{addescription}{allows to assert that an expression throws an exception.}
--If \adcode{EXPRESSION} throws an exception of type \adcode{EXCEPTIONTYPE}, the assert succeeds.
--\end{addescription}
--\begin{adexceptions}
--\adthrows{AldorUnitFailedExceptionType} if \adcode{EXPRESSION} does not throw an exception of type \adcode{EXCEPTIONTYPE}
--\end{adexceptions}
--\begin{adremarks}
--\adcode{EXPRESSION} can be any expression, including \adcode|{ }| code blocks.
--\end{adremarks}
macro assertException( EXPRESSION, EXCEPTIONTYPE ) == { 
	import from Character; 
	import from String; 
	import from TextWriter; 
	fluid noExceptionThrown? : Boolean := false;
	try { 
		EXPRESSION; 
		noExceptionThrown? := true;
        } catch caughtException in { 
		caughtException has EXCEPTIONTYPE => { 
			dbgout << "assertException succeeded" << newline; 
		} 
		true => { 
			fail "assertException failed. (an exception different to the specified one has been thrown on excecuting the expression of assertException"; (); 
		} 
		never;
	} 
	if noExceptionThrown? then 
	{
		fail "assertException failed. (No Exception thrown when executing the expression of assertException)" ;
	}
}

--\begin{addescription}{defines assert functions for a given type.}
--The defined function are
--\begin{itemize}
-- \item \adname[TestCaseTools]{assertEquals} for \adcode{TYPE},
-- \item \adname[TestCaseTools]{assertNotEquals} for \adcode{TYPE},
-- \item \adname[TestCaseTools]{assertFailed} for \adcode{Partial TYPE}, and
-- \item \adname[TestCaseTools]{failSafeRetract} for \adcode{Partial TYPE}.
--\end{itemize}
--\end{addescription}
macro defineAsserts( TYPE ) == { 
    failSafeRetract( pT: Partial TYPE): TYPE throw AldorUnitFailedExceptionType == failSafeRetract( TYPE )( pT ); 
    assertFailed( pT: Partial TYPE):() throw AldorUnitFailedExceptionType == assertFailed( TYPE )( pT ); 
-- -- The following statements are not compiled properly. Therefore TYPE has to provied PrimitiveType
--    if TYPE has PrimitiveType then {
--	assertEquals( left: TYPE, right: TYPE):() throw AldorUnitFailedExceptionType == assertEquals( TYPE pretend PrimitiveType )( left, right ); 
--	assertNotEquals( left: TYPE, right: TYPE ):() throw AldorUnitFailedExceptionType == assertNotEquals( TYPE pretend PrimitiveType )( left, right );
--    }
    assertEquals( left: TYPE, right: TYPE):() throw AldorUnitFailedExceptionType == assertEquals( TYPE )( left, right ); 
    assertNotEquals( left: TYPE, right: TYPE ):() throw AldorUnitFailedExceptionType == assertNotEquals( TYPE )( left, right );
}

--\begin{addescription}{formats a \adtype{TextWriter} to highlight output.}
--This highlighting can be reset by the \admacro{RESET} macro.
--\end{addescription}
--\begin{adseealso}
-- \admacro{RESET}
--\end{adseealso}
macro HIGHLIGHT( TEXTWRITER ) ==
#if LibraryAldorUnitRequiresLibraryExtIO
    {
	import from AnsiCodes;
	if allowColor? then
	{
	    TEXTWRITER << red << bold ;
	}
    }
#else
    TEXTWRITER;
#endif

--\begin{addescription}{resets a \adtype{TextWriter} to normal output.}
--\adthismacro is typically used for \adtype{TextWriter}s that have been set to highlight by the \admacro{HIGHLIGHT} macro.
--\end{addescription}
--\begin{adseealso}
-- \admacro{HIGHLIGHT}
--\end{adseealso}
macro RESET( TEXTWRITER ) == 
#if LibraryAldorUnitRequiresLibraryExtIO
    {
	if allowColor? then
	{
	    TEXTWRITER << reset;
	}
    }
#else
    TEXTWRITER;
#endif
