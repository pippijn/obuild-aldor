--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Tue May 24 13:42:09 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA14596; Tue, 24 May 1994 13:42:09 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 6879; Tue, 24 May 94 13:42:15 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.5781.May.24.13:42:15.-0400>
--*           for asbugs@watson; Tue, 24 May 94 13:42:15 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 5779; Tue, 24 May 1994 13:42:15 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Tue, 24 May 94 13:42:14 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA21384; Tue, 24 May 1994 13:44:28 -0400
--* Date: Tue, 24 May 1994 13:44:28 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9405241744.AA21384@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [1] Cannot give alternative conditional definitions [clash.as][current]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


#include "axllib"

Foo(n: Integer): with
    yoohoo: Integer -> Integer
  == add
    if odd? n then
        yoohoo(a: Integer): Integer == a
    else
        yoohoo(a: Integer): Integer == a-1


