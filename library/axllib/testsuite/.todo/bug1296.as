--* From hemmecke@risc.uni-linz.ac.at  Thu Feb  8 12:35:04 2001
--* Received: from server-23.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id MAA16249
--* 	for <ax-bugs@nag.co.uk>; Thu, 8 Feb 2001 12:35:03 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 4581 invoked from network); 8 Feb 2001 12:31:36 -0000
--* Received: from kernel.risc.uni-linz.ac.at (193.170.37.225)
--*   by server-23.tower-4.starlabs.net with SMTP; 8 Feb 2001 12:31:36 -0000
--* Received: from enceladus.risc.uni-linz.ac.at (bianca.risc.uni-linz.ac.at [193.170.38.234])
--* 	by kernel.risc.uni-linz.ac.at (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id NAA04847;
--* 	Thu, 8 Feb 2001 13:34:24 +0100
--* X-Authentication-Warning: kernel.risc.uni-linz.ac.at: Host bianca.risc.uni-linz.ac.at [193.170.38.234] claimed to be enceladus.risc.uni-linz.ac.at
--* Message-ID: <XFMail.20010208133426.hemmecke@risc.uni-linz.ac.at>
--* X-Mailer: XFMail 1.4.4 on Linux
--* X-Priority: 3 (Normal)
--* Content-Type: text/plain; charset=us-ascii
--* Content-Transfer-Encoding: 8bit
--* MIME-Version: 1.0
--* Resent-Date: Wed, 31 May 2000 10:50:24 +0200 (MET DST)
--* Resent-Message-Id: <XFMail.000531105024.hemmecke@risc.uni-linz.ac.at>
--* Resent-From: Ralf.Hemmecke@risc.uni-linz.ac.at
--* Resent-To: ax-bugs@nag.co.uk
--* Date: Thu, 08 Feb 2001 13:34:26 +0100 (CET)
--* Sender: hemmecke@risc.uni-linz.ac.at
--* From: hemmecke@risc.uni-linz.ac.at
--* To: ax-bugs@nag.co.uk
--* Subject: [5] function constant

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -V -Fx -laxllib -DC1 xxx.as
-- Version: Aldor version 1.1.13p1(5) for LINUX(glibc2.1)
-- Original bug file name: xxx.as

-- Author: Ralf Hemmecke, Johannes Kepler Universit"at Linz
-- Date: 02-FEB-2001
-- Aldor version 1.1.13p1(5) for LINUX(glibc2.1)
-- Subject: function constant

-- The intention here is to implement a function `compare' depending
-- on a domain parameter `order'. The function xcompare chooses an
-- appropriate compare function according to the a string parameter. 
-- Obviously C2 is not what I want, but it was the first version that
-- did not lead to a segmentation fault.

-- Adding the assertions (C1 and C3) or (C2 and C3) on is still
-- unsatisfactory for the same reason as C2.

-- Only giving the options C1 and C4 gives the desired result.

-- Seemingly 
--     reverseLex: (%, %) -> GLE == reverseLexN n;
-- and 
--     reverseLex(x: %, y: %): GLE == reverseLex(n)(x, y);
-- are different things. But why?
-------------------------------------------------------------------
-- Summary:
-- C1 Segmentation fault
-- C2 works and give correct results, but is unacceptable since
--    xcompare(s) is called each time compare is invoked.
-- C1 C3 still not as desired
-- C1 C4 That is what I wanted.

-- More detailed explanation:

-- Problem with:
-- axiomxl -V -Fx -DC1 -laxllib xxx.as
-- Calling xxx yields
--: Tie breaking with revlex
--: Compare with function: revlex
--: Check: lex
--: Check: invlex
--: Check: revlex
--: Segmentation fault

-- VERY STRANGE!!!
--   axiomxl -V -grun -laxllib -DC1 xxx.as
-- PRODUCED THE SAME OUTPUT AS C1 AND C4. 
-- NO SEGMENTATION FAULT WITH THE -grun OPTION.
-- So maybe the segmentation fault is not reproducible on another
-- machine.

-- The following also works, but I don't want that the search for the
-- appropriate function occurs each time I call compare. Thus I tend
-- to use the C1 setup.

-- axiomxl -V -Fx -DC2 -laxllib xxx.as
--: Tie breaking with revlex
--: Compare with function: revlex
--: Check: lex
--: Check: invlex
--: Check: revlex
--: comparison 1: greater
--: Tie breaking with revlex                <--- Difference to C1+C3
--: Compare with function: revlex
--: Check: lex
--: Check: invlex
--: Check: revlex
--: comparison 2: equal


-- Still unsatisfactory.
-- axiomxl -V -Fx -DC1 -DC3 -laxllib xxx.as
--: Tie breaking with revlex
--: Compare with function: revlex
--: Check: lex
--: Check: invlex
--: Check: revlex
--: comparison 1: greater
--: Compare with function: revlex
--: Check: lex
--: Check: invlex
--: Check: revlex
--: comparison 2: equal


-- This is what I wanted.
-- axiomxl -V -grun -DC1 -DC4 -laxllib xxx.as
--: Tie breaking with revlex
--: Compare with function: revlex
--: Check: lex
--: Check: invlex
--: Check: revlex
--: comparison 1: greater
--: comparison 2: equal



#include "axllib"
import from List String;
macro {
        GLE == 'greater,less,equal';
        I == SingleInteger;
        N == I;
        nl == newline;
        PIDX == I;
        TW == TextWriter;
}



PP(vars: List String, order: String): BasicType with {
        =: (%, %) -> Boolean;
        compare: (%, %) -> GLE;
        name: PIDX -> String;
        new: () -> %;
        variable: PIDX -> %;
} == {
    n: PIDX == #vars;
    add { -- where clause follows
        Rep ==  PrimitiveArray N;
        import from Rep;
        sample: % == per new(n, 0);

#if C1
        compare: (%, %) -> GLE == {
#elseif C2
        compare(x: %, y: %): GLE == {
#endif
                import from I, TextWriter;
                error << "Tie breaking with " << order << newline;
#if C1
                xcompare(order);
#elseif C2
                xcompare(order)(x, y);
#endif
        }

        -- local compare
#if C3
        xcompare(s: String)(x: %, y: %): GLE == {
#else
        xcompare(s: String): (%, %) -> GLE == {
#endif
                Rec ==> Record(t: String, cmp: (%, %) -> GLE);
                import from TextWriter;
                import from List Rec;
                orders: List Rec == [
                    ["lex", pureLex],
                    ["invlex", inverseLex],
                    ["revlex", reverseLex]
                ];
                error << "Compare with function: " << s << nl;
                for a in orders repeat{
                        error << "Check: " << a.t << nl;
#if C3
                        if a.t = s then return (a.cmp)(x, y);
#else
                        if a.t = s then return (a.cmp);
#endif
                }
                error << "Cannot handle order " << s << "." << newline;
                error << "The following orders are available: " <<
newline;
                for a in orders repeat{
                        error << a.t << newline;
                }
                error "";
        }
 


        (x: %) = (y: %): Boolean == {
                for i in 1..n repeat x.i ~= y.i => return false;
                true
        }

        (p: TW) << (x: %): TW == {
                import from N;
                -- nothing has been printed so far
                somethingPrinted? := false;
                for v in 1..n repeat {
                        if x.v > 0 then {
                                if somethingPrinted? then p << "*";
                                p << name v;
                                if x.v > 1 then p << "^" << x.v;
                                somethingPrinted? := true;
                        }
                }
                if not somethingPrinted? then p << 1;
                p;
        }

        local
        apply(x: %, i: PIDX): N == rep(x).i;

        inverseLex: (%, %) -> GLE == inverseLexN n;
        inverseLexN(dim: PIDX)(x: %, y: %): GLE == { -- invlex
                for i in 1..dim repeat {
                        if x.i > y.i then return less;
                        if y.i > x.i then return greater;
                }
                equal
        }

        name(i: PIDX): String == {
                if i < 0 or i > n then {
                        error "There is no variable with this index."
                } else vars.i;
        }

        new(): % == per new n;

        pureLex: (%, %) -> GLE == pureLexN n;
        pureLexN(dim: PIDX)(x: %, y: %): GLE == { -- lex
                for i:PIDX in 1..dim repeat {
                        if x.i > y.i then return greater;
                        if y.i > x.i then return less;
                }
                equal
        }

#if C4
        reverseLex(x: %, y: %): GLE == reverseLex(n)(x, y);
        reverseLex(dim: PIDX)(x: %, y: %): GLE == { -- revlex
                for i in dim..1 by -1 repeat {
                        if x.i > y.i then return less;
                        if y.i > x.i then return greater;
                }
                equal
        }
#else
        reverseLex: (%, %) -> GLE == reverseLexN n;
        reverseLexN(dim: PIDX)(x: %, y: %): GLE == { -- revlex
                for i in dim..1 by -1 repeat {
                        if x.i > y.i then return less;
                        if y.i > x.i then return greater;
                }
                equal
        }
#endif
        set!(x: %, i: PIDX, e: N): N == {rep(x).i := e}

        variable(i: PIDX): % == {
                if i < 0 or i > n then {
                        error "There is no variable with this index.";
                } 
                z: % := new();
                z.i := 1;
                z
        }
    }
}




main(): () == {
        T == PP(["x","y"],"revlex");
        import from GLE, PIDX, T, String;
        x: T := variable(1);
        y: T := variable(2);

--cmp 1
        gle := compare(x, y);

        cmp: String := if   gle = greater then "greater"
                       else if gle = less then "less"
                       else                    "equal";

        print << "comparison 1: " << cmp << newline;

-- cmp 2
        gle := compare(y, y);

        cmp: String := if   gle = greater then "greater"
                       else if gle = less then "less"
                       else                    "equal";

        print << "comparison 2: " << cmp << newline;
}

main();


