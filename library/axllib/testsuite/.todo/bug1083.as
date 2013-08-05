--* Received: from nirvana.inria.fr by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA05745; Wed, 5 Jun 96 08:08:41 BST
--* Received: by nirvana.inria.fr (8.6.13/8.6.12) id JAA02466 for ax-bugs@nag.co.uk; Wed, 5 Jun 1996 09:02:56 +0200
--* Date: Wed, 5 Jun 1996 09:02:56 +0200
--* From: Yannis Chicha <Yannis.Chicha@sophia.inria.fr>
--* Message-Id: <199606050702.JAA02466@nirvana.inria.fr>
--* To: ax-bugs
--* Subject: [3] compiler makes 'Program fault'

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl bug.as
-- Version: 1.1.5
-- Original bug file name: /u/psyche/0/safir/ychicha/ASHARP/BUGS/bugNAG


Compiler message:
Program fault (bus error).#1 (Error) Program fault (bus error).

Code :
#include "axllib";

s: with {

  foo == Record(R: Ring, x: R);

  func: foo -> ();
} == add {
  Rep ==> Record(contents: Integer);

  func(f:foo): () == 
     print << x << newline;
}

