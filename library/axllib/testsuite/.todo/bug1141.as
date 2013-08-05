--* From youssef@mailer.scri.fsu.edu  Wed Jun  3 00:16:23 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA20069; Wed, 3 Jun 98 00:16:23 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id AAA29157 for <ax-bugs@nag.co.uk>; Wed, 3 Jun 1998 00:17:07 +0100 (BST)
--* Received: from dirac.scri.fsu.edu (dirac.scri.fsu.edu [144.174.128.44]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id TAA27525; Tue, 2 Jun 1998 19:14:24 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac.scri.fsu.edu (5.67b) id AA32816; Tue, 2 Jun 1998 19:14:24 -0400
--* Date: Tue, 2 Jun 1998 19:14:24 -0400
--* Message-Id: <199806022314.AA32816@dirac.scri.fsu.edu>
--* To: adk@mailer.scri.fsu.edu, ax-bugs@nag.co.uk, edwards@mailer.scri.fsu.edu,
--*         youssef@mailer.scri.fsu.edu
--* Subject: [3] error in evaluating function argument?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Fx file.as
-- Version: 1.1.10c
-- Original bug file name: bug2.as

--+ 
--+ --
--+ -- Peter,
--+ --
--+ --    I think that I've run into an axiomxl bug here.  The following
--+ --  program has two evaluations of "interval".  Since mlow>=0.0, the
--+ --  arguments of the two calls are identical.  However, the output
--+ --  shows that they are not.  I suspect that the compiler is getting
--+ --  confused with the "{mlow>=0.0=>...}" expression and passing junk
--+ --  to the interval function.
--+ --
--+ --     I've tried a bit to simplify this by replacing Interval(F,1)
--+ --  with something simpler, but so far, I haven't been able to do this 
--+ --  without causing the bug to disappear.  Is this a known problem?
--+ --  If you like, I can send you what you need to reproduce the effect
--+ --  or continue trying to simplify.
--+ --
--+ --    Saul
--+ --     
--+ --
--+ #include "intervals"
--+ #include "axllib"
--+ #pile
--+ 
--+ F  ==> SDoubleFloat  -- this is a slightly modified version of DoubleFloat
--+ 
--+ import from SingleInteger,F,Interval(F,1)
--+ 
--+ mlow  :=   1.0
--+ mhigh :=   2.0
--+ 
--+ im2:Interval(F,1) := interval({mlow>=0.0 => mlow*mlow; -mlow*mlow},mhigh*mhigh)
--+ print << im2 << newline
--+ 
--+ im2 := interval(mlow*mlow,mhigh*mhigh)
--+ print << im2 << newline
--+ 
--+ --  executing this program produces the following output:
--+ --
--+ --  Interval: array(2.3873348330087346e-314)..array(4) <-- the low bound is wrong
--+ --  Interval: array(1)..array(4)                       <-- the right answer
--+ --

--
-- Peter,
--
--    I think that I've run into an axiomxl bug here.  The following
--  program has two evaluations of "interval".  Since mlow>=0.0, the
--  arguments of the two calls are identical.  However, the output
--  shows that they are not.  I suspect that the compiler is getting
--  confused with the "{mlow>=0.0=>...}" expression and passing junk
--  to the interval function.
--
--     I've tried a bit to simplify this by replacing Interval(F,1)
--  with something simpler, but so far, I haven't been able to do this 
--  without causing the bug to disappear.  Is this a known problem?
--  If you like, I can send you what you need to reproduce the effect
--  or continue trying to simplify.
--
--    Saul
--     
--
#include "intervals"
#include "axllib"
#pile

F  ==> SDoubleFloat  -- this is a slightly modified version of DoubleFloat

import from SingleInteger,F,Interval(F,1)

mlow  :=   1.0
mhigh :=   2.0

im2:Interval(F,1) := interval({mlow>=0.0 => mlow*mlow; -mlow*mlow},mhigh*mhigh)
print << im2 << newline

im2 := interval(mlow*mlow,mhigh*mhigh)
print << im2 << newline

--  executing this program produces the following output:
--
--  Interval: array(2.3873348330087346e-314)..array(4) <-- the low bound is wrong
--  Interval: array(1)..array(4)                       <-- the right answer
--
