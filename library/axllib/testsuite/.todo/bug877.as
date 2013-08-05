--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Oct  4 05:48:57 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21347; Tue, 4 Oct 1994 05:48:57 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 0181; Tue, 04 Oct 94 05:49:02 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.MIKER.NOTE.YKTVMV.8973.Oct.04.05:49:02.-0400>
--*           for asbugs@watson; Tue, 04 Oct 94 05:49:02 -0400
--* Received: from nagrs3.nag.co.uk by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Tue, 04 Oct 94 05:48:59 EDT
--* Received: by nagrs3.nag.co.uk (AIX 3.2/UCB 5.64/4.03)
--*           id AA04145; Tue, 4 Oct 1994 10:50:15 +0100
--* Date: Tue, 4 Oct 1994 10:50:15 +0100
--* From: miker@nagrs3.nag.co.uk (Mike Richardson)
--* Message-Id: <9410040950.AA04145@nagrs3.nag.co.uk>
--* To: asbugs@watson.ibm.com
--* Subject: [9] `:' and `:*' => confused error messages

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -Fx t.as
-- Version: 0.37.0
-- Original bug file name: /home/red5/miker/Axiom/ASdoc/t.as

--+ A declaration of, say, `s' with `:*', followed by the same declaration
--+ using `:' confuses A# which, when a value is assigned to s, produces the
--+ error message:
--+
--+ [L4 C1] #3 (Error) There are 2 meanings for `s' in this context.
--+ The possible types were:
--+           s: SingleInteger, a local
--+           s: SingleInteger, a local
--+   The context requires an expression of type SingleInteger.
--+
--+ (Declaring `s' twice, as, say, Integer and SingleInteger, also leads to
--+ a rather confused error message on assignment:
--+
--+ [L4 C6] #3 (Error) There is no suitable interpretation for the expression 7
--+   The context requires an expression of type SingleInteger.
--+      The possible types of the right hand side (`7') are:
--+           -- Integer
--+           -- SingleInteger
--+
--+ )
--+
--+ Mike
#include "axllib"
s :* SingleInteger;
s : SingleInteger;
s := 7;
