--* From youssef@mailer.scri.fsu.edu  Fri Oct 16 15:33:33 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA29029; Fri, 16 Oct 98 15:33:33 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id PAA01276 for <ax-bugs@nag.co.uk>; Fri, 16 Oct 1998 15:36:36 +0100 (BST)
--* Received: from dirac.scri.fsu.edu (dirac.scri.fsu.edu [144.174.128.44]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id KAA05126 for <ax-bugs@nag.co.uk>; Fri, 16 Oct 1998 10:33:17 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac.scri.fsu.edu (5.67b) id AA45010; Fri, 16 Oct 1998 10:33:17 -0400
--* Date: Fri, 16 Oct 1998 10:33:17 -0400
--* Message-Id: <199810161433.AA45010@dirac.scri.fsu.edu>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] Visibility of Domains

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.11e
-- Original bug file name: t.as

--+ --
--+ --  Hi Themos,
--+ --
--+ --  This is an example of a type of problem that I've run into.
--+ --  The code below fails in the Foo Category with 
--+ --
--+ --     "No meaning for identifier `Scalar'"
--+ --  
--+ --  Am I missing something?  Otherwise, domains defined in category
--+ --  definitions aren't useable in other category definitions.
--+ --
--+ --    Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define Module:Category == AbelianGroup with 
--+     Scalar: Ring
--+     *: (Scalar,%) -> %
--+     
--+ define Foo:Category == Module with
--+     *: (%,%) -> Scalar
--
--  Hi Themos,
--
--  This is an example of a type of problem that I've run into.
--  The code below fails in the Foo Category with 
--
--     "No meaning for identifier `Scalar'"
--  
--  Am I missing something?  Otherwise, domains defined in category
--  definitions aren't useable in other category definitions.
--
--    Saul
--
#include "axllib"
#pile

define Module:Category == AbelianGroup with 
    Scalar: Ring
    *: (Scalar,%) -> %
    
define Foo:Category == Module with
    *: (%,%) -> Scalar
