--* From SMWATT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Jun 14 00:35:28 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA22581; Tue, 14 Jun 1994 00:35:28 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 8763; Tue, 14 Jun 94 00:35:28 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.SMWATT.NOTE.VAGENT2.9427.Jun.14.00:35:26.-0400>
--*           for asbugs@watson; Tue, 14 Jun 94 00:35:27 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 9423; Tue, 14 Jun 1994 00:35:26 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Tue, 14 Jun 94 00:35:25 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA15263; Tue, 14 Jun 1994 00:38:21 -0400
--* Date: Tue, 14 Jun 1994 00:38:21 -0400
--* From: smwatt@watson.ibm.com (Stephen Watt)
--* X-External-Networks: yes
--* Message-Id: <9406140438.AA15263@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3] does not see pc and ps in the where rhs in outport. [basic.as][35.xx]

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


--
-- basic.as
--
-- Basic Types


#library LanguageLib "lang.aso"
#library MachineLib  "machine.aso"

import from LanguageLib, MachineLib;
import from Machine;

#include "asmacros"


+++ `OutPort' is a type of writable text streams.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: file, stream, text, output, write, print

OutPort: with {
	outport:(Character->(), (String,SingleInteger,SingleInteger)->()) -> %;
		++ `outport' forms a new OutPort value from functions
		++ which accept the data.

	put:	(%, Character) -> %;
		++ `put(o, c)' puts the Character `c' on the OutPort `o'.

	put:	(%, String) -> %;
		++ `put(o, s)' puts the String `s' on the OutPort `o'.

	put:	(%, String, SingleInteger, SingleInteger) -> %;
		++ `put(o, s, i0, len)' puts the String `s[i0..i0+len-1]'
		++ on the OutPort `o'.

	#:	(%) -> SingleInteger;

	-- These four are not primitive and will go away.
	put:	(%, BSInt) -> %;
	put:	(%, BBInt) -> %;
	put:	(%, BSFlo) -> %;
	put:	(%, BDFlo) -> %;
}
== add {
	SI     ==> SingleInteger;
	OPRets ==> (Character->(), (String, SI,SI)->(), ()->SI);
	Rep    ==> () -> OPRets;

	import {
		formatSInt:      (BSInt) -> String;
		formatBInt:      (BBInt) -> String;
		formatSFloat:    (BSFlo) -> String;
		formatDFloat:    (BDFlo) -> String;
	} from Foreign();

	import from SI;

	outport(pc: Character->(), ps: (String,SI,SI)->()): % ==
		per ((): OPRets +-> (fc, fs, fn)) where {
			n: SInt := 0;
			fc(c: Character): () == {
				pc c;
				free n := n + 1
			}
			fs(s: String, start: SI, end: SI):() == {
				ps(s, start, end);
				free n := n + (start::SInt - end::SInt)
			}
			fn(): SI == n::SI;
		}

	put(p: %, c: Character): % ==
		{ (fc, fs, fn) := rep(p)(); fc c; p }
	put(p: %, s: String, start:SI, length:SI): % ==
		{ (fc, fs, fn) := rep(p)(); fs(s, start, length); p }
	#(p: %): SI ==
		{ (fc, fs, fn) := rep(p)(); fn() }

	put(p: %, s: String): %	== put(p, s, 1::SI, (-1)::SI);
	put(p: %, i: BSInt):  % == put(p, formatSInt   i);
	put(p: %, i: BBInt):  % == put(p, formatBInt   i);
	put(p: %, x: BSFlo):  % == put(p, formatSFloat x);
	put(p: %, x: BDFlo):  % == put(p, formatDFloat x);
}


+++ Generator(T) is a type which allows T values to be obtained serially
+++ in a `repeat' or `collect' form.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: generator, step

Generator(T: Type): with == add;


+++ The Boolean data type supports logical operations.
+++ Both arguments of the binary operations are always evaluated.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: logical operation

Boolean: with {
	coerce:		BBool -> %;
	coerce:		% -> BBool;
}
== add {
	Rep ==> BBool;

	coerce(b: %): BBool   == rep b;
	coerce(b: BBool): %   == per b;
}


+++ Byte implements single byte integers. Typically 8 bits.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: byte, single byte integer

Byte: with {
	coerce:		% -> BByte;
	coerce:		BByte -> %;
}
== add {
	Rep ==> BByte;

	coerce(b: %): BByte	== rep b;
	coerce(b: BByte): %	== per b;
}


+++ HalfInteger implements half-precision integers.  Typically 16 bits.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: half-precision integer

HalfInteger: with {
	coerce:		% -> BHInt;
	coerce:		BHInt -> %;
}
== add {
	Rep ==> BHInt;

	coerce(h: %): BHInt	== rep h;
	coerce(h: BHInt): %	== per h;
}


+++ SingleInteger implements single-precision integers.  Typically 32 bits.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: single-precision integer

SingleInteger: with {
	coerce:		Boolean     -> %;
	coerce:		Byte	    -> %;
	coerce:		HalfInteger -> %;

	coerce:		% -> BSInt;
	coerce:		BSInt -> %;
}
== add {
	Rep ==> BSInt;

	coerce(b: Boolean): %	  == per(if b then 1 else 0);
	coerce(b: Byte): %	  == per convert(b::BByte);
	coerce(h: HalfInteger): % == per convert(h::BHInt);
	coerce(i: BSInt): %	  == per i;
	coerce(i: %): BSInt	  == rep i;
}


+++ Integer implements infinite precision integers.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: infinite precision integer

Integer: with {
        integer:	Literal -> %;

	coerce:		SingleInteger -> %;

	coerce:		% -> BBInt;
	coerce:		BBInt -> %;
}
== add {
	Rep ==> BBInt;

	integer(l: Literal): % == per convert (l pretend BArr);

	coerce (i: SingleInteger): % == per convert(i::BSInt);

	coerce(i: %): BBInt == rep i;
	coerce(i: BBInt): % == per i;
}


+++ Characters for natural language text.
+++
+++ In the portable byte code files, characters are represented in ASCII.
+++ In a running program, characters are represented according to the
+++ machine's native character set, e.g. ASCII or EBCDIC.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: character, text, ASCII, EBCDIC

Character: with {
	string:		Literal -> %;

	ord:		% -> SingleInteger;
	char:		SingleInteger -> %;

	coerce:		% -> BChar;
	coerce:		BChar -> %;
}
== add {
	Rep ==> BChar;

	import {
		ArrElt: (BArr, BSInt) -> BChar;
	} from Builtin;

	string(l: Literal): %     == per ArrElt(l pretend BArr, 0);

	ord(c: %): SingleInteger  == ord(rep c)::SingleInteger;
	char(i: SingleInteger):%  == per char(i::BSInt);

	coerce(c: BChar): % == per c;
	coerce(c: %): BChar == rep c;
}


+++ String is the type of character strings for natural language text.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: string, text

String: with {
	string:		Literal -> %;
	<<:		(OutPort, %) -> OutPort;
	<<:		% -> OutPort -> OutPort;
}
== add {
	string(l: Literal): %           == l pretend %;
	(p: OutPort) << (s: %): OutPort == put(p, s pretend String);
	(<<)(s: %)(p: OutPort): OutPort == p << s;
}


+++ Pointer is the type of pointers to opaque objects.
+++
+++ Author: A# library
+++ Date Created: 1992-94
+++ Keywords: pointer

Pointer: with == add;


+++ The error function displays a string and exits.
error(s: String): Exit == {
	import {
		stdoutFile:	() -> OutPort;
	} from Foreign;
	import from OutPort;
	stdoutFile() << s;
	halt 0;
}
