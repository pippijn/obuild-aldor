--* From SMWATT%WATSON.vnet.ibm.com@yktvmh.watson.ibm.com  Sun Oct 17 16:49:45 1993
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA12222; Sun, 17 Oct 1993 16:49:45 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8607; Sun, 17 Oct 93 14:54:52 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.9100.Oct.17.14:49:49.-0400>
--*           for asbugs@watson; Sun, 17 Oct 93 14:54:52 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9280; Sun, 17 Oct 1993 14:49:47 EDT
--* Received: from cyst.watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Sun, 17 Oct 93 14:32:54 EDT
--* Received: from watson.ibm.com by cyst.watson.ibm.com (AIX 3.2/UCB 5.64/900528)
--*   id AA66417; Sun, 17 Oct 1993 14:32:24 -0400
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA23726; Sun, 17 Oct 1993 14:34:20 -0400
--* Date: Sun, 17 Oct 1993 14:34:20 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9310171834.AA23726@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: AIX/ESA Porting differences [bugs-aixesa][v32.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


******** FIX
MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
w "/uaxiom/asharp/version/v32.0/tools/unix/dosfile.c",L202: Variable "t" is never referenced.
w "/uaxiom/asharp/version/v32.0/tools/unix/dosfile.c",L225: Variable "t" is never referenced.


******** OK
/uaxiom/asharp/version/v32.0/tools/unix/zaccmain.c:
MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
lex.yy.c:
w "lex.yy.c",L99/C3(#64):	Unreachable statement.
w "lex.yy.c",L102/C3(#64):	Unreachable statement.
w "lex.yy.c",L105/C3(#64):	Unreachable statement.
w "lex.yy.c",L108/C3(#64):	Unreachable statement.
w "lex.yy.c",L117/C3(#64):	Unreachable statement.
w "lex.yy.c",L120/C3(#64):	Unreachable statement.
w "lex.yy.c",L123/C3(#64):	Unreachable statement.
w "lex.yy.c",L126/C3(#64):	Unreachable statement.
w "lex.yy.c",L129/C3(#64):	Unreachable statement.
w "lex.yy.c",L132/C3(#64):	Unreachable statement.
w "lex.yy.c",L135/C3(#64):	Unreachable statement.
w "lex.yy.c",L138/C3(#64):	Unreachable statement.
w "lex.yy.c",L141/C3(#64):	Unreachable statement.
w "lex.yy.c",L144/C3(#64):	Unreachable statement.
w "lex.yy.c",L147/C3(#64):	Unreachable statement.
w "lex.yy.c",L150/C3(#64):	Unreachable statement.
w "lex.yy.c",L153/C3(#64):	Unreachable statement.
w "lex.yy.c",L156/C3(#64):	Unreachable statement.
w "lex.yy.c",L159/C3(#64):	Unreachable statement.
w "lex.yy.c",L162/C3(#64):	Unreachable statement.
w "lex.yy.c",L165/C3(#64):	Unreachable statement.
w "lex.yy.c",L456/C9(#39):	Array subscript out of range.
w "lex.yy.c",L457/C9(#39):	Array subscript out of range.
w "lex.yy.c",L461/C9(#39):	Array subscript out of range.
w "lex.yy.c",L464/C9(#39):	Array subscript out of range.
w "lex.yy.c",L478/C9(#39):	Array subscript out of range.
w "lex.yy.c",L480/C9(#39):	Array subscript out of range.
w "lex.yy.c",L489/C9(#39):	Array subscript out of range.
w "lex.yy.c",L492/C9(#39):	Array subscript out of range.
w "lex.yy.c",L494/C9(#39):	Array subscript out of range.
w "lex.yy.c",L850/C18(#257):	'=' encountered where '==' may have been intended.
w "lex.yy.c",L902/C31(#257):	'=' encountered where '==' may have been intended.
w "lex.yy.c",L953/C5(#64):	Unreachable statement.
w "lex.yy.c",L649: Variable "yyw" is never referenced.
No errors   34 warnings
y.tab.c:
w "/usr/ccs/lib/yaccpar",L150/C21(#39):	Array subscript out of range.
w "/usr/ccs/lib/yaccpar",L151/C21(#39):	Array subscript out of range.
w "/uaxiom/asharp/version/v32.0/tools/unix/zaccgram.y",L26/C33(#64):	Unreachable statement.
No errors   3 warnings

/uaxiom/asharp/version/v32.0/tools/unix/cscan.c:
cparse.c:
w "/usr/ccs/lib/yaccpar",L150/C21(#39):	Array subscript out of range.
w "/usr/ccs/lib/yaccpar",L151/C21(#39):	Array subscript out of range.
w "y.in",L120/C46(#64):	Unreachable statement.
w "y.in",L122/C46(#64):	Unreachable statement.
w "y.in",L124/C46(#64):	Unreachable statement.
No errors   5 warnings

******** OK


docc -O -DNDEBUG -I../src -c ../src/as_y.c
MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
w "as_y.yt",L2395/C21(#39):	Array subscript out of range.
w "as_y.yt",L2396/C21(#39):	Array subscript out of range.
No errors   2 warnings

******** OK
ar rv libas.a as_y.o

Checking for suspicious zeros in source files...
"as_y.yt", line 2318: Suspicious 0
"as_y.yt", line 2403: Suspicious 0
Done
make[1]: Leaving directory `/uaxiom/asharp/version/v32.0/src'



****** OK
>> domain1.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/domain1.out domain1.out
1c1
< -0.7485281749369217 + 0.47014297729184185 %i
---
> -0.74852817493692180 + 0.47014297729184180 %i

****** OK
>> mandel.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/mandel.out mandel.out
13c13
<   1 64 65 68 80 97    80 89
---
>   1 61 64 66 82 98    80 89

****** OK
>> scope11.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/scope11.out scope11.out
1c1
< 0.091394386750792400
---
> 0.091394386750792200


****** FIX
>> union1.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/union1.out union1.out
7c7
< 2.71828008
---
> 2.71827984

>> ar3.sh: (script) MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
w "asmain.c",L15/C1(#72):	main: Function has no return statement.
0706-224 WARNING:  Duplicate symbol 'matherr'.
DIFFERENT
-->> diff test.out/ar3.shR /tmp/testas.3654/ar3.shR
19a20
> No errors   1 warning

>> ar4.sh: (script) MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
MetaWare High C Compiler R2.5o
(c) Copyright 1987-92, MetaWare Incorporated
w "asmain.c",L15/C1(#72):	main: Function has no return statement.
0706-224 WARNING:  Duplicate symbol 'matherr'.
DIFFERENT
-->> diff test.out/ar4.shR /tmp/testas.3654/ar4.shR
19a20
> No errors   1 warning


****** OK
>> inline4.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/inline4.out inline4.out
2c2
< 0.82352941176470584 + -0.29411764705882354 %i
---
> 0.82352941176470580 + -0.29411764705882350 %i




****** FIX
>> basic.as: (compilation) (not identical) DIFFERENT
-->> diff /tmp/testas.3654/std-basic.asf /tmp/testas.3654/new-basic.asf
25c25
<       (Decl Word "stdoutVar" C 32767 3)
---
>       (Decl Word "stdoutVar" C 255 3)

>> float0.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/float0.out float0.out
1,2c1,2
< 0.99989631572895199
< 1.2345678901234567
---
> 0.99989631572895150
> 1.234567890123456

>> float2.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/float2.out float2.out

****** OK
2c2
< Result = 1.6054129768026948   Error estimate = 1.1373545745915582e-16
---
> Result = 1.6054129768026946   Error estimate = 2.2687402081905075e-16


****** OK
>> f11.as: (execution) DIFFERENT
-->> diff /uaxiom/asharp/version/v32.0/test/test.out/f11.out f11.out
6,18c6,18
< at i 5 y 2.7180555555555554
< at i 6 y 2.7182539682539684
< at i 7 y 2.71827876984127
< at i 8 y 2.7182815255731922
< at i 9 y 2.7182818011463845
< at i 10 y 2.7182818261984929
< at i 11 y 2.7182818282861687
< at i 12 y 2.7182818284467594
< at i 13 y 2.7182818284582302
< at i 14 y 2.7182818284589949
< at i 15 y 2.7182818284590429
< at i 16 y 2.7182818284590455
< at i 17 y 2.7182818284590455
---
> at i 5 y 2.7180555555555552
> at i 6 y 2.7182539682539679
> at i 7 y 2.7182787698412694
> at i 8 y 2.7182815255731916
> at i 9 y 2.7182818011463836
> at i 10 y 2.7182818261984918
> at i 11 y 2.7182818282861674
> at i 12 y 2.7182818284467578
> at i 13 y 2.7182818284582284
> at i 14 y 2.7182818284589929
> at i 15 y 2.7182818284590406
> at i 16 y 2.7182818284590433
> at i 17 y 2.7182818284590433
20c20
< at i 18 y 2.7182818284590455
---
> at i 18 y 2.7182818284590433
22c22
< at i 19 y 2.7182818284590455
---
> at i 19 y 2.7182818284590433
24c24
< at i 20 y 2.7182818284590455
---
> at i 20 y 2.7182818284590433
26c26
< at i 21 y 2.7182818284590455
---
> at i 21 y 2.7182818284590433
28,30c28,30
< at i 22 y 2.7182818284590455
< 2.7182818284590455
< 2.7182818284590455
---
> at i 22 y 2.7182818284590433
> 2.7182818284590433
> 2.7182818284590431
