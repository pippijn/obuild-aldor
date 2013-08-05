--* From adk@epcc.ed.ac.uk  Thu Sep 14 17:29:50 2000
--* Received: from e450.epcc.ed.ac.uk (e450.epcc.ed.ac.uk [129.215.56.230])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA21696
--* 	for <ax-bugs@nag.co.uk>; Thu, 14 Sep 2000 17:29:47 +0100 (BST)
--* Received: from maxinst.epcc.ed.ac.uk (maxinst [129.215.63.6])
--* 	by e450.epcc.ed.ac.uk (8.9.1/8.9.1) with ESMTP id RAA04415;
--* 	Thu, 14 Sep 2000 17:29:47 +0100 (BST)
--* From: Tony Kennedy <adk@epcc.ed.ac.uk>
--* Received: (from adk@localhost)
--* 	by maxinst.epcc.ed.ac.uk (8.9.1/8.9.1) id RAA04355;
--* 	Thu, 14 Sep 2000 17:29:45 +0100 (BST)
--* Date: Thu, 14 Sep 2000 17:29:45 +0100 (BST)
--* Message-Id: <200009141629.RAA04355@maxinst.epcc.ed.ac.uk>
--* To: adk@ph.ed.ac.uk, ax-bugs@nag.co.uk
--* Subject: [6] Compiler crashes with segmentation violation.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Fasy -V fpres.as
-- Version: 1.1.12p2 for SPARC [Solaris: GCC]
-- Original bug file name: fpres.as

#include "axllib"
#library libadk "libadk.al"
#pile

import from libadk

SI ==> SingleInteger

+++ <xml> 
+++ <P><EM>FinitelyPresentedFiniteMonoid</EM> is a domain of finite monoids
+++ specified by a set of generators <EM>X</EM> and a list of relations
+++ <EM>r</EM>. <EM>X</EM> is a finite set of generators from which we
+++ construct <EM>words</EM> which are the elements of the free monoid which
+++ they generate. In particular, the identity element of the monoid is
+++ represented by the empty word. The relations are represented by a list of
+++ elements of the free monoid on <EM>X</EM> (words), and they induce an
+++ equivalence relation on the free monoid. The finitely presented free monoid
+++ is the quotient of the free monoid by this equivalence relation. We shall
+++ call the elements of the finitely presented free monoid <EM>words</EM>,
+++ even though they are stricly speaking equivalence classes of words in the
+++ underlying free monoid.</P>
+++ <P><B>NOTE:</B> This domain only works for <B>finite</B> monoids, but it is
+++ in general undecidable given a finite presentation of a monoid whether the
+++ monoid is in fact finite, so we cannot check. A symptom of an infinite
+++ monoid is that domain instantiation runs out of memory, but this can also
+++ happen for small (but perverse) finite monoids. <EM>Caveat emptor</EM>.</P>
+++ <P>Perhaps we should make this an ordered monoid, as we can do this
+++ slightly more cheaply than by using the (not-yet-existing) default
+++ inherited from <EM>CountablyFinite</EM> (which is <EM>a < b</EM> iff
+++ <EM>ord a < ord b</EM>), because <EM>rep a < rep b</EM> iff <EM>ord a < ord
+++ b</EM>.</P>
+++ <P><B>Author:</B> ADK</P>
+++ <P><B>Date Created:</B> 2-JUN-1995 17:49:50.00</P>
+++ <P><B>Modifications:</B><UL>
+++ <LI><EM>19-SEP-1995 18:27:44.00 (ADK)</EM> Explicitly made
+++ <EM>CountablyInfinite(SI)</EM></LI>
+++ <LI><EM>15-APR-1996 14:57:25.00 (ADK)</EM> Rewritten to have generators
+++ specified by a domain belonging to <EM>CountablyFinite(SI)</EM></LI>
+++ <LI><EM>19-APR-1996 13:16:22.00 (ADK)</EM> Relations are now given as
+++ elements of the the free monoid on <EM>X</EM></LI>
+++ </UL></P>
+++ </xml>

FinitelyPresentedFiniteMonoid(X: CountablyFinite SI, r: List FreeMonoid X):
  Join(Monoid, Order, CountablyFinite SI) with

      *: (X, %) -> %			++ Multiply generator and word

      *: (%, X) -> %			++ Multiply word and generator

      coerce: X -> %			++ Coerce monoid generator into word

      coerce: FreeMonoid X -> %		++ Coerce word in free monoid into word
					++ in finitely presented monoid (i.e.,
					++ into its equivalence class modulo
					++ the presentation)

      coerce: % -> FreeMonoid X		++ Coerce word into the corresponding
					++ word in the free monoid. (N.B., this
					++ depends upon our choice of
					++ representative for the equivalence
					++ class)

      first: % -> X			++ First (leftmost) monoid generator
					++ in word 

      rest: % -> %			++ Word with first (leftmost) monoid
					++ generator removed. (N.B., the result
					++ may well be a different
					++ representative of the equivalence
					++ class of the free monoid version of
					++ this function)

      generator: % -> Generator Cross(X, SI)
					++ Generator of powers of monoid
					++ generators corresponding to word

      generator: % -> Generator X       ++ Generator of monoid generators
					++ corresponding to word

      printMultiplicationTable: TextWriter -> TextWriter
					++ Display the multiplication table for
					++ the monoid

      associative?: () -> Boolean	++ Check associativity of monoid

      commutative?: () -> Boolean	++ Check commutativity of monoid

    == add

      missing ==> 0			-- Uninitialized element of row in
					-- multiplication table

      -- An elements of the monoid (word) is represented by a unique index into
      -- the multiplicationTable for the domain.

      Rep == SI

      local
        one: Rep
        maxRow: Rep

      -- Each row of the multiplication <EM>table</EM> corresponds to an
      -- element of the monoid, and each column to a generator. A word
      -- corresponding to a row may be obtained by multiplying the word
      -- <EM>previous</EM> on the left by the generator <EM>via</EM>.

      Row == BoundedArray(X, Rep)
      Multiples == Record(table: Row, previous: Rep, via: X)
      multiplicationTable: ClusteredArray Multiples == empty()

      -- <EM>active? w</EM> is true if <EM>w</EM> is the root index of its
      -- cluster

      local active?(w: Rep): Boolean ==
	cluster(multiplicationTable, w) = w

      -- <EM>identifyRows!(i, j)</EM> joins the word equivalence class which
      -- contains <EM>i</EM> to the word equivalence class which contains
      -- <EM>j</EM>, and returns the word which is the root (representative) of
      -- the resulting equivalence class (cluster).

      -- N.B., identifying words u and v implies that for all generators g the
      -- words g * u and g * v must be identified also. These identifications
      -- are performed in breadth-first order as otherwise the explicit
      -- <EM>dispose!</EM> operations might be erroneous.

      local identifyRows!(i: Rep, j: Rep): Rep ==
	local toBeIdentified: List Record(lhs: Rep, rhs: Rep) := empty()

	iRoot: Rep == cluster(multiplicationTable, i)
	jRoot: Rep == cluster(multiplicationTable, j)
	iRoot = jRoot => jRoot
	smaller?: Boolean == 
#if NOLEXORDER
	  iRoot < jRoot
#else
#if BUG
	  per.iRoot < per.jRoot
#else
	  per.jRoot > per.iRoot
#endif
#endif
	smaller? => identifyRows!(jRoot, iRoot)
	iRow := multiplicationTable iRoot
	jRow := multiplicationTable jRoot
	identify!(multiplicationTable, iRoot, jRoot)
	for k: X in all() repeat
	  jRow.table.k = missing => jRow.table.k := iRow.table.k
	  iRow.table.k ~= missing =>
	    toBeIdentified := 
	      cons([iRow.table.k, jRow.table.k], toBeIdentified)
	dispose! iRow
	for pair in toBeIdentified repeat
	  identifyRows!(pair.lhs, pair.rhs)
	  dispose! pair
	jRoot

      -- We use the Todd-Coxeter algorithm to construct the multiplication
      -- table at domain initialization time. It returns three values, the
      -- cardinality of the monoid, the index of the identity element, and the
      -- maximum index (active or otherwise) in <EM>multiplicationTable</EM>.

      local toddCoxeter(): Cross(SI, Rep, Rep) ==
	local
	  oneVar: Rep
	  maxRowVar: Rep
	  newRow: Multiples
	  rowOne: Row == new(missing)

	-- Initialize the multiplication table with the empty word

	maxRowVar := oneVar :=
	  extend!(multiplicationTable, [rowOne, sample, sample])

	-- Step through the rows of the multiplication table adding new rows to
	-- the end as necessary until there are no more rows left (this of
	-- course may never happen if the monoid is not finite)

	for initialRow in (oneVar ..)@OpenSegment(Rep)
	  while initialRow <= maxRowVar repeat
	    while active? initialRow for relation in r repeat
	      state := initialRow

	      -- Step though all the relations in the presentation enforcing
	      -- the identity r * w = w for all relations <EM>r</EM> and all
	      -- words w

	      for g: X in relation repeat
		row := multiplicationTable state
		previousState := state
		state := row.table g
		state = missing =>

		  -- We have reached a new word, which has not (yet) been
		  -- identified with any other word

		  newRow := [new(missing), previousState, g]
		  row.table g := state := maxRowVar := 
		    extend!(multiplicationTable, newRow)

	      -- We are now in the state corresponding to r * w, which we now
	      -- assert is to be identified with the initial state w

	      identifyRows!(state, initialRow)

	-- Even though the preceding loop has terminated the monoid is still
	-- infinite if any of the entries in the multiplication table are
	-- missing

	cardVar: SI := 0
	for multiple in multiplicationTable repeat
	  cardVar := cardVar + 1
	  for entry in multiple.table repeat
	    entry = missing =>
	      error "FinitelyPresentedFiniteMonoid: monoid is not finite"

	-- Return the number of elements in the monoid

	(cardVar, oneVar, maxRowVar)

      printMultiplicationTable(p: TextWriter): TextWriter ==
	tab: Character == char "	"
	p << "#"
	for g: X in all() repeat p << tab << g
	p << tab << "representative" << newline
	for m: % in all() repeat
	  p << ord m
	  for g: X in all() repeat
	    p << tab << ord(g * m)
	  p << tab << m << newline
	p

      -- <EM>associative?()</EM> should always return <EM>true</EM>

      associative?(): Boolean ==
	for u: % in all() repeat
	  for v: % in all() repeat
	    for w: % in all() repeat
	      (u * v) * w ~= u * (v * w) => return false
	true

      -- <EM>commutative?()</EM> could be cached

      commutative?(): Boolean ==
	for u: % in all() repeat
	  for v: % in all() repeat
	    rep u < rep v and u * v ~= v * u => return false
	true

      coerce(f: FreeMonoid X): % ==
	f = 1 => 1
	(g, k) == first f
        power(coerce rest f, coerce g, k)$
	  BinaryPowering(%, (a: %, b: %): % +-> b * a, SI)

      -- The following is conditionalized because `1' is not defined until
      -- after <EM>toddCoxeter</EM> is run during domain initialization. The
      -- <EM>#else</EM> clause could be used anyhow, but it seems less elegant
      -- and less modular.

      coerce(w: %): FreeMonoid X ==
#if NOLEXORDER
	w = 1 => 1
	first.w * coerce rest w
#else
	rep w = one => 1
	m == multiplicationTable rep w
	m.via * coerce per m.previous
#endif

      coerce(x: X): % == per multiplicationTable.one.table.x

      first(a: %): X ==
	a = 1 => error "FinitelyPresentedFiniteMonoid: first applied to 1"
	multiplicationTable(rep a).via

      rest(a: %): % ==
	a = 1 => error "FinitelyPresentedFiniteMonoid: rest applied to 1"
	per multiplicationTable(rep a).previous

      local generator(a: %, g: X, k: SI): Generator Cross(X, SI) == generate
	a = 1 => k > 0 => yield (g, k)	-- if k = 0 then yield nothing
	h: X == first a
	h = g => for gk in generator(rest a, g, k + 1) repeat yield gk
	if k > 0 then yield (g, k)
	for gk in generator(rest a, h, 1) repeat yield gk

      generator(a: %): Generator Cross(X, SI) == generator(a, sample, 0)

      generator(a: %): Generator X == generate
	a ~= 1 =>
	  yield first a
	  for g: X in rest a repeat yield g

      all(): Generator % == generate 
	for i in one .. maxRow repeat
	  active? i => yield per i

      (a: %) * (g: X): % == a * coerce g

      (g: X) * (a: %): % == per multiplicationTable(rep a).table.g

      (a: %) * (b: %): % ==
	a = 1 => b
	first.a * (rest.a * b)

      -- One would think that this would be a good candidate for a category
      -- default for Monoid!

      (a: %)^(n: Integer): % == power(1, a, n)$BinaryPowering(%, *, Integer)

      (p: TextWriter) << (a: %): TextWriter ==
	import from SI
	local
	  delimiter: String := ""
	p << "<"
	for gk: Cross(X, SI) in a repeat
	  (g, k) := gk
	  p << delimiter << g
	  if k > 1 then p << "**" << k
	  delimiter := " * "
	p << ">"

      -- Note that the representation is not canonical, but the cluster number
      -- of any representative is canonical

      (a: %) = (b: %): Boolean ==
	cluster(multiplicationTable, rep a) =
          cluster(multiplicationTable, rep b)

      -- The ordering of words is inherited from the ordering provided by the
      -- corresponding free monoid

      (a: %) > (b: %): Boolean == a::FreeMonoid(X) > b::FreeMonoid(X)

      hash(a: %): SI == cluster(multiplicationTable, rep a)

      -- This is the code which is run at domain instantiation time to create
      -- multiplicationTable, card, and so forth.

#if BUG
      (card: SI, one: Rep, maxRow: Rep) == toddCoxeter()
#else
      local cardTmp:* SI
      (cardTmp, one, maxRow) == toddCoxeter()
      card:* SI == cardTmp
#endif

      1: % == per one

      sample: % == 1
