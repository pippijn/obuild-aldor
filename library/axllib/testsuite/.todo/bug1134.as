--* From hemmecke@aix550.informatik.uni-leipzig.de  Mon Sep 22 09:50:13 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA16162; Mon, 22 Sep 97 09:50:13 +0100
--* Received: from server1.rz.uni-leipzig.de (root@server1.rz.uni-leipzig.de [139.18.1.1])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id JAA13539 for <ax-bugs@nag.co.uk>; Mon, 22 Sep 1997 09:54:22 +0100 (BST)
--* Received: from aix550.informatik.uni-leipzig.de (aix550.informatik.uni-leipzig.de [139.18.2.14])
--* 	by server1.rz.uni-leipzig.de (8.8.5/8.8.5) with SMTP id KAA18743
--* 	for <ax-bugs@nag.co.uk>; Mon, 22 Sep 1997 10:52:04 +0200 (MESZ)
--* Received: by aix550.informatik.uni-leipzig.de (AIX 3.2/UCB 5.64/BelWue-1.1AIXRS)
--*           id AA37022; Mon, 22 Sep 1997 10:52:28 +0100
--* Date: Mon, 22 Sep 1997 10:52:28 +0100
--* From: hemmecke@aix550.informatik.uni-leipzig.de (Ralf Hemmecke)
--* Message-Id: <9709220952.AA37022@aix550.informatik.uni-leipzig.de>
--* To: ax-bugs@nag.co.uk
--* Subject: [1] cannot import from package with same name

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl xxx.as
-- Version: AXIOM-XL version 1.1.9a for AIX RS/6000
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, University of Leipzig
-- Date: 22-SEP-97
-- AXIOM-XL version 1.1.9a for AIX RS/6000
-- Subject: cannot import from package with same name

-- Compiling the code with
--   axiomxl xxx.as
-- yields the following error messages:

--:"xxx.as", line 6:   f(a:A,b:B):() == {
--:                  ....^
--:[L6 C5] #1 (Warning) Ignoring explicit import from Pkg(A).
--:
--:"xxx.as", line 8:     f a;
--:                  ......^
--:[L8 C7] #2 (Error) Argument 1 of `f' did not match any possible parameter type.
--:    The rejected type is A.
--:    Expected type a: A, b: B.


-- file xxx.as ----------------------------------------------------------
#include "axllib"
BT ==> BasicType;

Pkg(A:BT):with {f:A->()} == add {f(a:A):() == print << a << newline;}
Pkg(A:BT,B:BT):with {f:(A,B)->()} == add {
  f(a:A,b:B):() == {
    import from Pkg A;
    f a;
    print << b << newline;
  }
}

