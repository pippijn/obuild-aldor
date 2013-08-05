--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Sep 23 07:01:03 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19558; Fri, 23 Sep 1994 07:01:03 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7425; Fri, 23 Sep 94 07:01:07 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.MCD.NOTE.YKTVMV.1055.Sep.23.07:00:59.-0400>
--*           for asbugs@watson; Fri, 23 Sep 94 07:00:59 -0400
--* Received: from goggins.bath.ac.uk by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Fri, 23 Sep 94 07:00:58 EDT
--* Received: from bath.ac.uk (actually midge.bath.ac.uk) by goggins.bath.ac.uk
--*           with SMTP (PP); Fri, 23 Sep 1994 12:00:06 +0100
--* Received: from tamarin by midge.bath.ac.uk id aa14274; 23 Sep 94 12:00 BST
--* Received: from haldane.maths.bath.ac.uk by tamarin.bath.ac.uk
--*           with SMTP (PP)           id <15472-0@tamarin.bath.ac.uk>;
--*           Fri, 23 Sep 1994 12:00:15 +0100
--* Date: Fri, 23 Sep 94 12:00:12 BST
--* From: Mike Dewar <mcd@maths.bath.ac.uk>
--* To: asbugs@watson.ibm.com
--* Cc: mcd@maths.bath.ac.uk, jhd@maths.bath.ac.uk
--* Subject: Bug with asharp
--* Message-Id:  <9409231200.aa14274@midge.bath.ac.uk>

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

I've encountered this bizarre behaviour with asharp running interactively:

	nagrs1 765>asharp -v -Gloop
	A# version 0.37.0 for AIX RS/6000
	%1 >> #include "axllib"
	%2 >> import from Integer
	%3 >> import from Ratio Integer
	%4 >> 1/0
	      .^
	[L4 C2] #1 (Error) There are 2 meanings for the operator `/'.
	        Meaning 1: (Integer, Integer) -> Ratio(Integer)
	        Meaning 2: (Ratio(Integer), Ratio(Integer)) -> Ratio(Integer)
	
	%5 >> 1@Integer/0
	(1/0) @ Ratio(Integer)
	%6 >> b:=1@Integer/0
	(1/0) @ Ratio(Integer)
	%7 >> b-1
	(1/0) @ Ratio(Integer)
	%8 >> 0*b
	      .^
	[L8 C2] #1 (Error) There are 2 meanings for the operator `*'.
	        Meaning 1: (Integer, Ratio(Integer)) -> Ratio(Integer)
	        Meaning 2: (Ratio(Integer), Ratio(Integer)) -> Ratio(Integer)
	
	%9 >> b*0
	Division by Zero.

which then throws me out of asharp!

Mike.
