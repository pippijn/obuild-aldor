--* From chicha@csd.uwo.ca  Fri Nov 27 18:36:20 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA08234; Fri, 27 Nov 98 18:36:20 GMT
--* Received: from chaplin.csd.uwo.ca (chaplin.csd.uwo.ca [129.100.10.252])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id SAA02939 for <ax-bugs@nag.co.uk>; Fri, 27 Nov 1998 18:40:52 GMT
--* From: chicha@csd.uwo.ca
--* Message-Id: <199811271836.NAA15669@tarski.ai.csd.uwo.ca>
--* Date: Fri, 27 Nov 1998 13:36:59 -0500 (EST)
--* To: ax-bugs@nag.co.uk
--* Subject: [9] In interactive mode, an Aldor source line containing only the symbol "?" yields a compiler bug (also tested using axiomxl direct).

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Fx bug.as
-- Version: 1.1.12 (pre-release)
-- Original bug file name: /csd/project/aldor/marc/bug.as

#include "axllib.as"

?
