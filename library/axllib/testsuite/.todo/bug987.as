From asbugs@com.ibm.watson Thu Jun  8 23:49:18 1995
Date: Thu, 8 Jun 1995 18:41:10 -0400
From: asbugs@com.ibm.watson (S Watt)
To: adk@edu.fsu.scri, dooley@com.ibm.watson, iglio@it.unipi.dm.posso,
        peterb@uk.co.nag, smwatt@com.ibm.watson
Subject: Received A# bug987
Sender: asbugs@com.ibm.watson


  Reporter:    adk@scri.fsu.edu
  Number:      bug987
  Description: [4] Segmentation violation

Thank you for your bug report.  It has been assigned bug number bug987.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug987.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Jun  8 18:41:07 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23024; Thu, 8 Jun 1995 18:41:07 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8517; Thu, 08 Jun 95 18:41:06 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ADK.NOTE.YKTVMV.8333.Jun.08.18:41:06.-0400>
--*           for asbugs@watson; Thu, 08 Jun 95 18:41:06 -0400
--* Received: from mailer.scri.fsu.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Thu, 08 Jun 95 18:40:47 EDT
--* Received: from ibm12.scri.fsu.edu by mailer.scri.fsu.edu with SMTP id AA04828
--*   (5.67b/IDA-1.4.4 for <asbugs@watson.ibm.com>); Thu, 8 Jun 1995 18:38:05 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm12.scri.fsu.edu (5.67b) id AA34997; Thu, 8 Jun 1995 18:37:48 -0400
--* Date: Thu, 8 Jun 1995 18:37:48 -0400
--* Message-Id: <199506082237.AA34997@ibm12.scri.fsu.edu>
--* To: adk@scri.fsu.edu, asbugs@watson.ibm.com, infodesk@nag.co.uk
--* Subject: [4] Segmentation violation

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Ginterp bug-segerr-1.as
-- Version: 1.1.0
-- Original bug file name: bug-segerr-1.as

--+ ibm12::adk[60]> axiomxl -V -Ginterp bug-segerr-1.as
--+ AXIOM-XL version 1.1.0 for AIX RS/6000
--+                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
--+  Time    4.7 s  0  1  1  4 .2 .2  0 .2  0 .4 87  4 .4  1  0  0 .2 .2 %
--+
--+  Source  193 lines,  2437 lines per minute
--+  Lib    5194 bytes,  1365syme 2156foam 64fsyme 517name 65kind 488file 194lazy 17
--+ 3type 2inl 2twins 2ext 2doc 17id
--+  Store  1776 K pool
--+ #1 (Error) Program fault (segmentation violation).
--+ #2 (Warning) Removing file `bug-segerr-1.ao'.
#include "axllib"
#pile
--(PAB)problem here is that v is defined after its use in the defn of i.

f( g: Integer -> Integer ): Integer == g(3);
v: Integer := 0;
i: Integer == f( (j: Integer): Integer +-> {
		    free v;
		    v := v + 1;}
		 )
print << i << newline;


