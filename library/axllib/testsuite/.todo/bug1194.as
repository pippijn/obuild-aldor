--* From mnd@knockdhu.dcs.st-and.ac.uk  Fri Mar  3 16:48:48 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id QAA00632
--* 	for <ax-bugs@nag.co.uk>; Fri, 3 Mar 2000 16:48:47 GMT
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id QAA23870
--* 	for ax-bugs@nag.co.uk; Fri, 3 Mar 2000 16:54:29 GMT
--* Date: Fri, 3 Mar 2000 16:54:29 GMT
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200003031654.QAA23870@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][tinfer] Conditional categories confuse type inferer

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: Use -DHACK to get it to compile without error
-- Version: 1.1.12p5 (private edition)
-- Original bug file name: cat02.as


Type: with == add;
Category: with == add;
Tuple(T: Type): with == add;
((A: Tuple Type) -> (R: Tuple Type)): with == add;



define Green:Category == with
{
   green: () -> %;
}


define Red(T:Green):Category == with
{
   red: () -> T;
}


define Blue(T:Type):Category == with
{
#if HACK
   if (T has Green) then
      Red(T pretend Green);
#else
   if (T has Green) then
      Red(T);
#endif

   blue: () -> ();
}

