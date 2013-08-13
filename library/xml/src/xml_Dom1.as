#include "aldor"
--#include "aldorio"

-- xmlDom1.as contains domain definition for some domains in the XML DOM set
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

import from ULib,BasicLibrary,XMLBase,XMLCats,XMLD0;

M ==> Machine;
B ==> Boolean;
MI ==> MachineInteger;
TW ==> TextWriter;
PA ==> PrimitiveArray;
A ==> Array;

import from String;

REPATTR ==> Array(Union(val:Node(UCH),failed:'failed'));
ATTRIBUTES ==> Union(val:NamedNodeMap(UCH),failed:'failed');
CHILDNODES ==> Union(val:NodeList(UCH),failed:'failed');
FIRSTCHILD(Self) ==> Union(val:Self,failed:'failed');
LASTCHILD(Self) ==> Union(val:Self,failed:'failed');
LOCALNAME ==> Union(val:DOMString(UCH),failed:'failed');
NAMESPACEURI ==> Union(val:DOMString(UCH),failed:'failed');
NEXTSIBLING(Self) ==> Union(val:Self,failed:'failed');
NODENAME ==> Union(val:DOMString(UCH),failed:'failed');
NODETYPE ==> Union(val:MI,failed:'failed');
NODEVALUE ==> Union(val:DOMString(UCH),failed:'failed');
OWNERDOCUMENT ==> Union(val:Document(UCH),failed:'failed');
PARENTNODE(Self) ==> Union(val:Self,failed:'failed');
PREFIX ==> Union(val:DOMString(UCH),failed:'failed');
PREVIOUSSIBLING(Self) ==> Union(val:Self,failed:'failed');

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

define CreateAttrs(UCH:UniCodeCharacter):Category == with {
  new : (DOMString(UCH),DOMString(UCH)) -> %;
  new : (DOMString(UCH),DOMString(UCH),DOMString(UCH)) -> %;
}

define NewObject:Category == with {
  new : MI -> %;
    ++ create a new NamedNodeMap of a specified size
}

define ConvertibleFromNode(UCH:UniCodeCharacter):Category == with {
  retract : Node(UCH) -> %;
    ++ specialise a node to this domain
  default {
    retract(nd:Node(UCH)):% == nd pretend %
  }
}

define ConvertibleToNode(UCH:UniCodeCharacter):Category == with {
  cast : % -> Node(UCH);
    ++ convert from this domain to a node
  default {
    cast(dom:%):Node(UCH) == dom pretend Node(UCH)
  }
}

define NullaryNull:Category == with {
  null : () -> %;
}
define NullaryQuery:Category == with {
  null? : % -> B;
    ++ returns true if this node is null, false otherwise
}

extend Document(UCH:UniCodeCharacter): with NullaryNull == add {
  Rep ==> Node(UCH);
  null():% == {
--    import from Node(UCH) pretend NullaryNull;
    import from Node(UCH);
    per null();
  }
}

+++ extend the Node domain with the functionality which is specific to Nodes
extend Node(UCH:UniCodeCharacter) : Join(NodeCat(UCH),NodeEx(UCH),PrimitiveType,NullaryQuery) == add {

  Rep ==> NodeRep(%);
  import from Rep;

  -- The name of this node, depending on its type;
  nodeName(nd:%):DOMString(UCH) == {
    if not(rep(nd).nodeName case failed) then rep(nd).nodeName.val 
    else construct ""
  }

  -- The value of this node, depending on its type.
  nodeValue(nd:%):DOMString(UCH) == {
    if not(rep(nd).nodeValue case failed) then rep(nd).nodeValue.val 
    else construct ""
  }

  -- A code representing the type of the underlying object, as defined above
  nodeType(nd:%):MI == {
    if not(rep(nd).nodeType case failed) then rep(nd).nodeType.val else 0
  }

  -- The parent of this node. If a node has just been created and not yet 
  -- added to the tree, or if it has been removed from the tree, this is null
  parentNode(nd:%):% == {
    fc := rep(nd).parentNode;
    fc case failed => return(null());
    fc.val
  }

  -- The first child of this node. If there is no such node, this returns 
  -- null
  firstChild(nd:%):% == {
    fc := rep(nd).firstChild;
    fc case failed => return(null());
    fc.val
  }

  -- The last child of this node. If there is no such node, this returns 
  -- null
  lastChild(nd:%):% == {
    fc := rep(nd).lastChild;
    fc case failed => return(null());
    fc.val
  }

  -- The node immediately preceding this node. If there is no such node, 
  -- this returns null.
  previousSibling(nd:%):% == {
    fc := rep(nd).previousSibling;
    fc case failed => return(null());
    fc.val
  }

  -- The node immediately following this node. If there is no such node, 
  -- this returns null.
  nextSibling(nd:%):% == {
    fc := rep(nd).nextSibling;
    fc case failed => return(null());
    fc.val
  }

  -- (introduced in DOM Level 2)
  -- The namespace prefix of this node, or null if it is unspecified
  prefix(nd:%):DOMString(UCH) == {
    fc := rep(nd).prefix;
    fc case failed => return([""]);
    fc.val
  }

  -- (introduced in DOM Level 2)
  -- Returns the local part of the qualified name of this node.
  -- For nodes of any type other than ELEMENT_NODE and ATTRIBUTE_NODE and
  -- nodes created with a DOM Level1 method such as createElement from the 
  -- Document interface, this is allways null
  localName(nd:%):DOMString(UCH) == {
    fc := rep(nd).localName;
    fc case failed => return([""]);
    fc.val
  }

  -- (introduced in DOM Level 2)
  -- The namespace URI of this node, or null if it is unspecified
  namespaceURI(nd:%):DOMString(UCH) == {
    fc := rep(nd).namespaceURI;
    fc case failed => return([""]);
    fc.val
  }

  -- methods
  -- adds the node newChild to the end of the list of children of this node.
  -- If the newChild is allready on the tree, it is first removed.
  appendChild(node:%,newChild:%):% == {
    repn := rep node;rcnds := repn.childNodes;
    if rcnds case failed then {
      cnds:NodeList(UCH) := new();addChild(newChild,cnds);
      repn.childNodes := [cnds]
    } else {
      -- first see if newChild is on the tree
      for ch in rcnds.val for i in 0.. repeat
        -- if so remove it
        if ch=newChild then removeChild(i,node);
      -- add the new one;
      repn.childNodes := [addChild(newChild,rcnds.val)];}
    per repn
  }

  -- Returns whether this node has any children
  hasChildNodes(nd:%):Boolean == {
    rep(nd).childNodes case failed => false;
    length(rep(nd).childNodes.val)>0
  }

  -- Returns a duplicate of this node, i.e. serves as a generic copy 
  -- constructor for nodes. The duplicate node has no parent; (parentNode is
  -- null).
  -- Cloning an element copies all attributes and their values, including 
  -- those generated by the XML processorto represent defaulted attributes,
  -- but this method does not copy any text it contains unless it is a deep
  -- clone, since the text is contained in a child Text node. Cloning an
  -- attribute directly, as opposed to cloning as part of an Element cloning
  -- operation returns a specified attribute (specified is true). Cloning any
  -- other type of node simply returns a copy of this node.
  cloneNode(nd:%):% == {
    import from NamedNodeMap(UCH) pretend CopyableType;
    import from Attr(UCH) pretend Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH),CopyableType);
    default a:ATTRIBUTES;
    default ln:LOCALNAME;
    default uri:NAMESPACEURI;
    default nn:NODENAME;
    default nv:NODEVALUE;
    rnd := rep nd;
    if rnd.nodeType.val = ATTRIBUTE__NODE then 
      return cast copy(retract(nd)@Attr(UCH));
    if rnd.attributes case val then 
      rnd.attributes.val := copy(rnd.attributes.val);
    if rnd.localName case val then 
      rnd.localName.val := copy(rnd.localName.val);
    if rnd.namespaceURI case val then
      rnd.namespaceURI.val := copy(rnd.namespaceURI.val);
    if rnd.nodeName case val then 
      rnd.nodeName.val := copy(rnd.nodeName.val);
    if rnd.nodeValue case val then 
      rnd.nodeValue.val := copy(rnd.nodeValue.val);
    per rnd
  }

  -- Returns a duplicate of this node, where the children nodes are clones
  -- too. It has no parent, the cost of the operation is directly 
  -- proportional to the size of the tree beneath this node.
  deepCloneNode(x:%):% == {
    error "Deep cloning has not been implemented yet"
  }

  -- (introduced in DOM Level 2)
  -- Puts all text nodes in the full depth of the sub-tree underneath this 
  -- node, including attribute nodes, into a "normal" form where only
  -- structure seperates Text nodes.
  normalize(nd:%):% == error "normalize has not been implemented yet (Node)";

  -- (introduced in DOM Level 2)
  -- Tests whether the DOM implementation implements a specific feature and
  -- that feature is supported by this node.
  isSupported(str1:DOMString(UCH),str2:DOMString(UCH)):Boolean == error "not done (Node)";

  -- (introduced in DOM Level 2)
  -- Returns whether this node (if it is an element) has any attributes
  hasAttributes(nd:%):B == {
    import from NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH);
    rep(nd).attributes case failed => false;
    length(rep(nd).attributes.val)>0
  }

  -- A NodeList that contains all children of this node. If there are no 
  -- children, this is a NodeList containing no nodes
  childNodes(nd:%):NodeList(UCH) == {
    fc := rep(nd).childNodes;
    fc case failed => return(new());
    fc.val
  }

  -- A NamedNodeMap containing the attributes of this node (if it is an 
  -- element) or null otherwise
  attributes(nd:%):NamedNodeMap(UCH) == {
    import from NamedNodeMap(UCH) pretend NewObject;
    repnd := rep nd;
    nt := repnd.nodeType;
    if nt case failed or nt.val ~= 1 then return(new(0));
    natts := repnd.attributes;
    if natts case failed then return(new(0));
    natts.val
  }

  -- (introduced in DOM Level 2)
  -- The Document object associated with this node. This is also the 
  -- Document object used to create new nodes. When this node is a Document 
  -- or a DocumentType which is not used with any Document yet, this is null
  ownerDocument(nd:%):Document(UCH) == {
    import from Document(UCH) pretend NullaryNull;
    nrep := rep nd;
    nrep.ownerDocument case failed => return null();
    nrep.ownerDocument.val}

  -- Inserts the node newChild (the first parameter) before the existing 
  -- child node refChild (the second parameter). If refChild is null, insert 
  -- newChild at the end of the list of children.<XML><BR></XML>
  -- If newChild is a Document Fragment object, all of its children are 
  -- inserted, in the same order before refChild. If the newChild is already
  -- in the tree, it is first removed.
  insertBefore(newChild:%,refChild:MI,parent:%):() == {
    repparent := rep parent;pcns := repparent.childNodes;
    pcns case failed => {
      repparent.childNodes := [addChild(newChild,new())];
      -- *** must set parent !!!
      return
    }
    cl:NodeList(UCH) := new();pcnsv := pcns.val;

    l := length(pcnsv);
    -- create the NodeList before the refchild
    for i in 0..(refChild-1) repeat {
--    while refChild ~= (nch := item(pcnsv,i)) repeat {
      nch := item(pcnsv,i);
      addChild(nch,cl);
--      i := i+1;
    }
    -- add the new child
    addChild(newChild,cl);
    -- add the rest of the NodeList
    for j in refChild..(l-1) repeat addChild(item(pcnsv,j),cl);
    repparent.childNodes := [cl];
    ()
  }

  -- replaces the child node oldChild (the second parameter) with newChild
  -- (the first parameter) in the list of children.
  replaceChild(newChild:%,oldChild:MI,parent:%):() == {
    rp := rep parent;cns := rp.childNodes;
    cns case failed => error "the parent node has no child nodes";
    cnsv := cns.val;
    cnsv.oldChild := newChild;
    ()
  }

  -- Removes the child node indicated by oldChild from the list of children,
  -- returns null.
  removeChild(oldChild:MI,parent:%):() == {
    import from Array(Node(UCH));
    r := rep(parent); c := r.childNodes;fl := true;
    c case failed => return;
    c2 := c.val;
    l := length(c2);
    if l=1 and oldChild=0 then r.childNodes := [failed];
    cn := c2 pretend Array(Node(UCH));
    for i in oldChild..(l-2) repeat  cn.i := cn.(i+1);
    resize!(cn,l-1);
    ()
  }

  -- returns a null node
  null():% == per [[failed],[failed],[failed],[failed],[failed],[failed],[failed],[failed],[0],[failed],[failed],[failed],[failed],[failed]];

  null?(n:%):B == {
    nt := rep(n).nodeType;
    nt case failed or nt.val=0
  }

  (x:%) = (y:%):B == {
    import from NamedNodeMap(UCH) pretend PrimitiveType;
    (rx,ry) := (rep x,rep y);ret := false;
    if rx.attributes case failed and ry.attributes case failed and not ret then ret := true
    else if rx.attributes case val and ry.attributes case val then {if (rx.attributes.val) ~= (ry.attributes.val) then return false} else return false;
    if rx.childNodes case failed and ry.childNodes case failed and not ret then ret := true
    else if rx.childNodes case val and ry.childNodes case val then {if (rx.childNodes.val) ~= (ry.childNodes.val) then return false} else return false;
    if rx.firstChild case failed and ry.firstChild case failed and not ret then ret := true
    else if rx.firstChild case val and ry.firstChild case val then {if (rx.firstChild.val) ~= (ry.firstChild.val) then return false} else return false;
    if rx.lastChild case failed and ry.lastChild case failed and not ret then ret := true
    else if rx.lastChild case val and ry.lastChild case val then {if (rx.lastChild.val) ~= (ry.lastChild.val) then return false} else return false;
    if rx.localName case failed and ry.localName case failed and not ret then ret := true
    else if rx.localName case val and ry.localName case val then {if (rx.localName.val) ~= (ry.localName.val) then return false} else return false;
    if rx.namespaceURI case failed and ry.namespaceURI case failed and not ret then ret := true
    else if rx.namespaceURI case val and ry.namespaceURI case val then {if (rx.namespaceURI.val) ~= (ry.namespaceURI.val) then return false} else return false;
    if rx.nextSibling case failed and ry.nextSibling case failed and not ret then ret := true
    else if rx.nextSibling case val and ry.nextSibling case val then {if (rx.nextSibling.val) ~= (ry.nextSibling.val) then return false} else return false;
    if rx.nodeName case failed and ry.nodeName case failed and not ret then ret := true
    else if rx.nodeName case val and ry.nodeName case val then {if (rx.nodeName.val) ~= (ry.nodeName.val) then return false} else return false;
    if rx.nodeType case failed and ry.nodeType case failed and not ret then ret := true
    else if rx.nodeType case val and ry.nodeType case val then {if (rx.nodeType.val) ~= (ry.nodeType.val) then return false} else return false;
    if rx.nodeValue case failed and ry.nodeValue case failed and not ret then ret := true
    else if rx.nodeValue case val and ry.nodeValue case val then {if (rx.nodeValue.val) ~= (ry.nodeValue.val) then return false} else return false;
--    if rx.ownerDocument case failed and ry.ownerDocument case failed and not ret then ret := true
--    else if rx.ownerDocument case val and ry.ownerDocument case val then {if (rx.ownerDocument.val) ~= (ry.ownerDocument.val) then return false} else return false;
    if rx.parentNode case failed and ry.parentNode case failed and not ret then ret := true
    else if rx.parentNode case val and ry.parentNode case val then {if (rx.parentNode.val) ~= (ry.parentNode.val) then return false} else return false;
    if rx.prefix case failed and ry.prefix case failed and not ret then ret := true
    else if rx.prefix case val and ry.prefix case val then {if (rx.prefix.val) ~= (ry.prefix.val) then return false} else return false;
    if rx.previousSibling case failed and ry.previousSibling case failed and not ret then ret := true
    else if rx.previousSibling case val and ry.previousSibling case val then {if (rx.previousSibling.val) ~= (ry.previousSibling.val) then return false} else return false;
    ret
  }
}

--extend Attr(UCH:UniCodeCharacter):NodeCat(UCH) == Node(UCH);

+++ extend the Attr domain with the functionality which is specific to Attr's
extend Attr(UCH:UniCodeCharacter):AttrCat(UCH) with Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH),CreateAttrs(UCH),CopyableType) == add {
--extend Attr(UCH:UniCodeCharacter):AttrCat(UCH) with Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH),CreateAttrs(UCH)) == add {

  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  -- Returns the name of this attribute
  name(atr:%):DOMString(UCH) == {
    atrNm := rep(atr).nodeName;
    atrNm case failed => error "attribute has no name - invalid attribute object";
    atrNm.val
  }

  -- If this attribute was explicitly given a value in the original document,
  -- this is true; otherwise it is false.
  specified(attr:%):Boolean == error "not done (Attr)";

  -- On retrieval, the value of the attribute is returned as a string.
  -- Character and general entity references are replaced with their values.
  value(attr:%):DOMString(UCH) == {
    atrVal := rep(attr).nodeValue;
    atrVal case failed => error "attribute has no value - invalid attribute object";
    atrVal.val
  }

  -- The Element node this attribute is attached to, or null if this 
  -- attribute is not in use.
  ownerElement(attr:%):Element(UCH) == {
    import from Element(UCH) pretend Join(ConvertibleFromNode(UCH),NullaryNull);
    atrOE := rep(attr).parentNode;
    atrOE case failed => return(null());
    retract(atrOE.val)
  }

  -- attach this attribute to an element
  setOwnerElement(attr:%,parent:Element(UCH)):% == {
    import from Node(UCH),Element(UCH) pretend ConvertibleToNode(UCH);
    rep(attr).parentNode := [cast parent];
    attr
  }

  new(name:DOMString(UCH),val:DOMString(UCH)):% == {
    per [[failed],[failed],[failed],[failed],[name],[failed],[failed],[failed],[2],[val],[failed],[failed],[failed],[failed]];
  }

  new(pre:DOMString(UCH),name:DOMString(UCH),val:DOMString(UCH)):% == {
    per [[failed],[failed],[failed],[failed],[name],[failed],[failed],[failed],[2],[val],[failed],[failed],[pre],[failed]];
  }

  copy(at:%):% == {
    repat := rep at;
    if repat.prefix case val then
      new(copy repat.prefix.val,copy repat.localName.val,copy repat.nodeValue.val)
    else
      new(copy repat.localName.val,copy repat.nodeValue.val)
  }
}

+++ extend the Element domain with the functionality which is specific to Element's
extend Element(UCH:UniCodeCharacter):ElementCat(UCH) with Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH),NullaryNull) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Machine,Rep;

  -- The name of the element.
  tagName(el:%):DOMString(UCH) == {
    repel := rep(el);relp := repel.prefix;rel := repel.localName;
    relp case failed => {
      rel case failed => error "invalid element";
      return(rel.val);}
    append(append(relp.val,[":"]),rel.val)
  }

  -- Retrieves an attribute value by name. If the attribute does not exist 
  -- returns ""
  getAttribute(el:%,nm:DOMString(UCH)):DOMString(UCH) == {
    import from Node(UCH) pretend NullaryQuery,NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH);

    atts := rep(el).attributes;
    atts case failed => return [""];
    attsnm:NamedNodeMap(UCH) := atts.val;
    nd:Node(UCH) := getNamedItem(attsnm,nm);
    null? nd => [""];
    (nd pretend NodeRep(Node(UCH))).nodeValue.val;
  }

  -- Adds a new attribute. If an attribute with that name is allready present
  -- in the element, its value is changed to be that of the parameter. This
  -- value is a simple string.
  setAttribute(el:%,name:DOMString(UCH),newVal:DOMString(UCH)):Attr(UCH) == {
    import from Document(UCH),Node(UCH),
      Attr(UCH) pretend Join(CreateAttrs(UCH),ConvertibleToNode(UCH)),
      NamedNodeMap(UCH) pretend Join(NamedNodeMapCat(UCH),NewObject);
    rel := rep el;
    atts := rel.attributes;
    newatt:Attr(UCH) := new(name,newVal);newAtt:Node(UCH) := cast newatt;
    atts case failed => {
      attsv:NamedNodeMap(UCH) := new(0);setNamedItem(attsv,newAtt);
      rel.attributes := [attsv];return(newatt);
    }
    setNamedItem(rel.attributes.val,newAtt);
    newatt
  }

  -- removes an attribute by name. If the removed attribute is known to have
  -- a default value an attribute immediately appears containing the default 
  -- value as well as the corresponding namespace URI, local name and prefix
  -- when applicable.
  removeAttribute(el:%,nm:DOMString(UCH)):Attr(UCH) == {
    import from REPATTR,
      Attr(UCH) pretend ConvertibleFromNode(UCH),Node(UCH) pretend NullaryNull,
      NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH);
    rel := rep el;ret:Attr(UCH) := null()@Node(UCH) pretend Attr(UCH);
    pos:MI := -1;
    -- find the position of the attribute
    for i in 0.. for u in (rel.attributes.val pretend Array(Union(val:Node(UCH),failed:'failed'))) repeat {
      if u case val then 
        if (u.val pretend NodeRep(Node(UCH))).localName case val and
          (u.val pretend NodeRep(Node(UCH))).localName.val = nm then {
            pos := i;ret := (u.val pretend Attr(UCH));break;}
    }
    if pos = -1 then return ret;
    for i in pos+1..#((rel.attributes.val) pretend REPATTR) repeat (rel.attributes.val pretend REPATTR).(i-1) := (rel.attributes.val pretend REPATTR).i;
    resize!(rel.attributes.val pretend REPATTR,length(rel.attributes.val)-1);
    ret
  }

  -- (introduced in DOM Level 2)
  -- Retrieves an attribute value by local name and namespace URI.
  getAttributeNS(el:%,pre:DOMString(UCH),ln:DOMString(UCH)):DOMString(UCH) == {
    import from NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH);
    atts := rep(el).attributes;
    atts case failed => return [""];
    attsnm := atts.val;
    nd:Node(UCH) := getNamedItemNS(attsnm,pre,ln);
    (nd pretend NodeRep(Node(UCH))).nodeValue.val;
  }

  -- (introduced in DOM Level 2)
  -- Adds a new attribute. If an attribute with the same local name and 
  -- namespace URI is already present on the element, its prefix is changed 
  -- to be the prefix part of the qualifiedName and its value changed to be
  -- the value parameter.
  setAttributeNS(el:%,pre:DOMString(UCH),ln:DOMString(UCH),value:DOMString(UCH)):Attr(UCH) == {
    import from Document(UCH),Node(UCH),
      Attr(UCH) pretend Join(CreateAttrs(UCH),ConvertibleToNode(UCH)),
      NamedNodeMap(UCH) pretend Join(NamedNodeMapCat(UCH),NewObject);
    rel := rep el;
    atts := rel.attributes;
    newatt:Attr(UCH) := new(pre,ln,value);newAtt:Node(UCH) := cast newatt;
    atts case failed => {
      attsv:NamedNodeMap(UCH) := new(0);setNamedItemNS(attsv,newAtt);
      rel.attributes := [attsv];return(newatt);
    }
    setNamedItemNS(rel.attributes.val,newAtt);
    newatt
  }

  -- (introduced in DOM Level 2)
  -- Removes an attribute by local name and namespace URI. If the removed 
  -- attribute has a default value it is replaced. The replaceing attribute 
  -- has the same namespace URI and local name, as well as the original 
  -- prefix.
  removeAttributeNS(el:%,pre:DOMString(UCH),ln:DOMString(UCH)):Attr(UCH) == {
    import from REPATTR,Attr(UCH) pretend ConvertibleFromNode(UCH),
      Node(UCH) pretend NullaryNull,
      NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH);
    rel := rep el;ret:Attr(UCH) := null()@Node(UCH) pretend Attr(UCH);
    pos:MI := -1;
    -- find the position of the attribute
    for i in 0.. for u in (rel.attributes.val pretend Array(Union(val:Node(UCH),failed:'failed'))) repeat {
      -- *** of course we must check u.val... for case failed too ***
      if u case val and (u.val pretend NodeRep(Node(UCH))).localName case val and (u.val pretend NodeRep(Node(UCH))).localName.val = ln and (u.val pretend NodeRep(Node(UCH))).prefix.val=pre then {
        pos := i;ret := (u.val pretend Attr(UCH));break;}
    }
    if pos = -1 then return ret;
    for i in pos+1..#((rel.attributes.val) pretend REPATTR) repeat (rel.attributes.val pretend REPATTR).(i-1) := (rel.attributes.val pretend REPATTR).i;
    resize!(rel.attributes.val pretend REPATTR,length(rel.attributes.val)-1);
    ret
  }

  -- Returns true when an attribute with a given name is specified on this
  -- element or has a default value, returns false otherwise.
  hasAttribute(el:%,str:DOMString(UCH)):Boolean == {
    import from NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH),
      Node(UCH) pretend NodeCat(UCH);
    rel := rep el;
    atts := rel.attributes;
    atts case failed => return false;
    attsv := atts.val;
    for i in 0..length(attsv) repeat {
      att := item(attsv,i);
      localName att = str => return true;
    }
    false
  }

  -- (introduced in DOM Level 2)
  -- Returns true when an attribute with a given local name and namespace URI
  -- is specified on this element or has a default value, returns false 
  -- otherwise.
  hasAttributeNS(el:%,pre:DOMString(UCH),ln:DOMString(UCH)):Boolean == {
    import from NamedNodeMap(UCH) pretend NamedNodeMapCat(UCH),
      Node(UCH) pretend NodeCat(UCH);
    rel := rep el;
    atts := rel.attributes;
    atts case failed => return false;
    attsv := atts.val;
    for i in 0..length(attsv) repeat {
      att := item(attsv,i);
      localName att = ln and prefix att = pre => return true;
    }
    false
  }

-- -- Retrieves an attribute node by name.
--  getAttributeNode(el:%,str:DOMString(UCH)):Attr(UCH) == {
--    import from Attr(UCH) pretend ConvertibleFromNode(UCH);
--    rel := rep el;
--    atts := rel.attributes;
--    atts case failed => return retract null();
--    attsv := atts.val;
--    for i in 0..length(attsv) repeat {
--      att := item(attsv,i);
--      if localName att = str then return retract att;
--    }
--    retract null()
--  }
--
--  -- Adds a new attribute node. If an attribute with that name (nodename) is
--  -- allready present in the element, it is replaced by the new one.
--  setAttributeNode(el:%,att:Attr(UCH)):Attr(UCH) == error "not done (Element)";
--
--  -- Removes an attribute by name. If the removed attribute is known to have
--  -- a default value, an attribute immediately appears containing the default
--  -- value as well as the corresponding namespace URI, local name, and prefix
--  -- when applicable.
--  removeAttributeNode(el:%,att:Attr(UCH)):Attr(UCH) == error "not done (Element)";

  -- Returns a NodeList of all descendant Elements with a given tag name, in
  -- the order in which they are encountered.
  getElementsByTagName(el:%,str:DOMString(UCH)):NodeList(UCH) == {
    import from Node(UCH) pretend NodeCat(UCH);
    nl:NodeList(UCH) := new();
    kids:NodeList(UCH) :=childNodes cast el;
    for kid in kids repeat {
     if localName(kid)=str then addChild(kid,nl)
    }
    nl
  }

--  -- (introduced in DOM Level 2)
--  -- Retrieves an Attr node by local name and namespace URI.
--  getAttributeNodeNS(el:%,str1:DOMString(UCH),str2:DOMString(UCH)):Attr(UCH) == error "not done (Element)";

--  -- (introduced in DOM Level 2)
--  -- Adds a new attribute. If an attribute with that local name and that name
--  -- space URI is already present in the element, it is replaced by the new 
--  -- one.
--  setAttributeNodeNS(el:%,att:Attr(UCH)):Attr(UCH) == error "not done (Element)";

  -- (introduced in DOM Level 2)
  -- Returns a NodeList of all the descending Elements with a given local 
  -- name and namespace URI in the order in which they are encountered in a 
  -- preorder traversal of this Element tree.
  getElementsByTagNameNS(el:%,str1:DOMString(UCH),str2:DOMString(UCH)):NodeList(UCH) == {
    import from Node(UCH) pretend NodeCat(UCH);
    nl:NodeList(UCH) := new();
    kids:NodeList(UCH) :=childNodes cast el;
    for kid in kids repeat {
     if prefix(kid)=str1 and localName(kid)=str2 then addChild(kid,nl)
    }
    nl
  }

  null():% == {
    import from NamedNodeMap(UCH) pretend NewObject;
    per [[new(0)],[new()],[failed],[failed],[[""]],[[""]],[failed],[[""]],[1],[[""]],[failed],[failed],[[""]],[failed]]
  }
}

extend NamedNodeMap(UCH:UniCodeCharacter):NamedNodeMapCat(UCH) with Join(PrimitiveType,NewObject,CopyableType,Generatable(UCH)) == add {
--extend NamedNodeMap(UCH:UniCodeCharacter):NamedNodeMapCat(UCH) with Join(PrimitiveType,NewObject,Generatable(UCH)) == add {
  Rep ==> A(Union(val:Node(UCH),failed:'failed'));
  import from Rep,Union(val:Node(UCH),failed:'failed');

  copy(x:%):% == {
    import from MI,Node(UCH) pretend NodeCat(UCH);
    local ret:Rep := new(#rep(x));
    for i in 0..(#rep(x)-1) repeat {
      u := rep(x).i;
      if u case failed then ret.i := [failed] else ret.i := [cloneNode(u.val)];
    }
    per ret
  }

  generator(x:%):Generator(Node(UCH)) == {
    import from A(Node(UCH)),MI,Node(UCH) pretend NullaryNull;
    repx := rep x;
    generator(
      ar:Array(Node(UCH)) := new(#repx-1);
      for i in 0..(#repx-1) repeat 
        ar.i := if repx.i case val then repx.i.val else null();
      ar
    )
--    generator([if i case val then i.val else null() for i in rep(x)@Rep]@A(Node(UCH)));
  }

  (x:%) = (y:%):B == {
    import from MI,Node(UCH) pretend PrimitiveType;
    (xrep,yrep) := (rep x,rep y);
    #xrep ~= #yrep => return false;
    for ex in xrep for ey in yrep repeat {
		 -- XXX: this doesn't compile
      --if not(xor(ex case failed,ey case failed)) then return false;
      if ex case failed then iterate;
      if (ex.val) ~= (ey.val) then return false
    }
    true
  }

  -- The number of nodes in this map
  length(nnm:%):MI == #(rep nnm);

  -- Retrieves a Node specified by nodeName. If no node exists with that name 
  -- returns null()
  getNamedItem(nnm:%,nodeName:DOMString(UCH)):Node(UCH) == {
    import from Node(UCH) pretend Join(NodeCat(UCH),NodeEx(UCH));
    rnnm := rep nnm;
    for nd in rnnm repeat {
      if nd case failed then iterate;
      ndr := nd pretend NodeRep(Node(UCH));
      if localName(nd.val)=nodeName then return(nd.val)
--      ndr.localName case failed => error "invalid attribute value";
--      if ndr.localName.val=nodeName then return(nd.val);
    }
    null()
  }

  -- Adds a node using its nodeName attribute. If a node with that name 
  -- is already present in this map, it is replaced by the new one
  setNamedItem(ndm:%,nd:Node(UCH)):Node(UCH) == {
    import from MI,Node(UCH) pretend NodeCat(UCH);
    nmr:Rep := rep ndm;
    nm:DOMString(UCH) := localName(nd);
    notfound:B := true;
    for n in nmr for i in 0.. repeat {
      if n case val then {
        if localName(n.val)=nm then {
          notfound := false;
          set!(nmr,i,[nd])
        }}
    }
    if notfound then {
      l := #nmr;resize!(nmr,l+1);nmr.l := [nd];
    }
    nd
  }

  -- Removes a node specified by name. When this map contains the attributes
  -- attached to an element, if the removed attribute is known to have a 
  -- default value, an attribute immediately appears containing the default
  -- value as well as the corresponding namespace URI, local name and prefix
  -- when applicable
  removeNamedItem(nnm:%,name:DOMString(UCH)):Node(UCH) == {
    import from MI,NodeRep(Node(UCH));
    rnnm := rep nnm;
    ret:Rep := new(#rnnm);i := 0;j := 0;
    for u in rnnm repeat {
      if not(u case failed or (u.val pretend NodeRep(Node(UCH))).localName.val =name) then {
        ret.i := rnnm.j;i := i+1;
      }
      if not((u.val pretend NodeRep(Node(UCH))).localName case failed) and (u.val pretend NodeRep(Node(UCH))).localName.val=name then retv := rnnm.j;
      j := j+1;
    }
    retv pretend Node(UCH)
  }

  -- Returns the indexth item in the map (where index is the parameter). If
  -- index is greater or equal to the number of nodes in this map, this 
  -- returns null.
  item(nnm:%,pos:MI):Node(UCH) == {
    import from Node(UCH) pretend NodeEx(UCH);
    pos >= length(nnm) => return(null()$(Node(UCH) pretend NodeEx(UCH)));
    itm := rep(nnm).(pos);
    itm case failed => error "attempting to access an unintialised NamedNodeMap";
    itm.val;
  }

  -- (introduced in DOM Level 2)
  -- Retrieves a node specified by local name and namespace URI. HTML-only
  -- DOM implementations do not need to implement this method
  getNamedItemNS(nodeMap:%,pre:DOMString(UCH),localName:DOMString(UCH)):Node(UCH) == {
    import from Node(UCH) pretend Join(NodeCat(UCH),NodeEx(UCH));
    rnnm := rep nodeMap;
    for nd in rnnm repeat {
      if nd case failed then iterate;
      ndr := nd pretend NodeRep(Node(UCH));
      if localName(nd.val)=localName and prefix(nd.val)=pre then return(nd.val)
    }
    null()
  }

  -- (introduced in DOM Level 2)
  -- Adds a node using its namespaceURI and localName. If a node with that
  -- namespace URI and that local name is already present in this map, it is
  -- replaced by the new one.
  setNamedItemNS(nodeMap:%,nd:Node(UCH)):Node(UCH) == {
    import from MI,Node(UCH) pretend NodeCat(UCH);
    nmr:Rep := rep nodeMap;
    nm:DOMString(UCH) := localName(nd);pre := prefix nd;
    notfound:B := true;
    for n in nmr for i in 0.. repeat {
      if n case val then {
        if localName(n.val)=nm and prefix(n.val)=pre then {
          notfound := false;
          set!(nmr,i,[nd])
        }}
    }
    if notfound then {
      l := #nmr;resize!(nmr,l+1);nmr.l := [nd];
    }
    nd
  }

  -- (introduced in DOM Level 2)
  -- Removes a node specified by local name and namespace URI. A removed
  -- attribute may be known to have a default value when this map contains 
  -- the attributes attached to an element, as returned by the attributes
  -- attribute of the node interface. If so an attribute immediately appears 
  -- containing the default value as well as the corresponding namespace URI,
  -- local name and prefix when applicable. HTML-only DOM implementations do 
  -- not need to implement this method
  removeNamedItemNS(nodeMap:%,pre:DOMString(UCH),name:DOMString(UCH)):Node(UCH) == {
    import from MI,NodeRep(Node(UCH));
    rnnm := rep nodeMap;
    ret:Rep := new(#rnnm);i := 0;j := 0;
    for u in rnnm repeat {
      if not(u case failed or (u.val pretend NodeRep(Node(UCH))).localName.val =name) then {
        ret.i := rnnm.j;i := i+1;
      }
      if not((u.val pretend NodeRep(Node(UCH))).localName case failed) and (u.val pretend NodeRep(Node(UCH))).localName.val=name and not((u.val pretend NodeRep(Node(UCH))).prefix case failed) and (u.val pretend NodeRep(Node(UCH))).prefix.val=pre then retv := rnnm.j;
      j := j+1;
    }
    retv pretend Node(UCH)
  }

  -- make a new NamedNodeMap of specified type
  new(len:MI):% == {
    per([[failed] for i in 1..len]$Rep)
  }
}

--extend Text(UCH:UniCodeCharacter):NodeCat(UCH) == Node(UCH);

extend Text(UCH:UniCodeCharacter):Join(TextCat(UCH),CharacterDataCat(UCH),ConvertibleToNode(UCH),ConvertibleFromNode(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Machine,Rep;

  -- Breaks this node into two nodes at the specified offset, returning both as
  -- a tuple
  splitText(txt:%,pos:MI):NodeList(UCH) == {
    import from Document(UCH) pretend DocumentCat(UCH);
    t:Tuple(DOMString(UCH)) := split(rep(txt).nodeValue.val,pos);
    (v1,v2) := (element(t,1),element(t,2));
--    (createTextNode v1,createTextNode v2)
    nl:NodeList(UCH) := new();
    tn1:NodeRep(Node(UCH)) := null()$(Node(UCH) pretend NullaryNull) pretend NodeRep(Node(UCH));
    tn1.nodeType := [3];tn1.nodeValue := [v1];
    tn2:NodeRep(Node(UCH)) := null()$(Node(UCH) pretend NullaryNull) pretend NodeRep(Node(UCH));
    tn2.nodeType := [3];tn2.nodeValue := [v2];
    addChild(cast(tn1 pretend Text(UCH)),nl);
    addChild(cast(tn2 pretend Text(UCH)),nl);
    nl
  }

  data(t:%):DOMString(UCH) == {
    nv := rep(t).nodeValue;
    if nv case failed then [""] else nv.val}

  length(t:%):MI == {
    nv := rep(t).nodeValue;
    if nv case failed then 0 else #(nv.val)}

  substringData(t:%,spos:MI,fpos:MI):DOMString(UCH) == 
    substring(data t,spos,fpos);

  appendData(t:%,str:DOMString(UCH)):() == {
    rt := rep t;
    rt.nodeValue case failed => {
      rt.nodeValue := [str];return}
    rt.nodeValue := [append(rt.nodeValue.val,str)]; 
    ()
  }

  insertData(t:%,pos:MI,str:DOMString(UCH)):() == {
    rt := rep t;
    rt.nodeValue case failed => {
      rt.nodeValue := [str];return}
    rt.nodeValue := [insert!(rt.nodeValue.val,str,pos)]; 
    ()
  }

  deleteData(t:%,spos:MI,fpos:MI):() == {
    rt := rep t;
    rt.nodeValue case failed => return;
    rt.nodeValue := [deleteString!(rt.nodeValue.val,spos,fpos)]; 
    ()
  }

  replaceData(t:%,spos:MI,fpos:MI,str:DOMString(UCH)):() == {
    rt := rep t;
    rt.nodeValue case failed => return;
    rt.nodeValue := [replaceString!(rt.nodeValue.val,str,spos,fpos)]; 
    ()
  }
}

+++ The ProcessingInstruction interface represents a "processing instruction",
+++ used in XML as a way to keep processor-specific information in the text 
+++ of the document
extend ProcessingInstruction(UCH:UniCodeCharacter) : Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH),ProcessingInstructionCat(UCH)) == add {
  Rep ==> NodeRep(Node(UCH));
  import from Rep;

  target(nd:%):DOMString(UCH) == rep(nd).nodeName.val;
  data(nd:%):DOMString(UCH) == rep(nd).nodeValue.val;
}

extend Comment(UCH:UniCodeCharacter) : Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH)) == add{}

extend CDATASection(UCH:UniCodeCharacter) : Join(ConvertibleToNode(UCH),ConvertibleFromNode(UCH)) == add{}
