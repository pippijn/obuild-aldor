--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Nov 23 09:47:20 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA23300; Wed, 23 Nov 1994 09:47:20 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 4493; Wed, 23 Nov 94 09:47:26 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BRONSTEI.NOTE.YKTVMV.5553.Nov.23.09:47:22.-0500>
--*           for asbugs@watson; Wed, 23 Nov 94 09:47:23 -0500
--* Received: from inf.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 23 Nov 94 09:47:22 EST
--* Received: from vinci.inf.ethz.ch (bronstei@vinci.inf.ethz.ch [129.132.12.46]) by inf.ethz.ch (8.6.9/8.6.9) with ESMTP id PAA22601 for <asbugs@watson.ibm.com>; Wed, 23 Nov 1994 15:47:13 +0100
--* From: Manuel Bronstein <bronstei@inf.ethz.ch>
--* Received: (bronstei@localhost) by vinci.inf.ethz.ch (8.6.8/8.6.6) id PAA08666 for asbugs@watson.ibm.com; Wed, 23 Nov 1994 15:47:12 +0100
--* Date: Wed, 23 Nov 1994 15:47:12 +0100
--* Message-Id: <199411231447.PAA08666@vinci.inf.ethz.ch>
--* To: asbugs@watson.ibm.com
--* Subject: [3] extend doesn't work as documented

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -M2 badextend.as
-- Version: 0.37.0
-- Original bug file name: badextend.as

------------------------------- badextend.as -------------------------
--
-- extend doesn't work as advertised. Workaround?
--
-- % asharp -M2 badextend.as
-- "badextend.as", line 27:
-- extend Integer:MyRing == add { foo(x:Integer):Integer == x; }
-- .........................^
-- [L6 C26] #1 (Error) The domain is missing some exports.
--         Missing 0: %
--         Missing +: (%, %) -> %
--         Missing -: % -> %
--         Missing 1: %
--         Missing *: (%, %) -> %
--         Missing ^: (%, Integer) -> %
--         Missing coerce: Integer -> %
--         Missing coerce: SingleInteger -> %
--         Missing =: (%, %) -> Boolean
--         Missing <<: (TextWriter, %) -> TextWriter
--         Missing foo: % -> %
--

#include "axllib"

MyRing:Category == Ring with { foo: % -> % };

extend Integer:MyRing == add { foo(x:Integer):Integer == x; }

