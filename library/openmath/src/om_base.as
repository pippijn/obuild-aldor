-- om.as contains domains which constitute an Aldor openmath implementation
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

M ==> Machine;
B ==> Boolean;
L ==> List;
I ==> Integer;
MI ==> MachineInteger;
TW ==> TextWriter;
DF ==> DoubleFloat;
SF ==> SingleFloat;
CH ==> Character;
STR ==> String;
GMPF ==> GMPFloat;
Tree ==> ExpressionTree;
Leaf ==> ExpressionTreeLeaf;

import from String,Character;

+++ This category contains function signatures for constructor functions for
+++ the basic OpenMath objects.
define AldorToOpenMathCat(UCH:UniCodeCharacter):Category == OutputType with {
  OMOBJ : L(%) -> %;
    ++ create an 'OMOBJ' element
  OMS : (DOMString(UCH),DOMString(UCH)) -> %;
    ++ construct an 'OMS' element given the cd name and symbol name.
  OMS : (String,String) -> %;
    ++ construct an 'OMS' element given the cd name and symbol name.
  OMV : DOMString(UCH) -> %;
    ++ construct an 'OMV' element given the variable name
  OMV : String -> %;
    ++ construct an 'OMV' element given the variable name
  OMA : L(%) -> %;
    ++ construct an 'OMA' element given a list consisting of the function to 
    ++ be applied and the arguments of that function
  OMI : MI -> %;
    ++ construct an 'OMI' element given the Integer which that element 
    ++ represents
  OMI : Integer -> %;
    ++ construct an 'OMI' element given the Integer which that element 
    ++ represents
  OMSTR : DOMString(UCH) -> %;
    ++ construct an 'OMSTR' element given the string represented by that element
  OMSTR : String -> %;
    ++ construct an 'OMSTR' element given the string represented by that element
  OMBIND : (%,%,%) -> %;
    ++ construct an 'OMBIND' element given the quantifier,
    ++ bounded variable list ('OMBVAR') and application over which it is 
    ++ to be bound
  OMBVAR : L(%) -> %;
    ++ construct an 'OMBVAR' element, given the variables ('OMV' elements) 
    ++ or attributed variables ('OMATTR' elements) which make up this list
  OMATTR : L(%) -> %;
    ++ construct an 'OMATTR' element, given the predicate ('OMATP' element) 
    ++ and element to which this predicate applies
  OMATP : L(%) -> %;
    ++ construct an 'OMATP' element to represent an attribution predicate.
  OME : L(%) -> %;
    ++ construct an 'OME' element to represent an OpenMath error object.
  OMB : String -> %;
    ++ construct an 'OMB' element to represent an OpenMath Byte array object
  retract : Element(UCH) -> %;
    ++ convert an element from the Element domain to this domain
}

+++ This category contains function signatures of query functions for the 
+++ basic OpenMath objects
define OpenMathToAldorCat(UCH:UniCodeCharacter):Category == with {
  cast : % -> Element(UCH);
    ++ convert an element from this domain to an Element
  OMS? : % -> (DOMString(UCH),DOMString(UCH));
    ++ query the cd name and symbol name of this OpenMath symbol
  OMScd? : % -> DOMString(UCH);
    ++ query the cd name of this OpenMath symbol
  OMSname? : % -> DOMString(UCH);
    ++ query the symbol name of this OpenMath symbol
  qOMS? : % -> (DOMString(UCH),DOMString(UCH));
    ++ query the cd name and symbol name of this OpenMath symbol with no checking
  qOMScd? : % -> DOMString(UCH);
    ++ query the cd name of this OpenMath symbol with no checking
  qOMSname? : % -> DOMString(UCH);
    ++ query the symbol name of this OpenMath symbol with no checking
  OMV? : % -> DOMString(UCH);
    ++ query the value of this OpenMath variable
  qOMV? : % -> DOMString(UCH);
    ++ query the value of this OpenMath variable with no checking
  OMI? : % -> Integer;
    ++ query the value of this OpenMath integer
  qOMI? : % -> Integer;
    ++ query the value of this OpenMath integer with no checking
  OMSTR? : % -> String;
    ++ query the value of this OpenMath string
  qOMSTR? : % -> String;
    ++ query the value of this OpenMath string with no checking
}

+++ This domain contains constructors for the basic OpenMath objects. It also 
+++ contains destructors which return the basic objects DOMStrings (and 
+++ Strings), integers and Elements which they are made up of.
--OpenMath(UCH:UniCodeCharacter):AldorToOpenMathCat(UCH)
extend OpenMath(UCH:UniCodeCharacter):Join(AldorToOpenMathCat(UCH),OpenMathToAldorCat(UCH)) == add {
  Rep ==> Element(UCH);

  inline from Element(UCH),DOMString(UCH),NodeList(UCH),Document(UCH),Attr(UCH);
  import from Rep,Document(UCH),DOMString(UCH),MI,Attr(UCH),NodeList(UCH);

  (tw:TW) << (om:%):TW == tw<<rep om;

  retract(el:Element(UCH)):% == per el;

  OMOBJString:DOMString(UCH) == ["OMOBJ"];
  OMOBJ(l:L(%)):% == {
    import from NamedNodeMap(UCH);
    nl:NodeList(UCH) := new();
    for i in l repeat addChild(cast rep i,nl);
    per createElement(OMOBJString,new(0),nl)
  }

  OMString:DOMString(UCH) == ["OMS"];
  cdString:DOMString(UCH) == ["cd"];
  nameString:DOMString(UCH) == ["name"];

  OMS(str1:DOMString(UCH),str2:DOMString(UCH)):% == {
    nnm:NamedNodeMap(UCH) := new(0);
    setNamedItem(nnm,cast createAttribute(cdString,str1));
    setNamedItem(nnm,cast createAttribute(nameString,str2));
    per createElement(OMString,nnm,new());
  }

  OMS(str1:String,str2:String):% =={
    nnm:NamedNodeMap(UCH) := new(0);
    setNamedItem(nnm,cast createAttribute(cdString,[str1]));
    setNamedItem(nnm,cast createAttribute(nameString,[str2]));
    per createElement(OMString,nnm,new());
  }

  OMVString:DOMString(UCH) == ["OMV"];
  OMV(str:DOMString(UCH)):% == {
    nnm:NamedNodeMap(UCH) == new(0);
    setNamedItem(nnm,cast createAttribute(nameString,str));
    per createElement(OMVString,nnm,new())
  }

  OMV(str:String):% == {
    nnm:NamedNodeMap(UCH) == new(0);
    setNamedItem(nnm,cast createAttribute(nameString,[str]));
    per createElement(OMVString,nnm,new())
  }

  OMAString:DOMString(UCH) := ["OMA"];
  OMA(l:L(%)):% == {
    import from NamedNodeMap(UCH);
    nl:NodeList(UCH) := new();
    for i in l repeat addChild(cast rep i,nl);
    per createElement(OMAString,new(0),nl)
  }

  OMIString:DOMString(UCH) := ["OMI"];
  OMI(i:MI):% == {
    import from NamedNodeMap(UCH),I,Text(UCH);
    nl:NodeList(UCH) := new();
    addChild(cast createTextNode toString(i::I),nl);
    per createElement(OMIString,new(0),nl)
  }

  -- convert an integer to a string
  toString(i:I):DOMString(UCH) == {
    if i<0 then append(["-"],toStringAux(-i))
    else toStringAux(i)
  }

  zCode:MI := 48;

  toStringAuxL(i:I):L(UCH) == {
    import from MI,Character,STR;
    import from Tuple(I);
    id10:Tuple(I) := divide(i,10);
    (r := element(id10,1)) = 0 => return [fromChar char(zCode+machine(element(id10,2)))];
    cons(fromChar char(zCode+machine(element(id10,2))),toStringAuxL(r))
  }

  toStringAux(i:I):DOMString(UCH) == {
    import from L(UCH);
    construct(reverse toStringAuxL(i))}

  OMI(i:Integer):% == {
    import from NamedNodeMap(UCH),I,Text(UCH);
    nl:NodeList(UCH) := new();
    addChild(cast createTextNode toString(i),nl);
    per createElement(OMIString,new(0),nl)
  }
  OMSTRString:DOMString(UCH) := ["OMSTR"];
  OMSTR(str:DOMString(UCH)):% == {
    import from NamedNodeMap(UCH),Text(UCH);
    nl:NodeList(UCH) := new();
    addChild(cast createTextNode str,nl);
    per createElement(OMSTRString,new(0),nl)
  }

  OMSTR(str:String):% == {
    import from NamedNodeMap(UCH),Text(UCH);
    nl:NodeList(UCH) := new();
    addChild(cast createTextNode [str],nl);
    per createElement(OMSTRString,new(0),nl)
  }

  OMBINDString:DOMString(UCH) := ["OMBIND"];
  OMBIND(s:%,bl:%,a:%):% == {
    import from NamedNodeMap(UCH);
    nl:NodeList(UCH) := new();
    addChild(cast rep s,nl);addChild(cast rep bl,nl);addChild(cast rep a,nl);
    per createElement(OMBINDString,new(0),nl)
  }

  OMBVARString:DOMString(UCH) := ["OMBVAR"];
  OMBVAR(lv:L(%)):% == {
    import from NamedNodeMap(UCH);
    nl:NodeList(UCH) := new();
    for i in lv repeat addChild(cast rep i,nl);
    per createElement(OMBVARString,new(0),nl)
  }

  OMATTRString:DOMString(UCH) := ["OMATTR"];
  OMATTR(l:L(%)):% == {
    import from NamedNodeMap(UCH);
    nl:NodeList(UCH) := new();
    for i in l repeat addChild(cast rep i,nl);
    per createElement(OMATTRString,new(0),nl)
  }

  OMATPString:DOMString(UCH) := ["OMATP"];
  OMATP(l:L(%)):% == {
    import from NamedNodeMap(UCH);
    nl:NodeList(UCH) := new();
    for i in l repeat addChild(cast rep i,nl);
    per createElement(OMATPString,new(0),nl)
  }

  cast(om:%):Element(UCH) == rep om;

  OMS?(om:%):(DOMString(UCH),DOMString(UCH)) == {
    import from Element(UCH),Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    ln ~= OMString => return ([""],[""]);
    (getAttribute(rom,cdString),getAttribute(rom,nameString))
  }

  OMScd?(om:%):DOMString(UCH) == {
    import from Element(UCH),Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    ln ~= OMString => return [""];
    getAttribute(rom,cdString)
  }

  OMSname?(om:%):DOMString(UCH) == {
    import from Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    ln ~= OMString => return [""];
    getAttribute(rom,nameString)
  }

  qOMS?(om:%):(DOMString(UCH),DOMString(UCH)) == {
    import from Element(UCH),Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    (getAttribute(rom,cdString),getAttribute(rom,nameString))
  }

  qOMScd?(om:%):DOMString(UCH) == {
    import from Element(UCH),Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    getAttribute(rom,cdString)
  }

  qOMSname?(om:%):DOMString(UCH) == {
    import from Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    getAttribute(rom,nameString)
  }

  OMV?(om:%):DOMString(UCH) == {
    import from Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    ln ~= OMVString => return [""];
    getAttribute(rom,nameString)
  }

  qOMV?(om:%):DOMString(UCH) == {
    import from Node(UCH);
    rom := rep om;
    ln := localName cast rom;
    getAttribute(rom,nameString)
  }

  cd0:MI := ord char "0";

  toInteger(istr:DOMString(UCH)):Integer == {
    import from UCH,CH;
    ri := reverse istr; (e,ret):I := (1,0);
    for d in ri repeat {
      di:I := (ord qToCharLow d - cd0)::I;
      ret := ret+di*e;e := e*10}
    ret;
  }

  minus:UCH := fromChar char "-";
  toInteger1(istr:DOMString(UCH)):Integer == {
    import from Array(UCH);
--    if item(istr,0)=minus then -toInteger(substring(istr,1,(#istr-1)))
    if data(istr).0=minus then -toInteger(substring(istr,1,(#istr-1)))
    else toInteger(istr);
  }

  OMI?(om:%):Integer == {
    import from Text(UCH),NodeList(UCH),Node(UCH),MI;
    rom := rep om;
    tagName(rom) ~= OMIString => error "wrong element for conversion to integer";
    toInteger1(data retract item(childNodes cast rom,0));
  }

  qOMI?(om:%):Integer == {
    import from Text(UCH),NodeList(UCH),Node(UCH),MI;
    rom := rep om;
    toInteger1(data retract item(childNodes cast rom,0));
  }

  OMSTR?(om:%):String == {
    error "function not done yet as part of om"
  }

  qOMSTR?(om:%):String == {
    error "function not done yet as part of om"
  }

  OME(l:L(%)):% == {
    error "function not done yet as part of om"
  }

  OMB(a:String):% == {
    error "function not done yet as part of om"
  }
}
