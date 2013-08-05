--* From mnd@knockdhu.dcs.st-and.ac.uk  Fri Sep  7 12:44:48 2001
--* Received: from mail-delivery-1.star.net.uk (welly-1.star.net.uk [195.216.16.165])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id MAA13890
--* 	for <ax-bugs@nag.co.uk>; Fri, 7 Sep 2001 12:44:48 +0100 (BST)
--* Received: (qmail 31661 invoked from network); 7 Sep 2001 11:44:20 -0000
--* Received: from 6.star-private-mail-12.star.net.uk (HELO smtp-in-6.star.net.uk) (10.200.12.6)
--*   by delivery-1.star-private-mail-4.star.net.uk with SMTP; 7 Sep 2001 11:44:20 -0000
--* Received: (qmail 21163 invoked from network); 7 Sep 2001 11:44:20 -0000
--* Received: from mail17.messagelabs.com (62.231.131.67)
--*   by smtp-in-6.star.net.uk with SMTP; 7 Sep 2001 11:44:20 -0000
--* X-VirusChecked: Checked
--* Received: (qmail 28615 invoked from network); 7 Sep 2001 11:28:51 -0000
--* Received: from host213-122-55-193.btinternet.com (HELO knockdhu.dcs.st-and.ac.uk) (213.122.55.193)
--*   by server-3.tower-17.messagelabs.com with SMTP; 7 Sep 2001 11:28:51 -0000
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.11.2/8.11.2) id f87BD6e20426
--* 	for ax-bugs@nag.co.uk; Fri, 7 Sep 2001 12:13:06 +0100
--* Date: Fri, 7 Sep 2001 12:13:06 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200109071113.f87BD6e20426@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] Interpreter doesn't warn about use-before-def

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: Just type each line into a -gloop session
-- Version: 1.0.-1(4)
-- Original bug file name: bill0.as

#include "axllib"

foo():() == {
	import from SingleInteger;
	local a:Tuple(Integer);
	print << length(a);
}
