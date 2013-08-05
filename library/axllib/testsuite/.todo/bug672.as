--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Jun  6 12:11:33 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17593; Mon, 6 Jun 1994 12:11:33 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 6433; Mon, 06 Jun 94 12:11:33 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.ROOT.NOTE.VAGENT2.9885.Jun.06.12:11:33.-0400>
--*           for asbugs@watson; Mon, 06 Jun 94 12:11:33 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9881; Mon, 6 Jun 1994 12:11:33 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 06 Jun 94 12:11:32 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA12507; Mon, 6 Jun 1994 12:09:56 -0500
--* Date: Mon, 6 Jun 1994 12:09:56 -0500
--* From: root@watson.ibm.com
--* Message-Id: <9406061709.AA12507@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2] storage allocation error. [proviso.as][35.4]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

#if BugHeaders
LastSeenBy: pab
LastUpdate: 21/Jun/94
BugKeywords: tinfer/macro?
Priority: 8
Comments: sign is a function with a null body.
Comments: 'i<0' should not be the name of a macro
SeenBy: pab
Updates:
#endif
#assert modified
#if modified

#include "axllib"

Symbol ==> String;
import from Symbol;
Number ==> SingleInteger;
import from Number;

{Proviso(): with
 {
  sign: (Number) -> Symbol
 }
== add
 { sign(i:Number):Symbol ==
   {i>0 ==> "Positive";
    i=0 ==> "Zero";
    i<0 ==> "Negative"}
 } -- add
} -- Proviso



#else

#include "axllib"

Symbol ==> String;
import from Symbol;
Number ==> SingleInteger;
import from Number;

{Proviso(): with
 {
  sign: (Number) -> Symbol
 }
== add
 { sign(i:Number):Symbol ==
   {i>0 ==> "Positive";
    i=0 ==> "Zero";
    i<0 ==> "Negative"}
 } -- add
} -- Proviso



#endif

