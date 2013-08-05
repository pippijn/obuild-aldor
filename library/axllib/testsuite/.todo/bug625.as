--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Thu May  5 13:46:39 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA30464; Thu, 5 May 1994 13:46:39 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7363; Thu, 05 May 94 13:46:28 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.4434.May.05.13:46:24.-0400>
--*           for asbugs@watson; Thu, 05 May 94 13:46:27 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 4431; Thu, 5 May 1994 13:46:23 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Thu, 05 May 94 13:46:22 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA18567; Thu, 5 May 1994 13:48:29 -0400
--* Date: Thu, 5 May 1994 13:48:29 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9405051748.AA18567@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2] Fails without -DEXPORT_OK [fornc.as][v0.35.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

macro {
	Ptr		== Pointer;
	Int		== SingleInteger;
}

import {
	bar:		() -> ();
} from Foreign (C, "stdio.h");

import {
	getenv:		String -> String;
} from Foreign (C, "<stdlib.h>");

import {
	foo:		String -> String;
} from Foreign(C, "foofile.h");

export {
	fact:		Int -> Int
#if EXPORT_OK
        ;
	yabba:		Int -> Int
#endif
} to Foreign C;

fact(n: Int): Int == if n < 2 then 1 else n*fact(n-1)
yabba(n: Int): Int == n

import from String
import from OutPort

print(foo "USER")()
