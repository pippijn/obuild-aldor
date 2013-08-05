--* From mnd@dcs.st-and.ac.uk  Fri Jun  8 17:14:50 2001
--* Received: from server-22.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id RAA21321
--* 	for <ax-bugs@nag.co.uk>; Fri, 8 Jun 2001 17:14:49 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 29866 invoked from network); 8 Jun 2001 15:59:34 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-22.tower-4.starlabs.net with SMTP; 8 Jun 2001 15:59:34 -0000
--* Received: from kininvie.dcs.st-and.ac.uk (kininvie [138.251.206.236])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id RAA15294
--* 	for <ax-bugs@nag.co.uk>; Fri, 8 Jun 2001 17:14:20 +0100 (BST)
--* Received: (from mnd@localhost) by kininvie.dcs.st-and.ac.uk (8.9.3/8.6.12) id RAA15051 for ax-bugs@nag.co.uk; Fri, 8 Jun 2001 17:14:19 +0100
--* Date: Fri, 8 Jun 2001 17:14:19 +0100
--* From: "Martin N. Dunstan" <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200106081614.RAA15051@kininvie.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [1] Invalid function prototypes in generated C

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See header comment
-- Version: .
-- Original bug file name: multi.as

-- Save the C code at the end of this file in multiret.c and then:
--
-- % gcc -I$AXIOMXLROOT/include -c multiret.c
-- % axiomxl -grun -laxllib multi.as multiret.o
--
-- Note that the C compilation aborts due to bad C. Also note that adding
-- the -Cold option doens't help: we still generate ANSI prototypes!
#include "axllib"

SI==>SingleInteger;
import from SI;

import { 
	multiret : (SI, SI) -> (SI, SI);
} from Foreign C;

(x : SI, y : SI) := multiret(0,0);

print << "Ret 1: " << x <<  "  Ret 2: " << y << newline;

-- CUT everything below and store in multiret.c
#include <foam_c.h>

void multiret(FiWord arg1, FiWord arg2, FiWord *ret1, FiWord *ret2)
{
  *ret1 =1;
  *ret2 =2;
}

