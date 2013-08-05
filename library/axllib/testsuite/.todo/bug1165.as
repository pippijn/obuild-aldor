--* From hemmecke@risc.uni-linz.ac.at  Mon Aug  9 09:31:19 1999
--* Received: from risc.uni-linz.ac.at ([193.170.33.112])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with SMTP id JAA16137
--* 	for <ax-bugs@nag.co.uk>; Mon, 9 Aug 1999 09:31:17 +0100 (BST)
--* Received: by risc.uni-linz.ac.at id AA22793
--*   (5.67b8/IDA-1.5 for ax-bugs@nag.co.uk); Mon, 9 Aug 1999 10:27:38 +0200
--* Date: Mon, 9 Aug 1999 10:27:38 +0200
--* From: Ralf HEMMECKE <Ralf.Hemmecke@risc.uni-linz.ac.at>
--* Message-Id: <199908090827.AA22793@risc.uni-linz.ac.at>
--* To: ax-bugs@nag.co.uk
--* Subject: [2] To much optimization

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun -Q2 bug.as
-- Version: Aldor version 1.1.12p2 for LINUX(glibc)
-- Original bug file name: bug.as

-----------------------------------------------------------------------
-- 06-AUG-99
-----------------------------------------------------------------------
-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 06-AUG-99
-- Aldor version 1.1.12p2 for LINUX(glibc) 
-- Subject: To much optimization

-- The result is OK with optimization option -Q1 but wrong for -Q2.
-- Calling sequence:
-- Correct output:
--   axiomxl -grun bug.as
--   axiomxl -grun -Q1 bug.as
-- Incorrect output:
--   axiomxl -grun -Q2 bug.as

#include "axllib"

macro {
	I == SingleInteger;
	M == List I;
	Monomials == List M;
}

MonomialPackage: with {
	rhxminimal?:(M,Monomials)->Boolean;
	minimalGenerators: Monomials -> Monomials;
	MinimalGenerators: Monomials -> Monomials;
	hasLeftFactor?: (M,M)->Boolean;
} == add {
	hasLeftFactor?(x:M,y:M):Boolean == {
		if #x ~= 2 or #y ~= 2 then return false;
		return (x.1<=y.1 and x.2<=y.2);
	}

	rhxminimal?(m:M,U:Monomials):Boolean == {
		error << newline <<"m="<<m<<", U="<<U<<newline;
		U := [u for u in U | u ~= m];
		error << "del "<<U<<newline;
--		for u in U repeat if hasLeftFactor?(u,m) then return false;
		for u in U repeat {
			t := hasLeftFactor?(u,m);
			error<<"hasLeftFactor?("<<u<<", "<<m<<")="<<t<<newline;
			if t then {
				error << "We return FALSE"<<newline;
				return false;
			} 
		}
		error << "We return TRUE" << newline;
		return true;
	}
	minimalGenerators(U:Monomials):Monomials == {
		[u for u in U |
			(t := rhxminimal?(u,U);
			error << "rhxminimal?("<<u<<","<<U<<")="<<t<<newline;
			t)];
--		[u for u in U | minimal?(u,U)];
	}

	MinimalGenerators(U:Monomials):Monomials == {
		V:Monomials := [];
		for u in U repeat {
			t := rhxminimal?(u,U);
			error << "minimal?("<<u<<","<<U<<")="<<t<<newline;
			if t then V := cons(u,V);
		}
		V
	}
}

main():() == {
	import from M,Monomials,MonomialPackage;

	U:Monomials := [[4,1],[4,0]];
	V := minimalGenerators U;
	print << "======="<<newline<<V<<newline<<"======="<<newline;

	V := MinimalGenerators U;
	print << "======="<<newline<<V<<newline<<"======="<<newline;

	t := rhxminimal?([4,1],U);
	print << "Do we get FALSE? "<< t<<newline
}

main();


#endif
