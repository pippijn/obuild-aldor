--* From mnd@knockdhu.dcs.st-and.ac.uk  Mon May 22 15:35:02 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id PAA07103
--* 	for <ax-bugs@nag.co.uk>; Mon, 22 May 2000 15:34:54 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA20143
--* 	for ax-bugs@nag.co.uk; Mon, 22 May 2000 15:40:54 +0100
--* Date: Mon, 22 May 2000 15:40:54 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200005221440.PAA20143@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [5] Export lookup failure at runtime

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p5
-- Original bug file name: enbug2.as


--------------------------------- en02.as ---------------------------------
#include "axllib"

#library LL "en2lib.ao"
import from LL;

main():() ==
{
   import from SingleInteger;

   local var:FooDom;

   var := new red;
   print << "var = " << ((var.value) pretend SingleInteger) << newline;

   var.value := green;
   print << "var = " << ((var.value) pretend SingleInteger) << newline;

   var.value := blue;
   print << "var = " << ((var.value) pretend SingleInteger) << newline;
}


main();
--------------------------------- en02.as ---------------------------------



-------------------------------- en2lib.as --------------------------------
#include "axllib"

Colour == 'red, green, blue';


FooDom:with
{
   new: Colour -> %;
   apply: (%, 'value') -> Colour;
   set!: (%, 'value', Colour) -> Colour;
   export from 'value', Colour;
}
== add
{
   Rep == Record(val:Colour);
   import from Rep, 'value';

   new(x:Colour):% == per [x];
   apply(x:%, ignored:'value'):Colour == (rep x).val;
   set!(x:%, ignored:'value', v:Colour):Colour == { (rep x).val := v }
}
-------------------------------- en2lib.as --------------------------------

