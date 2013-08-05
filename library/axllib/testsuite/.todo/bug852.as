--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Sun Sep  4 15:59:33 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23844; Sun, 4 Sep 1994 15:59:33 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3427; Sun, 04 Sep 94 15:59:37 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.8981.Sep.04.15:59:36.-0400>
--*           for asbugs@watson; Sun, 04 Sep 94 15:59:37 -0400
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Sun, 04 Sep 94 15:59:36 EDT
--* Received: from ru7.inf.ethz.ch (ru7.inf.ethz.ch [129.132.12.16]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id VAA23270; Sun, 4 Sep 1994 21:59:28 +0200
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: (santas@localhost) by ru7.inf.ethz.ch (8.6.8/8.6.6) id VAA04071; Sun, 4 Sep 1994 21:59:27 +0200
--* Date: Sun, 4 Sep 1994 21:59:27 +0200
--* Message-Id: <199409041959.VAA04071@ru7.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: for-loop with #1 (Error) Program fault (segmentation violation)
--* In-Reply-To: Mail from '"Richard D. Jenks (945-1233)" <jenks@watson.ibm.com>'
--*       dated: Sun, 4 Sep 94 07:15:03 EDT
--* Cc: jenks@watson.ibm.com, bronstei@inf.ethz.ch

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--In A# version 0.36.0 for SPARC

------------------------------------------
#include "axllib"
SI ==> SingleInteger;
import from SI;
import from List(SI);

print << [for i in 1..3 repeat i] << newline
-------------------------------------------

--returns segmentation fault.

--Philip

