--* From adk@mailer.scri.fsu.edu  Wed Jun 18 23:54:35 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA19723; Wed, 18 Jun 97 23:54:35 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id XAA14049 for <ax-bugs@nag.co.uk>; Wed, 18 Jun 1997 23:54:09 +0100 (BST)
--* Received: from ibm4.scri.fsu.edu (ibm4.scri.fsu.edu [144.174.131.4]) by mailer.scri.fsu.edu (8.8.5/8.7.5) with ESMTP id SAA23302; Wed, 18 Jun 1997 18:52:41 -0400 (EDT)
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm4.scri.fsu.edu (8.8.5) id WAA21944; Wed, 18 Jun 1997 22:53:13 GMT
--* Date: Wed, 18 Jun 1997 22:53:13 GMT
--* Message-Id: <199706182253.WAA21944@ibm4.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs@nag.co.uk, edwards@scri.fsu.edu
--* Subject: [5] Undetected syntax error gives bad run time output

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -DBUG1 -Ginterp youssef-1.as
-- Version: 1.1.9a
-- Original bug file name: youssef-1.out

--+ #include "axllib"
--+ #pile
--+ 
--+ S ==> SingleInteger
--+ 
--+ --
--+ -- Compiler bug:
--+ -- This is a fine function
--+ --
--+ 
--+ #if BUG1
--+ foo: (a:S)->(b:S)->(c:S) == (a:S)(b:S):(c:S) +-> a+b
--+ #elseif BUG2
--+ foo: S -> (S -> S) == (a:S):S -> S ((b:S):S +-> a+b)
--+ #else
--+ foo(a:S): S -> S == (b:S):S +-> a + b
--+ #endif
--+ 
--+ import from S
--+ print << "foo(1)(1) = 2" << foo(1)(1) << newline
--+ 
--+ #if BUG1
--+ bar: (a:S)->(b:S)->(c:S) == (a:S)(b:S):(c:S) +-> a+b+c
--+ #elseif BUG2
--+ bar: S -> (S -> S) == (a:S):S -> S ((b:S):S +-> a + b + c)
--+ #else
--+ bar(a:S): S -> S == (b:S):S +-> a + b + c
--+ #endif
--+ 
--+ -- I would think that bar is a function with bad syntax.
--+ -- However, it compiles and bar(1)(1) prints as "1513"!
--+ 
--+ print << bar(1)(1) << newline
--+ 
--+ #endpile
AXIOM-XL version 1.1.9a for AIX RS/6000 
               ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
 Time    3.0 s  0  2  0  5  1  1 .3  0  0  0 87  2  1  1  0 .3  0  0 %

 Source  218 lines,  4288 lines per minute
 Lib    6377 bytes,  2093syme 2118foam 62fsyme 668name 91kind 527file 338lazy 281type 2inl 20twins 2ext 2doc 14id 3macros
 Store  1912 K pool
foo(1)(1) = 22
1541
