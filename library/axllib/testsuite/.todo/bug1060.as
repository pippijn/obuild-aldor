--* Received: from mailer.scri.fsu.edu by nags2.nag.co.uk (4.1/UK-2.1)
--* 	id AA03247; Wed, 10 Apr 96 23:14:38 BST
--* Received: from ibm4.scri.fsu.edu (ibm4.scri.fsu.edu [144.174.131.4]) by mailer.scri.fsu.edu (8.6.12/8.6.12) with SMTP id SAA14521; Wed, 10 Apr 1996 18:11:04 -0400
--* From: Tony Kennedy <adk@scri.fsu.edu>
--* Received: by ibm4.scri.fsu.edu (5.67b) id AA26937; Wed, 10 Apr 1996 18:09:27 -0400
--* Date: Wed, 10 Apr 1996 18:09:27 -0400
--* Message-Id: <199604102209.AA26937@ibm4.scri.fsu.edu>
--* To: adk@scri.fsu.edu, ax-bugs, edwards@scri.fsu.edu
--* Subject: [3] Error in ^: (%, Integer) -> % from SingleInteger

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.5
-- Original bug file name: sibug

Using the function

  ^: (%, Integer) -> %

exported by SingleInteger results in the run-time error "^$SingleInteger".
This is not suprising, as the definition (in the file sinteger.as) is

        (x: %) ^ (n: Integer): %     == error "^$SingleInteger";

How about replacing that with

  (x: %) ^ (n: Integer): % ==
    power(1$Integer, coerce(x)$Integer, n)$BinaryPowering(Integer, *, Integer)
      :: %

