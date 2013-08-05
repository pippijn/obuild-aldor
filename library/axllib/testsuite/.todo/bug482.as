--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Sun Oct 17 16:50:33 1993
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA13315; Sun, 17 Oct 1993 16:50:33 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8668; Sun, 17 Oct 93 14:55:58 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.9452.Oct.17.14:53:03.-0400>
--*           for asbugs@watson; Sun, 17 Oct 93 14:55:58 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9263; Sun, 17 Oct 1993 14:53:02 EDT
--* Received: from cyst.watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Sun, 17 Oct 93 14:27:41 EDT
--* Received: from watson.ibm.com by cyst.watson.ibm.com (AIX 3.2/UCB 5.64/900528)
--*   id AA73955; Sun, 17 Oct 1993 14:27:11 -0400
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA23690; Sun, 17 Oct 1993 14:29:07 -0400
--* Date: Sun, 17 Oct 1993 14:29:07 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9310171829.AA23690@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: aix3.1 gcc porting differences [bugs-rs3.1gcc][v32.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


******** SHould be fixed
	docc -O -DNDEBUG -I../src -c ../src/terror.c
../src/terror.c: In function `noMeaningsForOperator':
../src/terror.c:488: warning: empty body in an else-statement


	docc -O -DNDEBUG -I../src -c ../src/sefo.c
../src/sefo.c:580: warning: `sstMarkMask' defined but not used


	docc -O -DNDEBUG -I../src -c ../src/archive.c
../src/archive.c: In function `arRdTable':
../src/archive.c:336: warning: empty body in an else-statement


******** OK
	docc -O -DNDEBUG -I../src -c ../src/as_y.c
as_y.yt: In function `yyparse':
as_y.yt:2630: warning: label `yyerrlab' defined but not used
as_y.yt:2416: warning: label `yynewstate' defined but not used
as_y.yt:2410: warning: `yy_n' may be used uninitialized in this function


Checking for suspicious zeros in source files...
"as_y.yt", line 2318: Suspicious 0
"as_y.yt", line 2403: Suspicious 0
Done


********** This is completely wrong ************************
>> domain1.as: (execution) DIFFERENT
-->> diff /u/smwatt/asharp/version/v32.0/test/test.out/domain1.out domain1.out
1c1
< -0.7485281749369217 + 0.47014297729184185 %i
---
> -0.7313195548489666 + 0.68203497615262320 %i



******** OK
>> inline4.as: (execution) DIFFERENT
-->> diff /u/smwatt/asharp/version/v32.0/test/test.out/inline4.out inline4.out
2c2
< 0.82352941176470584 + -0.29411764705882354 %i
---
> 0.82352941176470580 + -0.29411764705882350 %i



******** OK
>> float0.as: (execution) DIFFERENT
-->> diff /u/smwatt/asharp/version/v32.0/test/test.out/float0.out float0.out
1c1
< 0.99989631572895199
---
> 0.99989631572895190
