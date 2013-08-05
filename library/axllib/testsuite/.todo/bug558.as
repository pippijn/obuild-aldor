--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Tue Jan 11 02:19:03 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/4.03)
--*           id AA27109; Tue, 11 Jan 1994 02:19:03 -0500
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0857; Tue, 11 Jan 94 02:25:04 EST
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.1389.Jan.11.02:25:02.-0500>
--*           for asbugs@watson; Tue, 11 Jan 94 02:25:03 -0500
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 1387; Tue, 11 Jan 1994 02:25:02 EST
--* Received: from cyst.watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 11 Jan 94 02:25:01 EST
--* Received: from watson.ibm.com by cyst.watson.ibm.com (AIX 3.2/UCB 5.64/900528)
--*   id AA50946; Tue, 11 Jan 1994 02:25:03 -0500
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA33269; Tue, 11 Jan 1994 02:27:30 -0500
--* Date: Tue, 11 Jan 1994 02:27:30 -0500
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9401110727.AA33269@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [5] float2 (quanc8) fails on Irix [/u/smwatt/asharp/version/v33.4a/test/float2.as][v33.4]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--> testrun -l asdem
#include "axllib"
#library  DemoLib "asdem"

R ==> DoubleFloat
I ==> SingleInteger

import DemoLib
import DoubleFloat
import SingleInteger
import DoubleFloatElementaryFunctions

a      := 0.0
b      := 2.0
relerr := 1.0e-10
abserr := 0.0

fun(x: R): R == if x = 0.0 then 1.0 else sin(x)/x

print("Integrating sin(x)/x from ")(a)(" to ")(b)()

(result, errest, nofun, flag) := quanc8(fun, a, b, abserr, relerr)

print("Result = ")(result)("   Error estimate = ")(errest)()
if flag ~= 0.0 then print("Warning..result may be unreliable.  flag = ")(flag)()
