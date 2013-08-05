--* From youssef@mailer.scri.fsu.edu  Mon Jul 20 17:16:25 1998
--* Received: from mxlink.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA21461; Mon, 20 Jul 98 17:16:25 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx2.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id RAA25292 for <ax-bugs@nag.co.uk>; Mon, 20 Jul 1998 17:15:54 +0100 (BST)
--* Received: from dirac.scri.fsu.edu (dirac.scri.fsu.edu [144.174.128.44]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id MAA31189; Mon, 20 Jul 1998 12:16:09 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac.scri.fsu.edu (5.67b) id AA74314; Mon, 20 Jul 1998 12:12:28 -0400
--* Date: Mon, 20 Jul 1998 12:12:28 -0400
--* Message-Id: <199807201612.AA74314@dirac.scri.fsu.edu>
--* To: adk@mailer.scri.fsu.edu, ax-bugs@nag.co.uk, edwards@mailer.scri.fsu.edu,
--*         youssef@mailer.scri.fsu.edu
--* Subject: [4] bug probably related to generators

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.10c
-- Original bug file name: testcats.as

--+ --
--+ -- axiomxl -g interp thisfile.as produces the following message:
--+ --
--+ --   Compiler bug...Bug: Unimplemented syme kind in genFoam (line 2869 in file ../src/genfoam.c).
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define Lazy: Category == with
--+     more?:  % -> Boolean
--+     more!:  % -> % 
--+     value:  % -> %
--+ 
--+ S ==> SingleInteger
--+ 
--+ LazyS: Monoid with Lazy with 
--+     new: Generator S -> %
--+     new:           S -> %
--+     singleinteger:         % -> S
--+ == add
--+     Rep ==> Generator S
--+     import from Rep
--+ 
--+     new(g:Generator S):% == 
--+         step! g
--+         per   g
--+     new(x:S):% == 
--+         g:Generator S := generate yield x
--+         per g
--+     more?(s:%):Boolean == empty? rep(s)
--+     more!(s:%):%       == per step! rep(s)
--+     value(s:%):%       == new value rep s 
--+     (a:%)=(b:%):Boolean == error "= not defined for LazyS"
--+     sample:% == new 0
--+     1:% == new 1
--+     (a:%)^(n:Integer):% == 
--+         g:Generator S := 
--+             generate 
--+                 for x in rep(a) repeat 
--+                     yield x^n
--+         per g
--+     singleinteger(a:%):S == value rep a
--+     <<(t:TextWriter,a:%):TextWriter == t << singleinteger a << ".."
--+     (a:%)*(b:%):% == 
--+         ga:Generator S := rep a
--+         gb:Generator S := rep b
--+         g:Generator S := 
--+             generate
--+                 repeat
--+                     yield value(ga)*value(gb)
--+                     
--
-- axiomxl -g interp thisfile.as produces the following message:
--
--   Compiler bug...Bug: Unimplemented syme kind in genFoam (line 2869 in file ../src/genfoam.c).
--
#include "axllib"
#pile

define Lazy: Category == with
    more?:  % -> Boolean
    more!:  % -> % 
    value:  % -> %

S ==> SingleInteger

LazyS: Monoid with Lazy with 
    new: Generator S -> %
    new:           S -> %
    singleinteger:         % -> S
== add
    Rep ==> Generator S
    import from Rep

    new(g:Generator S):% == 
        step! g
        per   g
    new(x:S):% == 
        g:Generator S := generate yield x
        per g
    more?(s:%):Boolean == empty? rep(s)
    more!(s:%):%       == per step! rep(s)
    value(s:%):%       == new value rep s 
    (a:%)=(b:%):Boolean == error "= not defined for LazyS"
    sample:% == new 0
    1:% == new 1
    (a:%)^(n:Integer):% == 
        g:Generator S := 
            generate 
                for x in rep(a) repeat 
                    yield x^n
        per g
    singleinteger(a:%):S == value rep a
    <<(t:TextWriter,a:%):TextWriter == t << singleinteger a << ".."
    (a:%)*(b:%):% == 
        ga:Generator S := rep a
        gb:Generator S := rep b
        g:Generator S := 
            generate
                repeat
                    yield value(ga)*value(gb)
                    
