-------------------------------------------------------------------------
--
-- eio_linb.test.as
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


TestStreamFormatter : TestCaseType with {

#include "eio_linb.test.signatures.as"

} == add {

    import from TestCaseTools;

    import from StringTokenizer;
    import from String;
    import from Character;
    import from MachineInteger;
    import from StreamFormatter;
    
    ----------------------------------------------------------------------

    
    testLineBreaker1():() == {
	local left: StringBuffer := new();
	local right: StringBuffer := new();
	lineBreaker( ( left :: TextWriter ), 6 ) << "abc";
	( right :: TextWriter ) << "abc";
	assertEquals( string left, string right );
    }


    ----------------------------------------------------------------------
    

    testLineBreaker2():() == {
	local left: StringBuffer := new();
	local right: StringBuffer := new();
	lineBreaker( ( left :: TextWriter ), 6 ) << "abcdefghij";
	( right :: TextWriter ) << "abcdef" << newline << "ghij";
	assertEquals( string left, string right );
    }


    ----------------------------------------------------------------------
    

    testLineBreaker3():() == {
	local left: StringBuffer := new();
	local right: StringBuffer := new();
	lineBreaker( ( left :: TextWriter ), 5 ) << "abc" << newline << "defghijkl" << newline << "mnopq" << newline << "r";
	( right :: TextWriter ) << "abc" << newline << "defgh" << newline << "ijkl" << newline << "mnopq" << newline << "r";
	assertEquals( string left, string right );
    }


    ----------------------------------------------------------------------
    
}
