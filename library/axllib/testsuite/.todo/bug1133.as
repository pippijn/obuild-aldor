--* From hemmecke@aix550.informatik.uni-leipzig.de  Wed Aug 27 11:10:04 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA02374; Wed, 27 Aug 97 11:10:04 +0100
--* Received: from server1.rz.uni-leipzig.de (root@server1.rz.uni-leipzig.de [139.18.1.1])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id LAA23704 for <ax-bugs@nag.co.uk>; Wed, 27 Aug 1997 11:13:34 +0100 (BST)
--* Received: from aix550.informatik.uni-leipzig.de (aix550.informatik.uni-leipzig.de [139.18.2.14])
--* 	by server1.rz.uni-leipzig.de (8.8.5/8.8.5) with SMTP id MAA03999
--* 	for <ax-bugs@nag.co.uk>; Wed, 27 Aug 1997 12:11:14 +0200 (MESZ)
--* Received: by aix550.informatik.uni-leipzig.de (AIX 3.2/UCB 5.64/BelWue-1.1AIXRS)
--*           id AA26499; Wed, 27 Aug 1997 12:10:38 +0100
--* Date: Wed, 27 Aug 1997 12:10:38 +0100
--* From: hemmecke@aix550.informatik.uni-leipzig.de (Ralf Hemmecke)
--* Message-Id: <9708271110.AA26499@aix550.informatik.uni-leipzig.de>
--* To: ax-bugs@nag.co.uk
--* Subject: [3] conditional def of domain constants

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -DC2 -fx xxx.as
-- Version: AXIOM-XL version 1.1.9a for AIX RS/6000
-- Original bug file name: xxx.as

-- The following program doeas not compile in the C2 case. With the
-- command:
--   axiomxl -DC2 -fx xxx.as
-- I got:
--: Program fault (segmentation violation).#1 (Error) Program fault (segmentation violation).

#include "axllib"

define Cat: Category == with {f: () -> String}
Dom1(s:String):Cat == add {f():String == concat("1-",s)}
Dom2(s:String):Cat == add {f():String == concat("2-",s)}

MAIN(opt:String):() == {

#if C1
D:Cat == if opt = "1" then Dom1 "xxx" else Dom2 "yyy";
#elseif C2
D:Cat == if opt = "1" then Dom1 "xxx" add else Dom2 "yyy" add;
#elseif C3
FD():Cat == if opt = "1" then Dom1 "xxx" add else Dom2 "yyy" add;
D==FD();
#endif

print << f()$D << newline;
}

MAIN("1");
