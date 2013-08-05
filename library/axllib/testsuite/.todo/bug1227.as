--* From mnd@knockdhu.dcs.st-and.ac.uk  Wed Jun  7 12:26:16 2000
--* Received: from knockdhu.dcs.st-and.ac.uk (knockdhu.dcs.st-and.ac.uk [138.251.206.239])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with ESMTP id MAA09485
--* 	for <ax-bugs@nag.co.uk>; Wed, 7 Jun 2000 12:20:08 +0100 (BST)
--* Received: (from mnd@localhost)
--* 	by knockdhu.dcs.st-and.ac.uk (8.8.7/8.8.7) id PAA28228
--* 	for ax-bugs@nag.co.uk; Tue, 6 Jun 2000 15:52:57 +0100
--* Date: Tue, 6 Jun 2000 15:52:57 +0100
--* From: mnd <mnd@knockdhu.dcs.st-and.ac.uk>
--* Message-Id: <200006061452.PAA28228@knockdhu.dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][other=genfoam_or_runtime_or_both] Domain-valued functions are just too eager.

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See header comments
-- Version: 1.1.12p5
-- Original bug file name: eager.as


--------------------------------------------------------------------------
-- This is a cut-down version of bug #1221. It must not be compiled with
-- optimisation -Q2 or higher because the compiler is too clever and we
-- don't instantiate any domains.
--
-- Split this into two files (eager.as and sink.C) and then:
--
-- % gcc -x c -c sink.C
-- % axiomxl -grun -Q1 -D LAZY eager.as sink.o
-- % axiomxl -grun -Q1 -D EAGER eager.as sink.o
--
-- Ignore the messages about there not being an exception handler.
--------------------------------------------------------------------------


#if 0
-------------------------------- (sink.C) --------------------------------
 #include <stdio.h>

 void sink(int x) { (void)printf("*** Success!\n"); }
 int INIT__0_rtexns(void) { }
--------------------------------------------------------------------------
#endif


-- We don't need all the rubbish that comes with standard libraries.
Category:with == add;
Type:Category == with;
Tuple(T:Type):with == add;
(args:Tuple Type) -> (results:Tuple Type):with == add;


-- Basic, Machine: doesn't matter.
Basic:with { Bool:Type; } == add { Bool:Type == add; }


-- Can't get much simpler than this.
Boolean:with { true: %; } == add
{
   import from Basic;
   import { BoolTrue: () -> Bool; } from Builtin;

   true:% == BoolTrue() pretend %;
}


-- This is the domain that will be instantiated first. Provided blob()
-- uses its argument `x' in some form, we initialise initialise Foo(%)
-- before we create the exports blob and 1.
--
-- Now if Foo(%) is eager then we ask our category a question. This in
-- turn forces 1 but since we haven't got an export 1 yet the lookup
-- fails. However, if Foo(%) is lazy then we don't ask the category any
-- questions and we get to create blob and 1 in peace.
OneDom:with
{
   one: () -> %;
   1:   %;

   default { one():% == 1; }
}
== add
{
   blob(x:Foo(%)):() == foo x;
   1:% == (true$Boolean) pretend %;
}


-- Bar is a property we can ask domains about.
define Bar:Category == with;


#if LAZY
-- Lazy: build first, ask questions later.
Foo(T:Type):with { foo: % -> (); } == add
{
   local tmp:Boolean := T has Bar;
   foo(x:%):() == { free tmp:Boolean; if tmp then {}; }
}
#elseif EAGER
-- Eager: build and ask questions immediately.
Foo(T:Type):with { foo: % -> (); } ==
{
   local tmp:Boolean := T has Bar;


   -- This may look silly but imagine that we have a select
   -- on a property of T and return a different domain.
   add {
      foo(x:%):() == { free tmp:Boolean; if tmp then {}; }
   }
}
#else
#error "Please compile with -DLAZY or -DEAGER"
#endif


-- Test function: forces OneDom which builds Foo(OneDom). This works
-- provided that Foo(OneDom) isn't eager or doesn't ask questions.
main():() ==
{
   -- Build OneDom.
   local var:OneDom := 1;


   -- Ensure that dead code elimination doesn't sweep `var' away.
   import { sink: OneDom -> (); } from Foreign C;
   sink(var);
}


-- Start the ball rolling.
main();

