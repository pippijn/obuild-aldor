--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Fri Jun 10 12:23:11 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA18733; Fri, 10 Jun 1994 12:23:11 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 1551; Fri, 10 Jun 94 12:23:12 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.USER4.NOTE.YKTVMV.8525.Jun.10.12:23:12.-0400>
--*           for asbugs@watson; Fri, 10 Jun 94 12:23:12 -0400
--* Received: from crescent.rutgers.edu by watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Fri, 10 Jun 94 12:23:12 EDT
--* Received: by crescent.rutgers.edu (5.59/SMI4.0/RU1.5/3.08)
--* 	id AA00235; Fri, 10 Jun 94 12:23:09 EDT
--* Date: Fri, 10 Jun 94 12:23:09 EDT
--* From: user4@crescent.rutgers.edu (Temp User4)
--* Message-Id: <9406101623.AA00235@crescent.rutgers.edu>
--* To: asbugs@watson.ibm.com
--* Subject: [8] uninformative error message [ftoc.as][?]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

--+ #include "axllib"
--+ import from Integer;
--+ --import from Segment Integer;
--+ c(n:Integer):Integer == {
--+ 	(n+40)*5 quo 9 -40
--+ 	}
--+ f(n:Integer):Integer == {
--+ 	(n+40)*9 quo 5 -40
--+ 	};
--+ for i:Integer in 0..200 by 10 repeat
--+ 	print (i)(" degrees F = ")(c(i))(" degrees C.")();
--+ for i:Integer in 0..100 by 10 repeat
#include "axllib"
import from Integer;
--import from Segment Integer;
c(n:Integer):Integer == {
	(n+40)*5 quo 9 -40
	}
f(n:Integer):Integer == {
	(n+40)*9 quo 5 -40
	};
for i:Integer in 0..200 by 10 repeat
	print (i)(" degrees F = ")(c(i))(" degrees C.")();
for i:Integer in 0..100 by 10 repeat
	print (i)(" degrees C = ")(f(i))(" degrees F.")();
