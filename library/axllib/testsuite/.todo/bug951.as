--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Feb 21 09:42:53 1995
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA21567; Tue, 21 Feb 1995 09:42:53 -0500
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 6095; Tue, 21 Feb 95 09:42:20 EST
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETERB.NOTE.YKTVMV.7479.Feb.21.09:42:18.-0500>
--*           for asbugs@watson; Tue, 21 Feb 95 09:42:20 -0500
--* Received: from sun2.nsfnet-relay.ac.uk by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 21 Feb 95 09:42:18 EST
--* Via: uk.co.iec; Tue, 21 Feb 1995 13:53:32 +0000
--* Received: from nldi16.nag.co.uk by nags2.nag.co.uk (4.1/UK-2.1) id AA10203;
--*           Tue, 21 Feb 95 13:54:59 GMT
--* From: Peter Broadbery <peterb@num-alg-grp.co.uk>
--* Date: Tue, 21 Feb 95 13:51:56 GMT
--* Message-Id: <20074.9502211351@nldi16.nag.co.uk>
--* Received: by nldi16.nag.co.uk (920330.SGI/NAg-1.0) id AA20074;
--*           Tue, 21 Feb 95 13:51:56 GMT
--* To: asbugs@watson.ibm.com
--* Subject: [ianm@uk.co.nag: axl bug]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Originally from ianm@nag.co.uk
-- Command line: axiomxl -gloop

Using the interpreter I defined a function:

inc(x: Integer): Integer == x + 1

I then attempted to redefine it:

inc(x: Integer): Integer == x + 2

and got the response:

Redefine? (y/n): n

so generating an error. However, when I tried:

inc(x: Integer): Integer == x + 2

again it accepted it without complaining.

Ian



