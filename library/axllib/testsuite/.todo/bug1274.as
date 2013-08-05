--* From youssef@d0mino.fnal.gov  Fri Nov  3 18:21:40 2000
--* Received: from server-8.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id SAA22114
--* 	for <ax-bugs@nag.co.uk>; Fri, 3 Nov 2000 18:21:33 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 14623 invoked from network); 3 Nov 2000 18:21:01 -0000
--* Received: from d0mino.fnal.gov (131.225.224.45)
--*   by server-8.tower-4.starlabs.net with SMTP; 3 Nov 2000 18:21:01 -0000
--* Received: (from youssef@localhost)
--* 	by d0mino.fnal.gov (SGI-8.9.3/8.9.3) id MAA32930;
--* 	Fri, 3 Nov 2000 12:21:00 -0600 (CST)
--* Date: Fri, 3 Nov 2000 12:21:00 -0600 (CST)
--* From: Saul Youssef <youssef@d0mino.fnal.gov>
--* Message-Id: <200011031821.MAA32930@d0mino.fnal.gov>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.12p6
-- Original bug file name: bugx.as

--+ --
--+ --  Hi Martin,
--+ -- 
--+ --     Shouldn't this work?  The compiler claims that "bar" is missing.
--+ --
--+ --   Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define Cat1:Category == with
--+    foo: () -> SingleInteger
--+    
--+ define Cat2:Category == with
--+    bar: () -> SingleInteger
--+    
--+ Dom1:Cat1 == add
--+    foo():SingleInteger == 1
--+    
--+ Dom2:Cat2 == add
--+    bar():SingleInteger == 2
--+    
--+ Dom12:Cat1 with Cat2 == Dom1 add Dom2 
--
--  Hi Martin,
-- 
--     Shouldn't this work?  The compiler claims that "bar" is missing.
--
--   Saul
--
#include "axllib"
#pile

define Cat1:Category == with
   foo: () -> SingleInteger
   
define Cat2:Category == with
   bar: () -> SingleInteger
   
Dom1:Cat1 == add
   foo():SingleInteger == 1
   
Dom2:Cat2 == add
   bar():SingleInteger == 2
   
Dom12:Cat1 with Cat2 == Dom1 add Dom2 

