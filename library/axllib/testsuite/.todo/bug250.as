--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed May 12 08:11:39 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA22451; Wed, 12 May 1993 08:11:39 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1393; Wed, 12 May 93 08:12:04 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.LAMBE.NOTE.YKTVMV.3419.May.12.08:12:03.-0400>
--*           for asbugs@watson; Wed, 12 May 93 08:12:04 -0400
--* Received: from kth.se by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 12 May 93 08:12:02 EDT
--* Received: from candida.matematik.su.se by kth.se (5.65+bind 1.7+ida 1.4.2/6.0)
--* 	id AA21259; Wed, 12 May 93 14:11:57 +0200
--* Received: from insanus (insanus.matematik.su.se) by candida.matematik.su.se (4.1/6.0)
--* 	id AA10340; Wed, 12 May 93 14:15:56 +0200
--* From: Larry Lambe  <lambe@matematik.su.se>
--* Received: by insanus (4.1/6.0)
--* 	id AA07269; Wed, 12 May 93 14:16:41 +0200
--* Date: Wed, 12 May 93 14:16:41 +0200
--* Message-Id: <9305121216.AA07269@insanus>
--* To: asbugs@watson.ibm.com
--* Subject: Segmentation fault in Groebner basis calculation [gbtst6.as][sun cc SPARC 10 OS 4.1.3]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--> testrun -lasdem

#include "axllib"

#library Dlib "asdem"

import Dlib
import SingleInteger

R ==> Integer
import R

hdp ==> HomogeneousDirectProduct(36)
import hdp

poly ==> Polynomial(R,hdp)
import poly

a1:poly := var unitVector 1
b1:poly := var unitVector 2
c1:poly := var unitVector 3
d1:poly := var unitVector 4
a2:poly := var unitVector 5
b2:poly := var unitVector 6
c2:poly := var unitVector 7
d2:poly := var unitVector 8
a3:poly := var unitVector 9
b3:poly := var unitVector 10
c3:poly := var unitVector 11
d3:poly := var unitVector 12
a4:poly := var unitVector 13
b4:poly := var unitVector 14
c4:poly := var unitVector 15
d4:poly := var unitVector 16
A1:poly := var unitVector 17
B1:poly := var unitVector 18
C1:poly := var unitVector 19
D1:poly := var unitVector 20
A2:poly := var unitVector 21
B2:poly := var unitVector 22
C2:poly := var unitVector 23
D2:poly := var unitVector 24
A3:poly := var unitVector 25
B3:poly := var unitVector 26
C3:poly := var unitVector 27
D3:poly := var unitVector 28
A4:poly := var unitVector 29
B4:poly := var unitVector 30
C4:poly := var unitVector 31
D4:poly := var unitVector 32

p1:= d1 * A4 + c1 * A3 + b1 * A2 - a4 * D1 - a3 * C1 - a2 * B1
p2:= d1*B4+c1 * B3 - b4 * D1 - b3 * C1 - b2 * B1 + b1 * B2 - b1 * A1 + a1 * B1
p3:= d1*C4-c4 * D1 - c3 * C1 - c2 * B1 + c1 * C3 - c1 * A1 + b1 * C2 + a1 * C1
p4:= -d4*D1-d3 * C1 - d2 * B1 + d1 * D4 - d1 * A1 + c1 * D3 + b1 * D2 + a1 * D1
p5:= d2*A4+c2 * A3 + b2 * A2 - a4 * D2 - a3 * C2 - a2 * B2 + a2 * A1 - a1 * A2
p6:= d2 * B4 + c2 * B3 - b4 * D2 - b3 * C2 - b1 * A2 + a2 * B1
p7:= d2*C4-c4 * D2 - c3 * C2 + c2 * C3 - c2 * B2 - c1 * A2 + b2 * C2 + a2 * C1
	p8:= -d4*D2-d3 * C2 + d2 * D4 - d2 * B2 - d1 * A2 + c2 * D3 + b2 * D2 + a2 * D1
p9:= d3*A4+c3*A3 + b3 * A2 - a4 * D3 - a3 * C3 + a3 * A1 - a2 * B3 - a1 * A3
p10:= d3*B4+c3*B3 - b4 * D3 - b3 * C3 + b3 * B2 - b2 * B3 - b1 * A3 + a3 * B1
p11:= d3*C4-c4 * D3 - c2 * B3 - c1 * A3 + b3 * C2 + a3 * C1
p12:= -d4*D3+d3 * D4 - d3 * C3 - d2 * B3 - d1 * A3 + c3 * D3 + b3 * D2 + a3 * D1
p13:= d4*A4+c4*A3 + b4 * A2 - a4 * D4 + a4 * A1 - a3 * C4 - a2 * B4 - a1 * A4
p14:= d4*B4+c4*B3 - b4 * D4 + b4 * B2 - b3 * C4 - b2 * B4 - b1 * A4 + a4 * B1
p15:= d4*C4-c4*D4 + c4 * C3 - c3 * C4 - c2 * B4 - c1 * A4 + b4 * C2 + a4 * C1
p16:= -d3*C4-d2 * B4 - d1 * A4 + c4 * D3 + b4 * D2 + a4 * D1

l : List poly := [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16]
--print(l)()
print("done loading polys")()

import GroebnerPackage(R,hdp,poly)
import String

base := groebner(l)
print(base)()
