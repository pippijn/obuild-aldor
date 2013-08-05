--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon Feb 13 10:12:09 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17274; Mon, 13 Feb 1995 10:12:09 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1599; Mon, 13 Feb 95 10:11:44 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.7179.Feb.13.10:11:43.-0500>
--*           for asbugs@watson; Mon, 13 Feb 95 10:11:44 -0500
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 13 Feb 95 10:11:42 EST
--* Via: uk.co.iec; Mon, 13 Feb 1995 12:55:22 +0000
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA15845;
--*           Mon, 13 Feb 95 12:57:05 GMT
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Mon, 13 Feb 95 12:54:36 GMT
--* Message-Id: <16770.9502131254@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA16770;
--*           Mon, 13 Feb 95 12:54:36 GMT
--* To: asbugs@watson.ibm.com
--* Subject: [1] problem with apply and foreign functions

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- from Larry Lambe
-- Command line: see file
-- Version: 1.0.0
-- Original bug file name: /home/users/lambe/to.nag


First of all, here is the C code:
----------------------------------------

#include "foam_c.h"

double * bar(x)
double x;
{
    double * foo;
    foo = (double *) malloc(5 * sizeof(double));
    foo[0] = x;
    foo[1] = 2.0*x;
    foo[2] = 3.0*x;
    foo[3] = 4.0*x;
    foo[4] = 5.0*x;
    return foo;
}

double set(a,i,v)
double * a;
int i;
double v;
{
       return a[i] = v;
}

double * new(i)
int i;
{
   double * foo;
   foo = (double *) malloc(i * sizeof(double));
   return foo;
}

double apply(a,i)
double * a;
int i;
{
   return a[i];
}
--------------------------------------------------

Here is the axiomxl:

------------------------

#include "axllib"

macro {
        Ptr    == Pointer;
        DF     == DoubleFloat;
        Int    == Integer;

}

import {
        bar   : BDFlo -> Ptr;
        new   : Int -> Ptr;
        set   : (Ptr, Int, DF) -> DF;
        apply : (Ptr, Int) -> DF;
} from Foreign C;

import from Int;

co : DF == 216.2127;
a := bar(co::BDFlo);

tst := a.1;

print<<tst<<newline;

--------------------------------------

Here is what the compiler says to this:

pavidus[320] comp1 df3 dftest3

dftest3.as:
Bug: Bad case 10 (line 1342 in file ../src/genfoam.c).
=========================

The shell script comp1 is:

pavidus[321] cat comp1
cc -c -I$AXIOMXLROOT/include $1.c
axiomxl -F x $2.as $1.o

---------------------------------------

When I change the above to

tst := apply(a,1);

and recompile, I get

pavidus[10] comp1 df4 dftest4

dftest4.as:
pavidus[11] dftest4
864.85080000000005
---------------------------

Thus, "apply" does not work for foreign functions.

Regards,
            Larry

--NAA21751.792508831/insanus--






