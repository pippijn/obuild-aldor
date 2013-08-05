--* From Manuel.Bronstein@sophia.inria.fr  Thu Nov 18 11:58:55 1999
--* Received: from droopix.inria.fr (IDENT:root@droopix.inria.fr [138.96.111.4])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id LAA12638
--* 	for <ax-bugs@nag.co.uk>; Thu, 18 Nov 1999 11:58:49 GMT
--* Received: by droopix.inria.fr (8.8.8/8.8.5) id MAA27703 for ax-bugs@nag.co.uk; Thu, 18 Nov 1999 12:58:23 +0100
--* Date: Thu, 18 Nov 1999 12:58:23 +0100
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <199911181158.MAA27703@droopix.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [3] bad inference problem

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl pcpc.as; axiomxl pcpcbug.as
-- Version: 1.1.12p2
-- Original bug file name: pcpc.as

-------------------------------- pcpc.as -----------------------------
--
-- The following must be separated into 2 files in order to reproduce
-- the bug. Split the bottom part as pcpcbug.as, then:
-- % axiomxl pcpc.as
-- % axiomxl pcpcbug.as
-- "pcpcbug.as", line 7: f(T:Bar, x:T):Integer == bar x;
--                       .............................^
-- [L7 C30] #1 (Error) Argument 1 of `bar' did not match any possible parameter
--                     type.
--     The rejected type is T.
--     Expected type %.
--
-- The bug disappears if Integer is not extended,
-- or if 'foo$%' is replaced by 'foo' in the default definition of #
--

#include "axllib"

define Foo: Category == Finite with { foo: Integer };

define Bar: Category == Foo with {
		bar: % -> Integer;
		default #:Integer == foo$%;
}

define Baz: Category == with { baz: % -> % };

extend Integer:Baz == add { baz(x:%):% == x };

-------------------------------- pcpcbug.as -----------------------------
#include "axllib"

#library lib "pcpc.ao"
import from lib;

f(T:Bar, x:T):Integer == bar x;

