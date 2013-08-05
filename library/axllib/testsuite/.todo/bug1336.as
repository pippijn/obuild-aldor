--* From mnd@knockdhu.dcs.st-and.ac.uk  Thu Nov  8 12:55:05 2001
--* Received: from welly-4.star.net.uk (welly-4.star.net.uk [195.216.16.162])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id MAA08707
--* 	for <ax-bugs@nag.co.uk>; Thu, 8 Nov 2001 12:55:04 GMT
--* Received: (qmail 21007 invoked from network); 8 Nov 2001 12:54:28 -0000
--* Received: from 7.star-private-mail-12.star.net.uk (HELO smtp-in-7.star.net.uk) (10.200.12.7)
--*   by 204.star-private-mail-4.star.net.uk with SMTP; 8 Nov 2001 12:54:28 -0000
--* Received: (qmail 6179 invoked from network); 8 Nov 2001 12:54:27 -0000
--* Received: from mail17.messagelabs.com (62.231.131.67)
--*   by smtp-in-7.star.net.uk with SMTP; 8 Nov 2001 12:54:27 -0000
--* X-VirusChecked: Checked
--* Received: (qmail 22360 invoked from network); 8 Nov 2001 12:53:45 -0000
--* Received: from knockdhu.dcs.st-and.ac.uk (138.251.206.239)
--*   by server-9.tower-17.messagelabs.com with SMTP; 8 Nov 2001 12:53:45 -0000
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.11.2/8.11.2) id fA8CvD808009
--* 	for ax-bugs@nag.co.uk; Thu, 8 Nov 2001 12:57:13 GMT
--* Date: Thu, 8 Nov 2001 12:57:13 GMT
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200111081257.fA8CvD808009@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [3][optimiz] float folding of inf/nan fails

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: aldor -Q2 -grun -laxllib infbug.as
-- Version: 1.0.-2(2)
-- Original bug file name: infbug.as


-- We must never float-fold constants that evaluate to inf or NaN.

#include "axllib"

main():() ==
{
   infinity:SingleFloat := 1.0e30 * 1.0e30;
   notANumber:SingleFloat := infinity-infinity;

   print << "Infinity = ";
   -- This line fails: when optimised -O2 we peep-hole float-fold "infinity"
   -- and get "inf" (from sprintf).
   print << infinity;
   print << newline;

   print << "NaN = ";
   -- This line fails: when optimised -O2 we peep-hole float-fold "notANumber"
   -- and get "nan" (from sprintf).
   print << notANumber;
   print << newline;
}

main();

