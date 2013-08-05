--* From postmaster%watson.vnet.ibm.com@yktvmv.watson.ibm.com  Thu Oct 21 05:46:20 1993
--* Received: from yktvmv2.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA14135; Thu, 21 Oct 1993 05:46:20 -0400
--* X-External-Networks: yes
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 3269; Thu, 21 Oct 93 05:53:08 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.THEMOS.NOTE.YKTVMV.4745.Oct.21.05:53:08.-0400>
--*           for asbugs@watson; Thu, 21 Oct 93 05:53:08 -0400
--* Received: from ben.britain.eu.net by watson.ibm.com (IBM VM SMTP V2R3) with TCP;
--*    Thu, 21 Oct 93 05:53:07 EDT
--* Received: from num-alg-grp.co.uk by ben.britain.eu.net via JANET
--*           with NIFTP (PP) id <sg.03927-0@ben.britain.eu.net>;
--*           Thu, 21 Oct 1993 10:52:40 +0100
--* From: Theodore Tsikas <themos@num-alg-grp.co.uk>
--* Date: Thu, 21 Oct 93 10:47:08 BST
--* Message-Id: <16213.9310210947@nags2.nag.co.uk>
--* Received: from co.uk (nags8) by nags2.nag.co.uk (4.1/UK-2.1) id AA16213;
--*           Thu, 21 Oct 93 10:47:08 BST
--* To: asbugs@watson.ibm.com
--* Subject: AXP(OSF/1) v32 optimisation and X problems

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

Following problems with OSF1 port of A#v32.0

1) cfold.c as_y.c were not optimized
   need way of passing the option
   -Olimit xxx to the C compiler: modified docc with line

alpha)  cc -Olimit 700 "$@" ;;


2) asharp option <-C args="-Olimit 700"> did not pass correctly to
  the C compiler
  example:

  loan4:themos 169>asharp -v -Fo -C args="-Olimit 700" X11.aso
  A# version 32.0 for OSF/1 AXP
  Exec: unicl -Olimit 700 -I/usr/users/themos/asharp/base/alpha/include -c X11.c
  Exec: cc -I/usr/users/themos/asharp/base/alpha/include -I/usr/include -c
-O 700 X11.c
                ld in sc sy li pa ma ab ck sb ti gf of pb pl pc po mi
   Time   0.3s   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  4 95  0 %
   Source   1L : 156 lines per minute

3) prime.as did not get optimised for the same reason.
loan4:themos 174>asharp -O -Fo -Faso ../src/../aslib/prime.as

uopt: Warning: C8_prime_QMARK_: this procedure not optimized because it
      exceeds size threshold; to optimize this procedure, use -Olimit option
      with value >=  608.


4) Xlib.as compilation ran out of swap space. did it by hand with:

      asharp -Fo Xlib.aso

5) xasharp core dumps.

6) xmandel application core dumps

Best Regards

Themos

