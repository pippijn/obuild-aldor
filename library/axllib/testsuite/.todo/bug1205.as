--* From axiom@nag.co.uk  Thu Apr  6 17:22:21 2000
--* Received: from nag.co.uk (IDENT:root@amorgos.nag.co.uk [192.156.217.56])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA25194
--* 	for <ax-bugs@nagmx1.nag.co.uk>; Thu, 6 Apr 2000 17:22:20 +0100 (BST)
--* Received: (from axiom@localhost)
--* 	by nag.co.uk (8.9.3/8.9.3) id SAA11278
--* 	for ax-bugs@nag.co.uk; Thu, 6 Apr 2000 18:25:48 +0100
--* Date: Thu, 6 Apr 2000 18:25:48 +0100
--* From: Axiom Implementation Account <axiom@nag.co.uk>
--* Message-Id: <200004061725.SAA11278@nag.co.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][runtime] local state and caching effect

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun pardom.as
-- Version: 1.1.12p5
-- Original bug file name: pardom.as

#include "basicmath"

Foo(p:SingleInteger) : with {
	state: () -> SingleInteger;
	setState!: (SingleInteger) -> ();
} == add {
	s:SingleInteger;
	s:=0;

	state():SingleInteger == { free s; s}
	setState!(x:SingleInteger):() == { free s; s:=x }
}
main1():() == {
	import from SingleInteger;
	setState!(1)$Foo(1);
	setState!(2)$Foo(2);
	setState!(3)$Foo(3);
	setState!(4)$Foo(4);
	setState!(5)$Foo(5);
	setState!(6)$Foo(6);
	setState!(7)$Foo(7);
	setState!(8)$Foo(8);
	setState!(9)$Foo(9);
	setState!(10)$Foo(10);
	setState!(11)$Foo(11);
	setState!(12)$Foo(12);
	setState!(13)$Foo(13);
	setState!(14)$Foo(14);
	setState!(15)$Foo(15);
	setState!(16)$Foo(16);
	setState!(17)$Foo(17);
}
main2():() == {
	import from SingleInteger;
	print << state()$Foo(1) << newline;
	print << state()$Foo(2) << newline;
	print << state()$Foo(3) << newline;
	print << state()$Foo(4) << newline;
	print << state()$Foo(5) << newline;
	print << state()$Foo(6) << newline;
}
main1();
main2();
main1();

