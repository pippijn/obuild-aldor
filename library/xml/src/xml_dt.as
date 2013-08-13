#include "aldor"
#include "aldorio"

#library ULib "xml__unicode.ao"
#library BasicLibrary "xml__basics.ao"
#library XMLBase "xml__base.ao"
#library XMLCats "xml__basiccats.ao"
#library XMLD0 "xml__Dom0.ao"
#library XMLD1 "xml__Dom1.ao"

import from ULib,BasicLibrary,XMLBase,XMLCats,XMLD0,XMLD1;

M ==> Machine;
B ==> Boolean;
MI ==> MachineInteger;
TW ==> TextWriter;

extend DocumentType(UCH:UniCodeCharacter):with DocumentTypeCat(UCH) == add {
  Rep ==> Record(n:DOMString(UCH),e:NamedNodeMap(UCH),ntn:NamedNodeMap(UCH),
                 p:DOMString(UCH),s:DOMString(UCH),internal:DOMString(UCH));

  import from Rep;
  name(dt:%):DOMString(UCH) == rep(dt).n;
  entities(dt:%):NamedNodeMap(UCH) == rep(dt).e;
  notations(dt:%):NamedNodeMap(UCH) == rep(dt).ntn;
  publicID(dt:%):DOMString(UCH) == rep(dt).p;
  systemID(dt:%):DOMString(UCH) == rep(dt).s;
  internalSubset(dt:%):DOMString(UCH) == rep(dt).internal;

  new(name:DOMString(UCH),ent:NamedNodeMap(UCH),notns:NamedNodeMap(UCH),
                 pID:DOMString(UCH),sID:DOMString(UCH),iS:DOMString(UCH)):% == {
    per([name,ent,notns,pID,sID,iS])
  }
}
