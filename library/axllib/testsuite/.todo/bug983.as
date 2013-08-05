--From asbugs@com.ibm.watson Thu Jun  1 20:04:48 1995
--Date: Thu, 1 Jun 1995 13:52:11 -0400
--From: asbugs@com.ibm.watson (S Watt)
--To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
--        peterb@uk.co.nag, smwatt@com.ibm.watson
--Subject: Received A# bug983
--Sender: asbugs@com.ibm.watson
--
--
--  Reporter:    adk@scri.fsu.edu
--  Number:      bug983
--  Description: [2] Ambiguity in String extensions between % and String
--
--Thank you for your bug report.  It has been assigned bug number bug983.
--
--If you wish to discuss this bug via E-mail, please direct your messages
--to specific people and include the bug number.

------------------------------ bug983.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun  1 13:52:09 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17471; Thu, 1 Jun 1995 13:52:09 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 9887; Thu, 01 Jun 95 13:52:09 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.1095.Jun.01.13:52:07.-0400>
--*           for asbugs@watson; Thu, 01 Jun 95 13:52:09 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 01 Jun 95 13:51:45 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA19931
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Thu, 1 Jun 1995 13:47:33 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA28236; Thu, 1 Jun 1995 13:47:20 -0400
--* Date: Thu, 1 Jun 1995 13:47:20 -0400
--* Message-Id: <199506011747.AA28236@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [2] Ambiguity in String extensions between % and String

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiom -V -Ginterp bug-extend-tinfer-ambiguity.as
-- Version: AXIOM-XL version 1.1.0 for AIX RS/6000
-- Original bug file name: bug-extend-tinfer-ambiguity.as

--+ AXIOM-XL version 1.1.0 for AIX RS/6000
--+ "bug-extend-tinfer-ambiguity.as", line 10:
--+     print << "Within hash$String" << newline
--+ ..........^..^
--+ [L10 C11] #1 (Error) There are 2 meanings for `<<' in this context.
--+ The possible types were:
--+ 	  <<: (TextWriter, String) -> TextWriter from String
--+ 	  <<: (TextWriter, %) -> TextWriter, a local
--+   The context requires an expression of type (TextWriter, %) -> TextWriter.
--+ [L10 C14] #2 (Error) There are 2 meanings for `Within hash$String' in this context.
--+ The possible types were:
--+ 	  string: Literal -> String from String
--+ 	  string: Literal -> %, a local
--+   The context requires an expression of type %.
--+
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    4.9 s  0  1  1  3 .2 .2  0  0  0 .4 94  0  0  0  0  0  0 .4 %
--+
--+  Source  202 lines,  2448 lines per minute
--+  Store  1776 K pool
#include "axllib.as"
#pile

SI ==> SingleInteger

extend String: with == add
  import from Character

  hash(s: %): SI ==
    print << "Within hash$String" << newline
    ord s 1

test(): () ==
  import from SI
  trivia: String == "Trivia"
  print << "hash " << trivia << " = " << hash trivia << newline

test()



