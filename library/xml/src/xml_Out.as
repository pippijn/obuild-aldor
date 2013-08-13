#include "aldor"
--#include "aldorio"

-- xmlOut.as contains extentions to XML DOM domains for output
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
#library BasicLibrary "xml__basics.ao"
#library XMLBase "xml__base.ao"
#library XMLCats "xml__basiccats.ao"
#library XMLD0 "xml__Dom0.ao"
#library XMLD1 "xml__Dom1.ao"
#library XMLDOC "xml__Doc.ao"

import from ULib,BasicLibrary,XMLBase,XMLCats,XMLD0,XMLD1,XMLDOC;

import from String;

M ==> Machine;
B ==> Boolean;
MI ==> MachineInteger;
TW ==> TextWriter;
DS ==> DOMString;

ATTRIBUTES ==> Union(val:NamedNodeMap(UCH),failed:'failed');
CHILDNODES ==> Union(val:NodeList(UCH),failed:'failed');
FIRSTCHILD ==> Union(val:Node(UCH),failed:'failed');
LASTCHILD ==> Union(val:Node(UCH),failed:'failed');
LOCALNAME ==> Union(val:DOMString(UCH),failed:'failed');
NAMESPACEURI ==> Union(val:DOMString(UCH),failed:'failed');
NEXTSIBLING ==> Union(val:Node(UCH),failed:'failed');
NODENAME ==> Union(val:DOMString(UCH),failed:'failed');
NODETYPE ==> Union(val:MI,failed:'failed');
NODEVALUE ==> Union(val:DOMString(UCH),failed:'failed');
OWNERDOCUMENT ==> Union(val:Document(UCH),failed:'failed');
PARENTNODE ==> Union(val:Node(UCH),failed:'failed');
PREFIX ==> Union(val:DOMString(UCH),failed:'failed');
PREVIOUSSIBLING ==> Union(val:Node(UCH),failed:'failed');

NodeRep(Self) ==> Record(
    attributes:Union(val:NamedNodeMap(UCH),failed:'failed'),
    childNodes:Union(val:NodeList(UCH),failed:'failed'),
    firstChild:Union(val:Self,failed:'failed'),
    lastChild:Union(val:Self,failed:'failed'),
    localName:Union(val:DOMString(UCH),failed:'failed'),
    namespaceURI:Union(val:DOMString(UCH),failed:'failed'),
    nextSibling:Union(val:Self,failed:'failed'),
    nodeName:Union(val:DOMString(UCH),failed:'failed'),
    nodeType:Union(val:MI,failed:'failed'),
    nodeValue:Union(val:DOMString(UCH),failed:'failed'),
    ownerDocument:Union(val:Document(UCH),failed:'failed'),
    parentNode:Union(val:Self,failed:'failed'),
    prefix:Union(val:DOMString(UCH),failed:'failed'),
    previousSibling:Union(val:Self,failed:'failed'));

define ConvertibleToString(UCH:UniCodeCharacter):Category == with {
  toString : % -> DS(UCH);
    ++ to string converts an object to the equivalent DOMString
}

extend Node(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add{
  Rep ==> NodeRep(%);
  import from Rep;

  ((w:TW) << (n:%)):TW == {
    import from DOMString(UCH);
    import from Element(UCH),Attr(UCH),Text(UCH),CDATASection(UCH),EntityReference(UCH),ProcessingInstruction(UCH),Comment(UCH),Document(UCH),DocumentType(UCH),DocumentFragment(UCH),Notation(UCH);
    nrep:Rep := rep n;
    type:MI := nrep.nodeType.val;
    if type=1 then return(w << (n pretend Element(UCH)))
    else if type=2 then return(w << (n pretend Attr(UCH)))
    else if type=3 then return(w << (n pretend Text(UCH)))
    else if type=4 then return(w << (n pretend CDATASection(UCH)))
    else if type=5 then return(w << (n pretend EntityReference(UCH)))
    else if type=6 then error "what is this?"
    else if type=7 then return(w << (n pretend ProcessingInstruction(UCH)))
    else if type=8 then return(w << (n pretend Comment(UCH)))
    else if type=9 then error "not done yet" --return(w << (n pretend Document(UCH)))
    else if type=10 then return(w << (n pretend DocumentType(UCH)))
    else if type=11 then return(w << (n pretend DocumentFragment(UCH)))
    else if type=12 then return(w << (n pretend Notation(UCH)))
    else if type=0 then return(w<<"()")
    else error "invalid NodeType";
  }

  toString(n:%):DS(UCH) == {
    import from DOMString(UCH);
    import from Element(UCH),Attr(UCH),Text(UCH),CDATASection(UCH),EntityReference(UCH),ProcessingInstruction(UCH),Comment(UCH),Document(UCH),DocumentType(UCH),DocumentFragment(UCH),Notation(UCH);
    nrep:Rep := rep n;
    type:MI := nrep.nodeType.val;
    if type=1 then return toString(n pretend Element(UCH))
    else if type=2 then return toString(n pretend Attr(UCH))
    else if type=3 then return(toString(n pretend Text(UCH)))
    else if type=4 then return(toString(n pretend CDATASection(UCH)))
    else if type=5 then return(toString(n pretend EntityReference(UCH)))
    else if type=6 then error "what is this?"
    else if type=7 then return(toString(n pretend ProcessingInstruction(UCH)))
    else if type=8 then return(toString(n pretend Comment(UCH)))
    else if type=9 then error "not done yet" --return(toString(n pretend Document(UCH)))
    else if type=10 then return(toString(n pretend DocumentType(UCH)))
    else if type=11 then return(toString(n pretend DocumentFragment(UCH)))
    else if type=12 then return(toString(n pretend Notation(UCH)))
    else if type=0 then return(["()"])
    else error "invalid NodeType";
  }
}

extend Text(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (txt:%):TW == {
    import from DOMString(UCH);

    rept := rep txt;
    ret:TW := w;
    ret<<rept.nodeValue.val
  }

  toString(txt:%):DS(UCH) == rep(txt).nodeValue.val;
}

extend Element(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  printAtts(w:TW,atts:ATTRIBUTES):TW == {
    import from Node(UCH),String,MI;
    atts case failed => return(w);
    local ret:TW := w;
    attrs:NamedNodeMap(UCH) := atts.val;
    for i in 0..(length(attrs)-1) repeat {
      ret := ret<<" " <<$(Node(UCH) pretend OutputType) item(attrs,i);
    }
    ret
  }

  toStrAtts(atts:ATTRIBUTES):DS(UCH) == {
    import from Node(UCH) pretend ConvertibleToString(UCH),String,MI,Attr(UCH) pretend Join(ConvertibleFromNode(UCH),ConvertibleToString(UCH));
    atts case failed => return([""]);
    ret:DS(UCH) := [""];
    attrs:NamedNodeMap(UCH) := atts.val;
    for i in 0..(length(attrs)-1) repeat {
      ret := append(ret,[" "]);
      ret := append(ret,toString item(attrs,i));
    }
    ret
  }

  (w:TW) << (el:%):TW == {
    import from Node(UCH);
    repel:Rep := rep el;
    local prefix?:Boolean := false;
    ret:TW := w;
    -- do we have a namespace prefix
    prefix? := (repel.prefix) case val;
    local name:DOMString(UCH);
    if prefix? then {
       name := append(append(repel.prefix.val,[":"]),repel.localName.val)}
    else name := repel.localName.val;
    -- get children nodes if we have any
    childs:Union(val:NodeList(UCH),failed:'failed') := repel.childNodes;
    if childs case failed or length(childs.val)=0 then {
      -- case for empty element
      ret := ret<<"<"<<name;ret := printAtts(ret,repel.attributes)<<"/>";}
    else {
      -- we may have some children
      ret := ret<<"<"<<name;ret := printAtts(ret,repel.attributes)<<">";
      children:NodeList(UCH) := childs.val;
      len:MI := length children;
      for i in 1..len repeat {
        ret := ret <<$(Node(UCH) pretend OutputType) item(children,i-1);
      }
      ret := ret<<"</"<<name<<">";
    }
    ret
  }

  toString(el:%):DS(UCH) == {
    import from Node(UCH),Node(UCH) pretend ConvertibleToString(UCH);
    repel:Rep := rep el;
    local prefix?:Boolean := false;
    ret:DS(UCH) := [""];
    -- do we have a namespace prefix
    prefix? := (repel.prefix) case val;
    local name:DOMString(UCH);
    if prefix? then {
       name := append(append(repel.prefix.val,[":"]),repel.localName.val)}
    else name := repel.localName.val;
    -- get children nodes if we have any
    childs:Union(val:NodeList(UCH),failed:'failed') := repel.childNodes;
    if childs case failed or length(childs.val)=0 then {
      -- case for empty element
      ret := append(["<"],name);ret := append(ret,toStrAtts(repel.attributes));
      ret := append(ret,["/>"]);
    }
    else {
      -- we may have some children
      ret := append(ret,["<"]);
      ret := append(ret,name);ret := append(ret,toStrAtts(repel.attributes));
      ret := append(ret,[">"]);
      children:NodeList(UCH) := childs.val;
      len:MI := length children;
      for i in 1..len repeat {
        ret := append(ret,toString(item(children,i-1)));
      }
      ret := append(ret,["</"]);ret := append(ret,name);ret := append(ret,[">"]);
    }
    ret
  }
}

extend Attr(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (attr:%):TW == {
    repattr:Rep := rep attr;
    ret:TW := w;
    -- do we have a namespace prefix
    local nm,value:DOMString(UCH);
    if (repattr.prefix) case val then {
      nm := append(append(repattr.prefix.val,[":"]),repattr.localName.val)
    } else nm := repattr.localName.val;
    value := repattr.nodeValue.val;
    w<<nm<<" = _""<<value<<"_"";
  }

  toString(att:%):DS(UCH) == {
    repattr:Rep := rep att;
    ret:DS(UCH) := [""];
    -- do we have a namespace prefix
    local nm,value:DOMString(UCH);
    if (repattr.prefix) case val then {
      nm := append(append(repattr.prefix.val,[":"]),repattr.localName.val)
    } else nm := repattr.localName.val;
    value := repattr.nodeValue.val;
    append(append(append(nm,[" = _""]),value),["_""]);
  }
}

extend CDATASection(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (item:%):TW == 
    w << "<![CDATA[" << rep(item).nodeValue.val << "]]>";

  toString(cds:%):DS(UCH) == {
    append(append(["<![CDATA["],rep(cds).nodeValue.val),["]]>"])
  }
}

extend EntityReference(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (item:%):TW == error "not done yet";

  toString(entref:%):DS(UCH) == {
    error ""
  }
}

extend ProcessingInstruction(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (item:%):TW == 
    w << "<?" << rep(item).nodeName.val << " " << rep(item).nodeValue.val << "?>";

  toString(pi:%):DS(UCH) == {
    append(append(append(append(["<?"],rep(pi).nodeName.val),[" "]),rep(pi).nodeValue.val),["?>"])
  }
}

extend Comment(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (item:%):TW == 
    w << "<!--" << rep(item).nodeValue.val << "-->";

  toString(c:%):DS(UCH) == {
    append(append(["<!--"],rep(c).nodeValue.val),["-->"])
  }
}

--extend Document(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
--  Rep ==> NodeRep(Node(UCH));
--  import from Rep;
--
--  (w:TW) << (item:%):TW == error "not done yet"
--}

extend DocumentType(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> MI;
  import from Rep;

  (w:TW) << (item:%):TW == {
    irep := rep item;
    irep=0 => return(w<<"Null Type");
    irep=1 => return(w<<"Element Type");
    irep=2 => return(w<<"Attribute Type");
    irep=3 => return(w<<"Text Type");
    irep=4 => return(w<<"CDATA Section Type");
    irep=5 => return(w<<"Entity Reference Type");
    irep=6 => return(w<<"Entity Type");
    irep=7 => return(w<<"Processing Instruction Type");
    irep=8 => return(w<<"Comment Type");
    irep=9 => return(w<<"Document Type");
    irep=10 => return(w<<"Document Type Type");
    irep=11 => return(w<<"Document Fragment Type");
    irep=12 => return(w<<"Notation Type");
    error "Unknown Type"
  };

  toString(dt:%):DS(UCH) == {
    irep := rep dt;
    irep=0 => return(["Null Type"]);
    irep=1 => return(["Element Type"]);
    irep=2 => return(["Attribute Type"]);
    irep=3 => return(["Text Type"]);
    irep=4 => return(["CDATA Section Type"]);
    irep=5 => return(["Entity Reference Type"]);
    irep=6 => return(["Entity Type"]);
    irep=7 => return(["Processing Instruction Type"]);
    irep=8 => return(["Comment Type"]);
    irep=9 => return(["Document Type"]);
    irep=10 => return(["Document Type Type"]);
    irep=11 => return(["Document Fragment Type"]);
    irep=12 => return(["Notation Type"]);
    error "Unknown Type"
  }
}

extend DocumentFragment(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (item:%):TW == error "not done yet";

  toString(df:%):DS(UCH) == {
    error "not done yet (DocumentFragment)"
  }
}

extend Notation(UCH:UniCodeCharacter):Join(OutputType,ConvertibleToString(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  (w:TW) << (item:%):TW == error "not done yet";

  toString(ntn:%):DS(UCH) == {
    error "not done yet (Notation)"
  }
}
