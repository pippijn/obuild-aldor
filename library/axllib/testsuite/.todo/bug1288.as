--* From mnd@dcs.st-and.ac.uk  Fri Nov 10 15:11:47 2000
--* Received: from server-12.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id PAA13868
--* 	for <ax-bugs@nag.co.uk>; Fri, 10 Nov 2000 15:11:44 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 14526 invoked from network); 10 Nov 2000 15:11:07 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-12.tower-4.starlabs.net with SMTP; 10 Nov 2000 15:11:07 -0000
--* Received: from dcs.st-and.ac.uk (ara3234-ppp [138.251.206.28])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id PAA12121
--* 	for <ax-bugs@nag.co.uk>; Fri, 10 Nov 2000 15:10:43 GMT
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA24235
--* 	for ax-bugs@nag.co.uk; Fri, 10 Nov 2000 15:08:35 GMT
--* Date: Fri, 10 Nov 2000 15:08:35 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200011101508.PAA24235@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [1][tinfer] error for valid program

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun -laxllib exntype2.as
-- Version: 1.1.13(7)
-- Original bug file name: exntype2.as


#include "axllib"

define AnError:RuntimeException with == add
{
   name():String == "An error has occurred";

   printError(t:TextWriter):() ==
      t << name() << newline;
}


-- If the previous bug I've reported was wrong and the compiler was right
-- then this one must surely be a bug! Here the function return type will
-- generate a type error. Actually I think that this is the correct way of
-- writing exceptions in types so this is probably the real bug not the
-- previous one. Ho hum.
foo():() throw (AnError) ==
{
   print << "Here goes ..." << newline;
   throw AnError;
}


try foo() catch E in { true => print << "          ... BOOM!" << newline; }

print << "That's all folks!" << newline;

