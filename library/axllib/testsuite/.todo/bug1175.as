--* From mnd@dCS.st-and.ac.uk  Mon Oct 18 15:40:12 1999
--* Received: from pittyvaich.dcs.st-and.ac.uk (pittyvaich.dcs.st-and.ac.uk [138.251.206.55])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA17257
--* 	for <ax-bugs@nag.co.uk>; Mon, 18 Oct 1999 15:39:59 +0100 (BST)
--* Received: from kininvie.dcs.st-and.ac.uk (kininvie [138.251.206.236])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id PAA14922
--* 	for <ax-bugs@nag.co.uk>; Mon, 18 Oct 1999 15:40:01 +0100 (BST)
--* Received: (from mnd@localhost) by kininvie.dcs.st-and.ac.uk (8.9.3/8.6.12) id PAA02407 for ax-bugs@nag.co.uk; Mon, 18 Oct 1999 15:39:18 +0100
--* Date: Mon, 18 Oct 1999 15:39:18 +0100
--* From: "Martin N. Dunstan" <mnd@dCS.st-and.ac.uk>
--* Message-Id: <199910181439.PAA02407@kininvie.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] Syntax errors are too terse

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p4 (personal edition)
-- Original bug file name: radixbug.as


#include "axllib"


import from SingleInteger;

-- These two lines cause the compiler to generate "Syntax error" without
-- any explanation of what the error was. The compiler knows what the
-- reason and it ought to tell the user.
print << "1 base 37   = " << (37rZ) << " (is invalid)" << newline;
print << "1 base 1    = " << (1rZ)  << " (is invalid)" << newline;

