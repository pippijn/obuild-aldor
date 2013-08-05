--* From mnd@dcs.st-and.ac.uk  Tue Jan  2 23:35:52 2001
--* Received: from server-8.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id XAA14059
--* 	for <ax-bugs@nag.co.uk>; Tue, 2 Jan 2001 23:35:45 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 1867 invoked from network); 2 Jan 2001 23:29:49 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-8.tower-4.starlabs.net with SMTP; 2 Jan 2001 23:29:49 -0000
--* Received: from dcs.st-and.ac.uk (ara3263-ppp [138.251.206.30])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id XAA09833
--* 	for <ax-bugs@nag.co.uk>; Tue, 2 Jan 2001 23:35:13 GMT
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id XAA14294
--* 	for ax-bugs@nag.co.uk; Tue, 2 Jan 2001 23:36:44 GMT
--* Date: Tue, 2 Jan 2001 23:36:44 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200101022336.XAA14294@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][other=abpretty] Incomplete types in error messages

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -laxllib bug1292.as
-- Version: 1.1.13(11)
-- Original bug file name: exnerr.as


#include "axllib"

AnError:RuntimeException with == add
{
   name():String == "An error has occurred";

   printError(t:TextWriter):() ==
      t << name() << newline;
}


AnotherError:with == add;


foo():() throw (RuntimeException) ==
{
   print << "Here goes ..." << newline;
   -- This throw is wrong: typeOf(AnotherError) is (with == add) which
   -- doesn't satisfy RuntimeException. The bug is that the error message
   -- is ... type  except RuntimeException not ... type () except ...
   throw AnotherError;
}


try foo() catch E in { true => print << "          ... BOOM!" << newline; }

print << "That's all folks!" << newline;


