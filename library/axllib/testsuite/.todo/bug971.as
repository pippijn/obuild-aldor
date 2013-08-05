From asbugs@com.ibm.watson Mon May 22 12:33:40 1995
Date: Mon, 22 May 1995 07:05:35 -0400
From: asbugs@com.ibm.watson (S Watt)
To: dooley@com.ibm.watson, iglio@it.unipi.dm.posso, peterb@uk.co.nag,
        smwatt@com.ibm.watson
Subject: Received A# bug971
Sender: asbugs@com.ibm.watson


  Reporter:    peterb@num-alg-grp.co.uk
  Number:      bug971
  Description: [6] Bug: can't create dummy

Thank you for your bug report.  It has been assigned bug number bug971.

If you wish to discuss this bug via E-mail, please direct your messages
to specific people and include the bug number.

------------------------------ bug971.as ---------------------------------
--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Mon May 22 07:05:32 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA24089; Mon, 22 May 1995 07:05:32 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3403; Mon, 22 May 95 07:05:32 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.4718.May.22.07:05:31.-0400>
--*           for asbugs@watson; Mon, 22 May 95 07:05:32 -0400
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 22 May 95 07:05:30 EDT
--* Via: uk.co.iec; Mon, 22 May 1995 12:00:24 +0100
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA00625;
--*           Mon, 22 May 95 12:02:54 BST
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Mon, 22 May 95 12:01:25 +0100
--* Message-Id: <355.9505221101@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA00355;
--*           Mon, 22 May 95 12:01:25 +0100
--* To: asbugs@watson.ibm.com
--* Subject: [6] Bug: can't create dummy

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


 From: adk@scri.fsu.edu
 NAG Log number: LJK13438

-- Command line: axiomxl bug8.as
-- Version: 1.0.4
-- Original bug file name: bug8.as

--+ {* (LexConst) generatorInverse *}
--+ <* General (* (* Array *) (* X *) *) *>
--+ Bug: can't create dummy
#include "axllib.as"
#library libadk "libadk.al"
#pile

SI ==> SingleInteger
import from libadk

+++ `FinitelyPresentedSubgroup' is a domain representing a subgroup by
+++ giving a set of generators, and set of `words' which are to be
+++ identified with the identity (and which are represented as tuples
+++ of generators), and a set of generators which generate the subgroup.
+++
+++ Author: ADK
+++ Date Created: 17-MAY-1995 17:28:57.00
+++ Modifications:

FinitelyPresentedSubgroup(X: BasicType, groupGenerators: Tuple X,
  subgroupGenerators: Tuple X, presentation: Tuple Tuple X): with
      toddCoxeter: () -> ()
    == add
      missingCoset ==> 0	-- This is part of the algorithm
      badGenerator ==> -1	-- This is just to catch bugs

      print << "Constructing domain FinitelyPresentedSubgroup..." << newline

      local
	CosetMultiples == Array SI
	cosetMultiplicationTable: ClusteredArray CosetMultiples == empty()
	cardGroupGenerators: SI == length(groupGenerators)$(Tuple X)
	generatorIndex: HashTable(X, SI) == table()
	generatorInverse: Array X == empty()
	maxCoset: SI := 1
	presentationCode: List Array SI := empty()

      -- Initialize generatorIndex table and its inverse

      for i in 1 .. cardGroupGenerators repeat
	gen: X := element(groupGenerators, i)
	generatorIndex gen := i
	extend!(generatorInverse, gen)

      print << "generatorIndex = " << generatorIndex << newline
      print << "generatorInverse = " << generatorInverse << newline

      -- Initialize presentationCode

      for i in 1 .. length(presentation)$(Tuple Tuple X) repeat
	local
	  word: Tuple X == element(presentation, i)
	  wordLength: SI == length(word)$(Tuple X)
	  newWordCode: Array SI == new(wordLength, badGenerator)
	for j in 1 .. wordLength repeat
	  newWordCode j := generatorIndex(element(word, j))
	presentationCode := cons(newWordCode, presentationCode)

      print << "presentationCode = " << presentationCode << newline

      active?(coset: SI): Boolean ==
	cluster(cosetMultiplicationTable, coset) = coset

      identifyCosets!(i: SI, j: SI): SI ==
	i < j => identifyCosets!(j, i)
	i > j =>
	  print << "Identifying cosets " << i << " and " << j << newline
	  iRow := cosetMultiplicationTable.i
	  jRow := cosetMultiplicationTable.j
	  identify!(cosetMultiplicationTable, i, j)
	  for k in 1 .. cardGroupGenerators repeat
	    jRow k = missingCoset => jRow k := iRow k
	    iRow k ~= missingCoset => jRow k := identifyCosets!(iRow k, jRow k)
	  dispose! iRow
	  j
	j				-- i = j => j

      printCosetMultiplicationTable(): () ==
        local tab: Character == char "	"
        print << "-- Coset Multiplication Table --" << newline

        print << "Coset"
        for g in generatorInverse repeat print << tab << g
	print << newline

	for i in 1 .. maxCoset repeat
          print << i
	  if (k := cluster(cosetMultiplicationTable, i)) = i then
	      for j in cosetMultiplicationTable i repeat
		print << tab << j
            else print << " --> " << k
	  print << newline

	print << newline

      toddCoxeter(): () ==

	  print << "Entering toddCoxeter..." << newline

	  local
	    row: CosetMultiples
	  free maxCoset

	  -- Insert trivial transitions for subgroup on itself (coset 1)

	  row := new(cardGroupGenerators, missingCoset)
	  for i in 1 .. length(subgroupGenerators)$(Tuple X) repeat
	    row generatorIndex element(subgroupGenerators, i) := 1
	  extend!(cosetMultiplicationTable, row)

	  printCosetMultiplicationTable()

	  -- And off we go...

	  for currentCoset in 1 .. while currentCoset <= maxCoset repeat
	    print << "Contemplating coset " << currentCoset << newline
	    while active? currentCoset for wordCode in presentationCode repeat
	      print << "Applying word " << wordCode
		<< " to coset " << currentCoset << newline
	      state := currentCoset
	      for generatorCode in wordCode repeat
		print << "Transition " << generatorInverse(generatorCode)
		  << ": " << state << " +-> "
		row := cosetMultiplicationTable state
		state := row generatorCode
		state = missingCoset =>
		  newRow := new(cardGroupGenerators, missingCoset)
		  row generatorCode := state := maxCoset :=
		    extend!(cosetMultiplicationTable, newRow)
		  print << "*" << state << newline
		print << state << newline
	      identifyCosets!(state, currentCoset)

	    printCosetMultiplicationTable()




