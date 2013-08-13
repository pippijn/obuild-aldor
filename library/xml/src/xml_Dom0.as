#include "aldor"
--#include "aldorio"

-- xmlDom0.as contains domain definition for some domains in the XML DOM set
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

import from ULib,BasicLibrary,XMLBase,XMLCats;

M ==> Machine;
B ==> Boolean;
MI ==> MachineInteger;
TW ==> TextWriter;

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

--NodeRep ==> Record(
--    attributes:Union(val:NamedNodeMap(UCH),failed:'failed'),
--    childNodes:Union(val:NodeList(UCH),failed:'failed'),
--    firstChild:Union(val:%,failed:'failed'),
--    lastChild:Union(val:%,failed:'failed'),
--    localName:Union(val:DOMString(UCH),failed:'failed'),
--    namespaceURI:Union(val:DOMString(UCH),failed:'failed'),
--    nextSibling:Union(val:%,failed:'failed'),
--    nodeName:Union(val:DOMString(UCH),failed:'failed'),
--    nodeType:Union(val:MI,failed:'failed'),
--    nodeValue:Union(val:DOMString(UCH),failed:'failed'),
--    ownerDocument:Union(val:Document(UCH),failed:'failed'),
--    parentNode:Union(val:%,failed:'failed'),
--    prefix:Union(val:DOMString(UCH),failed:'failed'),
--    previousSibling:Union(val:%,failed:'failed'));

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

define Generatable(UCH:UniCodeCharacter):Category == with {
  generator : % -> Generator(Node(UCH));
}

extend NodeList(UCH:UniCodeCharacter) : Join(NodeListCat(UCH),PrimitiveType,Generatable(UCH)) with {
  cast : % -> Array(Node(UCH));
  set! : (%,MI,Node(UCH)) -> %;
    ++ set an item in the nodelist
  new : () -> %;
    ++ create an empty NodeList 
  appendNodeLists! : (%,%) -> %;
    ++ append two node lists, not in XML DOM, but this would be more efficient 
    ++ than n - addChilds!, desctructive on the first argument
} == add{

  Rep ==>Array(Node(UCH));
  import from Rep,NodeRep(Node(UCH));

  cast(x:%):Rep == rep x;

  set!(x:%,pos:MI,nd:Node(UCH)):% == {
    rep(x).pos := nd;
    x
  }
  generator(x:%):Generator(Node(UCH)) == generator rep x;

  -- The number of nodes in the list. The range of valid child node indices
  -- is 0 to length - 1
  length(nl:%):MI == {
    repn:Rep := rep nl;
    #(repn)
  }

  -- for now
  null:Node(UCH) == [[failed],[failed],[failed],[failed],[failed],[failed],[failed],[failed],[0],[failed],[failed],[failed],[failed],[failed]] pretend Node(UCH);

  -- Returns the indexth item in the collection. If index is greater than or 
  -- equal to the number of nodes in the list, this returns null.
  item(nl:%,pos:MI):Node(UCH) == {
    import from Node(UCH) pretend NodeEx(UCH);
    pos >= length(nl) => return(null);
    repn:Rep := rep nl;
    repn.pos
  }

  -- Add a child to the NodeList. 
  addChild(nd:Node(UCH),nl:%):% == {
    local l:MI;
     repn:Rep := rep nl;
    --repn := append!(repn,nd);
    l := #repn;resize!(repn,l+1);repn.l := nd;
    -- maybe should also set parent and following sybling
    per repn
  }

  -- append two node lists, not in XML DOM, but this would be more efficient 
  -- than n - addChilds!, desctructive on the first argument
  appendNodeLists!(n1:%,n2:%):% == {
    (r1,r2) := (rep n1,rep n2);(l1,l2) := (#r1,#r2);s := l1+l2;
    resize!(r1,s);
    for i in l1..s for j in 1..l2 repeat {
      r1.i := r2.j
    }
    per r1
  }

  (x:%) = (y:%):B == true;

  -- create a new empty nodelist
  new():% == {
    per([]$Rep)
  }
}
