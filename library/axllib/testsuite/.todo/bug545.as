--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Dec 22 06:12:44 1993
--* Received: from yktvmv.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA27371; Wed, 22 Dec 1993 06:12:44 -0500
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2385; Wed, 22 Dec 93 06:19:03 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SANTAS.NOTE.YKTVMV.6761.Dec.22.06:19:02.-0500>
--*           for asbugs@watson; Wed, 22 Dec 93 06:19:03 -0500
--* Received: from bernina.ethz.ch by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 22 Dec 93 06:19:02 EST
--* Received: from neptune by bernina.ethz.ch with SMTP inbound id <19926-0@bernina.ethz.ch>; Wed, 22 Dec 1993 12:18:56 +0100
--* From: Philip Santas <santas@inf.ethz.ch>
--* Received: from rutishauser.inf.ethz.ch (rutishauser-gw.inf.ethz.ch) by neptune id AA28700; Wed, 22 Dec 93 12:18:52 +0100
--* Date: Wed, 22 Dec 93 12:18:50 +0100
--* Message-Id: <9312221118.AA22687@rutishauser.inf.ethz.ch>
--* Received: from vinci.inf.ethz.ch.rutishauser by rutishauser.inf.ethz.ch id AA22687; Wed, 22 Dec 93 12:18:50 +0100
--* To: asbugs@watson.ibm.com
--* Subject: Naming a file 'array.as' causes strange compiler behaviour

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


Version: A# version 33.0 for SPARC (debug version)
Severity: ?
Problem: Naming a file 'array.as' causes strange compiler behaviour
Comments: Correct programs not accepted.
          If I rename the file to, say, 'ar.as', then I have no problem.
          For which file-names do we have such problems?
Errors: "array.c", line 14: redeclaration of G_array
        ld: array.o: No such file or directory

Code:
----------array.as------------------
#include "axllib"
import SingleInteger
import Array SingleInteger
x := new (9, 5);
print(x 5)()
------------------------------------

Philip

