--* From youssef@buphyk.bu.edu  Thu Jan  4 20:06:05 2001
--* Received: from server-6.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id UAA03834
--* 	for <ax-bugs@nag.co.uk>; Thu, 4 Jan 2001 20:06:04 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 22836 invoked from network); 4 Jan 2001 20:01:19 -0000
--* Received: from buphyk.bu.edu (128.197.41.10)
--*   by server-6.tower-4.starlabs.net with SMTP; 4 Jan 2001 20:01:19 -0000
--* Received: (from youssef@localhost)
--* 	by buphyk.bu.edu (8.9.3/8.9.3) id PAA26455
--* 	for ax-bugs@nag.co.uk; Thu, 4 Jan 2001 15:05:14 -0500
--* Date: Thu, 4 Jan 2001 15:05:14 -0500
--* From: Saul Youssef <youssef@buphyk.bu.edu>
--* Message-Id: <200101042005.PAA26455@buphyk.bu.edu>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] Recursive category bug

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.13p1(5)
-- Original bug file name: recursivecategorybug.as

--+ --
--+ --  Hi Martin & Themos,
--+ -- 
--+ --      I've got some neat ideas related to recursive aldor categories, but I've run into
--+ --  a determined looking bug.  If you compile the code below with
--+ --
--+ --   axiomxl -Fao -M no-abbrev
--+ --
--+ --  You will get 
--+ --
--+ --  {* (Export) pb * }
--+ --  <* General (* (* <= *) (* AB *) (* B *) *) *>
--+ --  Compiler bug...Bug: can't create dummy
--+ --
--+ --  If you replace the last line with the last commented line, you get a core dump instead.
--+ --
--+ --  [The message above is what you get in 1.1.12p6.  In 1.1.13p1(5), you get
--+ --   a different message.]
--+ --
--+ --     Saul
--+ --
--+ #include "axllib"
--+ #pile
--+     
--+ define Goon:Category == with
--+ define Done:Category == with
--+ define  Min:Category == with
--+ define  Max:Category == with
--+ 
--+ define nPoset:Category == with
--+     if % has Goon then { <=: (%,%) -> nPoset  }
--+     if % has Done then { <=: (%,%) -> Boolean }
--+     
--+     if % has Min then { min:%; min:(x:%)->(max <=   x) }
--+     if % has Max then { max:%; max:(x:%)->(x   <= max) }
--+     
--+ define Set:Category == with
--+     =: (%,%) -> Boolean
--+     
--+ (A:Set)<=(B:Set):nPoset with 
--+     mor: (A->B) -> %
--+ == add
--+     mor(f:A->B):% == error " "
--+ 
--+ Product(A:Set,B:Set):nPoset with Goon with Max == add
--+     Rep == Record(X:Set,pa:(X<=A),pb:(X<=B)); import from Rep
--+     
--+     (P:%)<=(Q:%):nPoset == ((rep P).X)<=((rep Q).X)
--+     
--+     max: % == 
--+         AB:Set == add
--+ 	    Rep ==> Record(a:A,b:B); import from Rep
--+ 	    (x:%)=(y:%):Boolean == (rep x).a = (rep y).a and (rep x).b = (rep y).b
--+ 	RepP == Record(a:A,b:B); import from RepP
--+ 	pa:(AB<=A) == mor ( (ab:AB):A +-> (ab pretend RepP).a )
--+ 	pb:(AB<=B) == mor ( (ab:AB):B +-> (ab pretend RepP).b )
--+ 	
--+ 	[AB,pa,pb] pretend %    
--+ 
--+     max(x:%):(x<=max) == error " "  -- to see "can't create dummy compiler bug"
--+ --    max(x:%):(x<=max) == add        -- to see a core dump
--+     
--
--  Hi Martin & Themos,
-- 
--      I've got some neat ideas related to recursive aldor categories, but I've run into
--  a determined looking bug.  If you compile the code below with
--
--   axiomxl -Fao -M no-abbrev
--
--  You will get 
--
--  {* (Export) pb * }
--  <* General (* (* <= *) (* AB *) (* B *) *) *>
--  Compiler bug...Bug: can't create dummy
--
--  If you replace the last line with the last commented line, you get a core dump instead.
--
--  [The message above is what you get in 1.1.12p6.  In 1.1.13p1(5), you get
--   a different message.]
--
--     Saul
--
#include "axllib"
#pile
    
define Goon:Category == with
define Done:Category == with
define  Min:Category == with
define  Max:Category == with

define nPoset:Category == with
    if % has Goon then { <=: (%,%) -> nPoset  }
    if % has Done then { <=: (%,%) -> Boolean }
    
    if % has Min then { min:%; min:(x:%)->(max <=   x) }
    if % has Max then { max:%; max:(x:%)->(x   <= max) }
    
define Set:Category == with
    =: (%,%) -> Boolean
    
(A:Set)<=(B:Set):nPoset with 
    mor: (A->B) -> %
== add
    mor(f:A->B):% == error " "

Product(A:Set,B:Set):nPoset with Goon with Max == add
    Rep == Record(X:Set,pa:(X<=A),pb:(X<=B)); import from Rep
    
    (P:%)<=(Q:%):nPoset == ((rep P).X)<=((rep Q).X)
    
    max: % == 
        AB:Set == add
	    Rep ==> Record(a:A,b:B); import from Rep
	    (x:%)=(y:%):Boolean == (rep x).a = (rep y).a and (rep x).b = (rep y).b
	RepP == Record(a:A,b:B); import from RepP
	pa:(AB<=A) == mor ( (ab:AB):A +-> (ab pretend RepP).a )
	pb:(AB<=B) == mor ( (ab:AB):B +-> (ab pretend RepP).b )
	
	[AB,pa,pb] pretend %    

    max(x:%):(x<=max) == error " "  -- to see "can't create dummy compiler bug"
--    max(x:%):(x<=max) == add        -- to see a core dump
    

