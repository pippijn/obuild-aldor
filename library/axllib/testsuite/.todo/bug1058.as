--* Received: from mailer.scri.fsu.edu by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA10159; Fri, 5 Apr 96 20:44:41 BST
--* Received: from ibm4.scri.fsu.edu (ibm4.scri.fsu.edu [144.174.131.4]) by mailer.scri.fsu.edu (8.6.12/8.6.12) with SMTP id OAA25877; Fri, 5 Apr 1996 14:41:06 -0500
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm4.scri.fsu.edu (5.67b) id AA36726; Fri, 5 Apr 1996 14:39:30 -0500
--* Date: Fri, 5 Apr 1996 14:39:30 -0500
--* Message-Id: <199604051939.AA36726@ibm4.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs, edwards@scri.fsu.edu
--* Subject: [2] Repeated extensions fail without -Qinline-all

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: bug-extend-twice.ksh
-- Version: 1.5.1
-- Original bug file name: bug-extend-twice.ksh

--+ % axiomxl -V -Fao bug-extend-twice-a.as
--+ AXIOM-XL version 1.1.5 for AIX RS/6000 
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    4.5 s  0  1 .2  2 .4  1  0 .2  0  1 71  3  4 17  0  0  0 .2 %
--+ 
--+  Source  220 lines,  2875 lines per minute
--+  Lib   19087 bytes,  4347syme 8202foam 162fsyme 1215name 207kind 513file 994lazy 3116type 8inl 38twins 16ext 99doc 23id
--+  Store  2524 K pool
--+ % ar -rv libbug-extend-twice.al bug-extend-twice-a.ao
--+ a - bug-extend-twice-a.ao
--+ % axiomxl -V -Fao bug-extend-twice-b.as
--+ AXIOM-XL version 1.1.5 for AIX RS/6000 
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    4.1 s  0 .5  0  2 .2 .2  0  0 .2 .2 60  1 .5 35  0 .2  0 .2 %
--+ 
--+  Source  195 lines,  2812 lines per minute
--+  Lib   11103 bytes,  3612syme 1764foam 26fsyme 1080name 172kind 548file 946lazy 2719type 14inl 26twins 24ext 2doc 23id
--+  Store  2048 K pool
--+ % ar -rv libbug-extend-twice.al bug-extend-twice-b.ao
--+ a - bug-extend-twice-b.ao
--+ % axiomxl -V -Qinline-all -Ginterp bug-extend-twice-c.as
--+ AXIOM-XL version 1.1.5 for AIX RS/6000 
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    3.1 s  0  1 .3  3 .3  1  0  0  0 .3 86  1  6  2  0  0  0  0 %
--+ 
--+  Source  200 lines,  3870 lines per minute
--+  Lib    6968 bytes,  1974syme 2713foam 66fsyme 715name 94kind 589file 362lazy 233type 16inl 32twins 2ext 2doc 23id
--+  Store  1980 K pool
--+ x: SI == 42, val x = 42, ord x = 42, hash x = 42
--+ % axiomxl -V -Ginterp bug-extend-twice-c.as
--+ AXIOM-XL version 1.1.5 for AIX RS/6000 
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    2.9 s  0  2 .3  2 .3 .3  0  0 .3 .3 90  2  1  2  0  0  0  0 %
--+ 
--+  Source  200 lines,  4123 lines per minute
--+  Lib    7133 bytes,  1764syme 3269foam 78fsyme 662name 84kind 573file 306lazy 195type 8inl 20twins 2ext 2doc 23id
--+  Store  1844 K pool
--+ Program fault (segmentation violation).#1 (Error) Program fault (segmentation violation).
--+ #2 (Warning) Removing file `bug-extend-twice-c.ao'.
#!/bin/ksh
#
# bug-extend-twice.as
#
# This demonstrates a bug (in AXIOM-XL version 1.1.5 for AIX RS/6000) when
# a domain (SingleInteger) is extended successively by two separate files
# in a library. The test program fails UNLESS it is compiled with -Qinline-all.
#
X=bug-extend-twice
mkdir $X
cd $X
cat > $X-a.as << \EOF
--
-- This is the first file which extends SingleInteger
--
#include "axllib.as"
#pile
SINS ==> Join(Steppable, IntegerNumberSystem)

define Countable(I: SINS): Category == BasicType with
  ord: % -> I			++ Index within enumeration
  val: I -> %			++ Enumeration of countable set
  all: () -> Generator %	++ Generator which enumerates set

define CountablyInfinite(I: SINS): Category == Countable I with
  default
    all(): Generator % ==
      import from I, Segment I
      generate for i: I in 1 .. repeat yield val i

    val(i: I): % ==
      import from Segment I
      for a: % in all() for j: I in 1 .. repeat
        i = j => return a
      never

    ord(a: %): I ==
      import from Segment I
      for b: % in all() for j: I in 1 .. repeat
	a = b => return j
      never

extend SingleInteger: CountablyInfinite SingleInteger ==
  add
    Rep ==> SingleInteger

    ord(a: %): SingleInteger == rep a

    val(a: SingleInteger): % == per a
EOF
print - "% axiomxl -V -Fao $X-a.as"
axiomxl -V -Fao $X-a.as
print - "% ar -rv lib$X.al $X-a.ao"
ar -rv lib$X.al $X-a.ao
cat > $X-b.as << EOF
---
--- This is the second file, which extends the extended SingleInteger from the
--- first file
---
#include "axllib.as"
#library libadk "lib$X.al"
#pile

import from libadk

extend SingleInteger: with == add
  hash(i: %): % == i
EOF
print - "% axiomxl -V -Fao $X-b.as"
axiomxl -V -Fao $X-b.as
print - "% ar -rv lib$X.al $X-b.ao"
ar -rv lib$X.al $X-b.ao
cat > $X-c.as << EOF
---
--- This is the test program which tries to use the first extension
---
#include "axllib.as"
#library libadk "lib$X.al"
#pile

import from libadk

testSI(): () ==
  import from SingleInteger

  x: SingleInteger == 42
  print . "x: SI == ~a, val x = ~a, ord x = ~a, hash x = ~a~n" .
    (<< x, << val x, << ord x, << hash x)

testSI()
EOF
#
# Run the test program with -Qinline-all
#
print - "% axiomxl -V -Qinline-all -Ginterp $X-c.as"
axiomxl -V -Qall -Ginterp $X-c.as
#
# Run the test program with default optimization to demonstrate the bug
#
print - "% axiomxl -V -Ginterp $X-c.as"
axiomxl -V -Ginterp $X-c.as


