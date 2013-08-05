--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Sep 30 07:27:02 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17570; Fri, 30 Sep 1994 07:27:02 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 6023; Fri, 30 Sep 94 07:27:07 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.MIKER.NOTE.YKTVMV.1583.Sep.30.07:27:06.-0400>
--*           for asbugs@watson; Fri, 30 Sep 94 07:27:06 -0400
--* Received: from nagrs3.nag.co.uk by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 30 Sep 94 07:27:05 EDT
--* Received: by nagrs3.nag.co.uk (AIX 3.2/UCB 5.64/4.03)
--*           id AA04262; Fri, 30 Sep 1994 12:28:16 +0100
--* Date: Fri, 30 Sep 1994 12:28:16 +0100
--* From: miker@nagrs3.nag.co.uk (Mike Richardson)
--* Message-Id: <9409301128.AA04262@nagrs3.nag.co.uk>
--* To: asbugs@watson.ibm.com
--* Subject: [3] Incorrect association

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -Fx t.as
-- Version: 0.37.0
-- Original bug file name: /home/red5/miker/Axiom/ASdoc/t.as

--+ The program:
--+
--+       #include "axllib"
--+       import from SingleInteger;
--+       S ==> SingleInteger;
--+       (f:(S->S))^(n:S) : (S->S) == {
--+          n = 1 => f;
--+          (x:S):S +-> f (f^(n-1)) x;
--+       }
--+
--+ generates the error messages
--+
--+ [L6 C16] #1 (Error) There are no suitable meanings for the operator `f(f ^ (n - 1))'.
--+ [L6 C16] #2 (Error) No meaning for identifier `f'.
--+
--+ suggesting that the expression "f (f^(n-1)) x" is being parsed as if
--+ space associates to the left.  P.30 of ASUG indicates that it associates
--+ to the right and this is the behaviour normally encountered in A#.
--+
--+ Forcing the correct evaluation order with "f((f^(n-1))x)" produces the
--+ desired result.
--+
--+ Mike
#include "axllib"
import from SingleInteger;
S ==> SingleInteger;
(f:(S->S))^(n:S) : (S->S) == {
   n = 0 => (x:S):S +-> x
   n = 1 => f;
   (x:S):S +-> f (f^(n-1)) x;
}
d(x:S):S == x+x;
print << (d^1) 2 << newline;
print << (d^5) 2 << newline;
