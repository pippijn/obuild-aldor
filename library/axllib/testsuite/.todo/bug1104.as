--* From bronstei@inf.ethz.ch  Fri Oct 25 09:54:22 1996
--* Received: from nags2.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA16661; Fri, 25 Oct 96 09:54:22 +0100
--* Received: from inf.ethz.ch (neptune.ethz.ch) by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA17087; Fri, 25 Oct 96 10:00:16 BST
--* Received: from ru8.inf.ethz.ch (bronstei@ru8.inf.ethz.ch [129.132.12.17]) by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id KAA06702 for <ax-bugs@nag.co.uk>; Fri, 25 Oct 1996 10:53:46 +0200
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (from bronstei@localhost) by ru8.inf.ethz.ch (8.7.1/8.7.1) id KAA00307 for ax-bugs@nag.co.uk; Fri, 25 Oct 1996 10:53:44 +0200 (MET DST)
--* Date: Fri, 25 Oct 1996 10:53:44 +0200 (MET DST)
--* Message-Id: <199610250853.KAA00307@ru8.inf.ethz.ch>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] command line -h problem

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.7
-- Original bug file name: cmdline.txt

% axiomxl -h z
Debug options:
  -Z db           Generate debugging information in object files.
  -Z prof         Generate profiling code in object files.
 
  Use `axiomxl -h help' for a menu of more detailed help.
 
% axiomxl -h y
Improper use of `-h' option.  Type `axiomxl -help' for help.

