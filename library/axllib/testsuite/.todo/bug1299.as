--* From youssef@buphyk.bu.edu  Tue Feb 27 22:17:20 2001
--* Received: from server-16.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id WAA26572
--* 	for <ax-bugs@nag.co.uk>; Tue, 27 Feb 2001 22:17:19 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 32680 invoked from network); 27 Feb 2001 22:11:51 -0000
--* Received: from buphyk.bu.edu (128.197.41.10)
--*   by server-16.tower-4.starlabs.net with SMTP; 27 Feb 2001 22:11:51 -0000
--* Received: (from youssef@localhost)
--* 	by buphyk.bu.edu (8.9.3/8.9.3) id RAA06103
--* 	for ax-bugs@nag.co.uk; Tue, 27 Feb 2001 17:16:36 -0500
--* Date: Tue, 27 Feb 2001 17:16:36 -0500
--* From: Saul Youssef <youssef@buphyk.bu.edu>
--* Message-Id: <200102272216.RAA06103@buphyk.bu.edu>
--* To: ax-bugs@nag.co.uk
--* Subject: [3] segfaults and bugs related to +++ comment lines

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: none
-- Version: 1.1.12p6
-- Original bug file name: nasty.tar.gz.uu

--+ 
--+ Hi Martin,
--+     
--+     Here's a couple of juicy bugs.  It takes several files to show this, so
--+ it's in a uuencoded gzipped tar file sent through axlbug.  If any of that 
--+ doesn't work, let me know and I'll send it as an email attachment.
--+ 
--+    Saul
--+ 
--+ =================================
--+ Hi Martin,
--+ 
--+     This directory contains a couple of rather juicy bugs.  Let me walk 
--+ you through reproducting them (in 1.1.12p6).
--+ 
--+ (a) First, do 
--+    
--+        % source go
--+        
--+     to demonstrate the basic bug.  This should print out a few numbers
--+     and then segfault.
--+     
--+ (b) BUG #1.  Edit the file Domains.as.  You will find three comment lines
--+ 
--+ +++
--+ +++  The Final object is any singleton 
--+ +++
--+ 
--+     remove these lines and % source go again.  You will find that Domains.as
--+     compiles as before, but DomainsTest.as no longer compiles!
--+     
--+ (c) Now put the comments back in Domains.as to get things back to the
--+     original state.      
--+     
--+ So far, this has only involved the category Domain.  The rest will involve
--+ Set also (Domain and Set are defined in Basics.as).  Set is the same as
--+ Domain with just an extra =:(%,%)->Boolean signature.
--+ 
--+ (d) The file Set.as is a copy of the file Domains.as with global string 
--+     substitution "Domain"->"Set" and adding two "="'s as needed.  
--+     
--+ (e) Verify that Sets.as compiles and that it's test program SetsTest.as 
--+     (which is also a copy of DomainsTest.as with string substitution) 
--+     runs correctly.
--+     
--+ (f) In the file Sets.as, remove the unneeded 
--+ 
--+ +++
--+ +++  The Final object is any singleton 
--+ +++
--+     1:Set == 
--+         S0:Set == add
--+             (t:TextWriter)<<(x:%):TextWriter == t << "*"
--+             (x:%)=(y:%):Boolean == false
--+         S0 add
--+     1(A:Set):(A->1) == (a:A):1 +-> (1$SingleInteger) pretend 1 
--+     
--+     and recompile. You will find that Sets.as compiles without problems.
--+     Verify that SetsTest.as no longer compiles.
--+     
--+ (g) BUG #2: SetsTest.as is now failing to compile due to not picking up a "*" function.
--+     SetsTest2.as is a disambiguated version of SetsTest.as.  Verify that it compiles
--+     with no complaints, but segfaults when you run it.
--+ 
--+ 
begin 644 /dev/stdout
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
BU=;FB^*\L4T9+;300@LMM-!""RVT\!W!_P$2I<`B`%``````
`
end

