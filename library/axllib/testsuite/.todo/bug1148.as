--* From youssef@mailer.scri.fsu.edu  Mon Aug 24 23:26:05 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA27468; Mon, 24 Aug 98 23:26:05 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id XAA11188 for <ax-bugs@nag.co.uk>; Mon, 24 Aug 1998 23:29:39 +0100 (BST)
--* Received: from dirac.scri.fsu.edu (dirac.scri.fsu.edu [144.174.128.44]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id SAA28255 for <ax-bugs@nag.co.uk>; Mon, 24 Aug 1998 18:26:35 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac.scri.fsu.edu (5.67b) id AA33970; Mon, 24 Aug 1998 18:26:30 -0400
--* Date: Mon, 24 Aug 1998 18:26:30 -0400
--* Message-Id: <199808242226.AA33970@dirac.scri.fsu.edu>
--* To: ax-bugs@nag.co.uk
--* Subject: [9] minor bad compiler behavior

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -g interp
-- Version: 1.1.11e
-- Original bug file name: bug0.as

--+ --
--+ --  Here's an example of a minor funny thing that happens in 1.1.11e.
--+ --
--+ --     Domains belonging to the category VectorSpace below export their
--+ --  own Scalar Fields.  The constructor makes a vector space of pairs in
--+ --  the usual way.  For some reason, the compiler gets confused if the
--+ --  new Scalars are explicitly given the type Field.  If the new Scalars
--+ --  are defined as in the comment, however, there is no problem.
--+ --
--+ --    Saul
--+ --
--+ #include "axllib"
--+ #pile
--+ 
--+ define VectorSpace: Category == AbelianGroup with 
--+     Scalar: Field
--+     *: (Scalar,%) -> %
--+     
--+ Constructor(V:VectorSpace):VectorSpace == add 
--+     Rep ==> Record(a:V,b:V)
--+     import from Rep
--+     
--+     Scalar:Field == Scalar$V
--+ --    Scalar == Scalar$V      <- if this is used instead, there is
--+ --                               no compiler error.
--+     
--+     (s:Scalar$%)*(x:%):% == per [s*rep(x).a,s*rep(x).b]
--+     
--
--  Here's an example of a minor funny thing that happens in 1.1.11e.
--
--     Domains belonging to the category VectorSpace below export their
--  own Scalar Fields.  The constructor makes a vector space of pairs in
--  the usual way.  For some reason, the compiler gets confused if the
--  new Scalars are explicitly given the type Field.  If the new Scalars
--  are defined as in the comment, however, there is no problem.
--
--    Saul
--
#include "axllib"
#pile

define VectorSpace: Category == AbelianGroup with 
    Scalar: Field
    *: (Scalar,%) -> %
    
Constructor(V:VectorSpace):VectorSpace == add 
    Rep ==> Record(a:V,b:V)
    import from Rep
    
    Scalar:Field == Scalar$V
--    Scalar == Scalar$V      <- if this is used instead, there is
--                               no compiler error.
    
    (s:Scalar$%)*(x:%):% == per [s*rep(x).a,s*rep(x).b]
    
