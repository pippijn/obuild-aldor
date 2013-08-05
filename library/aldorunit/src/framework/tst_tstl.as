-------------------------------------------------------------------------
--
-- tst_tstl.as
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

macro DEFAULTDEBUGLEVEL == (200@MachineInteger);
macro PRINTSUMMARY? == ( debugLevel >= 100 );
macro PRINTFAILEDBUTNOTOKTESTS? == ( debugLevel >= 200 and debugLevel < 300);
macro PRINTALLTESTS? == ( debugLevel >= 300 );

macro FINALOUT        == stdout;
macro PROGRESSOUT     == stdout;
macro FAILEDTESTNROUT == stderr;


import from MachineInteger;
import from List MachineInteger;

+++\begin{addescription}{collects functions to be used in test suites.}
+++\end{addescription}
TestSuiteTools : with {

    -----------------------------------------------------

    +++\begin{addescription}{changes the verbosity of tests and the testsuite.}
    +++The following table shows what output is made using \adname{runTestSuite}, when $val$ is passed to \adthisname.
    +++
    +++\begin{tabular}{|rcl|l|}
    +++ \hline
    +++            & val & $<  99$ & no output \\
    +++ $100 \leq$ & val & $< 199$ & summary \\
    +++ $200 \leq$ & val & $< 299$ & summary and details of failed tests\\
    +++ $300 \leq$ & val &           & summary and details of all tests \\
    +++ \hline
    +++\end{tabular}
    +++\end{addescription}
    changeDebugLevel: MachineInteger -> ();

    -----------------------------------------------------

#if LibraryAldorUnitRequiresLibraryExtIO
    +++\begin{addescription}{controls the use of color ANSI codes.}
    +++If \adthisname is passed \adname[Boolean]{true}, ANSI color codes are used for highlighting. If \adthisname is passed \adname[Boolean]{false}, highlighting is turned off.
    +++\end{addescription}
    allowColor: ( allow? : Boolean == true;) -> ();
#endif

    -----------------------------------------------------

#if LibraryAldorUnitRequiresLibraryExtIO
    +++\begin{addescription}{controls the use of the status indicator.}
    +++If \adthisname is passed \adname[Boolean]{true}, then a character is displayed when starting a test suite. If \adthisname is passed \adname[Boolean]{false}, no indicator is given.
    +++\end{addescription}
    +++\begin{adremarks}
    +++The status indicator consists of characters that symbolize a running weel. At the start of each test, the indicator rotates a bit further.
    +++\end{adremarks}
    allowProgressIndicator: ( allow? : Boolean == true;) -> ();
#endif

    -----------------------------------------------------

    +++\begin{addescription}{processes a test case.}
    +++The given \adtype{String} is the name of the test case. The first function is a function that is called before each test (see \adname[TestCaseType]{setUp} of \adtype{TestCaseType}). The \adtype{List} contains the tests. The second function is a function that is called after each test (see \adname[TestCaseType]{tearDown} of \adtype{TestCaseType}). The returned \adtype{Integer} gives the number of tests that failed.
    +++\end{addescription}
    processTestCase: ( String, ()->(), List NamedTest, ()->() ) -> Integer;
    
    +++\begin{addescription}{prints a summary of processed tests.}
    +++\end{addescription}
    printSummary: () -> ();
    
    +++\begin{addescription}{runs a test case.}
    +++The first parameter is the name of the test suite's executable. The second parameter is the name of the project that is tested by the test suite. These parameter are used solely for printing usage information. The third parameter is a \adtype{List} of the test cases.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname parses and interprets the command line parameters.
    +++\end{adremarks}
    runTestSuite: ( String, String, List NamedTestCase ) -> Integer;

    -----------------------------------------------------

    +++\begin{addescription}{aquires a \adtype{TextWriter} for the current debug level.}
    +++As different debug levels behave differently, \adthisname can be used to obtain a \adtype{TextWriter} that reflects the debug level's output policy.
    +++\end{addescription}
    +++\begin{adremarks}
    +++As \adthisname need not be constant, it is implemented as function. Therefore, an output \adtype{TextWriter} has to be aquired by
    +++
    +++\begin{adsnippet}
    +++aquireDbgout()
    +++\end{adsnippet}
    +++
    +++. \LibAldor's \adtype{TextWriter}s however are typically implemented via constant values (for example \adname[TextWriter]{stdout}). Therefore, the macro \admacro{dbgout} is introduced. This macro does not need parathesis. With the help of this macro
    +++
    +++\begin{adsnippet}
    +++aquireDbgout() << "some debug output" << newline;
    +++\end{adsnippet}
    +++
    +++can be rewritten as
    +++
    +++\begin{adsnippet}
    +++dbgout << "some debug output" << newline;
    +++\end{adsnippet}
    +++
    +++which resembles the use of the \adtype{TextWriter}'s of \LibAldor (e.g.:\adname[TextWriter]{stdout}).
    +++\end{adremarks}
    acquireDbgout:() -> TextWriter;

    -----------------------------------------------------

    +++\begin{addescription}{causes the current test to fail.}
    +++\adthisname is used solely by \adtype{TestCaseTools} to allow to format failures of \adthistype and \adtype{TestCaseTools} in the same way, without duplicating code.
    +++\end{addescription}
    +++\begin{adremarks}
    +++This function is not intended for public use. Use \adtype{TestCaseTools}'s \adname[TestCaseTools]{fail} instead.
    +++\end{adremarks}
    failWithException: String -> () throw AldorUnitFailedExceptionType;

    -----------------------------------------------------

} == add {



    import from Character;
    import from WriterManipulator;
    import from String;
    import from TextWriter;
    import from NamedTestCase;
    
    -----------------------------------------------------

#if LibraryAldorUnitRequiresLibraryExtIO
    local allowColor? : Boolean := true;
#else
    local allowColor? : Boolean := false;
#endif

    -----------------------------------------------------

    local progressIndicatorState  : MachineInteger := 0;
    local allowProgressIndicator? : Boolean := false;

    -----------------------------------------------------

    local debugLevel : MachineInteger := DEFAULTDEBUGLEVEL;

    fluid debugWriter : TextWriter;

    -----------------------------------------------------

    local sumTotalTests  : Integer := 0;
    local sumFailedTests : Integer := 0;
    local sumTestCases   : Integer := 0;
    local sumTestCaseTotalTests : Integer := 0;
    local sumTestCaseFailedTests : Integer := 0;

    ----------------------------------------------------------------------

    changeDebugLevel( l: MachineInteger ):() == {
	free debugLevel: MachineInteger;
	debugLevel := l;
    }

    ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryExtIO
    allowProgressIndicator( allow? : Boolean == true;):() == {
	free allowProgressIndicator?: Boolean;
	allowProgressIndicator? := allow?;
    }		  
#endif

    ----------------------------------------------------------------------

#if LibraryAldorUnitRequiresLibraryExtIO
    allowColor( allow? : Boolean == true;):() == {
	free allowColor?: Boolean;
	allowColor? := allow?;
    }
#endif

    ----------------------------------------------------------------------

    printProgress():() == {
	free progressIndicatorState: MachineInteger;
#if LibraryAldorUnitRequiresLibraryExtIO
	if allowProgressIndicator? then
	{
	    local progressChar : Character;
	    import from CharacterNames;
	    import from AnsiCodes;
	    if progressIndicatorState = 0 then {
		progressChar := reverseSolidus;
	    } else if progressIndicatorState = 1 then {
		progressChar := verticalLine;
	    } else if progressIndicatorState = 2 then {
		progressChar := solidus;
	    } else if progressIndicatorState = 3 then {
		progressChar := hyphenMinus;
	    } else if even? progressIndicatorState then {
		progressChar := exclamationMark;
	    } else {
		progressChar := questionMark;
	    }
	    PROGRESSOUT << saveCursor << (space$CharacterNames) << leftParenthesis << progressChar << rightParenthesis << recallCursor;
	    flush! PROGRESSOUT
	}
#endif
	progressIndicatorState := next progressIndicatorState;
	if progressIndicatorState > 3 then
	{
	    progressIndicatorState := 0;
	}
    }

    ----------------------------------------------------------------------

    failInTest( caption: String, exception: Type ):() == {
	local buf: StringBuffer := new();
	local writer: TextWriter := buf::TextWriter;
	writer << "an exception occurred in the " << caption << " function !" << newline; 
	writer << "Type:" << newline;
	writer << ( (name$Trace) exception ) << newline;
#if LibraryAldorUnitRequiresLibraryExtIO
	if exception has ExceptionType then {
	    writer << "Presentation:" << newline;
	    (print$exception) writer << newline;
	} else
#endif 
	--the following part is necessary for two situations
	--1. environments without ExtIO
	--2. exceptions coming from libraries that
	--   have been built without ExtIO
	if exception has RuntimeException then {
	    writer << "Presentation:" << newline;
	    (printError$exception) writer;
	    writer << newline;
	}
	failWithoutException string buf;
    }
    
    ----------------------------------------------------------------------
    
    runTest( name: String == "unnamed test",
      setUp: () -> () == ():() +-> {} ,
      test: () -> (),
      tearDown: () -> () == ():() +-> {} 
    ): Boolean == {

	local testOk? : Boolean := true;
	local noUnhandledException? : Boolean := true;
	printProgress();

	-- try to setup the environment

	try {
	    dbgout << "calling setUp function" << newline;
	    flush! dbgout;
	    setUp();
	    dbgout << "setUp function finished" << newline;
	    flush! dbgout;
	} catch E in {
	    true => { 
		noUnhandledException? := false;
		--failWithoutException "an exception occurred in the setup function !"; 
		failInTest( "setUp", E );
	    }
	    never;
	}

	if noUnhandledException? then
	{
	    -- test the given function
	    try {
		dbgout << "----------------------" << newline;
		dbgout << "calling test function" << newline;
		flush! dbgout;
		test();
		dbgout << "test function finished" << newline;
		flush! dbgout;
	    } catch E in {
 		E has AldorUnitFailedExceptionType => { testOk? := false; }
		true => { 
		    noUnhandledException? := false; 
		    --failWithoutException "the test threw an unhandled exception !"; 
		    failInTest( "test", E );
		}
		never;
	    }

	}

	-- cleaning up, even if setup of testFunction threw exceptions
	try {
	    dbgout << "----------------------" << newline;
	    dbgout << "calling tearDown function" << newline;
	    flush! dbgout;
	    tearDown();
	    dbgout << "tearDown function finished";-- << newline;
	    flush! dbgout;
	} catch E in {
	    true => {
		noUnhandledException? := false; 
		--failWithoutException "an exception occurred in the teardown function !"; 
		failInTest( "tearDown", E );
	    }
	    never;
	}

	noUnhandledException? and testOk?;
    }

    ----------------------------------------------------------------------

    printSummary():() == {

	if PRINTSUMMARY? then {
	    FINALOUT << "    " << newline
            << "summary of the test suite:" << newline 
            << "============================" << newline
	    << newline 
	    << "test cases      : " << sumTestCases << newline
	    << "tests           : " << sumTotalTests << newline
	    << "tests succeeded : " << (sumTotalTests-sumFailedTests) << newline;

	    if ~ zero? sumFailedTests then 
	    {
		HIGHLIGHT( FINALOUT );
	    }
	    FINALOUT << "tests failed    : " << sumFailedTests << newline;
	    if ~ zero? sumFailedTests then 
	    {
		RESET( FINALOUT );
	    }
	}

    }

    ----------------------------------------------------------------------

    printTestCaseHeader( name: String ):() == {

	FINALOUT << "+--- beginning of test case : " << name <<newline;
	FINALOUT << "|" << newline;
	flush! FINALOUT;
    }

    ----------------------------------------------------------------------

    printTestCaseFooter( name: String ):() == {
	FINALOUT << "+--- end of test case       : " << name 
	<< " ( " << sumTestCaseTotalTests << " total / "
	<< (sumTestCaseTotalTests - sumTestCaseFailedTests) << " correct / " ;

	if ~ zero? sumTestCaseFailedTests then
	{
	    HIGHLIGHT( FINALOUT );
	}
	FINALOUT << sumTestCaseFailedTests << " failed tests";
	if ~ zero? sumTestCaseFailedTests then 
	{
	    RESET( FINALOUT );
	}
	FINALOUT << " )" << newline
        << newline;
	flush! FINALOUT;
    }

    ----------------------------------------------------------------------

    printTestHeader( name: String ):() == {

	FINALOUT << "|  +--- beginning of test : " << name <<newline;
	FINALOUT << "|  | ";
	flush! FINALOUT;

    }

    ----------------------------------------------------------------------

    printTestFooter( name: String, testOk?: Boolean ):() == {

	FINALOUT << newline << "|  +--- end of test : " ;
	FINALOUT << name << "( test ";
	if testOk? then
	{
	    FINALOUT << "succeeded";
	} else { 
	    HIGHLIGHT( FINALOUT ) ;
	    FINALOUT << "failed";
	    RESET( FINALOUT );
	}
	FINALOUT << " )" << newline
	<< "|" << newline;
	flush! FINALOUT;

    }

    ----------------------------------------------------------------------

    processTestCase( testName: String == "unnamed test case",
      setUp: () -> () == ():() +-> {} ,
      tests: List NamedTest,
      tearDown: () -> () == ():() +-> {} 
    ):Integer == {

	import from NamedTest;
	local printedTestCaseHeader? := false;
	local printedTestHeader? := false;
	fluid debugWriter : TextWriter;
	local debugStringBuffer : StringBuffer;

	-- counting test cases, tests, ...
	free sumTotalTests;
	free sumFailedTests;
	free sumTestCases;
	free sumTestCaseTotalTests;
	free sumTestCaseFailedTests;

	sumTestCaseTotalTests := 0;
	sumTestCaseFailedTests := 0;

	-- the writer used for outputting the debug information
	-- of a test
	local immediateDebugWriter : TextWriter:= textWriter(
	  (ch:Character):() +-> {
	      FINALOUT << ch;
	      if ch = newline then
	      {
		  FINALOUT << "|  | ";
	      }
	      flush! FINALOUT;
	  }
	);

	if PRINTALLTESTS? then
	{
	    printTestCaseHeader testName;
	    printedTestCaseHeader? := true;
	}

	-- iterating over the tests, and performing them on the way
	for testsElement in tests repeat {

	    printedTestHeader? := false;

	    if PRINTALLTESTS? then
	    {
		printTestHeader( testsElement.name );
		printedTestHeader? := true;
		fluid debugWriter := immediateDebugWriter;
	    } else {
		debugStringBuffer := new();
		fluid debugWriter := debugStringBuffer :: TextWriter;
	    }

	    local testOk? := runTest( testsElement.name, setUp, testsElement.test, tearDown);

	    if ~ testOk? then
	    {
		if PRINTFAILEDBUTNOTOKTESTS? then
		{
		    if ~ printedTestCaseHeader? then
		    {
			printTestCaseHeader testName;
			printedTestCaseHeader? := true;
		    }
		    printTestHeader( testsElement.name );
		    printedTestHeader? := true;
		    immediateDebugWriter << debugStringBuffer;
		}

		sumTestCaseFailedTests := next sumTestCaseFailedTests;
	    }
	    if ~ testOk? and PRINTFAILEDBUTNOTOKTESTS? or PRINTALLTESTS? then
	    {
		printTestFooter( testsElement.name, testOk? );
	    }

	    sumTestCaseTotalTests := next sumTestCaseTotalTests;

	}

	if printedTestCaseHeader? then
	{
	    printTestCaseFooter testName;
	}

	sumTestCases := next sumTestCases;
	sumTotalTests  := sumTotalTests  + sumTestCaseTotalTests ;
	sumFailedTests := sumFailedTests + sumTestCaseFailedTests;

        sumTestCaseFailedTests;

    }


    ----------------------------------------------------------------------	


    printUsage( executableName: String, programName: String, namedTestCases: List NamedTestCase ):() == {

	FINALOUT << newline
        << executableName << " for " << programName << ":" << newline 
        << "===================================" << newline 
        << newline
        << "Usage: " << newline
        << "   TestSuite { -? | -h | --help | -t TESTCASE | -d DEBUGLEVEL | -n "
#if LibraryAldorUnitRequiresLibraryExtIO
        << "| -m | -p "
#endif
        << "} " << newline
        << newline
        << newline
        << "Parameters:" << newline
        << newline
        << "       -?, -h, --help  -- print this text" << newline
        << "       -t TESTCASE     -- run TESTCASE. allowed more than once" << newline
        << "                          default is all possible TestCases" << newline
        << "                          possible values for TestCase:" << newline;

	for namedTestCase in namedTestCases repeat
	{
            FINALOUT << "                            " << ( namedTestCase . name ) << newline;
	}
        FINALOUT 
	<< "       -d DEBUGLEVEL   -- specifies what is to be printed" << newline
        << "                          default : " << DEFAULTDEBUGLEVEL << newline
        << "                            ??? -  99 : nothing" << newline
        << "                            100 - 199 : summary" << newline
        << "                            200 - 299 : summary + details of failed tests" << newline
        << "                            300 - ??? : summary + details of every test" << newline
        << "       -n              -- enable printing the number of failed tests to stderr" << newline
#if LibraryAldorUnitRequiresLibraryExtIO
        << "       -m              -- force monochrome output (disable ansi codes)" << newline
	<< "       -p              -- enable progress indicator" << newline
#endif
	;

        FINALOUT << newline
        << newline
        --<< "Return value:" << newline
        --<< "       The value returned by this program is the number of failed tests." << newline
        --<< newline
        --<< newline
        << "Description:" << newline
        << newline
        << "       This program runs the test suite for the aldor project " << programName << newline
        ;


    }


    ----------------------------------------------------------------------	


    runTestSuite( executableName: String, programName: String, namedTestCases: List NamedTestCase ):Integer == {
	import from String;
	import from Character;
	import from CommandLine;
        import from List String;

        failedTests : Integer := 0;

	-- print usage and exit on flags "?" and "h"
        flag? char "?" or flag? char "h" =>
        {
            printUsage( executableName, programName, namedTestCases );
            0;
        } 

	-- setting and adapting the debug level
        local debugLevel : MachineInteger := DEFAULTDEBUGLEVEL;
        if flag? char "d" then
        {
	    try {
		debugLevels := flag char "d";
		if ~ empty? debugLevels then
		{ 
                    debugLevel := <<(first reverse! debugLevels :: TextReader);
		}
	    } catch E in {
 		E has SyntaxExceptionType => {
		    FINALOUT << "inproper uasge of the -d option" << newline;
		    printUsage( executableName, programName, namedTestCases );
		    return 0;
		}
		never;
	    }
        }
        changeDebugLevel debugLevel;

#if LibraryAldorUnitRequiresLibraryExtIO
        -- pretty printing with flag "m"
        if flag? char "m" then
        {
	    allowColor false;
        }

	-- showing the progress to the user with flag "p"
        if flag? char "p" then
        {
	    allowProgressIndicator true;
        }
#endif


	-- runnning the desired tests
	for namedTestCase in namedTestCases repeat 
	{
	    if ~ flag? char "t" or member?( namedTestCase . name , flag char "t" ) then
	    {
		failedTests := failedTests + ( namedTestCase . testCase )();
		flush! FINALOUT;
	    }
	}
	
	-- give a summary
        printSummary();
	
	-- report the number of failed tests to another stream
	if flag? char "n" then
	{
	    FAILEDTESTNROUT << failedTests << newline; 
	}
	
	-- returning the number of failed tests
        failedTests;
    }


    ----------------------------------------------------------------------


    acquireDbgout():TextWriter == {

        fluid debugWriter;
	debugWriter;
    }


    ----------------------------------------------------------------------	

    
    failWithoutException( reason:String == "of unspecified reason" ):() throw AldorUnitFailedExceptionType == {
	dbgout << newline;
	HIGHLIGHT( dbgout );
	dbgout << "failing, because " << reason;
	RESET( dbgout );
	dbgout << newline;
	flush! dbgout;
    }


    ----------------------------------------------------------------------	

    failWithException( reason:String == "of unspecified reason" ):() throw AldorUnitFailedExceptionType == {
	failWithoutException reason;
	throw AldorUnitFailedException;
    }

    ----------------------------------------------------------------------	

    
}
