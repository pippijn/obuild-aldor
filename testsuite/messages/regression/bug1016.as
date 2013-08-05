--* Received: from uk.ac.nsfnet-relay by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA07700; Tue, 12 Sep 95 11:00:58 BST
--* Received: from server1.rz.uni-leipzig.de by sun3.nsfnet-relay.ac.uk 
--*           with Internet SMTP id <sg.20190-0@sun3.nsfnet-relay.ac.uk>;
--*           Tue, 12 Sep 1995 10:57:00 +0100
--* Received: from aix550.informatik.uni-leipzig.de by server1.rz.uni-leipzig.de 
--*           with SMTP (1.37.109.16/16.2) id AA165748289;
--*           Tue, 12 Sep 1995 11:31:30 +0200
--* Received: by aix550.informatik.uni-leipzig.de (AIX 3.2/UCB 5.64/BelWue-1.1AIXRS) 
--*           id AA14456; Tue, 12 Sep 1995 11:33:40 +0100
--* Date: Tue, 12 Sep 1995 11:33:40 +0100
--* From: hemmecke@de.uni-leipzig.informatik.aix550 (Ralf Hemmecke)
--* Message-Id: <9509121033.AA14456@aix550.informatik.uni-leipzig.de>
--* To: ax-bugs@uk.co.nag
--* Subject: [7] use of fluid
--* Sender: hemmecke@de.uni-leipzig.informatik.aix550

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl xxx.as
-- Version: AXIOM-XL version 1.1.3 for AIX RS/6000
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, University of Leipzig
-- Date: 12-SEP-95
-- AXIOM-XL version 1.1.3 for AIX RS/6000
-- Subject: use of fluid

-- Although this program is not very useful, and it certainly contains the
-- wrong use of `local' (it should be `fluid' there, I guess), but it
-- results in the compile message:

--: Compiler bug...Bug: Yow

-- with `axiomxl xxx.as'. Which is not very helping if one does not 
-- know what is wrong.

#include "axllib.as"

MAIN():()=={
  local x:Integer:=0;
  f():Integer == {fluid x:Integer:=x+1; print << "x="<<x << newline; 0}
  f(); x:=7; f()
}
MAIN()

