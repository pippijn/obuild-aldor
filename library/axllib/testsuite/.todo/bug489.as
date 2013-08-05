--* From DOOLEY%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Wed Oct 20 09:04:39 1993
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21993; Wed, 20 Oct 1993 09:04:39 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2944; Wed, 20 Oct 93 09:11:08 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.DOOLEY.NOTE.VAGENT2.9221.Oct.20.09:11:07.-0400>
--*           for asbugs@watson; Wed, 20 Oct 93 09:11:07 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9219; Wed, 20 Oct 1993 09:11:07 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Wed, 20 Oct 93 09:11:06 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA18526; Wed, 20 Oct 1993 09:12:22 -0400
--* Date: Wed, 20 Oct 1993 09:12:22 -0400
--* From: dooley@watson.ibm.com (Sam Dooley)
--* Message-Id: <9310201312.AA18526@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: package call from % seems to confuse gen0MakeExporter [bu484a.as][v32.1]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

import Integer
MyCategory(): Category == with
      sigma: % -> %
        ++ sigma is any automorphism of the field.
      sigma: (%, Integer) -> %
        ++ sigma(x,n) returns sigma applied n times to x
     add

      -- this version creates a segmentation violation at codegen time
      sigma(x:%):% == sigma(x, 1)$%

