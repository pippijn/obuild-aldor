--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Aug 30 21:55:47 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA17776; Tue, 30 Aug 1994 21:55:47 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 7847; Tue, 30 Aug 94 21:55:52 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.8863.Aug.30.21:55:52.-0400>
--*           for asbugs@watson; Tue, 30 Aug 94 21:55:52 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 8859; Tue, 30 Aug 1994 21:55:51 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Tue, 30 Aug 94 21:55:51 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA27364; Tue, 30 Aug 1994 21:56:08 -0400
--* Date: Tue, 30 Aug 1994 21:56:08 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9408310156.AA27364@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [4][tinfer] Confusion with "Third"s

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp foo3.as
-- Version: current
-- Original bug file name: foo3.as

--+ >Compiling gives the following error messages:
--+
--+
--+
--+ #1 (Error) There are 2 meanings for `C' in this context.
--+ The possible types were:
--+           C: Third( with
--+                         T: Type
--+                  ..., a local
--+           C:
--+                  with
--+                     ==  add ()
--+        ... from AsLib
--+   The context requires an expression of type Tuple(Type).
--+
--+
--+ >Replacing C: Category == ...     with    C == .... causes the
--+ >messages to go away.
#include "axllib"

import from Integer;

C: Category == with {

        T: Type;

        1: T;

        Y: Integer -> Type;
        X: T -> Type;

        g: Y(1);
        h: X(1);
}
