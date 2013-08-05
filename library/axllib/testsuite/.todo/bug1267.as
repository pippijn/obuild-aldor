--* From mnd@dcs.st-and.ac.uk  Tue Oct 17 11:02:33 2000
--* Received: from server-19.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with SMTP id LAA12224
--* 	for <ax-bugs@nag.co.uk>; Tue, 17 Oct 2000 11:02:32 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 21061 invoked from network); 17 Oct 2000 09:53:23 -0000
--* Received: from pittyvaich.dcs.st-and.ac.uk (138.251.206.55)
--*   by server-19.tower-4.starlabs.net with SMTP; 17 Oct 2000 09:53:23 -0000
--* Received: from dcs.st-and.ac.uk (knockdhu [138.251.206.239])
--* 	by pittyvaich.dcs.st-and.ac.uk (8.9.1b+Sun/8.9.1) with ESMTP id LAA15970
--* 	for <ax-bugs@nag.co.uk>; Tue, 17 Oct 2000 11:02:03 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id LAA29773
--* 	for ax-bugs@nag.co.uk; Tue, 17 Oct 2000 11:05:36 +0100
--* Date: Tue, 17 Oct 2000 11:05:36 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200010171005.LAA29773@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [3][optimiz] Function overloading domain does not get initialised

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: ./fundom.sh (try changing the OPTLEVEL flag to Q0)
-- Version: 1.1.13(0)
-- Original bug file name: fundom.sh

#!/bin/sh

TMPDIR=/tmp/fundom-bug.$$

OPTLEVEL=-Q2

perror() {
   echo $* 1>&2
   exit 0
}


# Create a private workspace.
mkdir ${TMPDIR} || exit 0 # mkdir will emit the reason for the error.
cd ${TMPDIR}


# Create the base library.
cat <<EOF > fundom0.as
#include "axllib"

define FooCat(T:BasicType):Category == with
{
   foo: T -> %;
   oof: % -> T;

   export from T;
}


FooDom(T:OrderedFinite):FooCat(T) == FooDom(T, #$T);

FooDom(T:BasicType, siz:Integer):FooCat(T) == add
{
   Rep == T;
   import from T;

   foo(x:T):% == per x;
   oof(x:%):T == rep x;
}
EOF


# Create the test program.
cat <<EOF > fundom1.as
#include "axllib"

#library LL "fundom0.ao"
import from LL;
inline from LL;

main():() ==
{
   import from FooDom(DoubleFloat);

   print << "[Before ...]" << newline;
   print << "[" << (oof foo 3.2) << "]" << newline;
   print << "[After ...]" << newline;
}

main();
EOF


# Compile the library.
echo "Compiling library file ..."
axiomxl ${OPTLEVEL} -Fao fundom0.as
echo "      ... done."
echo ""


# Compile the test.
echo "Compiling the test ..."
axiomxl -Fx ${OPTLEVEL} -laxllib fundom1.as fundom0.ao
echo "      ... done."
echo ""


# Run the test.
echo "Running the test ..."
./fundom1
echo "      ... done. (exit status = $?)"
echo ""


# Clean up
cd /tmp
/bin/rm -rf ${TMPDIR}
exit 0


