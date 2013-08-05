--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Sun Oct 17 16:50:32 1993
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA12787; Sun, 17 Oct 1993 16:50:32 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8657; Sun, 17 Oct 93 14:55:51 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.9424.Oct.17.14:52:57.-0400>
--*           for asbugs@watson; Sun, 17 Oct 93 14:55:51 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9274; Sun, 17 Oct 1993 14:52:56 EDT
--* Received: from cyst.watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Sun, 17 Oct 93 14:30:31 EDT
--* Received: from watson.ibm.com by cyst.watson.ibm.com (AIX 3.2/UCB 5.64/900528)
--*   id AA86770; Sun, 17 Oct 1993 14:30:00 -0400
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA23707; Sun, 17 Oct 1993 14:31:56 -0400
--* Date: Sun, 17 Oct 1993 14:31:56 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9310171831.AA23707@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: AXP OSF/1 porting differences [bugs-axposf1][v32.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


***** OK -- cd break up fucntion

docc -O -DNDEBUG -I../src -c ../src/cfold.c

uopt: Warning: cfoldBCall: this procedure not optimized because it
      exceeds size threshold; to optimize this procedure, use -Olimit option
      with value >=  626.




***** OK
docc -O -DNDEBUG -I../src -c ../src/as_y.c

uopt: Warning: yyparse: this procedure not optimized because it
      exceeds size threshold; to optimize this procedure, use -Olimit option
      with value >=  547.


***** OK
Checking for suspicious zeros in source files...
"as_y.yt", line 2318: Suspicious 0
"as_y.yt", line 2403: Suspicious 0
Done

asharp -F aso -F o -OQ inline-all  prime.as

uopt: Warning: C8_prime_QMARK_: this procedure not optimized because it
      exceeds size threshold; to optimize this procedure, use -Olimit option
      with value >=  603.



***** OK
>> domain1.as: (execution) DIFFERENT
-->> diff /margit/a/users/smwatt/asharp/version/v32.0/test/test.out/domain1.out domain1.out
1c1
< -0.7485281749369217 + 0.47014297729184185 %i
---
> -0.7485281749369217 + 0.47014297729184180 %i




***** Needs to be fixed
>> mandel.as: (compilation) (not identical) DIFFERENT
-->> diff /tmp/testas.4647/std-mandel.asf /tmp/testas.4647/new-mandel.asf
506c506
<           (Set (Loc 23 double) (DFlo 2.055313086699586e-320))
---
>           (Set (Loc 23 double) (DFlo 4.000000000000000e0))


***** Needs to be fixed
>> inline0.as: (compilation) (not identical) DIFFERENT
-->> diff /tmp/testas.4647/std-inline0.asf /tmp/testas.4647/new-inline0.asf
402,403c402,403
<           (Def (Glo 103 inline0_1_534137267) (SFlo 8.708405476647607s-311))
<           (Def (Glo 104 inline0_1_239458468) (DFlo 3.038651941617419e-319))
---
>           (Def (Glo 103 inline0_1_534137267) (SFlo 1.000000000000000s0))
>           (Def (Glo 104 inline0_1_239458468) (DFlo 1.000000000000000e0))
1830,1831c1830,1831
<     (Def (Const 88 \1) (SFlo 8.708405476647607s-311))
<     (Def (Const 89 \1) (DFlo 3.038651941617419e-319))
---
>     (Def (Const 88 \1) (SFlo 1.000000000000000s0))
>     (Def (Const 89 \1) (DFlo 1.000000000000000e0))




***** OK
>> inline4.as: (execution) DIFFERENT
-->> diff /margit/a/users/smwatt/asharp/version/v32.0/test/test.out/inline4.out inline4.out
2c2
< 0.82352941176470584 + -0.29411764705882354 %i
---
> 0.82352941176470580 + -0.29411764705882350 %i



***** OK
>> float0.as: (execution) DIFFERENT
-->> diff /margit/a/users/smwatt/asharp/version/v32.0/test/test.out/float0.out float0.out
1c1
< 0.99989631572895199
---
> 0.99989631572895190

