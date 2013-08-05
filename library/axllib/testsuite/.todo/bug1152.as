--* From youssef@mailer.scri.fsu.edu  Sun Oct 11 23:57:53 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA06081; Sun, 11 Oct 98 23:57:53 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id AAA18609 for <ax-bugs@nag.co.uk>; Mon, 12 Oct 1998 00:04:23 +0100 (BST)
--* Received: from dirac.scri.fsu.edu (dirac.scri.fsu.edu [144.174.128.44]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id TAA07163 for <ax-bugs@nag.co.uk>; Sun, 11 Oct 1998 19:01:03 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac.scri.fsu.edu (5.67b) id AA27108; Sun, 11 Oct 1998 19:01:03 -0400
--* Date: Sun, 11 Oct 1998 19:01:03 -0400
--* Message-Id: <199810112301.AA27108@dirac.scri.fsu.edu>
--* To: ax-bugs@nag.co.uk
--* Subject: [8] can't Generate multiple values

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp file.as
-- Version: 1.1.11e
-- Original bug file name: test3.as

--+ --
--+ --  Hi. 
--+ --      I would think that it's reasonable to make a generator which
--+ --  generates multiple values.  However, this does not seem to work.
--+ --     Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ local g:Generator (Integer,Integer)
--+ 
--
--  Hi. 
--      I would think that it's reasonable to make a generator which
--  generates multiple values.  However, this does not seem to work.
--     Saul
--
#include "axllib"
#pile

local g:Generator (Integer,Integer)

