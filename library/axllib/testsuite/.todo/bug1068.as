--* Received: from mailer.scri.fsu.edu by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA09682; Tue, 23 Apr 96 21:04:40 BST
--* Received: from ibm4.scri.fsu.edu (ibm4.scri.fsu.edu [144.174.131.4]) by mailer.scri.fsu.edu (8.6.12/8.6.12) with SMTP id QAA20747; Tue, 23 Apr 1996 16:01:06 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm4.scri.fsu.edu (5.67b) id AA37789; Tue, 23 Apr 1996 15:59:04 -0400
--* Date: Tue, 23 Apr 1996 15:59:04 -0400
--* Message-Id: <199604231959.AA37789@ibm4.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs, edwards@scri.fsu.edu
--* Subject: [7] What should sample be for an empty domain?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Ginterp bug-card-zero.as
-- Version: any
-- Original bug file name: bug-card-zero.as

--+ f = x, lf = list(x, y, z), card = 3
--+ lg = list(), card = 0
--+ sample =  EU` EV0 EV0 EX  EZ0 EV0 Czp E[ E_P Czp E[ Czp E[ Et E[$B* E6P E9 E6P E6P*7
#include "axllib.as"
#library libadk "libadk.al"
#pile

SI ==> SingleInteger

import from libadk, SI

SmallFiniteSet(ts: Tuple String): CountablyFinite SI with

    coerce: String -> %

    coerce: % -> String

  == add

    Rep == SI
    import from SI

    card: SI == length ts

    all(): Generator % == generate for i in 1 .. card repeat yield per i

    ord(a: %): SI == rep a

    val(i: SI): % ==
      i < 1 or i > card => error "val$SmallFiniteSet: out of range"
      per i

    sample: % == per 1			-- What if card = 0?

    (a: %) = (b: %): Boolean == rep.a = rep.b

    (p: TextWriter) << (a: %): TextWriter == p << a::String

    coerce(a: %): String == element(ts, rep a)

    coerce(s: String): % ==
      for a: % in all() repeat s = a::String => return a
      error "coerce$SmallFiniteSet: string not in set"

F == SmallFiniteSet("x", "y", "z")
f: F == coerce "x"
lf: List F == [y for y: F in all()]
print . "f = ~a, lf = ~a, card = ~a~n" . (<< f, << lf, << card$F)

G == SmallFiniteSet()
lg: List G == [y for y: G in all()]
print . "lg = ~a, card = ~a~n" . (<< lg, << card$G)
g: G == sample
print . "sample = ~a~n" . (<< g)
