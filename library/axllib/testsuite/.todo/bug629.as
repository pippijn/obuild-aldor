--* From postmaster%watson.vnet.ibm.com@yktvmh.watson.ibm.com  Mon May  9 20:39:50 1994
--* Received: from yktvmh.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA26495; Mon, 9 May 1994 20:39:50 -0400
--* Received: from watson.vnet.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 6321; Mon, 09 May 94 20:39:59 EDT
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.RMC.NOTE.VAGENT2.4125.May.09.20:39:58.-0400>
--*           for asbugs@watson; Mon, 09 May 94 20:39:59 -0400
--* Received: from YKTVMH by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 4123; Mon, 9 May 1994 20:39:58 EDT
--* Received: from watson.ibm.com by yktvmh.watson.ibm.com (IBM VM SMTP V2R3)
--*    with TCP; Mon, 09 May 94 20:39:57 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/920123)
--*           id AA22412; Mon, 9 May 1994 20:37:31 -0400
--* Date: Mon, 9 May 1994 20:37:31 -0400
--* From: rmc@watson.ibm.com
--* Message-Id: <9405100037.AA22412@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [8] negative sqrt should say more [lambert.as][35.0]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- My second A# program
-- RMC 6-5-94

-- Lessons.
-- 1) Declare everything, including its type.---NOT!
-- 1a) Import everything you need!!!
-- 2) Put .0 after floats to distinguish them from integers.
-- 3) Semicolons separate statements in functions.
-- 4) Division by teeny-tiny numbers plus cancellation = trouble.
--    (Actually this was the division by zero bug, but it is best to
--     avoid division by zero in any case)
-- 5) (Second round).  I like the "suspicious juxtaposition" warning.
--    I had forgotten a semicolon.
-- 6) Don't need semicolons after } (or before).
-- 7) Nifty way of doing cases by =>.

+++ The Lambert W function by Halley's iteration
+++ with initial guess w given by a polyalgorithm.

#include "axllib"

import from Float;
import from Integer;

LambertW(x:Float):Float == {
  local w:Float := 0.0;
  local residual:Float := 1.0;
  local ew:Float;
  local p:Float;
  import from Integer;
  { -- A nifty way to do cases.  Thx BT.
    x < 0.0 =>
     { p := sqrt(2.0*(exp(1.0)*x+1.0));
       w := -1.0 + p - p^2/3.0 + (11.0)/(72.0)*p^3;
      }
    x < 2.0 =>
      w := x - x^2 + 1.5*x^3 - 8.0/3.0*x^4;

    w := log(x) - log(log(x));
  }
  ew := exp(w);
  residual := w*ew - x;
  print()()("x = ")(x)();
  print("w = ")(w)(",  residual = ")(residual)();
  while abs residual > 10.0^(1-digits()) repeat {
    w := w - residual/( (w+1.0)*ew - 0.5*(w+2.0)*residual/(w+1.0) );
    ew := exp(w);
    residual := w*ew - x;
    print("w = ")(w)(",  residual = ")(residual)();
    };
  return w
}


digits 30

print(LambertW(-0.2))()

print(LambertW(7.0))()

print(LambertW(-1.0))
