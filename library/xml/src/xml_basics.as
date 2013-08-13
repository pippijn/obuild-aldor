#include "aldor"
--#include "aldorio"

-- xmlbasics.as contains Aldor categories TranslateableFromString, 
-- ConvertibleToOpenMath TranslateableFromOpenMath and
-- ConvertibleToMathML also domains DOMString and DOMTimeStamp.
-- It contains dummy domains OpenMath, MathMLPres and MathMLCont needed for 
-- signatures
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

#library ULib "xml__unicode.ao"
#library GenLib "xml__mygen.ao"

import from ULib,GenLib;

A ==> Array;
B ==> Boolean;
T ==> Tuple;
L ==> List;
MI ==> MachineInteger;
BY ==> Byte;
GEN ==> Generator;
PTR ==> Pointer;
STR ==> String;
CHAR ==> Character;

import from String;

MathMLPres(UCH:UniCodeCharacter) : with == add;
MathMLCont(UCH:UniCodeCharacter) : with == add;
OpenMath(UCH:UniCodeCharacter) : with == add;

define TranslateableFromString:Category == with {
  fromString : (UCH:UniCodeCharacter,DOMString(UCH)) -> %;
    ++ translate from a unicode string into this domain
}

+++ Contains a function which allows values of the domain to be translated 
+++ from valid MathML - Content, 
define TranslateableFromMathML:Category == with {
  fromMathML : (UCH:UniCodeCharacter,MathMLCont(UCH)) -> %;
    ++ function translates from a valid Content MathML string to an object of 
    ++ the domain
  qFromMathML : (UCH:UniCodeCharacter,MathMLCont(UCH)) -> %;
    ++ a quick version (with no checking)
  default {
    qFromMathML(UCH:UniCodeCharacter,mml:MathMLCont(UCH)):% == 
      fromMathML(UCH,mml);
  }
}


+++ Contains a function which allows values of the domain to be translated 
+++ from valid OpenMath 
define TranslateableFromOpenMath:Category == with {
  fromOpenMath : (UCH:UniCodeCharacter,OpenMath(UCH)) -> %;
    ++ function translates from a valid OpenMath string to an object of 
    ++ the domain
  qFromOpenMath : (UCH:UniCodeCharacter,OpenMath(UCH)) -> %;
    ++ a quick version (with no checking)
  default {
    qFromOpenMath(UCH:UniCodeCharacter,om:OpenMath(UCH)):% == 
      fromOpenMath(UCH,om);
  }
}

+++ this category allows a domain to be converted to OpenMath
define ConvertibleToOpenMath:Category == with {
  convertToOpenMath : (%,UCH:UniCodeCharacter) -> OpenMath(UCH);
    ++ function to convert to OpenMath using the UCH
    ++ unicode character set
  qConvertToOpenMath : (%,UCH:UniCodeCharacter) -> OpenMath(UCH);
    ++ a quick version of convertToOpenMath (with no checking)
  default {
    qConvertToOpenMath(om:%,UCH:UniCodeCharacter):OpenMath(UCH) == 
      convertToOpenMath(om,UCH);
  }
}

+++ this category allows a domain to be converted to MathML
define ConvertibleToMathML:Category == with {
  convertToMathMLPres : (%,UCH:UniCodeCharacter) -> MathMLPres(UCH);
    ++ function to convert to MathML Presentation using the UCH
    ++ unicode character set
  qConvertToMathMLPres : (%,UCH:UniCodeCharacter) -> MathMLPres(UCH);
    ++ a quick version of convertToMathMLPres (with no checking)
  convertToMathMLCont : (%,UCH:UniCodeCharacter) -> MathMLCont(UCH);
    ++ function to convert to MathML Content using the UCH
    ++ unicode character set
  qConvertToMathMLCont : (%,UCH:UniCodeCharacter) -> MathMLPres(UCH);
    ++ a quick version of convertToMathMLCont (with no checking)
  default {
    qConvertToMathMLPres(ml:%,UCH:UniCodeCharacter):MathMLPres(UCH) == 
      convertToMathMLPres(ml,UCH);
    qConvertToMathMLCont(ml:%,UCH:UniCodeCharacter):MathMLCont(UCH) == 
      convertToMathMLCont(ml,UCH);
  }
}

+++ Domain to implement the DOMString type as defined in:
+++ http://www.w3.org/TR/2000/PR-DOM-Level-2-Core-20000927/core.html
DOMString(UCH:UniCodeCharacter) : Join(CopyableType,PrimitiveType) with {
  # : % -> MI;
    ++ return the length of the string
  bracket : String -> %;
    ++ construct a DOMString object
  < : (%,%) -> Boolean;
    ++ we impose an ordering on these objects, as this allows for fast 
    ++ searching of an ordered table.
  > : (%,%) -> Boolean;
    ++ we impose an ordering on these objects, as this allows for fast 
    ++ searching of an ordered table.
  stripWS : % -> %;
    ++ strip the white space from a DOMString
  construct : String -> %;
    ++ construct an object of this type, from a character string.
  construct : Array(UCH) -> %;
    ++ construct an object of this type
  construct : L(UCH) -> %;
    ++ construct an object of this type
  constructRev : L(UCH) -> %;
    ++ construct an object of this type, the elements must be given in the 
    ++ reverse order (this has efficiency implications)
  data : % -> Array(UCH);
    ++ access an object of this type
  << : (TextWriter,%) -> TextWriter;
    ++ output an object of this type
--  cons : (UCH,%) -> %;
--    ++ cons an element to the start of a DOMString
  reverse : % -> %;
    ++ reverse a DOMString 
  append : (%,%) -> %;
    ++ append two DOMStrings together
  substring : (%,MI,MI) -> %;
    ++ return the substring between indices given by the second and third 
    ++ arguments
  insert! : (%,%,MI) -> %;
    ++ insert the string given by the second argument into the first argument
    ++ at the index given by the third argument. The function is destructive on
    ++ the first argument.
  deleteString! : (%,MI,MI) -> %;
    ++ delete the string between the indices given by the second and third
    ++ arguments. The function is destructive on the first argument.
  replaceString! : (%,%,MI,MI) -> %;
    ++ replace the string given by the second argument in the first argument,
    ++ starting at the position given by the third argument.
  split : (%,MI) -> (%,%);
    ++ split a DOMString at the given offset, return a tuple of the two strings
  generator : % -> Generator(UCH);
    ++ A generator which generates the 'characters' out of which these objects
    ++ are made.
  generator : % -> MyGen(UCH);
    ++ A generator which generates the 'characters' out of which these objects
    ++ are made.
  default {
    (a:%) > (b:%):B == not(a<b or a=b);
  }
  export from UCH;
} == add {
  Rep ==> Array(UCH);

  import from Rep,UCH,CHAR;

  copy(x:%):% == per copy rep x;

  #(s:%):MI == #rep(s);

  -- this gives a bogus value at present (the category UniCodeCharacter must
  -- be extended in order that an ordering can be implemented in this domain)
  (a:%) < (b:%):B == {
--    import from MI;
--    if not(#rep(a)=#rep(b)) then return(#rep(a)<#rep(b));
--    for ca in rep(a) for cb in rep(b) repeat {
--      if element(ca,1)=element(cb,1) and element(ca,2)=element(cb,2) then
--        iterate; -- this element is equal
--      if element(ca,1)=element(cb,1) then 
--        return (element(ca,2)<element(cb,2)); -- the first bytes are equal
--      return(element(ca,1)<element(cb,1))
--    }
    false -- a and b are equal
  } 

  space:UCH == fromChar char " ";
  import from MI;
  cr:UCH == fromChar char(13@MI); -- the code for carriage return
  nl:UCH == fromChar char(10@MI); -- the code for newline
  tab:UCH == fromChar char(9@MI); -- the code for tab
  whiteSpace(c:UCH):B == 
    c = space or c = cr or c = nl or c = tab;

  stripWS(str:%):% == {
    i:MI := 0;while whiteSpace(rep(str).i) repeat i:=i+1;
    j:MI := # rep str;while whiteSpace(rep(str).(j-1)) repeat j:=j-1;
    r:Rep := new(j-i,sp);
    for k in i..(j-1) repeat r.(k-i) := rep(str).k;
    per r
  }

--  cons(c:UCH,str:%):% == per cons(c,rep str);
  sp:UCH == fromChar(char " ");

  reverse(str:%):% == {
    repstr:Rep := rep str;
    len:MI := #repstr;
    ret:Rep := new(len,sp);
    for i in (len-1)..0 by -1 for j in 0.. repeat {
      ret.j := repstr.i
    }
    per ret
  }

  append(str1:%,str2:%):% == {
--    local l:MachineInteger,String;
    import from MachineInteger;
    (s1,s2) := (rep str1,rep str2);
--    for c in s2 repeat { --this doesn't work, because resize is screwey
--      l := #s1+1;
--      resize!(s1,l);
--      s1.l := c;
--    }
    -- for now we must do this :-(
    (l1,l2) := (#s1-1,#s2-1);l1pl2 := l1+l2;
    ret:Rep := new(l1+l2+2);
    for i in 0..l1 repeat {
      ret.i := s1.i;
    }
    for i in 0..l2 for j in (l1+1)..(l1pl2+1) repeat {
      ret.j := s2.i
    }
    per ret
  }

  (x:%) = (y:%):B == {
    import from MI;
    (xrep,yrep) := (rep x,rep y);
    not(#xrep = #yrep) => return(false);
    for cx in xrep for cy in yrep repeat {
      not(cx=cy) => return(false);
    }
    true
  }

  bracket(str:STR):% == construct(str);

  construct(str:String):% == {
    import from MI,Byte;
    len := #str;
    ret:Rep := new(len,sp);
    for c in str for i in 0.. repeat {
      set!(ret,i,fromChar c);
    }
    per ret
  }

  construct(a:Rep):% == per a;

  constructRev(l:L(UCH)):% == {
    import from MI;
    ret:Rep := new(#l);
    for i in (#l-1)..0 by -1 for c in l repeat ret.i := c;
    per ret
  }

  construct(l:L(UCH)):% == {
    import from MI;
    ret:Rep := new(#l);
--    for i in 1..#l for c in l repeat ret.i := c;
    for i in 0.. for c in l repeat ret.i := c;
    per ret
  }

  data(s:%):Array(UCH) == rep s;

  (w: TextWriter) << (b: %): TextWriter == {
    import from Byte,String,CHAR,MI,UCH;
    brep := rep b;
    local ret:TextWriter := w;
    for t in brep repeat {
      ret := ret<<t
    }
    ret
  }

  generator(s:%):GEN(UCH) == generator rep s;
  generator(s:%):MyGen(UCH) == generator generator rep s;

  substring(str:%,spos:MI,fpos:MI):% == {
    rstr := rep str;
    per [rstr.i for i in spos..fpos]
  }

  insert!(str:%,istr:%,pos:MI):% == {
    (rstr,ristr) := (rep str,rep istr);
    ls := #rstr;li := #istr;resize!(rstr,ls+li);
    for i in (ls+li-1)..pos+li by -1 repeat rstr.i := rstr.(i-li);
    for i in pos.. for c in ristr repeat rstr.i := c;
    per rstr
  }

  deleteString!(str:%,spos:MI,fpos:MI):% == {
    fpos > (#str-1) => error "the final position was out of range";
    rstr := rep str;
    for i in (fpos+1)..(#str-1) for j in spos.. repeat rstr.j := rstr.i;
    per resize!(rstr,#str-(fpos-spos+1));
  }

  -- *** we can make this more efficient by a factor of 2 by making the 
  -- movements explicitly rather than relegating to these functions ***
  replaceString!(str:%,rstring:%,spos:MI,fpos:MI):% == {
    spos > (#str - 1) => error "the final position was out of range";
    deleteString!(str,spos,fpos);
    insert!(str,rstring,spos);
    str
  }

  split(str:%,pos:MI):(%,%) == {
    strrep := rep str;
    (per [strrep.i for i in 0..pos],per [strrep.i for i in (pos+1)..(#strrep-1)])
  }
}

+++ Domain to implement the DOMTimeStamp type as defined in:
+++ http://www.w3.org/TR/2000/PR-DOM-Level-2-Core-20000927/core.html
DOMTimeStamp : with {
  construct : (MI,MI) -> %;
    ++ construct an object of this type
  string : % -> A(MI);
    ++ access an object of this type
} == add {
  Rep ==> A(MI);

  import from Rep,MI,A(MI);

  construct(l:MI,r:MI):% == per([l,r]);
  string(s:%):A(MI) == rep s;
}

define UnicodeString:Category == with {
  = : (%,%) -> B;
    ++ equality check between two objects of this domain
  construct : String -> %;
    ++ construct an object of this type, from a character string.
  append : (%,%) -> %;
    ++ append two UnicodeStrings together
  generator : % -> MyGen(Tuple(Byte));
    ++ A generator which generates the 'characters' out of which these objects
    ++ are made.
  << : (TextWriter,%) -> TextWriter;
    ++ output an object of this type
}
