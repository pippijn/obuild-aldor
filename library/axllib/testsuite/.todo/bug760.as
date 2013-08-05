--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Wed Jul 27 15:42:56 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17782; Wed, 27 Jul 1994 15:42:56 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3911; Wed, 27 Jul 94 15:43:00 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.LAL.NOTE.YKTVMV.5753.Jul.27.15:42:59.-0400>
--*           for asbugs@watson; Wed, 27 Jul 94 15:42:59 -0400
--* Received: from nag.com by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Wed, 27 Jul 94 15:42:57 EDT
--* Received: by nag.com (/\==/\ Smail3.1.28.1 #28.1)
--* 	id <m0qTEtH-0001XtC@nag.com>; Wed, 27 Jul 94 14:43 CDT
--* Received: by pear.naginc (4.1/SMI-4.1)
--* 	id AA05101; Wed, 27 Jul 94 14:50:12 CDT
--* Date: Wed, 27 Jul 94 14:50:12 CDT
--* From: lal@watson.ibm.com (Larry A. Lambe)
--* Message-Id: <9407271950.AA05101@pear.naginc>
--* To: asbugs@watson.ibm.com, lal
--* Subject: [5] core file generated [gbtst6.as][36.1]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--+
--+ asharp -Fx -lasdem gbtst6.as
--+ pear% gbtst6
--+ done loading polys
--+ Segmentation fault (core dumped)
--+
-- use -Fx -lasdem
#pile

#include "axllib"

#library Dlib "asdem"

import from Dlib

R ==> Integer

import from R

hdp ==> HomogeneousDirectProduct(retract 36)
import from hdp

poly ==> Polynomial(R,hdp)
import from poly

a1:poly := var unitVector retract 1
b1:poly := var unitVector retract 2
c1:poly := var unitVector retract 3
d1:poly := var unitVector retract 4
a2:poly := var unitVector retract 5
b2:poly := var unitVector retract 6
c2:poly := var unitVector retract 7
d2:poly := var unitVector retract 8
a3:poly := var unitVector retract 9
b3:poly := var unitVector retract 10
c3:poly := var unitVector retract 11
d3:poly := var unitVector retract 12
a4:poly := var unitVector retract 13
b4:poly := var unitVector retract 14
c4:poly := var unitVector retract 15
d4:poly := var unitVector retract 16
A1:poly := var unitVector retract 17
B1:poly := var unitVector retract 18
C1:poly := var unitVector retract 19
D1:poly := var unitVector retract 20
A2:poly := var unitVector retract 21
B2:poly := var unitVector retract 22
C2:poly := var unitVector retract 23
D2:poly := var unitVector retract 24
A3:poly := var unitVector retract 25
B3:poly := var unitVector retract 26
C3:poly := var unitVector retract 27
D3:poly := var unitVector retract 28
A4:poly := var unitVector retract 29
B4:poly := var unitVector retract 30
C4:poly := var unitVector retract 31
D4:poly := var unitVector retract 32

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

print<<"done loading polys"<<newline

import from GroebnerPackage(R,hdp,poly)

import from String

base := groebner(l)

print<<base<<newline
