--* From mnd@dcs.st-and.ac.uk  Fri Nov 10 15:11:54 2000
--* Received: from server-10.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id PAA13912
--* 	for <ax-bugs@nag.co.uk>; Fri, 10 Nov 2000 15:11:51 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 3793 invoked from network); 10 Nov 2000 15:11:09 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-10.tower-4.starlabs.net with SMTP; 10 Nov 2000 15:11:09 -0000
--* Received: from dcs.st-and.ac.uk (ara3234-ppp [138.251.206.28])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id PAA12124
--* 	for <ax-bugs@nag.co.uk>; Fri, 10 Nov 2000 15:10:44 GMT
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA24266
--* 	for ax-bugs@nag.co.uk; Fri, 10 Nov 2000 15:10:31 GMT
--* Date: Fri, 10 Nov 2000 15:10:31 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200011101510.PAA24266@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] fun with anonymous functions

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun -laxllib -D{BRACKETED|BRACED|BARE|RIGHT|WRONG} juxta.as
-- Version: 1.1.13(6)
-- Original bug file name: juxta.as


#include "axllib"

-- Examples of invoking anonymous function values.
--
-- The aim is to create a function value and apply it without introducing
-- and names for locals or definitions. Below are five possible ways of
-- writing such a program. All are valid Aldor programs but only the first
-- two have the required semantics. The other three are semantically valid
-- but don't satisfy our aim.
--
-- The bug is that the first program generates a suspicious juxtaposition
-- warning while the last three do not. Ideally the situtation ought to be
-- reversed so that the first is accepted quietly but the final three are
-- not. The second program ought to be treated just like the first one.

#if BRACKETED
-- Define an anonymous function enclosed in () to ensure that the correct
-- juxtaposition is used. This generates a suspicious juxtaposition.
(():() +-> { print << "Success!" << newline; })();
#elseif RIGHT
-- Define a sequence containing an anonymous function. The type of the
-- sequence is ()->() and we enclose it all in () as before. This does not
-- generate a suspicious juxtaposition warning.
({():() +-> { print << "Success!" << newline; }})();
#elseif BRACED
-- This code is wrong because "(" can begin a new expression and so there
-- is an implicit statement separator between "}}" and "()".
{():() +-> { print << "Success!" << newline; }}();
#elseif BARE
-- This code is wrong because juxtaposition binds more tightly than +->.
():() +-> { print << "Success!" << newline; }();
#elseif WRONG
-- This is wrong because it is obviously two separate statements.
():() +-> print << "Success!" << newline; ();
#else
#error You must define one of BRACKETED, BRACED, BARE, RIGHT or WRONG.
#endif


