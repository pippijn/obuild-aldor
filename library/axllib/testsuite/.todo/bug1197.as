--* From mnd@knockdhu.dcs.st-and.ac.uk  Mon Mar  6 17:09:36 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id RAA15960
--* 	for <ax-bugs@nag.co.uk>; Mon, 6 Mar 2000 17:09:34 GMT
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id RAA08587
--* 	for ax-bugs@nag.co.uk; Mon, 6 Mar 2000 17:15:15 GMT
--* Date: Mon, 6 Mar 2000 17:15:15 GMT
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200003061715.RAA08587@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [4][genfoam] Passing Fortran functions to Fortran is broken

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See header comment in the source code
-- Version: 1.1.12p5 (personal edition)
-- Original bug file name: ald.as


---------------------------------------------------------------------------
-- Save the Fortran below as ftn.f (call this file ald.as).
-- To see the working version compile with:
--
--   f95 -c ftn.f && axiomxl -Fx -laxllib -CFortran -DUseAldor ald.as ftn.o
--
-- To see the broken version compile without -DUseAldor.
---------------------------------------------------------------------------
-- The problem is that the wrapped import `summer' is given the empty
-- environment. It ought to be given the environment of `main'.
---------------------------------------------------------------------------

#include "axllib"

SI ==> SingleInteger;
PARRAY(T) ==> PrimitiveArray(T);


main():() ==
{
#if UseAldor
   local summer(a:PARRAY SI, m:SI):SI ==
   {
      local result:SI := 0;

      for i in 1..m repeat
         result := result + (a.i);

      result;
   }
#else
   import { summer: (PARRAY SI, SI) -> SI; } from Foreign Fortran;
#endif

   import from SI;
   import { warm: ((PARRAY SI, SI) -> SI) -> SI; } from Foreign Fortran;

   print << "warm(summer) == " << warm(summer) << newline;
}


main();


-- Here is some Fortran that can be used to test this.
#if 0
      integer function summer(arr, n)
         implicit none
         integer n
         integer arr(n)

         integer i, result

         result = 0

         do 10 i = 1,n
            result = result + arr(i)
 10      continue

         summer = result
      end


      integer function warm(fun)
         implicit none
         integer fun
         integer arr(6)

         integer i

         do 20 i = 1,6
            arr(i) = i
 20      continue

         warm = fun(arr, 6)
      end
#endif
