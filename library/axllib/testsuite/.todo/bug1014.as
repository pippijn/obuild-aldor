--* Received: from uk.ac.nsfnet-relay by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA02754; Sat, 9 Sep 95 15:59:43 BST
--* Received: from server1.rz.uni-leipzig.de by sun3.nsfnet-relay.ac.uk 
--*           with Internet SMTP id <sg.16191-0@sun3.nsfnet-relay.ac.uk>;
--*           Sat, 9 Sep 1995 15:56:04 +0100
--* Received: from aix550.informatik.uni-leipzig.de by server1.rz.uni-leipzig.de 
--*           with SMTP (1.37.109.16/16.2) id AA114098560;
--*           Sat, 9 Sep 1995 16:56:00 +0200
--* Received: by aix550.informatik.uni-leipzig.de (AIX 3.2/UCB 5.64/BelWue-1.1AIXRS) 
--*           id AA20519; Sat, 9 Sep 1995 16:58:08 +0100
--* Date: Sat, 9 Sep 1995 16:58:08 +0100
--* From: hemmecke@de.uni-leipzig.informatik.aix550 (Ralf Hemmecke)
--* Message-Id: <9509091558.AA20519@aix550.informatik.uni-leipzig.de>
--* To: ax-bugs@uk.co.nag
--* Subject: [7] difference interactive/non-interactive mode
--* Sender: hemmecke@de.uni-leipzig.informatik.aix550

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl xxx.as
-- Version: AXIOM-XL version 1.1.3 for AIX RS/6000
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, University of Leipzig
-- Date: 09-SEP-95
-- AXIOM-XL version 1.1.3 for AIX RS/6000 
-- Subject: difference interactive/non-interactive mode

-- As I realized earlier when I checked my old bugs with the new version
-- (V1.1.3) there now seems to be a differenc between interactive and
-- non-interactive mode of the compiler. This bug has probably something to
-- do with return type of my function buildDomains.

-- There are 3 possible ways to use that script.
-- 1) compile via axiomxl xxx.as
-- 2) axiomxl -gloop
--    %1>> #include "xxx.as"
-- 3) axiomxl -gloop
--    Now use the mouse to drag&drop that little program into the axiomxl
--    window.

-- Results:

-- (1) and (2) yield the same error, namely:
--:"xxx.as", line 18: g==f$D;
--:                   ....^^
--:[L18 C5] #2 (Error) Have determined 0 possible types for the expression.
--:[L18 C6] #1 (Error) No meaning for identifier `D'.
--:
--:"xxx.as", line 19: g(2);
--:                   ^
--:[L19 C1] #3 (Error) There are no suitable meanings for the operator `g'.

-- In case (3) that problem does not occur.

-- If one adds the switch `-DC1' the compiler does not complain.
-- But I want to return a tuple of (dependent) domains, so I mentioned 
-- the C1 case only to help you finding the bug. 
--------------------------
#include "axllib"
BT ==> BasicType;
INT ==> Integer;
define Cat:Category == BT with {f:INT->INT}
Dom(x:INT,R:BT):Cat == Integer add { f(z:INT):INT == x+z }
import from INT;
#if C1
buildDomains(R:BT,x: INT): Cat  == Dom(x,R);
D == buildDomains(INT,2);
#else
buildDomains(R:BT,x: INT): (BT,Cat) == (R,Dom(x,R));
(R,D) == buildDomains(INT,2);
#endif
g==f$D;
print << g(2) << newline;
