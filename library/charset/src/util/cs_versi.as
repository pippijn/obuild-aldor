-------------------------------------------------------------------------
--
-- cs_versi.as
--
-------------------------------------------------------------------------


macro MAJORVERSION ==  1;
macro MINORVERSION ==  0;
macro PATCHVERSION ==  2;
macro DESCRIPTION ==  "A library for differential characteristic set computations";
macro NAME ==  "CharSet";
macro CREDITS ==  [  "Christian Aistleitner" ];
macro REQUIREDLIBRARIES ==  [  "Aldor" , "Algebra" , "ExtIO" ];

#include "aldor"

+++\begin{addescription}{provides information about \projectname in machine readable form}
+++\end{addescription}
CharSetLibraryInformation : VersionInformationType with {
    +++\begin{addescription}{holds the names of those projects that \projectname depends on}
    +++\end{addescription}
    +++\begin{adremarks}
    +++ This \adtype{List} is (or may be) used to determine all projects that have to be used when linking against \projectname.
    +++
    +++ For example, \LibModel's \file{configure} script takes advantage of \adthisname.
    +++\end{adremarks}
    requiredLibraries : List String;

    +++\begin{addescription}{holds a short description of the \projectname library}
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
