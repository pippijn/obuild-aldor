--* From youssef@mailer.scri.fsu.edu  Sun Feb  1 23:56:07 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA29356; Sun, 1 Feb 98 23:56:07 GMT
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id AAA21626 for <ax-bugs@nag.co.uk>; Mon, 2 Feb 1998 00:00:51 GMT
--* Received: from dirac (dirac.scri.fsu.edu [144.174.128.44]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id SAA10856; Sun, 1 Feb 1998 18:57:53 -0500 (EST)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac (AIX 4.1/UCB 5.64) id AA154616; Sun, 1 Feb 1998 18:57:38 -0500
--* Date: Sun, 1 Feb 1998 18:57:38 -0500
--* Message-Id: <9802012357.AA154616@dirac>
--* To: adk@mailer.scri.fsu.edu, ax-bugs@nag.co.uk, edwards@mailer.scri.fsu.edu,
--*         youssef@mailer.scri.fsu.edu
--* Subject: [3] inheritance problem?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp -Fx file.as
-- Version: 1.1.10c
-- Original bug file name: t2.as

--+ --
--+ -- Hi Peter;
--+ --
--+ --   I'm having trouble with the simple example below.  It may be
--+ -- a bug or it may be that I don't understand something.  Could you
--+ -- give it a look?
--+ --
--+ --
--+ --    The idea is to add one signature to a domain that simply returns
--+ -- a String.  First, I try it with SingleInteger:
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ SI ==> SingleInteger
--+ 
--+ NamedInteger(n:String): IntegerNumberSystem with
--+   name:() -> String
--+   new: SI -> %
--+ == SI add
--+   Rep ==> SI
--+   
--+   name():String == n
--+   new(x:SI):% == per x
--+   
--+ import from SI
--+ 
--+ x: NamedInteger("Foo") := new(2)
--+ y: NamedInteger("Foo") := new(2)
--+ 
--+ print << x + y << newline  -- this prints "4" as expected
--+ --
--+ --  This works fine and as I would expect, i.e. "+" is inherited by
--+ -- the Domain NamedInteger("Foo").
--+ --
--+ --    However, I have trouble if I try to do the same thing for 
--+ --  arbitrary Domains:
--+ --
--+ NamedDomain(C:Category, D:C, n:String): C with
--+   name:() -> String
--+   new: D  -> %
--+ == D add
--+   Rep ==> D
--+   export from D
--+   
--+   name():String == n
--+   new(d:D):% == per d
--+ 
--+ import from NamedDomain(IntegerNumberSystem,SI,"Foo")
--+ 
--+ xx: NamedDomain(IntegerNumberSystem,SI,"Foo") := new(2)
--+ yy: NamedDomain(IntegerNumberSystem,SI,"Foo") := new(2)
--+ --
--+ --  This compiles fine up to here, but it fails because it
--+ --  can't find a "+" operation for NamedDomain(IntegerNumberSystem,SI,"Foo")
--+ --
--+ print << name()$NamedDomain(IntegerNumberSystem,SI,"Foo") << newline
--+ print << xx + yy << newline  -- this fails because it can't find "+"
--+ --
--+ --   Is this a bug or am I not understanding something?
--+ --
--+ --     Saul
--+ --
--
-- Hi Peter;
--
--   I'm having trouble with the simple example below.  It may be
-- a bug or it may be that I don't understand something.  Could you
-- give it a look?
--
--
--    The idea is to add one signature to a domain that simply returns
-- a String.  First, I try it with SingleInteger:
--
#include "axllib"
#pile

SI ==> SingleInteger

NamedInteger(n:String): IntegerNumberSystem with
  name:() -> String
  new: SI -> %
== SI add
  Rep ==> SI
  
  name():String == n
  new(x:SI):% == per x
  
import from SI

x: NamedInteger("Foo") := new(2)
y: NamedInteger("Foo") := new(2)

print << x + y << newline  -- this prints "4" as expected
--
--  This works fine and as I would expect, i.e. "+" is inherited by
-- the Domain NamedInteger("Foo").
--
--    However, I have trouble if I try to do the same thing for 
--  arbitrary Domains:
--
NamedDomain(C:Category, D:C, n:String): C with
  name:() -> String
  new: D  -> %
== D add
  Rep ==> D
  export from D
  
  name():String == n
  new(d:D):% == per d

import from NamedDomain(IntegerNumberSystem,SI,"Foo")

xx: NamedDomain(IntegerNumberSystem,SI,"Foo") := new(2)
yy: NamedDomain(IntegerNumberSystem,SI,"Foo") := new(2)
--
--  This compiles fine up to here, but it fails because it
--  can't find a "+" operation for NamedDomain(IntegerNumberSystem,SI,"Foo")
--
print << name()$NamedDomain(IntegerNumberSystem,SI,"Foo") << newline
print << xx + yy << newline  -- this fails because it can't find "+"
--
--   Is this a bug or am I not understanding something?
--
--     Saul
--
