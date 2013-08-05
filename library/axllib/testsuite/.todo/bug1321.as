--* From mnd@dcs.st-and.ac.uk  Wed Jul 25 12:07:05 2001
--* Received: from mail.london-1.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id MAA06828
--* 	for <ax-bugs@nag.co.uk>; Wed, 25 Jul 2001 12:06:58 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 2512 invoked from network); 25 Jul 2001 11:01:58 -0000
--* Received: from host213-122-144-232.btinternet.com (HELO dcs.st-and.ac.uk) (213.122.144.232)
--*   by server-3.tower-4.starlabs.net with SMTP; 25 Jul 2001 11:01:58 -0000
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.11.0/8.11.0) id f6PB7Pg02819
--* 	for ax-bugs@nag.co.uk; Wed, 25 Jul 2001 12:07:25 +0100
--* Date: Wed, 25 Jul 2001 12:07:25 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200107251107.f6PB7Pg02819@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [7] missing domain-valued exports

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -grun -laxllib bug1321.as
-- Version: 1.1.13(30)
-- Original bug file name: foomnd.as


#include "axllib"
#pile

define Set:Category == with
    =:(%,%) -> Boolean

define FooCategory:Category == with
    foo: SingleInteger -> SingleInteger
    FooDom: Set
    

Foo1:FooCategory == add
    foo(x:SingleInteger):SingleInteger == 2 * x
    FooDom:Set == 
       X:Set == SingleInteger add
       X add
       

    

