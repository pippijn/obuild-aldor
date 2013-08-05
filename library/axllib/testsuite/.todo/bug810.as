--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 16 23:13:45 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA04127; Tue, 16 Aug 1994 23:13:45 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7621; Tue, 16 Aug 94 23:13:49 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.PETEB.NOTE.VAGENT2.7905.Aug.16.23:13:48.-0400>
--*           for asbugs@watson; Tue, 16 Aug 94 23:13:49 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 7901; Tue, 16 Aug 1994 23:13:48 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Tue, 16 Aug 94 23:13:48 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19995; Tue, 16 Aug 1994 23:13:42 -0400
--* Date: Tue, 16 Aug 1994 23:13:42 -0400
--* From: peteb@watson.ibm.com (Peter A. Broadbery)
--* Message-Id: <9408170313.AA19995@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [2] hashcodes fail for 'T' don't match

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: asharp -flsp -fasy zzz.as [btw: I mean the compile-time type hashcode]
-- Version: current
-- Original bug file name: /maths/pab/junk/zzz.as

#include "ax0.as"
#assert true
#if 0
L ==> List;
STR ==> String;

#if true
Integer ==> SingleInteger;
import from Integer;

T(): with { f: () -> Integer; g: () -> Integer } == add {
	f(): Integer == {
		n := 1;
		for x in 1..5 repeat n := x*n;
		n
	}
	g(): Integer == {
		import from Segment Integer;
		n := 1;
		for x in (1..5)@Segment Integer repeat n := x*n;
		n
	}
}
#endif
