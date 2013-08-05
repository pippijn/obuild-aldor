-------------------------------------------------------------------------
--
-- cs_cstls.test.as
--
-------------------------------------------------------------------------

#include "charset"
#include "aldorunit"


TestExportedCoherentAutoreducedSetTools : TestCaseType with {

#include "cs_cstls.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from String;
    import from ExportedCoherentAutoreducedSetTools;
    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet1():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------

    
    testCoherentAutoreducedSet2():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "presortClasses,LexicographicEliminationOrder" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------

    
    testCoherentAutoreducedSet3():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "SortedListExponent,OrderlyEliminationOrder" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet4():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "SortedListExponent,presortClasses" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet5():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "ListExponent,RecursivePolynomialRingViaPercentArray" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet6():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "ListSortedExponent,presortClasses" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet7():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "CumulativeExponent,DistributedMultivariatePolynomial1,OrderlyOrder" ), "[diff(c(s,r,t),t),a(s,r,t)]" );	    
    }

    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet8():() == {
	assertEquals( string coherentAutoreducedSet( pointer "maple", pointer "[ a(s,r,t)+diff(diff(c(s,r,t),r),t), diff(c(s,r,t),t) ]", pointer "[ a, b, c ]", pointer "[ s, r, t ]", pointer "presortClasses,OrderlyOrder" ), "ERROR(_"cannot use presortClasses for differential variables, that do not have an elimination order_");" );
    }

    
    ----------------------------------------------------------------------


    testCoherentAutoreducedSet9():() == {
	assertEquals( string coherentAutoreducedSet( pointer "mathematicafullform", pointer "{ Plus[a[s,r,t],D[D[c[s,r,t],r],t]],D[c[s,r,t],t] }", pointer "{ a, b, c }", pointer "{ s, r, t }", pointer "ListSortedExponent,presortClasses" ), "List[Derivative[0,0,1][c][s,r,t],a[s,r,t]]" );	    
    }

    
    ----------------------------------------------------------------------



}
