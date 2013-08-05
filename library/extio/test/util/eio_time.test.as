-------------------------------------------------------------------------
--
-- eio_time.test.as
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


TestTimes : TestCaseType with {

#include "eio_time.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from Times;
    import from MachineInteger;
    defineAsserts( Times );
    
    ----------------------------------------------------------------------

    
    testEquals(): () == {
	local time:= failSafeRetract( times() );
	assertEquals( time, time );
    }

    ----------------------------------------------------------------------

    testNotEquals(): () == {
	local time1:= failSafeRetract( times() );
	local time2 := copy time1;
	time2 . real := next ( time2 . real ); 
	assertNotEquals( time1, time2 );
    }

    ----------------------------------------------------------------------

    testCopy(): () == {
	local time:= failSafeRetract( times() );
	assertEquals( time, copy time );
    }

    ----------------------------------------------------------------------

    testReal(): () == {
	local time1:= failSafeRetract( times() );
	local time2 := copy time1;
	assertEquals( time1, time2 );

	local oldval := time2 . real;
	time2 . real := next oldval;
	assertNotEquals( time1, time2 );
	assertEquals( time2 . real, next oldval ); 
	
	time2 . real := oldval;
	assertEquals( time2 . real, oldval ); 
	assertEquals( time1, time2 );
    }

    ----------------------------------------------------------------------

    testUtime(): () == {
	local time1:= failSafeRetract( times() );
	local time2 := copy time1;
	assertEquals( time1, time2 );

	local oldval := time2 . utime;
	time2 . utime := next oldval;
	assertNotEquals( time1, time2 );
	assertEquals( time2 . utime, next oldval ); 
	
	time2 . utime := oldval;
	assertEquals( time2 . utime, oldval ); 
	assertEquals( time1, time2 );
    }

    ----------------------------------------------------------------------

    testStime(): () == {
	local time1:= failSafeRetract( times() );
	local time2 := copy time1;
	assertEquals( time1, time2 );

	local oldval := time2 . stime;
	time2 . stime := next oldval;
	assertNotEquals( time1, time2 );
	assertEquals( time2 . stime, next oldval ); 
	
	time2 . stime := oldval;
	assertEquals( time2 . stime, oldval ); 
	assertEquals( time1, time2 );
    }

    ----------------------------------------------------------------------

    testCutime(): () == {
	local time1:= failSafeRetract( times() );
	local time2 := copy time1;
	assertEquals( time1, time2 );

	local oldval := time2 . cutime;
	time2 . cutime := next oldval;
	assertNotEquals( time1, time2 );
	assertEquals( time2 . cutime, next oldval ); 
	
	time2 . cutime := oldval;
	assertEquals( time2 . cutime, oldval ); 
	assertEquals( time1, time2 );
    }

    ----------------------------------------------------------------------

    testCstime(): () == {
	local time1:= failSafeRetract( times() );
	local time2 := copy time1;
	assertEquals( time1, time2 );

	local oldval := time2 . cstime;
	time2 . cstime := next oldval;
	assertNotEquals( time1, time2 );
	assertEquals( time2 . cstime, next oldval ); 
	
	time2 . cstime := oldval;
	assertEquals( time2 . cstime, oldval ); 
	assertEquals( time1, time2 );
    }

    ----------------------------------------------------------------------



    
    
}
