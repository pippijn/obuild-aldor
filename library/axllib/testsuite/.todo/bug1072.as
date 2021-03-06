--* Received: from nirvana.inria.fr by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA16762; Fri, 26 Apr 96 19:50:33 BST
--* Received: by nirvana.inria.fr (8.6.13/8.6.12) id UAA06143 for ax-bugs@nag.co.uk; Fri, 26 Apr 1996 20:45:20 +0200
--* Date: Fri, 26 Apr 1996 20:45:20 +0200
--* From: Stephen Watt <Stephen.Watt@sophia.inria.fr>
--* Message-Id: <199604261845.UAA06143@nirvana.inria.fr>
--* To: ax-bugs
--* Subject: [1] Looking in GenPoly(??)(Integer) for monom with code 134434896

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Fx fantiono.as
-- Version: 1.1.5
-- Original bug file name: fantino.as

#include "axllib"

macro Term  == Record(c: Coef, g: Gen);
macro Monome== Record(coef:R,  power:Integer);

define ExplicitlyGeneratedRing: Category == Ring with { 
	isLeaf?:	Boolean;
	
	-- If isLeaf? then the following are useful:
	Gen:		BasicType;
	Coef:		ExplicitlyGeneratedRing;

	decompose:	% -> List Term;
	recompose:	List Term -> %
}


extend Integer: ExplicitlyGeneratedRing == add {
	import from Term;
	import from List Term;

	isLeaf?: Boolean  == true;
	define Gen:  BasicType   == Boolean;
	define Coef: ExplicitlyGeneratedRing   == %;

	toCoef(n: %): Coef == n pretend Coef;
	frCoef(c: Coef): % == c pretend %;

	toGen(b: Boolean): Gen == b pretend Gen;
	frGen(g: Gen): Boolean == g pretend Boolean;

	decompose(n: %): List Term == [[toCoef n, toGen true]];
	recompose(l: List Term): % == frCoef first(l).c;
}

GenPoly(v: String)(R: ExplicitlyGeneratedRing): ExplicitlyGeneratedRing with {
	monom: (R, Integer) -> %
}
== add {
	
        import from Boolean;
	import from Term;
	import from List Term;
	import from List Monome;
	import from Monome;

	-- representation des polynomes
	-- contraintes :
	-- trier par puissance
	-- pas de puissances redondantes
	Rep ==> List Monome;
	import from Rep;

	monom(r: R, n: Integer): % == per [[r, 0]];

	-- constructeurs
	0:% == per [[0,0]];
	1:% == per [[1,0]];
	coerce(n:Integer):% == per [[coerce(n)$R,0]];
	coerce(n:SingleInteger):% == per [[coerce(n)$R,0]];
	-- x:% == per [[1,1]];
	(x:R)^(n:Integer):% == per [[x,n]];

	(x:%)+(y:%):% == x;
	-(x:%):% == x;
	(x:%)*(y:%):% == x;
	(x:%)^(n:Integer):% == x;
	(x:%)=(y:%):Boolean == false;
	(f:TextWriter)<<(x:%):TextWriter == {
		for z in rep x repeat 
			print << " + " << z.coef << "*" << v <<"^" << z.power;
	    	f
	}
	  
	-- explicitly generated ring

	isLeaf?: Boolean         == false;
	define Gen:  BasicType   == Integer;
	define Coef: ExplicitlyGeneratedRing   == R;

	decompose(x: %): List Term == 
	 [[y.coef pretend Coef, y.power pretend Gen] for y in (rep x)];
	recompose(l: List Term): % == 
	 per [[x.c pretend R,x.g pretend Integer] for x in l];
}


CheckRing(n: Integer, R: ExplicitlyGeneratedRing, r: R): () == {
	print << "Entering CheckRing at level " << n << newline;

	print << " Is it a leaf? " << isLeaf?$R << newline;

	if not (isLeaf?$R) then CheckRing(n+1, Coef$R, 0$Coef$R); --first(decompose r).c);
}

test1(): () == {
	n: Integer == 7;
	import from List Record(c: Coef$Integer, g: Gen$Integer);

	print << "Are the integers a leaf? " << isLeaf?$Integer << newline;
	print << "Decomposing the integer n gives " << first(decompose(n)).c << newline;


	macro GI == GenPoly."x" Integer;
	p: GI := monom(7,2);

	print << "Are the polys a leaf? " << isLeaf?$GI << newline;
	print << "THe poly p is " << p << newline;
	print << "Decomposing the poly p gives " << first(decompose(p)).c << newline;


	macro GGI == GenPoly."y" GenPoly."x" Integer;
	pp: GGI := monom(monom(3,4), 8);

	print << "Are the 2polys a leaf? " << isLeaf?$GGI << newline;
	print << "THe 2poly pp is " << pp << newline;
	print << "Decomposing the 2poly pp gives " << first(decompose(pp)).c << newline;

	CheckRing(1, GGI, pp)
}

test1()
