--* From mnd@dcs.st-and.ac.uk  Wed Feb 28 18:05:49 2001
--* Received: from server-14.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id SAA06078
--* 	for <ax-bugs@nag.co.uk>; Wed, 28 Feb 2001 18:05:47 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 30136 invoked from network); 28 Feb 2001 18:00:13 -0000
--* Received: from host213-1-155-206.btinternet.com (HELO dcs.st-and.ac.uk) (213.1.155.206)
--*   by server-14.tower-4.starlabs.net with SMTP; 28 Feb 2001 18:00:13 -0000
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.8.7/8.8.7) id SAA09998
--* 	for ax-bugs@nag.co.uk; Wed, 28 Feb 2001 18:00:37 GMT
--* Date: Wed, 28 Feb 2001 18:00:37 GMT
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200102281800.SAA09998@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [2][interp] Interpreter segfaults with declarative extend

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See header comment
-- Version: 1.1.13(20)
-- Original bug file name: bug1300.as

-------------------------------------------------------------------------
-- Save and split into bug1300a.as and bug1300b.as and then:
--   % axiomxl bug1300a.as
--   % axiomxl -ginterp bug1300b.as
--
-- To avoid the segfault use:
--   % axiomxl -DFIX bug1300a.as
--   % axiomxl -ginterp bug1300b.as
-------------------------------------------------------------------------

-- start of bug1300a.as
#include "axllib"

SI ==> SingleInteger;

define FloatLiteral:Category == with { float : Literal -> % }

define OrderedField : Category == Join(Field, Order);

define FieldWithValuation(OF : OrderedField) : Category == Field with {
   valuation : % -> OF;
}

#if FIX
extend Float : OrderedField == add;
#else
extend Float : OrderedField;
#endif
-- end of bug1300a.as


-- start of bug1300b.as
#include "axllib"

SI ==> SingleInteger;

#library LL "bug1300a.ao"
import from LL;

FloatWithVal: Join(FieldWithValuation(Float), FloatLiteral) == Float add { 
        Rep == Float;
        import from Rep;
        valuation(a : %): Float == abs(rep(a));
        float(x:Literal):% == per float(x); -- For floating-point literals
}

main():() ==
{
   import from FormattedOutput, Float;
   local x:FloatWithVal := -2.4;
   print("valuation(~a) = ~a~n")(<< x, << valuation(x));
}

main();
-- end of bug1300b.as

