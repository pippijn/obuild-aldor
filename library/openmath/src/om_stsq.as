-- stsq.as contains domains which allow querying of OpenMath sts (small type 
-- system see Davenport "A Small openMath Type System", ACM SIGSAM, 
-- vol. 34, no. 2, pgs 16-21, 2000.) files
--
-- Copyright (C) 2003 	Bill Naylor
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-- You may contact the author at e-mail: bill@mcs.vuw.ac.nz 

#include "aldor.as"

#include "xmllib.as"
#include "openmath.as"

M ==> Machine;
B ==> Boolean;
L ==> List;
I ==> Integer;
MI ==> MachineInteger;
TW ==> TextWriter;
DF ==> DoubleFloat;
SF ==> SingleFloat;
STR ==> String;
GMPF ==> GMPFloat;

import from String;

+++ This category contains the function signatures for query functions on XML
+++ objects which constitute small type system ({\em sts}) files, associated
+++ with OpenMath content dictionaries
define STSQueryCat(UCH:UniCodeCharacter):Category == with {
  CDSignatureType? : Element(UCH) -> DOMString(UCH);
    ++ return the type system associated with this database of type information
  CDSignatureCd? : Element(UCH) -> DOMString(UCH);
    ++ return the name of the cd that this file pertains to
  CDSComment? : Element(UCH) -> DOMString(UCH);
    ++ return a string describing this particular sts file
  Signatures? : Element(UCH) -> L(DOMString(UCH));
    ++ return a list of strings which are the symbol names of the symbols
    ++ whose signatures are in this file.
  Signature? : (Element(UCH),DOMString(UCH)) -> Element(UCH);
    ++ return the signature of the symbol specified by symbol name (the second
    ++ parameter) in this content dictionary (the first parameter)
}

+++ This domain contains functions to query OpenMath sts files
STSQuery(UCH:UniCodeCharacter):STSQueryCat(UCH) == add {
  Rep ==> Element(UCH);

  cdSignaturesString:DOMString(UCH) := ["CDSignatures"];
  typeString:DOMString(UCH) := ["type"];
  CDSignatureType?(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH);
    ln := localName cast el;
    ln ~= cdSignaturesString => return [""];
    getAttribute(el,typeString);
  }

  cdString:DOMString(UCH) := ["cd"];
  CDSignatureCd?(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH);
    ln := localName cast el;
    ln ~= cdSignaturesString => return [""];
    getAttribute(el,cdString);
  }

  CDSCommentString:DOMString(UCH) := ["CDSComment"];
  CDSComment?(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDSCommentString then 
        return(data retract item(childNodes c,0))
    }
    [""]
  }

  SignatureString:DOMString(UCH) := ["Signature"];
  nameString:DOMString(UCH) := ["name"];
  Signatures?(el:Element(UCH)):L(DOMString(UCH)) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    ret:L(DOMString(UCH)) := [];
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = SignatureString then
        ret := cons(getAttribute(retract c,nameString),ret)
    }
    ret
  }

  Signature?(el:Element(UCH),name:DOMString(UCH)):Element(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    ret:L(DOMString(UCH)) := [];
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if getAttribute(retract c,nameString) = name then {
        return retract item(childNodes c,0)
      }
    }
    error "symbol not in CD signature file"
  }
}
