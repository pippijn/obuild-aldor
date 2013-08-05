--* From Stephen.Watt@sophia.inria.fr  Wed Feb 26 08:53:58 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA01010; Wed, 26 Feb 97 08:53:58 GMT
--* Received: from korrigan.inria.fr (korrigan.inria.fr [138.96.48.27])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id IAA03712 for <ax-bugs@nag.co.uk>; Wed, 26 Feb 1997 08:54:34 GMT
--* Received: by korrigan.inria.fr (8.8.5/8.6.12) id JAA00666 for ax-bugs@nag.co.uk; Wed, 26 Feb 1997 09:53:46 +0100 (MET)
--* Date: Wed, 26 Feb 1997 09:53:46 +0100 (MET)
--* From: Stephen Watt <Stephen.Watt@sophia.inria.fr>
--* Message-Id: <199702260853.JAA00666@korrigan.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [5] -Fc ignored sometimes

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Cargs=-g -Fc -Fo -Fao cposso.as (does not generate .c file)
-- Version: 1.1.8 SPARC
-- Original bug file name: cposso.as

-------------------------------------------------------------------------------
--
--  asposso.as
--  Copyright (C) 1996, 1997 INRIA.
--
-------------------------------------------------------------------------------
--  Package:  Aldor-Interface
--  date:     01 January 1997
--  author:   Stephen Watt
--  email:    Stephen.Watt@sophia.inria.fr
--  Address:  INRIA Sophia Antipolis
--            2004, route des Lucioles
--            06902 Sophia Antipolis Cedex
--            FRANCE
--
-- This code is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#include "axllib.as"

macro SInt == SingleInteger;

PossoLibrary: with {

	Bool:			Type;	-- A kind of int
	SIntArray:		Type;

	Stream:			Type;
	CoeffRing:   		Type;
	Coeff:   		Type;
	Poly:   		Type;
	PolyList:   		Type;
	PolyRing:   		Type;
	PolyRingMap:   		Type;
	GroebnerReductor:	Type;
	GRList:   		Type;

	-- Streams -----------------------------------------------------------
	OutMode:		() -> SInt;
	InMode:			() -> SInt;
	openStream:		(String, mode: SInt) ->  Stream;
	closeStream:		(Stream) ->  ();
	cin:			() -> Stream;
	cout:			() -> Stream;
	cerr:			() -> Stream;

	-- PolyRing ----------------------------------------------------------
	polyRingCreate:		() -> PolyRing;
	polyRingRead:		(PolyRing, Stream) -> PolyRing;
	polyRingWrite:		(PolyRing, Stream) -> PolyRing;
	polyRingSet:		(PolyRing) -> PolyRing;
	polyRingGet:		() -> PolyRing;

	-- CoeffRing ---------------------------------------------------------
	GCoeffRingCreate:	() -> CoeffRing;
	ZpCoeffRingCreate:	(prime: SInt) -> CoeffRing;
	FCoeffRingCreate:	() -> CoeffRing;
	HCoeffRingCreate:	(prime: SInt, prec: SInt, SInt) -> CoeffRing;
	SCoeffRingCreate:	() -> CoeffRing;

	-- Coeff -------------------------------------------------------------
	GCoeffCreate:		(CoeffRing, SInt) -> Coeff;
	ZpCoeffCreate:		(CoeffRing, SInt) -> Coeff;
	FCoeffCreateInt:	(CoeffRing, SInt) -> Coeff;
	FCoeffCreateDouble:	(CoeffRing, DoubleFloat)   -> Coeff;
	HCoeffCreate:		(CoeffRing, SInt) -> Coeff;
	SCoeffCreate:		(CoeffRing, SInt) -> Coeff;

	coeffRead:		(CoeffRing, Stream, Coeff) -> Coeff;
	coeffWrite:		(CoeffRing, Stream, Coeff) -> Coeff;

	coeffCopy: (CoeffRing, p1: Coeff, p2: Coeff) -> Coeff;
		++ Makes a deep copy of p2 to p1.
        	++ Returns p1.

	coeffAdd: (CoeffRing, res: Coeff, p1: Coeff, p2: Coeff) -> Coeff;
		++ Adds p1 to p2. The result is set to res
	    	++ The destructive operation is CoeffAdd: (p1, p1, p2)

	coeffMul: (CoeffRing, res: Coeff, p1: Coeff, p2: Coeff) -> Coeff;
		++ Multiplies p1 to p2. The result is set to res
		++ The destructive operation is CoeffMul: (p1, p1, p2)

	-- Poly ---------------------------------------------------------------
	polyCreate: (PolyRing) -> Poly;
	polyRead: (PolyRing, Stream, Poly) -> Poly;
	polyWrite: (PolyRing, Stream, Poly) -> Poly;

	polyCopy: (PolyRing, p1: Poly, p2: Poly) -> Poly;
		++ Makes a deep copy of p2 to p1

	polyAdd: (PolyRing, res: Poly, p1: Poly, p2: Poly) -> ();
		++ Adds p1 to p2. The result is set to res
		++ The destructive operation is polyAdd: (p1, p1, p2)

	polyMul: (PolyRing, res: Poly, p1: Poly, p2: Poly) -> ();
		++ Multiplies p1 to p2. The result is set to res
		++ The destructive operation is polyMul: (p1, p1, p2)

	-- PolyList -----------------------------------------------------------
	polyListCreate: (pr: PolyRing) -> PolyList;
	polyListRead:   (PolyList, Stream) -> PolyList;
	polyListWrite:  (PolyList, Stream) -> PolyList;

	-- GroebnerReductor ---------------------------------------------------
 	-- The following functions use an index in the C++ corresponding table.
	-- If you need to add a new function, you must do that in C++, not in C.
	-- An C interface function using directly function pointers is needed
	-- to allow the definition of new functionalities in C.

	setStrategyLess:       (GroebnerReductor, index: SInt) -> ();
	setSloppyStrategyLess: (GroebnerReductor, index: SInt) -> ();
	setDiscardingPair:     (GroebnerReductor, index: SInt) -> ();
	setPostSimplify:       (GroebnerReductor, index: SInt) -> ();
	setInitialize:         (GroebnerReductor, index: SInt) -> ();
	setBasisInsert:        (GroebnerReductor, index: SInt) -> ();
	setSimplifiersInsert:  (GroebnerReductor, index: SInt) -> ();
	setEraseUseless:       (GroebnerReductor, index: SInt) -> ();
	setFinalReduction:     (GroebnerReductor, index: SInt) -> ();
	setNormalize:          (GroebnerReductor, index: SInt) -> ();
	setWeakNormalize:      (GroebnerReductor, index: SInt) -> ();
	setUpdateQueue:        (GroebnerReductor, index: SInt) -> ();

	NO__ERASE__USELESS:		 SInt;
	NORMAL__ERASE__USELESS:		 SInt;
	NORMAL__FINAL__REDUCTION:	 SInt;
	NO__FINAL__REDUCTION:		 SInt;
	NORMAL__INITIALIZE:		 SInt;
	TAIL__BASIS__INSERT:		 SInt;
	HYBRIDS__TAIL__BASIS__INSERT:	 SInt;
	TAIL__SIMPLIFIERS__INSERT:	 SInt;
	TC__SIMPLIFIERS__INSERT:	 SInt;
	NO__POST__SIMPLIFY:		 SInt;
	NEVER__BREAK:			 SInt;
	NO__DISCARDING__PAIR:		 SInt;
	NORMAL__STRATEGY:		 SInt;
	SUGAR__STRATEGY:		 SInt;
	TC__NORMAL__STRATEGY:		 SInt;
	TC__WEIGHT__E__CART__STRATEGY:	 SInt;
	PRIMITIVE__NORMALIZE:		 SInt;
	NO__NORMALIZE:			 SInt;
	NO__INTERNAL__NORMALIZE:	 SInt;
	CLEAN__INF:			 SInt;
	NO__UPDATE__QUEUE:		 SInt;
	NORMAL__UPDATE__QUEUE:		 SInt;

	groebnerReductorCreate:	 (pr: PolyRing) -> GroebnerReductor;

	getBasis: (gr: GroebnerReductor) -> PolyList;
 		++ Returns the GR basis as a polynomial list

	setBasis: (gr: GroebnerReductor, pl: PolyList) -> ();
 		++  Sets the basis of a GR taking it from a PL

	getSimplifiers: (gr: GroebnerReductor) -> PolyList;
 		++ Returns the GR simplifiers as a PL

	setSimplifiers: (gr: GroebnerReductor, pl: PolyList) -> ();
 		++ Sets the simplifiers of a GR taking it from a PL

	computeBasis: (gr: GroebnerReductor, pl: PolyList) -> PolyList;
 		++ Compute the basis and returns it

	initialize: (gr: GroebnerReductor, initialGenerators: PolyList) -> ();
 		++ Adds to a GR a set of singleton pairs corresponding to the
		++ elements of PL

	mergeReductor: (gr1: GroebnerReductor, gr2: GroebnerReductor) -> ();
 		++ Given two GR with the same ring, merges them: basis and
		++ simplifiers are merged, the pairs are merged adding the
		++ cross-pairs between the bases. Redundant elements in the
		++ basis are discarded.

	traceComputeBasis: (gr: GroebnerReductor, pl: PolyList, prime: SInt) -> PolyList;
 		++ Performs the trace lifting algorithm with pilot computation
		++ mod int

	-- GroebnerReductorList Operations ------------------------------------
	GRListCreate: () -> GRList;
	GRListPush: (GRList, GroebnerReductor) -> GRList;
	GRListPop: (GRList) -> GRList;
	GRListIsEmpty: (GRList) -> Bool;
	GRListLength: (GRList) -> SInt;

	-- Control operations -------------------------------------------------
	setAlgVerbosity: (gr: GroebnerReductor, level: SInt) -> ();
 		++ Sets a level of verbosity [0-4] in the algorithm output

	setResultVerbosity: (gr: GroebnerReductor, level: SInt) -> ();
 		++ Sets a level of verbosity [0-4] in the result output
} == add {

	import {
		CPL__OutMode:		() -> SInt;
		CPL__InMode:		() -> SInt;
		CPL__openStream:	(name: String, mode: SInt) ->  Stream;
		CPL__closeStream:	(Stream) ->  ();
		CPL__cin:		() -> Stream;
		CPL__cout:		() -> Stream;
		CPL__cerr:		() -> Stream;

		CPL__polyRingCreate:	() -> PolyRing;
		CPL__polyRingRead:	(PolyRing, Stream) -> PolyRing;
		CPL__polyRingWrite:	(PolyRing, Stream) -> PolyRing;
		CPL__polyRingSet:	(PolyRing) -> PolyRing;
		CPL__polyRingGet:	() -> PolyRing;

		CPL__GCoeffRingCreate:	() -> CoeffRing;
		CPL__ZpCoeffRingCreate:	(SInt) -> CoeffRing;
		CPL__FCoeffRingCreate:	() -> CoeffRing;
		CPL__HCoeffRingCreate:	(SInt, SInt, SInt) -> CoeffRing;
		CPL__SCoeffRingCreate:	() -> CoeffRing;

		CPL__GCoeffCreate:	(CoeffRing,SInt) -> Coeff;
		CPL__ZpCoeffCreate:	(CoeffRing,SInt) -> Coeff;
		CPL__FCoeffCreateInt:   (CoeffRing,SInt) -> Coeff;
		CPL__FCoeffCreateDouble:(CoeffRing,BDFlo)-> Coeff;
		CPL__HCoeffCreate:	(CoeffRing,SInt) -> Coeff;
		CPL__SCoeffCreate:	(CoeffRing,SInt) -> Coeff;
		CPL__coeffRead:		(CoeffRing,Stream,Coeff) -> Coeff;
		CPL__coeffWrite:	(CoeffRing,Stream,Coeff) -> Coeff;
		CPL__coeffCopy: 	(CoeffRing,Coeff,Coeff) -> Coeff;
		CPL__coeffAdd: 		(CoeffRing,Coeff,Coeff,Coeff) -> Coeff;
		CPL__coeffMul: 		(CoeffRing,Coeff,Coeff,Coeff) -> Coeff;

		CPL__polyCreate: 	(PolyRing) -> Poly;
		CPL__polyRead: 		(PolyRing, Stream, Poly) -> Poly;
		CPL__polyWrite: 	(PolyRing, Stream, Poly) -> Poly;
		CPL__polyCopy: 		(PolyRing, Poly, Poly) -> Poly;
		CPL__polyAdd: 		(PolyRing, Poly, Poly, Poly) -> ();
		CPL__polyMul: 		(PolyRing, Poly, Poly, Poly) -> ();

		CPL__polyListCreate: 	(PolyRing) -> PolyList;
		CPL__polyListRead:   	(PolyList, Stream) -> PolyList;
		CPL__polyListWrite:  	(PolyList, Stream) -> PolyList;

		CPL__setStrategyLess:   (GroebnerReductor, SInt) -> ();
		CPL__setSloppyStrategyLess: (GroebnerReductor, SInt) -> ();
		CPL__setDiscardingPair: (GroebnerReductor, SInt) -> ();
		CPL__setPostSimplify:   (GroebnerReductor, SInt) -> ();
		CPL__setInitialize:     (GroebnerReductor, SInt) -> ();
		CPL__setBasisInsert:    (GroebnerReductor, SInt) -> ();
		CPL__setSimplifiersInsert: (GroebnerReductor, SInt) -> ();
		CPL__setEraseUseless:   (GroebnerReductor, SInt) -> ();
		CPL__setFinalReduction: (GroebnerReductor, SInt) -> ();
		CPL__setNormalize:      (GroebnerReductor, SInt) -> ();
--!! This seems missing from CPL_bind.h
--  		CPL__setWeakNormalize:  (GroebnerReductor, SInt) -> ();
		CPL__setUpdateQueue:    (GroebnerReductor, SInt) -> ();

		CPL__groebnerReductorCreate: (PolyRing) -> GroebnerReductor;
--!! This seems mis-spelled in CPL_bind.h
		PL__getBasis: 		(GroebnerReductor) -> PolyList;
		CPL__setBasis: 		(GroebnerReductor, PolyList) -> ();
		CPL__getSimplifiers:	(GroebnerReductor) -> PolyList;
		CPL__setSimplifiers:	(GroebnerReductor, PolyList) -> ();
		CPL__computeBasis:	(GroebnerReductor, PolyList) -> PolyList;
		CPL__initialize:	(GroebnerReductor, PolyList) -> ();
		CPL__mergeReductor: 	(GroebnerReductor, GroebnerReductor) -> ();
--!! This has one more parameter than in CPL_bind.h
		CPL__traceComputeBasis: (GroebnerReductor, PolyList, SInt) -> PolyList;
		CPL__GRListCreate:      () -> GRList;
		CPL__GRListPush:        (GRList, GroebnerReductor) -> GRList;
		CPL__GRListPop:         (GRList) -> GRList;
		CPL__GRListIsEmpty:     (GRList) -> Bool;
		CPL__GRListLength:      (GRList) -> SInt;

		CPL__setAlgVerbosity:   (GroebnerReductor, SInt) -> ();
		CPL__setResultVerbosity:(GroebnerReductor, SInt) -> ();
	} from Foreign C;

	CoeffRing: 			Type == Pointer;
	Coeff:   			Type == Pointer;
	PP:   				Type == Pointer;
	Poly:   			Type == Pointer;
	PolyList:   			Type == Pointer;
	PolyRing:   			Type == Pointer;
	PolyRingMap:   			Type == Pointer;
	GroebnerReductor:		Type == Pointer;
	HilbertReductor:		Type == Pointer;
	TConeReductor:  		Type == Pointer;
	GRList:   			Type == Pointer;

	Bool:				Type == SInt;
	Stream:				Type == Pointer;
	SIntArray:			Type == Pointer;

	-- Streams -----------------------------------------------------------
	OutMode(): SInt ==
		CPL__OutMode();

	InMode(): SInt ==
		CPL__InMode();

	openStream(name: String, mode: SInt): Stream ==
		CPL__openStream(name, mode);

	closeStream(s: Stream): () ==
		CPL__closeStream(s);

	cin (): Stream ==
		CPL__cin();

	cout(): Stream ==
		CPL__cout();

	cerr(): Stream ==
		CPL__cerr();

	-- PolyRing ----------------------------------------------------------
	polyRingCreate(): PolyRing ==
		CPL__polyRingCreate();

	polyRingRead(pr: PolyRing, fd: Stream): PolyRing ==
		CPL__polyRingRead(pr, fd);

	polyRingWrite(pr: PolyRing, fd: Stream): PolyRing ==
		CPL__polyRingWrite(pr, fd);

	polyRingSet(pr: PolyRing): PolyRing ==
		CPL__polyRingSet(pr);

	polyRingGet(): PolyRing ==
		CPL__polyRingGet();

	-- CoeffRing ---------------------------------------------------------
	GCoeffRingCreate(): CoeffRing ==
		CPL__GCoeffRingCreate();

	ZpCoeffRingCreate(prime: SInt): CoeffRing ==
		CPL__ZpCoeffRingCreate(prime);

	HCoeffRingCreate(prime: SInt, prec: SInt, kval: SInt): CoeffRing ==
		CPL__HCoeffRingCreate(prime, prec, kval);

	FCoeffRingCreate(): CoeffRing ==
		CPL__FCoeffRingCreate();

	SCoeffRingCreate(): CoeffRing ==
		CPL__SCoeffRingCreate();


	-- Coeff -------------------------------------------------------------
	GCoeffCreate(R: CoeffRing, n: SInt): Coeff ==
		CPL__GCoeffCreate(R, n);

	ZpCoeffCreate(R: CoeffRing, n: SInt): Coeff ==
		CPL__ZpCoeffCreate(R, n);

	FCoeffCreateInt(R: CoeffRing, n: SInt): Coeff ==
		CPL__FCoeffCreateInt(R, n);

	FCoeffCreateDouble(R: CoeffRing, f: DoubleFloat): Coeff ==
		CPL__FCoeffCreateDouble(R, f::BDFlo);

	HCoeffCreate(R: CoeffRing, n: SInt): Coeff ==
		CPL__HCoeffCreate(R, n);

	SCoeffCreate(R: CoeffRing, n: SInt): Coeff ==
		CPL__SCoeffCreate(R, n);

	coeffRead(R: CoeffRing, s: Stream, c: Coeff): Coeff ==
		CPL__coeffRead(R, s, c);

	coeffWrite(R: CoeffRing, s: Stream, c: Coeff): Coeff ==
		CPL__coeffWrite(R, s, c);

	coeffCopy(R: CoeffRing, p1: Coeff, p2: Coeff): Coeff ==
		CPL__coeffCopy(R, p1, p2);

	coeffAdd(R: CoeffRing, res: Coeff, p1: Coeff, p2: Coeff): Coeff ==
		CPL__coeffAdd(R, res, p1, p2);

	coeffMul(R: CoeffRing, res: Coeff, p1: Coeff, p2: Coeff): Coeff ==
		CPL__coeffMul(R, res, p1, p2);


	-- Poly ---------------------------------------------------------------
	polyCreate(R: PolyRing): Poly ==
		CPL__polyCreate(R);

	polyRead(R: PolyRing, s: Stream, p: Poly): Poly ==
		CPL__polyRead(R, s, p);

	polyWrite(R: PolyRing, s: Stream, p:Poly): Poly ==
		CPL__polyWrite(R, s, p);

	polyCopy(R: PolyRing, p1: Poly, p2: Poly): Poly ==
		CPL__polyCopy(R, p1, p2);

	polyAdd(R: PolyRing, res: Poly, p1: Poly, p2: Poly): () ==
		CPL__polyAdd(R, res, p1, p2);

	polyMul(R: PolyRing, res: Poly, p1: Poly, p2: Poly): () ==
		CPL__polyMul(R, res, p1, p2);


	-- PolyList -----------------------------------------------------------
	polyListCreate(R: PolyRing): PolyList ==
		CPL__polyListCreate(R);

	polyListRead(l: PolyList, s: Stream): PolyList ==
		CPL__polyListRead(l, s);

	polyListWrite(l: PolyList, s: Stream): PolyList ==
		CPL__polyListWrite(l, s);


	-- GroebnerReductor ---------------------------------------------------
	setStrategyLess(gr: GroebnerReductor, index: SInt): () ==
		CPL__setStrategyLess(gr, index);

	setSloppyStrategyLess(gr: GroebnerReductor, index: SInt): () ==
		CPL__setSloppyStrategyLess(gr, index);

	setDiscardingPair(gr: GroebnerReductor, index: SInt): () ==
		CPL__setDiscardingPair(gr, index);

	setPostSimplify(gr: GroebnerReductor, index: SInt): () ==
		CPL__setPostSimplify(gr, index);

	setInitialize(gr: GroebnerReductor, index: SInt): () ==
		CPL__setInitialize(gr, index);

	setBasisInsert(gr: GroebnerReductor, index: SInt): () ==
		CPL__setBasisInsert(gr, index);

	setSimplifiersInsert(gr: GroebnerReductor, index: SInt): () ==
		CPL__setSimplifiersInsert(gr, index);

	setEraseUseless(gr: GroebnerReductor, index: SInt): () ==
		CPL__setEraseUseless(gr, index);

	setFinalReduction(gr: GroebnerReductor, index: SInt): () ==
		CPL__setFinalReduction(gr, index);

	setNormalize(gr: GroebnerReductor, index: SInt): () ==
		CPL__setNormalize(gr, index);

	setWeakNormalize(gr: GroebnerReductor, index: SInt): () ==
		error "setWeakNormalize undefined in CPL_bind.h";

	setUpdateQueue(gr: GroebnerReductor, index: SInt): () ==
		CPL__setUpdateQueue(gr, index);


	NO__ERASE__USELESS:	 	SInt == 0;
	NORMAL__ERASE__USELESS:	 	SInt == 1;
	NORMAL__FINAL__REDUCTION:	SInt == 0;
	NO__FINAL__REDUCTION:	 	SInt == 1;
	NORMAL__INITIALIZE:	 	SInt == 0;
	TAIL__BASIS__INSERT:	 	SInt == 0;
	HYBRIDS__TAIL__BASIS__INSERT:	SInt == 1;
	TAIL__SIMPLIFIERS__INSERT:	SInt == 0;
	TC__SIMPLIFIERS__INSERT:	SInt == 1;
	NO__POST__SIMPLIFY:	 	SInt == 0;
	NEVER__BREAK:	 		SInt == 0;
	NO__DISCARDING__PAIR:		SInt == 0;
	NORMAL__STRATEGY:	 	SInt == 0;
	SUGAR__STRATEGY:	 	SInt == 1;
	TC__NORMAL__STRATEGY:	 	SInt == 2;
	TC__WEIGHT__E__CART__STRATEGY:	SInt == 3;
	PRIMITIVE__NORMALIZE:	 	SInt == 0;
	NO__NORMALIZE:	 		SInt == 1;
	NO__INTERNAL__NORMALIZE:	SInt == 0;
	CLEAN__INF:	 		SInt == 1;
	NO__UPDATE__QUEUE:	 	SInt == 0;
	NORMAL__UPDATE__QUEUE:	 	SInt == 1;

	groebnerReductorCreate(R: PolyRing): GroebnerReductor ==
		CPL__groebnerReductorCreate(R);

	getBasis(gr: GroebnerReductor): PolyList ==
		--!! Work around for CPL_bind.h
		PL__getBasis(gr);

	setBasis(gr: GroebnerReductor, pl: PolyList): () ==
		CPL__setBasis(gr, pl);

	getSimplifiers(gr: GroebnerReductor): PolyList ==
		CPL__getSimplifiers(gr);

	setSimplifiers(gr: GroebnerReductor, pl: PolyList): () ==
		CPL__setSimplifiers(gr, pl);

	computeBasis(gr: GroebnerReductor, pl: PolyList): PolyList ==
		CPL__computeBasis(gr, pl);

	initialize(gr: GroebnerReductor, initialGenerators: PolyList): () ==
		CPL__initialize(gr, initialGenerators);

	mergeReductor(gr1: GroebnerReductor, gr2: GroebnerReductor): () ==
		CPL__mergeReductor(gr1, gr2);

	traceComputeBasis(gr: GroebnerReductor, pl: PolyList, prime: SInt): PolyList ==
	--!! Something wrong with this in CPL_bind.h
		--!! CPL__traceComputeBasis(gr, pl, prime);
		error "CPL_bind.h error";

	-- GroebnerReductorList Operations ------------------------------------
	GRListCreate(): GRList ==
		CPL__GRListCreate();

	GRListPush(grl: GRList, gr: GroebnerReductor): GRList ==
		CPL__GRListPush(grl, gr);

	GRListPop(grl: GRList): GRList ==
		CPL__GRListPop(grl);

	GRListIsEmpty(grl: GRList): Bool ==
		CPL__GRListIsEmpty(grl);

	GRListLength(grl: GRList): SInt ==
		CPL__GRListLength(grl);


	-- Control operations -------------------------------------------------
	setAlgVerbosity(gr: GroebnerReductor, level: SInt): () ==
		CPL__setAlgVerbosity(gr, level);

	setResultVerbosity(gr: GroebnerReductor, level: SInt): () ==
		CPL__setResultVerbosity(gr, level);
}
