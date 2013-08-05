From asbugs@com.ibm.watson Wed May 31 23:39:41 1995
Date: Wed, 31 May 1995 18:11:13 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug976
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug976
  Description: [3] Post facto extension causes segmentation fault.

Thank you for your bug report.  It has been assigned bug number bug976.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug976.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed May 31 18:11:10 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21851; Wed, 31 May 1995 18:11:10 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 9555; Wed, 31 May 95 18:11:10 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.5127.May.31.18:11:09.-0400>
--*           for asbugs@watson; Wed, 31 May 95 18:11:09 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 31 May 95 18:11:08 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA11109
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Wed, 31 May 1995 18:08:47 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA22516; Wed, 31 May 1995 18:08:46 -0400
--* Date: Wed, 31 May 1995 18:08:46 -0400
--* Message-Id: <199505312208.AA22516@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [3] Post facto extension causes segmentation fault.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: Just run the shell script!
-- Version: AXIOM-XL version 1.1.0 for AIX RS/6000
-- Original bug file name: bug-hash-test.ksh

#!/bin/ksh
#
# Demonstrate bug in running hash test.
#
cat > hash.as <<"**END**"
#include "axllib.as"
#pile

+++ Extend various domains to add non-trivial hash functions.
+++
+++ Author: ADK
+++ Date Created: 31-MAY-1995 11:57:52.00
+++ Modifications:
+++  31-MAY-1995 11:57:52.00 (ADK) Recreated because the source code vanished!

SI ==> SingleInteger
bigPrime ==> 1073741789			-- largest prime < 2^30

extend SI: with == add
  hash(i: %): % == i

extend Character: with == add
  hash(c: %): SI == ord c

-- Define a local version of `mod_*' as the one from Machine is broken.

mod_* ==> my_mod_*

local my_mod_*(a: SI, b: SI, p: SI): SI ==
  import from Machine
  local
    aw: Word == a::SInt pretend Word
    bw: Word == b::SInt pretend Word
    pw: Word == p::SInt pretend Word
  (abHigh: Word, abLow: Word) == double_*(aw, bw)
  (pqHigh: Word, pqLow: Word, rw: Word) == doubleDivide(abHigh, abLow, pw)
  coerce(rw pretend SInt)

local msg:* String == "Error in extended string hash function"

extend String: with == add
  hash(s: %): SI ==
    import from Character
    local h: SI := 0
    for i in 1 .. #s repeat
      hsi := mod_*(h, retract(#$Character)$Integer, bigPrime)
#if DEBUG
      hsi ~= retract hi => error msg
	where
	  hi: Integer == (h::Integer * #$Character) mod (bigPrime@Integer)
#endif
      h := mod_+(hsi, ord s.i, bigPrime)
    h
**END**
cat > hash-test.as <<"**END**"
#include "axllib.as"
#library hashao "hash.ao"
#pile

SI ==> SingleInteger
import from hashao

test(): () ==
  import from SI, Character, String
  local
    c: Character
    s: String := "foo"

  print << "hash 42 = " << hash 42 << newline

  c := char s
  print << "hash " << c << " = " << hash c << newline

  print << "hash " << s << " = " << hash s << newline

  for i in 1 .. 10 repeat
    s := concat(s, "bar")
    print << "hash " << s << " = " << hash s << newline

print << "Starting test ..." << newline
test()
print << "... ending test" << newline
**END**
print "Compiling hash.as"
axiomxl -V -Fao -Fo hash.as
print "Compiling hash-test.as"
axiomxl -V -Fx hash-test.as hash.o
print "Running hash-test"
hash-test


