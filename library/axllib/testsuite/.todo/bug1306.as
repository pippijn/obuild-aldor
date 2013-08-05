--* From gnl@ph.ed.ac.uk  Wed Apr  4 22:28:51 2001
--* Received: from server-24.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nag.co.uk (8.9.3/8.9.3) with SMTP id WAA09702
--* 	for <ax-bugs@nag.co.uk>; Wed, 4 Apr 2001 22:28:50 +0100 (BST)
--* X-VirusChecked: Checked
--* Received: (qmail 19929 invoked from network); 4 Apr 2001 21:28:22 -0000
--* Received: from sloth.ph.ed.ac.uk (129.215.72.230)
--*   by server-24.tower-4.starlabs.net with SMTP; 4 Apr 2001 21:28:22 -0000
--* Received: from ukqcd2.ph.ed.ac.uk (ukqcd2.ph.ed.ac.uk [129.215.73.54])
--* 	by sloth.ph.ed.ac.uk (8.9.3/8.9.3) with ESMTP id WAA08634;
--* 	Wed, 4 Apr 2001 22:28:16 +0100 (BST)
--* From: Giuseppe Lacagnina <gnl@ph.ed.ac.uk>
--* Received: (gnl@localhost) by ukqcd2.ph.ed.ac.uk (8.6.12/8.6.12) id WAA17818; Wed, 4 Apr 2001 22:28:16 +0100
--* Date: Wed, 4 Apr 2001 22:28:16 +0100
--* Message-Id: <200104042128.WAA17818@ukqcd2.ph.ed.ac.uk>
--* To: adk@ph.ed.ac.uk, ax-bugs@nag.co.uk
--* Subject: [4] extend loses export?

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -fao Fraction.as; axiomxl -ginterp Polynomial.as
-- Version: Aldor version 1.1.12 for OSF/1 AXP
-- Original bug file name: Polynomial.as

--+ #include "axllib"
--+ #pile
--+ 
--+ Fraction(D : Join(EuclideanDomain, OrderedRing)): Join(Field, OrderedRing) with
--+     coerce : D -> %
--+   == add
--+     Rep == Record(num : D, den : D)
--+     import from Rep
--+ 
--+     local canonical(p : D, q : D) : % ==
--+       local g : D == gcd(p, q)
--+       per [p quo g, q quo g]
--+ 
--+     local ispositive?(a : %) : Boolean == (rep a).num > 0
--+ 
--+     0 : % == per [0,1]
--+ 
--+     1 : % == per [1,1]
--+ 
--+     (a : %) * (b : %) : % ==
--+       local
--+ 	ra : Rep == rep a
--+         rb : Rep == rep b
--+       canonical(ra.num * rb.num, ra.den * rb.den)
--+         
--+     (a : %) + (b : %) : % ==
--+       local
--+ 	ra : Rep == rep a
--+         rb : Rep == rep b
--+       canonical(ra.num * rb.den + ra.den * rb.num, ra.den * rb.den)
--+ 
--+     (a : %) = (b : %) : Boolean ==
--+       local
--+ 	ra : Rep == rep a
--+         rb : Rep == rep b
--+       ra.num = rb.num and ra.den = rb.den
--+ 
--+     (a : %) > (b : %) : Boolean == ispositive?(a - b)
--+ 
--+     - (a : %) : % == 
--+       local ra : Rep == rep a
--+       per [- ra.num, ra.den]
--+ 
--+     inv(a : %) : % ==
--+       local ra : Rep == rep a
--+       ra.den = 0 => error "Inverse of 0 does not exist"
--+       ra.num < 0 => per [- ra.den, - ra.num]
--+       per [ra.den, ra.num]
--+ 
--+     (a : %) ^ (n : Integer) : % ==
--+       power(1, a, n)$BinaryPowering(%, *, Integer)
--+ 
--+     coerce(d : D) : % == per [d, 1]
--+ 
--+     coerce(i : Integer) : % == per [i::D, 1]
--+ 
--+     coerce(i : SingleInteger) : % == per [i :: D, 1]
--+ 
--+     (t : TextWriter) << (a : %) : TextWriter ==
--+       local ra : Rep == rep a
--+       t << "(" << ra.num << "/" << ra.den << ")"
--+ 
--+ #endpile
#include "axllib"
#include "axldem"
#pile

#library FRAC "Fraction.ao"

import from FRAC

I ==> Integer
R == Fraction I
PRI == Polynomial(R,I)
P ==> PRI
import from I, R

extend PRI : Join(EuclideanDomain, OrderedRing) == add

  (a : %) > (b : %) : Boolean ==
    degree a = degree b => leadingCoefficient a > leadingCoefficient b
    degree a > degree b

  local QR == Record(quotient : %, remainder : %)

  local qrdivide(a : %, b : %): QR ==
    local
      alpha : R == leadingCoefficient b
      monicb : % == b * inv alpha
    qr : QR == monicDivide(a, monicb)
    [qr.quotient * alpha, qr.remainder * alpha]

  (a : %) quo (b : %) : % == 
    local qr : QR == qrdivide(a, b)
    qr.quotient

  (a : %) rem (b : %) : % ==
    local qr : QR == qrdivide(a, b)
    qr.remainder

  gcd(a : %, b : %) : % == error "No gcd yet!"

p : P == (3::R * var 2)@P + (4::R * var 1)@P + (-7::R)::P
q : P == (7::R * var 2)@P + 314::P

print << q << newline

#if 0

F == Fraction P

fp : F == p :: F
fq : F == q :: F
print << fq << newline
f : F == fp / fq

print << f << newline
#endif
#endpile


