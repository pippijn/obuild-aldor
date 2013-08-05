--* From Manuel.Bronstein@sophia.inria.fr  Mon Sep 28 11:39:23 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA19474; Mon, 28 Sep 98 11:39:23 +0100
--* Received: from nirvana.inria.fr (bmanuel@nirvana.inria.fr [138.96.48.30])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id LAA22820 for <ax-bugs@nag.co.uk>; Mon, 28 Sep 1998 11:42:23 +0100 (BST)
--* Received: by nirvana.inria.fr (8.8.8/8.8.5) id MAA19069 for ax-bugs@nag.co.uk; Mon, 28 Sep 1998 12:39:09 +0200
--* Date: Mon, 28 Sep 1998 12:39:09 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <199809281039.MAA19069@nirvana.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] no type corresponding to C int on DECs

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.11e
-- Original bug file name: cint.txt

There is no type in Machine that corresponds to a 4-byte C-int
on a 64-bit machine, this is a problem when importing from Foreign "C"
a function that has 'int' rather than 'long' in its parameters:

On a 64-bit DEC:
obelix{bmanuel} 152: axiomxl -g loop
%1 >> #include "axllib"
                                           Comp: 250 msec, Interp: 0 msec
%2 >> a:SingleInteger := max
9223372036854775807 @ SingleInteger
                                           Comp: 67 msec, Interp: 67 msec
%3 >> b:HalfInteger := max
32767 @ HalfInteger


On a 32-bit Sun:
panoramix{} 41: axiomxl -g loop
%1 >> #include "axllib"
                                           Comp: 300 msec, Interp: 20 msec
%2 >> a:SingleInteger := max
2147483647 @ SingleInteger
                                           Comp: 100 msec, Interp: 90 msec
%3 >> b:HalfInteger := max
32767 @ HalfInteger
                                           Comp: 40 msec, Interp: 20 msec

I would expect the HInt$Machine type to be half the size of SInt,
in order to allow C-compatibility.

