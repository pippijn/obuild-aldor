--* From mnd@knockdhu.dcs.st-and.ac.uk  Wed May 17 14:34:07 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id OAA04375
--* 	for <ax-bugs@nag.co.uk>; Wed, 17 May 2000 14:34:06 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id OAA30011
--* 	for ax-bugs@nag.co.uk; Wed, 17 May 2000 14:39:44 +0100
--* Date: Wed, 17 May 2000 14:39:44 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200005171339.OAA30011@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][other=archive.c] Archive handling is stuffed

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: chmod 755 bug1213.sh && ./bug1213.sh
-- Version: 1.1.12p5
-- Original bug file name: bug1213.sh

#!/bin/sh

CURDIR=`pwd`
TMPDIR=/tmp/footest-tmp-$$

mkdir $TMPDIR
cd $TMPDIR
cat << EOF > file_with_a_long_name.as
#include "axllib"

foo(x:String):String == x;
EOF
cat << EOF > footest.as
#include "axllib"
#library FooLib "foo"
import from FooLib;

import from String;
print << (foo "No problems!") << newline;
EOF
axiomxl -Fao file_with_a_long_name.as
ar rcv libfoo.al file_with_a_long_name.ao
axiomxl -ginterp -lfoo footest.as
cd $CURDIR
/bin/rm -rf $TMPDIR
exit 0
