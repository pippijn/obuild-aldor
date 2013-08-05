--* Received: from psyche.inria.fr by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA10731; Sat, 6 Apr 96 07:40:23 BST
--* Received: by psyche.inria.fr (8.6.13/8.6.12) id IAA10497; Sat, 6 Apr 1996 08:35:10 +0200
--* Date: Sat, 6 Apr 1996 08:35:10 +0200
--* From: Stephen Watt <Stephen.Watt@sophia.inria.fr>
--* Message-Id: <199604060635.IAA10497@psyche.inria.fr>
--* To: adk@scri.fsu.edu
--* Subject: Re:  Trouble with extended Enumeration
--* Cc: ax-bugs

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

From a first look, it appears that you are not doing anything wrong.

I suspect that you are hitting some special handling code for Enumerations,
in that the code generator thinks it knows all about them, but now doesn't.
If this theory is correct, then it shouldn't be too difficult to fix.

This is a very nice example, extending a quasi-builtin type.  

-- Stephen

P.S.  I'm forwarding this to NAG so that it is not lost.

> Date: Sat, 6 Apr 1996 00:26:07 -0500
> Message-Id: <199604060526.AA33755@ibm4.scri.fsu.edu>
> To: Stephen.Watt@unice.fr
> Subject: Trouble with extended Enumeration
>
> I am working on implementing the free group stuff we discussed during
> our visit, and I decided (following your suggestion) that a nice way
> of specifying the generators was to pass them to the FreeGroup
> constructor as a CountableSet (i.e., BasicType joined with a category
> Countable which provides a generator of elements of the set).
>
> This worked very nicely, but it then struck me that one of the most
> natural ways of specifying a finite set of group generators would be
> as an Enumeration -- so I tried to extend the functor Enumerate as follows:
>
> -- This is my file enum.as
>
> #include "axllib.as"
> #pile
>
> SI ==> SingleInteger
>
> extend Enumeration(T: Tuple Type): with
>     card: SI
>     ord: % -> SI
>     val: SI -> %
>   == add
>     Rep ==> BSInt
>     card: SI == length T
>     ord(e: %): SI == (rep e)::SI + 1
>     val(i: SI): % == per((i - 1)::BSInt)
>
> --- This is my test program enum-test.as
>
> #include "axllib.as"
> #library libenum "enum.ao"
> #pile
>
> SI ==> SingleInteger
>
> import from libenum
> import from SI
>
> test(): () ==
>   E == Enumeration(a,b,c)
>   import from E
>   i: SI == card$E
>   e: E == val 1
>   j: SI == ord e
>   print . "i = ~a, e = ~a, j = ~a~n" . (<< i, << e, << j)
>
> test()
>
> However, I just get a bunch of compilation erros when I try to compile
> the test program, because card$E, val$E, and ord$E are not found. Can
> you suggest what I am doing wrong?
>
> 	-Tony-
>
> P.S., trying to print an element of an Enumeration also seems to
> exercise a compiler bug.

