--* From youssef@mailer.scri.fsu.edu  Mon Jul  7 22:56:36 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA11715; Mon, 7 Jul 97 22:56:36 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id WAA10038 for <ax-bugs@nag.co.uk>; Mon, 7 Jul 1997 22:56:35 +0100 (BST)
--* Received: from sp2-3.scri.fsu.edu (sp2-3.scri.fsu.edu [144.174.128.93]) by mailer.scri.fsu.edu (8.8.5/8.7.5) with SMTP id RAA29268; Mon, 7 Jul 1997 17:55:14 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by sp2-3.scri.fsu.edu (5.67b) id AA13500; Mon, 7 Jul 1997 17:55:14 -0400
--* Date: Mon, 7 Jul 1997 17:55:14 -0400
--* Message-Id: <199707072155.AA13500@sp2-3.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs@nag.co.uk, edwards@scri.fsu.edu
--* Subject: [8] Domain definition only works with mysterious extra "add"

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -v -g interp file.as
-- Version: 1.1.9a
-- Original bug file name: bug0.as

--+ 
--+ Greetings;
--+ 
--+    In this program, I attempt to define "Foo" to be the domain 
--+ SingleInteger with type Category.  This only seems to work 
--+ with a mysterious extra "add" (Tony Kennedy's suggestion). 
--+ 
--+   Cheers,
--+   
--+      Saul Youssef
--+      
--+ the compiler output looks like this:
--+ 
--+ {sp2-3:/home/scri35/scratch/youssef/axiom/tests:772} axiomxl -v -g interp bug0.as
--+ AXIOM-XL version 1.1.9a for AIX RS/6000 
--+ "bug0.as", line 9: Foo: A == SingleInteger
--+                    ..........^
--+ [L9 C11] #1 (Error) There are 0 meanings for `SingleInteger' in this context.
--+ The possible types were:
--+           SingleInteger: Join(
--+                  with 
--+                         coerce: B... from AxlLib
--+   The context requires an expression of type A.
--+ 
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    0.9 s  0  2  1  2  0  1  0  0  0  0 93  0  0  0  0  0  0  1 %
--+ 
--+  Source  195 lines,  12061 lines per minute
--+  Store  1504 K pool
--+ {
--
-- I do not seem to be able to define Foo as a Domain valued constant
-- unless I add an "add"
--
#pile
#include "axllib"

A: Category == BasicType
Foo: A == SingleInteger
--Foo: A == SingleInteger add  -- if you define Foo this way instead, it works

#endpile
