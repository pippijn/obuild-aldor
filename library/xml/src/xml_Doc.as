#include "aldor"
--#include "aldorio"

-- xmlDoc.as contains domain definition for some domains in the XML DOM set
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

import from ULib,BasicLibrary,XMLBase,XMLCats,XMLD0,XMLD1;

import from String;

M ==> Machine;
B ==> Boolean;
MI ==> MachineInteger;
TW ==> TextWriter;
DT ==> DocumentType;

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

+++ extend the Document domain with the functionality which is specific to Document's
extend Document(UCH:UniCodeCharacter):DocumentCat(UCH) with {
  new : (DT(UCH),Element(UCH),Array(NodeRep(Node(UCH)))) -> %;
} == add {
  Rep ==> Record(dt:DT(UCH),del:Element(UCH),nl:Array(NodeRep(Node(UCH))));
  -- N.B. the document element will be represented twice, this is required in 
  -- order to get the ordering of the level zero child elements
  import from Rep,MachineInteger;

  new(dt:DT(UCH),docEl:Element(UCH),ndList:Array(NodeRep(Node(UCH)))):% == {
    per([dt,docEl,ndList])
  }

  -- The Document Type Decleration associated with this document.
  doctype(doc:%):DocumentType(UCH) == rep(doc).dt;

  -- The DOMImplementation object that handles this document.
  implementation(doc:%):DOMImplementation(UCH) == error "not done (Document)";

  -- This is a convenience attribute that allows direct access to the childs
  -- node that is the root element of the document.
  documentElement(doc:%):Element(UCH) == rep(doc).del;

  -- set the dependance of the child nodes with there parent node
  setParents!(childs:NodeList(UCH),parent:Node(UCH)):NodeList(UCH) == {
    repchs:Array(Node(UCH)) := childs pretend Array(Node(UCH));
    for i in 0..length(childs)-1 repeat {
      repch := (repchs.i) pretend NodeRep(Node(UCH));
      repch.parentNode := [parent];
      repchs.i := repch pretend Node(UCH)
    }
    repchs pretend NodeList(UCH)
  }

  -- set interdependancies between the child nodes
  setSiblingIntdeps!(childs:NodeList(UCH)):NodeList(UCH) == {
    repchs:Array(Node(UCH)) := childs pretend Array(Node(UCH));
    -- set nextSibling attributes
    for i in 0..length(childs)-2 repeat {
      repch := (repchs.i) pretend NodeRep(Node(UCH));
      repch.nextSibling := [repchs.(i+1)]
    }
    -- set previousSibling attributes
    for i in 1..length(childs)-1 repeat {
      repch := (repchs.i) pretend NodeRep(Node(UCH));
      repch.previousSibling := [repchs.(i-1)]
    }
    repchs pretend NodeList(UCH)
  }

  setOwners!(attrs:NamedNodeMap(UCH),el:NodeRep(Node(UCH))):() == {
    for att in attrs repeat {
      (att pretend NodeRep(Node(UCH))).parentNode := [el pretend Node(UCH)]
    }
    ();
  }

  -- Creates an element of the type specified.
  createElement(nm:DOMString(UCH),attrs:NamedNodeMap(UCH),childs:NodeList(UCH)):Element(UCH) == {

    lc := length(childs);
    firstChild:Union(val:Node(UCH),failed:'failed') := if lc>0 then [item(childs,0)] else [failed];
    lastChild:Union(val:Node(UCH),failed:'failed') := if lc>0 then [item(childs,lc-1)] else [failed];

    ret:NodeRep(Node(UCH)) := [[attrs],[childs],firstChild,lastChild,[nm],[failed],[failed],[nm],[1],[failed],[failed],[failed],[failed],[failed]];
    -- set the parents of the child nodes
    setParents!(childs,ret pretend Node(UCH));
    -- set nextSibling and previousSibling attributes for each child
    setSiblingIntdeps!(childs);
    -- set the owner elements for the attributes
--    setOwners!(ret.attributes.val,ret);
    ret pretend Element(UCH);
  }

  -- Creates an empty DocumentFragment object.
  createDocumentFragment():DocumentFragment(UCH) == error "not done (Document)";

  -- Creates a Text node given the specified string.
  createTextNode(str:DOMString(UCH)):Text(UCH) == {
    ret:NodeRep(Node(UCH)) := [[failed],[failed],[failed],[failed],[failed],[failed],[failed],[failed],[3],[str],[failed],[failed],[failed],[failed]];
    ret pretend Text(UCH);
  }

  -- Creates a Comment node given the specified string.
  createComment(val:DOMString(UCH)):Comment(UCH) == {
    ret:NodeRep(Node(UCH)) := [[failed],[failed],[failed],[failed],[failed],[failed],[failed],[failed],[8],[val],[failed],[failed],[failed],[failed]];
    ret pretend Comment(UCH);
  }

  -- Creates a CDATASection node whos value is the specified string.
  createCDATASection(val:DOMString(UCH)):CDATASection(UCH) == {
    ret:NodeRep(Node(UCH)) := [[failed],[failed],[failed],[failed],[failed],[failed],[failed],[failed],[4],[val],[failed],[failed],[failed],[failed]];
    ret pretend CDATASection(UCH);
  }

  -- Creates a ProcessingInstruction node given the specified name and
  -- data strings.
  createProcessingInstruction(name:DOMString(UCH),data:DOMString(UCH)):ProcessingInstruction(UCH) == {
    ret:NodeRep(Node(UCH)) := [[failed],[failed],[failed],[failed],[failed],[failed],[failed],[name],[7],[data],[failed],[failed],[failed],[failed]];
    ret pretend ProcessingInstruction(UCH);
  }

  -- Creates an Attr of the given node.
  createAttribute(name:DOMString(UCH),val:DOMString(UCH)):Attr(UCH) == {
    ret:NodeRep(Node(UCH)) := [[failed],[failed],[failed],[failed],[name],[failed],[failed],[name],[2],[val],[failed],[failed],[failed],[failed]];
    ret pretend Attr(UCH);
  }

  -- Creates an EntityReference object. In addition, if the refernced entity
  -- is known, the child list of the EntityReference node is made the same
  -- as that of the corresponding Entity node.
  createEntityReference(str:DOMString(UCH)):EntityReference(UCH) == error "not done (Document)";

  -- Returns a NodeList of all the Elements with a given tag name in the 
  -- order in which they are encountered in a preorder traversal of the 
  -- Document tree.
  getElementsByTagName(lclName:DOMString(UCH),doc:Document(UCH)):NodeList(UCH) == error "not done (Document)";

  -- (introduced in DOM Level 2)
  -- Imports a node from another document to this document. The returned
  -- node has no parent; (parentNode is null). The source node is not
  -- altered or removed from the original document.
  importNode(nd:Node(UCH),fl:Boolean):Node(UCH) == error "not done (Document)";

  nl:DOMString(UCH) == [""];
  -- (introduced in DOM Level 2)
  -- Creates an element of the given qualified name and namespace URI.
  createElementNS(pre:DOMString(UCH),nm:DOMString(UCH),attrs:NamedNodeMap(UCH),childs:NodeList(UCH)):Element(UCH) == {

    lc := length(childs);
    firstChild:Union(val:Node(UCH),failed:'failed') := if lc>0 then [item(childs,0)] else [failed];
    lastChild:Union(val:Node(UCH),failed:'failed') := if lc>0 then [item(childs,lc-1)] else [failed];
    nodename:DOMString(UCH) := append(
      if pre=nl then nm else append(pre,[":"]),nm);

    ret:NodeRep(Node(UCH)) := [[attrs],[childs],firstChild,lastChild,[nm],[failed],[failed],[nodename],[1],[failed],[failed],[failed],[pre],[failed]];
    ret pretend Element(UCH);
  }

  -- (introduced in DOM Level 2)
  -- Creates an attribute of the given qualified name and namespace URI.
  createAttributeNS(pre:DOMString(UCH),loc:DOMString(UCH),val:DOMString(UCH)):Attr(UCH) == {
    nodename:DOMString(UCH) := append(
      if pre=nl then loc else append(pre,[":"]),loc);

    ret:NodeRep(Node(UCH)) := [[failed],[failed],[failed],[failed],[loc],[failed],[failed],[nodename],[2],[val],[failed],[failed],[pre],[failed]];
    ret pretend Attr(UCH);
  }

  -- (introduced in DOM Level 2)
  -- Returns a NodeList of all the Elements with a given local name and 
  -- namespace URI in the order in which they are encountered in a preorder
  -- traversal of the Document tree.
  getElementByTagNameNS(lclName:DOMString(UCH),prefix:DOMString(UCH),doc:Document(UCH)):NodeList(UCH) == error "not done (Document)";

  -- (introduced in DOM Level 2)
  -- Returns the Element whose ID is given by elementID. If no such element
  -- exists, returns null. Behaviour is not defined if more than one element
  -- has this ID.
  getElementById(id:DOMString(UCH),doc:Document(UCH)):Element(UCH) == error "not done (Document)";
}
