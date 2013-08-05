--* From Manuel.Bronstein@sophia.inria.fr  Fri Aug  3 15:51:50 2001
--* Received: from mail17.messagelabs.com (mail17.messagelabs.com [62.231.131.67])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id PAA25247
--* 	for <ax-bugs@nag.co.uk>; Fri, 3 Aug 2001 15:51:47 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 10755 invoked from network); 3 Aug 2001 14:48:33 -0000
--* Received: from panoramix.inria.fr (138.96.111.9)
--*   by server-8.tower-17.messagelabs.com with SMTP; 3 Aug 2001 14:48:33 -0000
--* Received: by panoramix.inria.fr (8.11.1/8.10.0) id f73EpB032674 for ax-bugs@nag.co.uk; Fri, 3 Aug 2001 16:51:11 +0200
--* Date: Fri, 3 Aug 2001 16:51:11 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <200108031451.f73EpB032674@panoramix.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [7] [(a,b)] does not get inferred to List Cross(..)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.13
-- Original bug file name: listcross.as

-------------------------- listcross.as ----------------------------

#include "axllib"

-- This compiles ok
Foo(A:Type, B:Type):with { foo: (A,B) -> List Cross(A,B) } == add {
	foo(a:A, b:B):List Cross(A, B) == cons((a, b), []);
}

-- This does not compile
Bar(A:Type, B:Type):with { bar: (A,B) -> List Cross(A,B) } == add {
	bar(a:A, b:B):List Cross(A, B) == [(a, b)];
}


