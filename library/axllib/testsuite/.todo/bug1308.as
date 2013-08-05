--* From mnd@dcs.st-and.ac.uk  Fri Apr  6 10:00:28 2001
--* Received: from server-13.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id KAA29858
--* 	for <ax-bugs@nag.co.uk>; Fri, 6 Apr 2001 10:00:27 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 13516 invoked from network); 6 Apr 2001 08:58:14 -0000
--* Received: from host213-1-183-236.btinternet.com (HELO dcs.st-and.ac.uk) (213.1.183.236)
--*   by server-13.tower-4.starlabs.net with SMTP; 6 Apr 2001 08:58:14 -0000
--* Received: (from mnd@localhost)
--* 	by dcs.st-and.ac.uk (8.11.0/8.11.0) id f35LTQK27671
--* 	for ax-bugs@nag.co.uk; Thu, 5 Apr 2001 22:29:26 +0100
--* Date: Thu, 5 Apr 2001 22:29:26 +0100
--* From: mnd <mnd@dcs.st-and.ac.uk>
--* Message-Id: <200104052129.f35LTQK27671@dcs.st-and.ac.uk>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][tinfer] Mutually recursive types (kind-of)

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: See source
-- Version: 1.1.13(21)
-- Original bug file name: bug04.as

-- Nightmare version of bug1303 ...

-- Bare-bones library.
Category:with == add;
Type:Category == with;
Tuple(T:Type):with == add;
(args:Tuple Type) -> (results:Tuple Type):with == add;


-- It doesn't matter whether NodeList is defined before Node, this program
-- will not compile. The reason is that the return type of the second export
-- Node is NodeList and vice versa. When the compiler type-checks the first
-- one it fails to create a substitution from UCH1 to UCH0 or vice versa.
-- This causes a type checking error when handling the qualification in the
-- body of the second export.
--
-- Note that the qualifications are not necessary but make it easier to
-- catch the type inferer at the correct point.
--
-- See references to tfSymeInducesDependency in tfsat.c for examples of
-- where this bites: break on tfSatAsMulti with abDumpPosition(ab). Wait
-- until you see the tokens highlighted with ^...^ below and then trace
-- the code. For the first token you get an empty sigma, for the second
-- you get UCH1 +-> UCH0.

Node(UCH0:with): with
{
   node: NodeList(UCH0) -> %;
   edon: Node(UCH0) -> NodeList(UCH0);
}
== add
{
   node(x:NodeList(UCH0)):% == x pretend %;

   -- Not used: it exists to create a type reference to NodeList().
   edon(x:Node(UCH0)):NodeList(UCH0) == nodelist(x)$NodeList(UCH0);
      -- .............^............^
}


NodeList(UCH1:with): with
{
   nodelist : Node(UCH1) -> %;
   tsiledon: NodeList(UCH1) -> Node(UCH1);
} == add
{
   nodelist(x:Node(UCH1)):% == x pretend %;

   -- Not used: it exists to create a type reference to Node().
   tsiledon(lis:NodeList(UCH1)):Node(UCH1) == node(lis)$Node(UCH1);
      -- .......................^........^
}

