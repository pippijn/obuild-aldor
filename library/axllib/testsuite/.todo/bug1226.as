--* From Manuel.Bronstein@sophia.inria.fr  Mon Jun  5 12:30:20 2000
--* Received: from droopix.inria.fr (IDENT:root@droopix.inria.fr [138.96.111.4])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id MAA02035
--* 	for <ax-bugs@nag.co.uk>; Mon, 5 Jun 2000 12:30:15 +0100 (BST)
--* Received: by droopix.inria.fr (8.10.0/8.10.0) id e55BU9e20156 for ax-bugs@nag.co.uk; Mon, 5 Jun 2000 13:30:09 +0200
--* Date: Mon, 5 Jun 2000 13:30:09 +0200
--* From: Manuel Bronstein <Manuel.Bronstein@sophia.inria.fr>
--* Message-Id: <200006051130.e55BU9e20156@droopix.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [4] SFlo$Machine <> float on linux

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -fx -laxllib sflo.as sfloc.o
-- Version: 1.1.12p4
-- Original bug file name: sflo.as

------------------------------ sflo.as ------------------------------
--
-- Seems like the SFlo$Machine <--> float equivalence is broken
-- This problem happens only on linux, works ok under OSF1
--
-- % unicl -c sfloc.c
-- % axiomxl -fx -laxllib sflo.as sfloc.o
-- % ./sflo
-- sf = 3.1400001
-- sflo = 36893488147419103232.000000
--

#include "axllib"

import {
    SFloPrint:   SFlo$Machine -> ();
} from Foreign C;

Main():() == {
    import from Machine, SingleFloat;
    
    sf:SingleFloat := 3.14;
    print << "sf = " << sf << newline;
    SFloPrint(sf::SFlo);
}

Main();


-- SAVE THE FOLLOWING AS sfloc.c AND COMPILE IT SEPARATELY
------------------------------ sfloc.c ------------------------------
#include <stdlib.h>

void SFloPrint(float sflo) 
{
    printf("sflo = %f\n", sflo);
}
