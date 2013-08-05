--* From: Theodore Thomas Tsikas <themos@uk.co.nag>
--* Date: Tue, 9 Jan 96 11:21:57 GMT
--* Received: from co.uk (nags8) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA29177; Tue, 9 Jan 96 11:21:57 GMT
--* To: ax-bugs@uk.co.nag
--* Subject: [2] compiler allows bad cat. defaults violating conditions

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl cattest1a.as
-- Version: 1.1.5
-- Original bug file name: /home/red5/themos/work/basicmath/TEST/cattest1a.as

--FooCat conditionally exports fooatt1
--UseFoo extends it and uses fooatt1 regardless of the condition
--the compiler does not generate an error

#include "axllib"
define att1:Category == with {};

define FooCat(S:Type) :Category == with {
	if % has att1 then {
		fooatt1: (S,S)->%
		}
}

define UseFoo(S:Type) :Category == FooCat(S) with {
	bar:(S,S)->%;
	default bar(x:S,y:S):% == fooatt1(x,y)
}

	
