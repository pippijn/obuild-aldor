--* From youssef@mailer.scri.fsu.edu  Sun May 10 03:52:56 1998
--* Received: from nagmx1.nag.co.uk by red.nag.co.uk via SMTP (920330.SGI/920502.SGI)
--* 	for /home/red5/axiom/support/recvbug id AA09831; Sun, 10 May 98 03:52:56 +0100
--* Received: from mailer.scri.fsu.edu (mailer.scri.fsu.edu [144.174.112.142])
--*           by nagmx1.nag.co.uk (8.8.4/8.8.4) with ESMTP
--* 	  id DAA00986 for <ax-bugs@nag.co.uk>; Sun, 10 May 1998 03:57:36 +0100 (BST)
--* Received: from dirac.scri.fsu.edu (margit.scri.fsu.edu [144.174.128.45]) by mailer.scri.fsu.edu (8.8.7/8.7.5) with SMTP id WAA08866; Sat, 9 May 1998 22:54:51 -0400 (EDT)
--* From: Saul Youssef <youssef@scri.fsu.edu>
--* Received: by dirac.scri.fsu.edu (5.67b) id AA26234; Sat, 9 May 1998 22:54:51 -0400
--* Date: Sat, 9 May 1998 22:54:51 -0400
--* Message-Id: <199805100254.AA26234@dirac.scri.fsu.edu>
--* To: adk@mailer.scri.fsu.edu, ax-bugs@nag.co.uk, edwards@mailer.scri.fsu.edu,
--*         youssef@mailer.scri.fsu.edu
--* Subject: [3] axiomxl has a segentation fault

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.10c
-- Original bug file name: bug.as

--+ --
--+ --  Peter,
--+ --
--+ --     I've managed to cause axiomxl to have a segmentation fault
--+ --  for some reason and I can't think of any reason why this should
--+ --  happen.  If you would like to reproduce this, make the files
--+ --   
--+ --    ntuples.as   and
--+ --    data.as 
--+ -- 
--+ --  as indicated below.  Then do 
--+ --
--+ --    % axiomxl -Fao ntuples.as   
--+ --    % axiomxl -Fao data.as
--+ --
--+ --  you should get a segmentation fault on the second compilation
--+ --  on an AIX system with aldor 1.1.10c 
--+ --
--+ 
--+ ===== put this in ntuples.as =============================================
--+ --
--+ -- SW n-Tuples
--+ --
--+ 
--+ #include "axllib"
--+ #pile
--+ 
--+ S ==> SingleInteger
--+ 
--+ define FloatCategory: Category == OrderedRing with 
--+     step: S -> (%,%) -> Generator %
--+     exp:           % -> %
--+     float:   Literal -> %
--+     
--+ SDoubleFloat: FloatCategory == DoubleFloat add
--+     Rep ==> DoubleFloat
--+     import from Rep, DoubleFloatElementaryFunctions
--+     
--+     exp(x:%):%         == per exp rep x
--+     float(l:Literal):% == per float l
--+     
--+ SFloat: FloatCategory == Float add 
--+     Rep ==> Float
--+ 
--+ NTuple(F:FloatCategory,n:S): OrderedRing with
--+     ntuple: Array F   ->  %        -- create a new ntuple
--+     ntuple: Tuple F   ->  %
--+     val:          %   ->  Array F  -- return n-tuple as an array
--+     apply:    (%,S)   ->  F        -- return n-tuple component
--+     set!:   (%,S,F)   ->  %
--+     dim:          %   ->  S        -- dimension of the n-tuple
--+     mag2:         %   ->  F        -- sum of squares of components
--+     sum:          %   ->  F        -- sum of components
--+     *:        (F,%)   ->  %        -- scalar muliplication
--+ == add
--+     Rep ==> Array F
--+     import from S, Rep
--+ --
--+ --      NTuple specific
--+ --    
--+     ntuple(a:Array F):% == 
--+         #a=n => per a
--+         error "wrong array length for ntuple"
--+     ntuple(t:Tuple F):% == 
--+         length t=n => per [t]
--+         error "wrong number of arguments for ntuple"
--+     val(t:%):Array F    ==  rep t
--+     dim(t:%):S          == #rep t 
--+     apply(t:%,i:S):F    ==  (rep t).i
--+     set!(t:%,i:S,x:F):% ==  {z:=rep t; z.i := x; per z}
--+     mag2(t:%):F ==
--+         x:F := 1
--+         for y in rep t repeat x := x * y
--+         x
--+     sum(t:%):F ==
--+         x:F := 0
--+         for y in rep t repeat x := x + y
--+         x
--+     (s:F)*(t:%):% == ntuple [s*rep(t).i for i:S in 1..dim t]
--+ --
--+ --     OrderedRing signatures
--+ --    
--+     0:% == ntuple new (n,0)
--+     1:% == ntuple new (n,1)
--+     (t1:%)+(t2:%):% == ntuple ([rep(t1).i+rep(t2).i for i:S in 1..n])
--+     (t1:%)*(t2:%):% == ntuple ([rep(t1).i*rep(t2).i for i:S in 1..n])
--+     (t1:%)-(t2:%):% == ntuple ([rep(t1).i-rep(t2).i for i:S in 1..n])
--+     -(t:%):%        == ntuple ([-rep(t).i for i:S in 1..n])
--+     (t:%)^(p:Integer):%   == 
--+         x:% := 1
--+         for i:S in 1..n repeat
--+             x := x * t
--+         x
--+     (t1:%)>(t2:%):Boolean == 
--+         q := true
--+         for i:S in 1..n repeat
--+             q := q and rep(t1).i>rep(t2).i
--+         q
--+     coerce(m:Integer):% == 
--+         t:% := 0
--+         for i:Integer in 1..m repeat
--+           t := t + 1
--+         t
--+     coerce(m:S):% ==
--+         t:% := 0
--+         for i:S in 1..m repeat
--+           t := t + 1
--+         t
--+ --
--+ --     BasicType etc.
--+ --
--+     (t1:%)=(t2:%):Boolean ==
--+         q := true
--+         for i:S in 1..n repeat
--+             q := q and rep(t1).i=rep(t2).i
--+         q
--+     <<(t:TextWriter,nt:%):TextWriter == t << rep nt
--+     
--+ NTupleProjection(F:FloatCategory,n1:S,n2:S): with 
--+     project: (NTuple(F,n1),Array S) -> NTuple(F,n2)
--+ == add
--+     project(t1:NTuple(F,n1),ind:Array S):NTuple(F,n2) == 
--+         #ind = n2 => 
--+             a:Array F := [val(t1).(ind.k) for k in 1..n2]
--+             ntuple a
--+         error "wrong number of indices for projection in project"
--+      
--+ #if TEST
--+ 
--+ import from S, SFloat, NTuple(SFloat,3), NTupleProjection(SFloat,6,3)
--+ ones:Array SFloat := [1.0,1.0,1.0]
--+ 
--+ low:  NTuple(SFloat,3) := ntuple ones
--+ high: NTuple(SFloat,3) := ntuple (5.0,5.0,5.0)
--+ long: NTuple(SFloat,6) := ntuple (10.0,20.0,30.0,40.0,50.0,60.0)
--+ ind: Array S := [2,4,6]
--+ 
--+ print << low << newline
--+ print << high << newline
--+ print << low+high << newline
--+ print << low*high << newline
--+ print << high*(high+low) << newline
--+ print << long << newline
--+ print << project(long,ind) << newline
--+ print << mag2 high << newline
--+ print << 0.5*high << newline
--+ print << exp(1.0) << newline
--+ 
--+ #endif
--+ 
--+ =================== end of ntuples.as ====================================
--+ 
--+ ================= put the following in data.as ===========================
--+ --
--+ #include "axllib"
--+ #include "ntuples"
--+ #pile
--+ 
--+ S ==> SingleInteger
--+ import from S
--+ 
--+ Lepton == 'electron, muon'
--+ 
--+ DataJet(F:FloatCategory): BasicType with
--+     datajet: (F,F,F)->(F,F,F)          ->  %
--+     datajet: (NTuple(F,3),NTuple(F,3)) ->  %
--+     distance2: (%,NTuple(F,3))         ->  F
--+     apply: (%,'px') -> F
--+     apply: (%,'py') -> F
--+     apply: (%,'pz') -> F
--+     apply: (%,'sigx') -> F
--+     apply: (%,'sigy') -> F
--+     apply: (%,'sigz') -> F
--+     apply: (%,S) -> (F,F)
--+     tag?:       % -> Boolean
--+     mutag?:     % -> Boolean
--+     etag?:      % -> Boolean
--+ == add
--+     Rep ==> Record(p:NTuple(F,3),sigp:NTuple(F,3),tag:Boolean,leptype:Lepton)
--+     import from Lepton, Rep
--+     
--+     datajet(px:F,py:F,pz:F)(sx:F,sy:F,sz:F):% ==
--+         sx>=0.0 and sy>=0.0 and sz>= 0.0 => 
--+             per [ntuple(px,py,pz), ntuple(sx,sy,sz),false,electron]
--+         error "negative sigmas in datajet"
--+     datajet(t1:NTuple(F,3),t2:NTuple(F,3)):% == per [t1,t2,false,electron]
--+         
--+     =(a:%,b:%):Boolean == rep a = rep b
--+     sample: % == per [sample, sample, sample, sample ]
--+     apply(j:%,x:'px'):F == rep(j).p.1
--+     apply(j:%,x:'py'):F == rep(j).p.2
--+     apply(j:%,x:'pz'):F == rep(j).p.3
--+     apply(j:%,x:'sigx'):F == rep(j).sigp.1
--+     apply(j:%,x:'sigy'):F == rep(j).sigp.2
--+     apply(j:%,x:'sigz'):F == rep(j).sigp.3
--+     apply(j:%,i:S):(F,F) == 
--+         1<=i and i<=3 => (rep(j).p.i, rep(j).sigp.i)
--+         error "DataJet index out of range"
--+     tag?(j:%):Boolean == rep(j).tag
--+     mutag?(j:%):Boolean == rep(j).tag and rep(j).leptype=muon
--+     etag?(j:%):Boolean  == rep(j).tag and rep(j).leptype=electron
--+     <<(t:TextWriter,j:%):TextWriter == 
--+         for i in 1..3 repeat
--+             t << "Jet:"
--+             pr j.i where
--+                 pr(x:F,y:F):() == t <<"    "<< x <<" +- " << y << newline
--+         t
--+     distance2(j:%,v:NTuple(F,3)):F == 1.0
--+ --    distance2(j:%,v:NTuple(F,3)):F == 
--+ --        temp:NTuple(F,3) := ((rep(j).p - v) * rep(j).sigp)
--+ --        temp.1*temp.1 + temp.2*temp.2 + temp.3*temp.3
--+     
--+ 
--+     
--+     
--+ 
--+ 
--
--  Peter,
--
--     I've managed to cause axiomxl to have a segmentation fault
--  for some reason and I can't think of any reason why this should
--  happen.  If you would like to reproduce this, make the files
--   
--    ntuples.as   and
--    data.as 
-- 
--  as indicated below.  Then do 
--
--    % axiomxl -Fao ntuples.as   
--    % axiomxl -Fao data.as
--
--  you should get a segmentation fault on the second compilation
--  on an AIX system with aldor 1.1.10c 
--

===== put this in ntuples.as =============================================
--
-- SW n-Tuples
--

#include "axllib"
#pile

S ==> SingleInteger

define FloatCategory: Category == OrderedRing with 
    step: S -> (%,%) -> Generator %
    exp:           % -> %
    float:   Literal -> %
    
SDoubleFloat: FloatCategory == DoubleFloat add
    Rep ==> DoubleFloat
    import from Rep, DoubleFloatElementaryFunctions
    
    exp(x:%):%         == per exp rep x
    float(l:Literal):% == per float l
    
SFloat: FloatCategory == Float add 
    Rep ==> Float

NTuple(F:FloatCategory,n:S): OrderedRing with
    ntuple: Array F   ->  %        -- create a new ntuple
    ntuple: Tuple F   ->  %
    val:          %   ->  Array F  -- return n-tuple as an array
    apply:    (%,S)   ->  F        -- return n-tuple component
    set!:   (%,S,F)   ->  %
    dim:          %   ->  S        -- dimension of the n-tuple
    mag2:         %   ->  F        -- sum of squares of components
    sum:          %   ->  F        -- sum of components
    *:        (F,%)   ->  %        -- scalar muliplication
== add
    Rep ==> Array F
    import from S, Rep
--
--      NTuple specific
--    
    ntuple(a:Array F):% == 
        #a=n => per a
        error "wrong array length for ntuple"
    ntuple(t:Tuple F):% == 
        length t=n => per [t]
        error "wrong number of arguments for ntuple"
    val(t:%):Array F    ==  rep t
    dim(t:%):S          == #rep t 
    apply(t:%,i:S):F    ==  (rep t).i
    set!(t:%,i:S,x:F):% ==  {z:=rep t; z.i := x; per z}
    mag2(t:%):F ==
        x:F := 1
        for y in rep t repeat x := x * y
        x
    sum(t:%):F ==
        x:F := 0
        for y in rep t repeat x := x + y
        x
    (s:F)*(t:%):% == ntuple [s*rep(t).i for i:S in 1..dim t]
--
--     OrderedRing signatures
--    
    0:% == ntuple new (n,0)
    1:% == ntuple new (n,1)
    (t1:%)+(t2:%):% == ntuple ([rep(t1).i+rep(t2).i for i:S in 1..n])
    (t1:%)*(t2:%):% == ntuple ([rep(t1).i*rep(t2).i for i:S in 1..n])
    (t1:%)-(t2:%):% == ntuple ([rep(t1).i-rep(t2).i for i:S in 1..n])
    -(t:%):%        == ntuple ([-rep(t).i for i:S in 1..n])
    (t:%)^(p:Integer):%   == 
        x:% := 1
        for i:S in 1..n repeat
            x := x * t
        x
    (t1:%)>(t2:%):Boolean == 
        q := true
        for i:S in 1..n repeat
            q := q and rep(t1).i>rep(t2).i
        q
    coerce(m:Integer):% == 
        t:% := 0
        for i:Integer in 1..m repeat
          t := t + 1
        t
    coerce(m:S):% ==
        t:% := 0
        for i:S in 1..m repeat
          t := t + 1
        t
--
--     BasicType etc.
--
    (t1:%)=(t2:%):Boolean ==
        q := true
        for i:S in 1..n repeat
            q := q and rep(t1).i=rep(t2).i
        q
    <<(t:TextWriter,nt:%):TextWriter == t << rep nt
    
NTupleProjection(F:FloatCategory,n1:S,n2:S): with 
    project: (NTuple(F,n1),Array S) -> NTuple(F,n2)
== add
    project(t1:NTuple(F,n1),ind:Array S):NTuple(F,n2) == 
        #ind = n2 => 
            a:Array F := [val(t1).(ind.k) for k in 1..n2]
            ntuple a
        error "wrong number of indices for projection in project"
     
#if TEST

import from S, SFloat, NTuple(SFloat,3), NTupleProjection(SFloat,6,3)
ones:Array SFloat := [1.0,1.0,1.0]

low:  NTuple(SFloat,3) := ntuple ones
high: NTuple(SFloat,3) := ntuple (5.0,5.0,5.0)
long: NTuple(SFloat,6) := ntuple (10.0,20.0,30.0,40.0,50.0,60.0)
ind: Array S := [2,4,6]

print << low << newline
print << high << newline
print << low+high << newline
print << low*high << newline
print << high*(high+low) << newline
print << long << newline
print << project(long,ind) << newline
print << mag2 high << newline
print << 0.5*high << newline
print << exp(1.0) << newline

#endif

=================== end of ntuples.as ====================================

================= put the following in data.as ===========================
--
#include "axllib"
#include "ntuples"
#pile

S ==> SingleInteger
import from S

Lepton == 'electron, muon'

DataJet(F:FloatCategory): BasicType with
    datajet: (F,F,F)->(F,F,F)          ->  %
    datajet: (NTuple(F,3),NTuple(F,3)) ->  %
    distance2: (%,NTuple(F,3))         ->  F
    apply: (%,'px') -> F
    apply: (%,'py') -> F
    apply: (%,'pz') -> F
    apply: (%,'sigx') -> F
    apply: (%,'sigy') -> F
    apply: (%,'sigz') -> F
    apply: (%,S) -> (F,F)
    tag?:       % -> Boolean
    mutag?:     % -> Boolean
    etag?:      % -> Boolean
== add
    Rep ==> Record(p:NTuple(F,3),sigp:NTuple(F,3),tag:Boolean,leptype:Lepton)
    import from Lepton, Rep
    
    datajet(px:F,py:F,pz:F)(sx:F,sy:F,sz:F):% ==
        sx>=0.0 and sy>=0.0 and sz>= 0.0 => 
            per [ntuple(px,py,pz), ntuple(sx,sy,sz),false,electron]
        error "negative sigmas in datajet"
    datajet(t1:NTuple(F,3),t2:NTuple(F,3)):% == per [t1,t2,false,electron]
        
    =(a:%,b:%):Boolean == rep a = rep b
    sample: % == per [sample, sample, sample, sample ]
    apply(j:%,x:'px'):F == rep(j).p.1
    apply(j:%,x:'py'):F == rep(j).p.2
    apply(j:%,x:'pz'):F == rep(j).p.3
    apply(j:%,x:'sigx'):F == rep(j).sigp.1
    apply(j:%,x:'sigy'):F == rep(j).sigp.2
    apply(j:%,x:'sigz'):F == rep(j).sigp.3
    apply(j:%,i:S):(F,F) == 
        1<=i and i<=3 => (rep(j).p.i, rep(j).sigp.i)
        error "DataJet index out of range"
    tag?(j:%):Boolean == rep(j).tag
    mutag?(j:%):Boolean == rep(j).tag and rep(j).leptype=muon
    etag?(j:%):Boolean  == rep(j).tag and rep(j).leptype=electron
    <<(t:TextWriter,j:%):TextWriter == 
        for i in 1..3 repeat
            t << "Jet:"
            pr j.i where
                pr(x:F,y:F):() == t <<"    "<< x <<" +- " << y << newline
        t
    distance2(j:%,v:NTuple(F,3)):F == 1.0
--    distance2(j:%,v:NTuple(F,3)):F == 
--        temp:NTuple(F,3) := ((rep(j).p - v) * rep(j).sigp)
--        temp.1*temp.1 + temp.2*temp.2 + temp.3*temp.3
    

    
    


