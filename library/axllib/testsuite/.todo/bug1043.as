--* Received: from uk.ac.nsfnet-relay by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA19635; Thu, 7 Dec 95 10:18:09 GMT
--* Received: from neptune.ethz.ch by sun2.nsfnet-relay.ac.uk with Internet SMTP 
--*           id <sg.06436-0@sun2.nsfnet-relay.ac.uk>;
--*           Thu, 7 Dec 1995 10:13:29 +0000
--* Received: from mendel.inf.ethz.ch (bronstei@mendel.inf.ethz.ch [129.132.12.20]) 
--*           by inf.ethz.ch (8.6.10/8.6.10) with ESMTP id LAA08728 
--*           for <ax-bugs@nag.co.uk>; Thu, 7 Dec 1995 11:11:29 +0100
--* From: Manuel Bronstein <bronstei@ch.ethz.inf>
--* Received: (bronstei@localhost) by mendel.inf.ethz.ch (8.6.10/8.6.10) 
--*           id LAA15006 for ax-bugs@nag.co.uk; Thu, 7 Dec 1995 11:11:28 +0100
--* Date: Thu, 7 Dec 1995 11:11:28 +0100
--* Message-Id: <199512071011.LAA15006@mendel.inf.ethz.ch>
--* To: ax-bugs@uk.co.nag
--* Subject: [9] # from List has difficulty in -Gloop

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Gloop
-- Version: 1.1.5
-- Original bug file name: pound.as

---------------------------- pound.as ----------------------------
--
-- # from List cannot be used in column 1 in the interactive loop:
-- (very very minor detail, just thought I'd mention it):
--
-- % axiomxl -Gloop
--
%1 >> #include "axllib"   
                                           Comp: 2000 msec, Interp: 100 msec
%2 >> macro I == SingleInteger;
                                           Comp: 17 msec, Interp: 0 msec
%3 >> import from I, List I;
                                           Comp: 1150 msec, Interp: 0 msec
%4 >> l := [1,2,3];
list(1, 2, 3) @ List(SingleInteger)
                                           Comp: 150 msec, Interp: 1066 msec
%5 >> #l;
      ^
[L5 C1] #1 (Warning) Unknown system command.

%6 >>   #l;
3 @ SingleInteger

