--* Received: from rati.inria.fr by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA14762; Thu, 29 Aug 96 11:07:32 BST
--* Received: by rati.inria.fr (8.7.5/8.6.12) id MAA06318 for ax-bugs@nag.co.uk; Thu, 29 Aug 1996 12:01:04 +0200
--* Date: Thu, 29 Aug 1996 12:01:04 +0200
--* From: Yannis Chicha <Yannis.Chicha@sophia.inria.fr>
--* Message-Id: <199608291001.MAA06318@rati.inria.fr>
--* To: ax-bugs
--* Subject: [3] problems for recognizing parameter type

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Fao -Fo parametres.as
-- Version: 1.1.5
-- Original bug file name: /u/psyche/0/safir/ychicha/TRAVAIL/ASHARP/TESTS/parametres.as



Here is the program :

----------------------------------------------------------------------

#include "axllib"

define Cat: Category == with {
	new:	() -> %;
	foo: Integer -> ();
}

Dom(a: String): Cat  == add {
	Rep ==> Record(i: Integer);
	import from Rep;

	new(): % == per [3];
	foo(int: Integer): () == print << int << " " << a << newline;

}

f(s: String): (D: Cat, d: D) == {
	D == Dom(s);
	d == new();
	(D,d)
}

g(): () == {

	(D,d) := f("FOO");

	func(D,d)
		where func(D1: Cat, d1: D1): () == {
			import from Integer;
			foo(3);
		}
}

----------------------------------------------------------------------

Here is the compilation :

axiomxl -Fao -Fo parametres.as               

==>

"parametres.as", line 28:         func(D,d)
                          ...............^
[L28 C16] #1 (Error) Argument 2 of `func' did not match any possible parameter type.
    The rejected type is d: D.
    Expected type D1.
