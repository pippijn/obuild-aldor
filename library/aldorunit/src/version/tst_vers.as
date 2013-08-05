-------------------------------------------------------------------------
--
-- tst_vers.as
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

macro MAJORVERSION ==  1;
macro MINORVERSION ==  0;
macro PATCHVERSION ==  3;
macro DESCRIPTION ==  "A library for testing aldor code";
macro NAME ==  "AldorUnit";
macro CREDITS ==  [  "Christian Aistleitner" ];
macro REQUIREDLIBRARIES ==  [  "Aldor" , "Algebra" , "ExtIO" ];

#include "aldor"

+++\begin{addescription}{provides information about \projectname in machine readable form.}
+++\end{addescription}
AldorUnitLibraryInformation : VersionInformationType with {

    +++\begin{addescription}{holds the names of those projects that \projectname depends on.}
    +++\end{addescription}
    +++\begin{adremarks}
    +++ This \adtype{List} is (or may be) used to determine all projects that have to be used when linking against \projectname.
    +++
    +++ For example, \LibModel's \file{configure} script takes advantage of \adthisname.
    +++\end{adremarks}
    requiredLibraries : List String;

    +++\begin{addescription}{holds a short description of the \projectname library.}
    +++\end{addescription}
    description       : String;

} == add {
	import from MachineInteger;
	import from String;
	import from List String;
	
	major == MAJORVERSION;
	minor == MINORVERSION;
	patch == PATCHVERSION;
	description == DESCRIPTION;
	requiredLibraries == REQUIREDLIBRARIES;
        version: String  == {
	    import from Character;
	    local versionBuffer : StringBuffer := new();
	    (versionBuffer :: TextWriter) << major << "." << minor << "." << patch << null;
	    string versionBuffer;		
	}
	name == NAME;
	credits == CREDITS;
}
