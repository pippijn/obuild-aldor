--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Sat Jun 25 03:40:54 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA20428; Sat, 25 Jun 1994 03:40:54 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 2237; Sat, 25 Jun 94 03:40:54 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.3467.Jun.25.03:40:54.-0400>
--*           for asbugs@watson; Sat, 25 Jun 94 03:40:54 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 3463; Sat, 25 Jun 1994 03:40:53 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Sat, 25 Jun 94 03:40:53 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21933; Sat, 25 Jun 1994 03:44:09 -0400
--* Date: Sat, 25 Jun 1994 03:44:09 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9406250744.AA21933@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2] Porting problems with DEC Alpha [porting][v35.9]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


>> hilbert0.as: (compilation) ERROR
>> hilbert0.as: (generation .lsp) ERROR
>> session1.sh: (script) DIFFERENT
-->> diff ../testout/session1.shR /tmp/testas.3047/session1.shR
1,42c1
< list(natascia, I, love, you) @ List(String)
< 10 @ SingleInteger
< 7 @ SingleInteger
...
< array(1, 2, 3, 4) @ Array(SingleInteger)
< 1
< 2
< 3
< 4
---
> #1 (Error) Program fault (segmentation violation).

>> ore0.as: (interpreting) ERROR
a = (1/1)
sigma^(-100)(a) = (1/1)
#1 (Error) Program fault (segmentation violation).
>> msg.sh: (script) DIFFERENT

>> object0.as: (execution) DIFFERENT
-->> diff /margit/a/users/smwatt/asharp/version/v0-35-9/test/../testout/object0.out object0.out
1c1
< [2][1.25][(2/3)]
---
> [2][(2/3)]


