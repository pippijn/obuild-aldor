--* From Bernard.Mourrain@sophia.inria.fr  Wed Nov 19 11:11:05 1997
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA17281; Wed, 19 Nov 97 11:11:05 GMT
--* Received: from korrigan.inria.fr (korrigan.inria.fr [138.96.48.27])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id LAA01203 for <ax-bugs@nag.co.uk>; Wed, 19 Nov 1997 11:14:29 GMT
--* Received: by korrigan.inria.fr (8.8.6/8.8.5) id MAA11174 for ax-bugs@nag.co.uk; Wed, 19 Nov 1997 12:12:37 +0100 (MET)
--* Date: Wed, 19 Nov 1997 12:12:37 +0100 (MET)
--* From: Bernard Mourrain <Bernard.Mourrain@sophia.inria.fr>
--* Message-Id: <199711191112.MAA11174@korrigan.inria.fr>
--* To: ax-bugs@nag.co.uk
--* Subject: [1] A problem of linkage with basicmath

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -Q3 -lbasicmath -fx es.as
-- Version: AXIOM-XL version 1.1.10b for SPARC [Solaris: GCC]
-- Original bug file name: es.as

--+ korrigan:mourrain/ALDO:  axiomxl -Q3 -lbasicmath -fx es.as
--+ Undefined                       first referenced
--+  symbol                             in file
--+ fiSFloMantissa                      /u/korrigan/0/safir/mourrain/ALDO/BasicMath/lib/libbasicmath.a(sfloat.o)
--+ fiSFloExponent                      /u/korrigan/0/safir/mourrain/ALDO/BasicMath/lib/libbasicmath.a(sfloat.o)
--+ ld: fatal: Symbol referencing errors. No output written to es
--+ #1 (Fatal Error) Linker failed.  Command was: unicl es.o axlmain.o -L/u/korrigan/0/safir/mourrain/ALDO/BasicMath/lib -L. -L/net/safir/lib/axiomxl/sun4OS5/share/lib -L/net/safir/lib/axiomxl/sun4OS5/lib -o  es -O -lbasicmath -laxllib -lfoam
--+ #1 (Warning) Removing file `es.o'.
--+ #2 (Warning) Removing file `axlmain.o'.
#include "basicmath"

import from SingleFloat;

print << 1 + 1 << newline;

