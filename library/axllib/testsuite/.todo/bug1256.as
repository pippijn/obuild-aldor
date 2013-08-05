--* From youssef@d0mino.fnal.gov  Wed Sep 20 07:39:24 2000
--* Received: from d0mino.fnal.gov (d0mino.fnal.gov [131.225.224.45])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id HAA05332
--* 	for <ax-bugs@nag.co.uk>; Wed, 20 Sep 2000 07:39:22 +0100 (BST)
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id BAA27595;
--* 	Wed, 20 Sep 2000 01:39:26 -0500 (CDT)
--* Date: Wed, 20 Sep 2000 01:39:26 -0500 (CDT)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200009200639.BAA27595@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: extendbug.as

--+ --
--+ --  Hi Martin.  Here's a bug related to extensions.  I split it in two files because
--+ --  you said that one must not extend a domain in the same file where it's defined.
--+ --  Execute the second file to see a core dump.   Saul
--+ --
--+ 
--+ --  Put the following down to the Snip in bug1.as".  Compile with axiomxl -Fao
--+ 
--+ #include "axllib"
--+ #pile
--+ 
--+ define Rng:Category == with 
--+     +: (%,%) -> %
--+ 
--+ Foo:with 
--+     F: Rng -> with
--+ == add
--+     F(A:Rng):with == A
--+     
--+ -- Snip here and put the rest in "bug2.as" --  Do axiomxl -g interp to get core dump  
--+ 
--+ #include "axllib"
--+ #library BUG1 "bug1.ao"
--+ #pile
--+ 
--+ import from BUG1
--+ 
--+ import from Foo
--+ 
--+ extend F(A:Rng): with Rng == add
--+ 
--+     
--+     
--+     
--+     
--+     
--
--  Hi Martin.  Here's a bug related to extensions.  I split it in two files because
--  you said that one must not extend a domain in the same file where it's defined.
--  Execute the second file to see a core dump.   Saul
--

--  Put the following down to the Snip in bug1.as".  Compile with axiomxl -Fao

#include "axllib"
#pile

define Rng:Category == with 
    +: (%,%) -> %

Foo:with 
    F: Rng -> with
== add
    F(A:Rng):with == A
    
-- Snip here and put the rest in "bug2.as" --  Do axiomxl -g interp to get core dump  

#include "axllib"
#library BUG1 "bug1.ao"
#pile

import from BUG1

import from Foo

extend F(A:Rng): with Rng == add

    
    
    
    
    
