#include "aldor.as"
#include "aldorio"

#library GenLib "xml__mygen.ao"
#library XMLBLib "xml__base.ao"
#library XMLLib "xml__basics.ao"
#library UCL "xml__unicode.ao"
#library XMLB3Lib "xml__basiccats.ao"
#library XMLD0 "xml__Dom0.ao"
#library XMLD1 "xml__Dom1.ao"
#library XMLO "xml__Out.ao"
#library XMLDocL "xml__Doc.ao"

import from GenLib,XMLBLib, XMLLib, UCL, XMLB3Lib, XMLD0, XMLD1,XMLO,XMLDocL;

A ==> Array;
B ==> Boolean;
T ==> Tuple;
L ==> List;
U ==> Union;
MI ==> MachineInteger;
BY ==> Byte;
--GEN ==> Generator;
GEN ==> MyGen;
PTR ==> Pointer;
CHAR ==> Character;
DOMS ==> DOMString;

+++ A package containing usefull functions 
FileToDOMString(UCH:UniCodeCharacter) : with {
  fileToDOM : String -> DOMString(UCH);
    ++ function for taking a text file and 
    ++ converting its characters to DOMString objects
} == add {
  fileToDOM(fn:String):DOMString(UCH) == {
    import from MI;
    charL:L(Character) := [];
    file:File := open(fn); eof:Character := char(255);
    fileTR:TextReader := file::TextReader;
    while ((ch := read!(fileTR)) ~= eof) repeat {
      charL := cons(ch,charL);
    }
    ca:A(UCH) := new(#charL);
    for i in (#charL-1)..0 by -1 for c in charL repeat ca.i := fromChar c;
    construct(ca)
  }
}

Parse(UCH:UniCodeCharacter) : with {
  convertToXML : DOMString(UCH) -> Node(UCH);
    ++ parse a DOMString which represents an XML Element(UCH) object
} == add {

  import from Character,UCH,Tuple(UCH),BY,T(BY),MI;
  default stack:L(DOMString(UCH)) := [];
  starttag == fromChar(char("<"));

  convertToXML(str:DOMString(UCH)):Node(UCH) == {

    -- clear stack
    free stack := [];
    free starttag;
    g:GEN(UCH) := generator(str);step! g;--step! g;
    -- find first "<"
    while value(g) ~= starttag repeat {
      step! g;
    }
    getNode(g)
  }

  import from MI,Machine;
  default nullaryOp:B := true;

  -- put a tag name (possibly with prefix) on stack
  put(preLocal:Tuple(U(str:DOMString(UCH),nul:'nul'))):Ptr == {
    import from U(str:DOMString(UCH),nul:'nul');
    free stack;
    if element(preLocal,2) case nul then
      error "local name unspecified";
    -- we do have prefix
    if element(preLocal,1) case str then {
      str2:DOMString(UCH) := append(element(preLocal,1).str,construct ":");
      str2 := append(str2,element(preLocal,2).str);
      stack := cons(str2,stack);
    } else { -- we have no prefix
      stack := cons(element(preLocal,2).str,stack);
    }
    nil@Ptr
  }

  pop():DOMString(UCH) == {
    if empty? stack then
      error "pop attempted on an empty stack";
    ret := first stack;free stack := rest stack;
    ret
  }

  tupleEq(t1:T(Byte),t2:T(Byte)):B == {
    element(t1,1) = element(t2,1) and element(t1,2) = element(t2,2)
  }

  getNode(g:GEN(UCH)):Node(UCH) == {
    import from Document(UCH);
    free nullaryOp,starttag;
    import from Element(UCH),U(str:DOMString(UCH),nul:'nul');
    if value(g) ~= starttag then -- node is a string
      return getString(g);
    else {
      preLocal:Tuple(U(str:DOMString(UCH),nul:'nul')) := getName(g);
      attributes:NamedNodeMap(UCH) := getAttributes(g);
      -- only put tags for nonnullary operators on the stack
      if not nullaryOp then put(preLocal);
      removeClosing(g)}
    children:NodeList(UCH) := new();
    if not nullaryOp then children := getChildren(g);
    if element(preLocal,2) case nul then error "cannot have nul local part";

    if element(preLocal,1) case str then {
      elt := cast createElementNS(element(preLocal,1).str,element(preLocal,2).str,
                attributes,children)
    }
    else {
      elt := cast createElement(element(preLocal,2).str,attributes,children)
    }
    elt
  }

  getString(g:GEN(UCH)):Node(UCH) == {
    import from Text(UCH),UCH,Document(UCH);
    free starttag;

    retl:L(UCH) := [];
--    while (not(tupleEq(c := value(g),starttag))) repeat {
    while (c := value(g)) ~= starttag repeat {
      step! g;
      retl := cons(c,retl);
    }
    str:DOMString(UCH) := construct(reverse retl);
    cast createTextNode str;
  }

  endtag:UCH == fromChar char ">";
  colon:UCH == fromChar char ":";
  slash:UCH == fromChar char "/";

  getName(g:GEN(UCH)):Tuple(U(str:DOMString(UCH),nul:'nul')) == {
    import from UCH,U(str:DOMString(UCH),nul:'nul');
    local prefx,loclNm,tmpNm:L(UCH);
    free endtag,colon,slash;

    preFlag:B := true;prefx := [];loclNm := [];tmpNm := [];
    step! g; -- remove the opening "<"
    while true repeat {
      if whiteSpace(value(g)) or value(g) = endtag or
         value(g) = slash then break;
      if preFlag then {
        if value(g) = colon then {
          preFlag := false; prefx := tmpNm;
        }
        tmpNm := cons(value(g),tmpNm);
      } else loclNm := cons(value(g),loclNm);
      step! g
    }
    if preFlag then {
      return([nul],[construct reverse tmpNm])}
    else {
      return([construct reverse prefx],[construct reverse loclNm])}
    never
  }

  equal:UCH == fromChar char "=";

  -- this getName is specifically for attributes
  getNameAttrib(g:GEN(UCH)):Tuple(U(str:DOMString(UCH),nul:'nul')) == {
    import from UCH,U(str:DOMString(UCH),nul:'nul');
    local prefx,loclNm,tmpNm:L(UCH);
--    local prefx,loclNm,tmpNm:DOMString(UCH);
    free endtag,colon,slash,equal;

    preFlag:B := true;prefx := [];loclNm := [];tmpNm := [];

    while true repeat {
      if (value(g)= endtag or value(g) = slash) then 
        error "attribute has been given no value";
      if value(g) = equal or whiteSpace(value(g)) then break;
      if preFlag then {
        if value(g) = colon then {
          preFlag := false; prefx := tmpNm;
        }
        tmpNm := cons(value(g),tmpNm);
      } else loclNm := cons(value(g),loclNm);
      step! g
    }
    if preFlag then {
      return([nul],[construct reverse tmpNm])}
    else {
      return([construct reverse prefx],[construct reverse loclNm])}
    never
  }

  space:UCH == fromChar char " ";
  cr:UCH == fromChar char(13@MI); -- the code for carriage return
  nl:UCH == fromChar char(10@MI); -- the code for newline
  tab:UCH == fromChar char(9@MI); -- the code for tab
  whiteSpace(c:UCH):B == 
    c = space or c = cr or c = nl or c = tab;

  -- function to remove white space
  remW(g:GEN(UCH)):Ptr == {
    while whiteSpace value g and not empty? g repeat {
      step! g}nil}

  -- the codes for the two types of quotes
  quote1:UCH == fromChar char("'");
  quote2:UCH == fromChar char(34@MI); --  the code for '"'

  getAttributes(g:GEN(UCH)):NamedNodeMap(UCH) == {
    free nullaryOp;
    free endtag,slash,equal,quote1,quote2;

    import from Attr(UCH),U(str:DOMString(UCH),nul:'nul'),Document(UCH);
    local tup:Tuple(U(str:DOMString(UCH),nul:'nul'));

--    retList:List(Attr(UCH)) := [];
    retList:NamedNodeMap(UCH) := new(0);
    nullaryOp := false;
    while true repeat { -- N.B. there may be many attributes

      -- remove leading white space
      remW(g);
      while whiteSpace value g repeat step! g;
      -- check to see if we are at the end of the "< ... >"
      if not(value g = endtag or value g = slash) then {
        tup := getNameAttrib g; -- get the name of the attribute

        -- remove " = '" or ' = "', with any intervening white space
        remW(g);
        if value(g) = equal then step! g;remW(g);
        if ((quote := value g) = quote1 or 
           (quote := value g) = quote2) then step! g
        else {
--          printGen(g);printStack();
          error "malformed attribute form";
        }

        -- now get the value
        val := getValue(g,quote); 
        -- now make attribute and put in the return value
        if element(tup,1) case str then -- we have a prefix to the attribute
          setNamedItemNS(retList,cast createAttributeNS(element(tup,1).str,element(tup,2).str,val));
        else setNamedItemNS(retList,cast createAttribute(element(tup,2).str,val));
      } else {
        if value(g) = endtag then break;
        if value g = slash then {
          nullaryOp := true;break
        }
      }
    }
    retList
  }

  getValue(g:GEN(UCH),quote:UCH):DOMString(UCH) == {
    free endtag,equal;

    val:L(UCH) := [];
    while true repeat {
      if value(g) ~= quote then {
        val := cons(value g,val);step! g;
      } else {step! g;break;}
    }
    construct reverse val
  }

  removeClosing(g:GEN(UCH)):Ptr == {
    free endtag,slash;

    remW g;

    if value(g) = slash then { step! g;
      if value(g) = endtag then {step! g} 
      else error "bad closing tag1"
    } else if value(g) = endtag then step! g
    else error "bad closing tag2";
    remW(g);
    nil
  }

  getChildren(g:GEN(UCH)):NodeList(UCH) == {

    ret:NodeList(UCH) := new();
    while true repeat {
      if value(g) = starttag and 
         secondVal(g) = slash then break;
      addChild(getNode(g),ret);
    }
    remove(g,pop());
    ret
  }

  remove(g:GEN(UCH),matchStr:DOMString(UCH)):Ptr == {

    -- we must remove "</" from g
    step! g;step! g;
    g2:GEN(UCH) := generator matchStr; 
    step! g2; -- need to remove null from start of generator -- step! g2;
    while true repeat {
      if not(value(g2) = value(g)) then {
        error "invalid XML1";
      }
      step! g;step! g2;
      if empty? g2 then break;
    }
    remW g;
    if value g ~= endtag then {
        printGen g;
        printGen g2;
        error "invalid XML2";
    }
    step! g;
    remW g;
    nil@Ptr
  }

  printGen(g:GEN(UCH)):Ptr == {
    import from Character;
    stdout<<newline;
    while true repeat {
      stdout<<value g;step! g;
      if empty? g then break
    }
    stdout<<newline;
    nil@Ptr
  }

  printStack():Ptr == {
    import from DOMString(UCH);
    free stack;
    stdout<<newline<<"stack is:"<<newline;
    for w in stack repeat {
      stdout<<"element :"<<w<<":"<<newline;
    }
    nil@Ptr
  }
}
