#include "aldor"
--#include "aldorio"

-- xmlbasiccats.as contains category definitions for domains in the XML DOM set
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

import from ULib,BasicLibrary,XMLBase;

M ==> Machine;
B ==> Boolean;
MI ==> MachineInteger;

import from String;

+++ This Category exports constants intended to indicate DOM errors
define DOMExceptionCat : Category == with {
  import from MI;
  INDEX__SIZE__ERR : MI;
    ++ If an index or size is negative or greater than the allowed value
  DOMSTRING__SIZE__ERR : MI;
    ++ If the specified range of text does not fit into a DOMString
  HIERARCHY__REQUEST__ERR : MI;
    ++ If any node is inserted somewhere it doesn't belong
  WRONG__DOCUMENT__ERR : MI;
    ++ If a node is used in a different document than the one that created it
  INVALID__CHARACTER__ERR : MI;
    ++ If an invalid or illegal character is specified, such as in a name. See
    ++ production 2 in the XML specification for the definition of a legal 
    ++ character and production 5 for the definition of a legal name character.
  NO__DATA__ALLOWED__ERR : MI;
    ++ If data is specified for a node which does not support data.
  NO__MODIFICATION__ERR : MI;
    ++ If an attempt is made to modify an object where modifications are not 
    ++ allowed
  NOT__FOUND__ERR : MI;
    ++ If an attempt is made to reference a node in a context where it does 
    ++ not exist
  NOT__SUPPORTED__ERR : MI;
    ++ If the implementation does not support the type of object requested
  INUSE__ATTRIBUTE__ERR : MI;
    ++ If an attempt is made to add an attribute that is allready in use
    ++ elsewhere
  INVALID__STATE__ERR : MI;
    ++ (introduced in DOM Level 2)
    ++ If an attempt is made to use an object that is not, or is no longer 
    ++ useable
  SYNTAX__ERR : MI;
    ++ (introduced in DOM Level 2)
    ++ If an invalid or illegal string is specified
  INVALID__MODIFICATION__ERR : MI;
    ++ (introduced in DOM Level 2)
    ++ If an attempt is made to modify the type of the underlying object
  NAMESPACE__ERR : MI;
    ++ (introduced in DOM Level 2)
    ++ If an attempt is made to create or change an object in a way which is
    ++ incorrect with regard to namespaces
  INVALID__ACCESS__ERR : MI;
    ++ (introduced in DOM Level 2)
    ++ If a parameter or an operation is not supported by the underlying object

  default {
    import from MI;
    INDEX__SIZE__ERR : MI == 1;
    DOMSTRING__SIZE__ERR : MI == 2;
    HIERARCHY__REQUEST__ERR : MI == 3;
    WRONG__DOCUMENT__ERR : MI == 4;
    INVALID__CHARACTER__ERR : MI == 5;
    NO__DATA__ALLOWED__ERR : MI == 6;
    NO__MODIFICATION__ERR : MI == 7;
    NOT__FOUND__ERR : MI == 8;
    NOT__SUPPORTED__ERR : MI == 9;
    INUSE__ATTRIBUTE__ERR : MI == 10;
    INVALID__STATE__ERR : MI == 11;
    SYNTAX__ERR : MI == 12;
    INVALID__MODIFICATION__ERR : MI == 13;
    NAMESPACE__ERR : MI == 14;
    INVALID__ACCESS__ERR : MI == 15;
}}

+++ The Node type is the primary datatype for the DOM. It represents a single 
+++ node in the document tree.
define NodeCat(UCH:UniCodeCharacter):Category == with {
  -- constants to specify the different node types
  ELEMENT__NODE : MI;
    ++ The node is an Element
  ATTRIBUTE__NODE : MI;
    ++ The node is an Attr
  TEXT__NODE : MI;
    ++ The node is a Text node
  CDATA__SECTION__NODE : MI;
    ++ The node is a CDATA section
  ENTITY__REFERENCE__NODE : MI;
    ++ The node is an EntityReference
  ENTITY__NODE : MI;
    ++ The node is an Entity
  PROCESSING__INSTRUCTION__NODE : MI;
    ++ The node is a ProcessingInstruction
  COMMENT__NODE : MI;
    ++ The node is a Comment
  DOCUMENT__NODE : MI;
    ++ The node is a Document
  DOCUMENT__TYPE__NODE : MI;
    ++ The node is a DocumentType
  DOCUMENT__FRAGMENT__NODE : MI;
    ++ The node is a DocumentFragment
  NOTATION__NODE : MI;
    ++ The node is a Notation

  -- attributes
  nodeName : % -> DOMString(UCH);
    ++ The name of this node, depending on its type; see the table above.
  nodeValue : % -> DOMString(UCH);
    ++ The value of this node, depending on its type. When it is defined to 
    ++ be null, setting it has no effect
  nodeType : % -> MI;
    ++ A code representing the type of the underlying object, as defined above
  parentNode : % -> %;
    ++ The parent of this node. If a node has just been created and not yet 
    ++ added to the tree, or if it has been removed from the tree, this is null
  firstChild : % -> %;
    ++ The first child of this node. If there is no such node, this returns 
    ++ null
  lastChild : % -> %;
    ++ The last child of this node. If there is no such node, this returns 
    ++ null
  previousSibling : % -> %;
    ++ The node immediately preceding this node. If there is no such node, 
    ++ this returns null.
  nextSibling : % -> %;
    ++ The node immediately following this node. If there is no such node, 
    ++ this returns null.
  prefix : % -> DOMString(UCH);
    ++ (introduced in DOM Level 2)
    ++ The namespace prefix of this node, or null if it is unspecified
  localName : % -> DOMString(UCH);
    ++ (introduced in DOM Level 2)
    ++ Returns the local part of the qualified name of this node.
    ++ For nodes of any type other than ELEMENT_NODE and ATTRIBUTE_NODE and
    ++ nodes created with a DOM Level1 method such as createElement from the 
    ++ Document interface, this is allways null
  namespaceURI : % -> DOMString(UCH);
    ++ (introduced in DOM Level 2)
    ++ The namespace URI of this node, or null if it is unspecified

  -- methods
  appendChild : (%,%) -> %;
    ++ adds the node newChild to the end of the list of children of this node.
    ++ If the newChild is allready on the tree, it is first removed.
  hasChildNodes : % -> Boolean;
    ++ Returns whether this node has any children
  cloneNode : % -> %;
    ++ Returns a duplicate of this node, i.e. serves as a generic copy 
    ++ constructor for nodes. The duplicate node has no parent; (parentNode is
    ++ null).<XML><BR></XML>
    ++ Cloning an element copies all attributes and their values, including 
    ++ those generated by the XML processor to represent defaulted attributes,
    ++ this method does not copy any children of this node, unless it is a deep
    ++ clone. Cloning an
    ++ attribute directly, as opposed to cloning as part of an Element cloning
    ++ operation returns a specified attribute (specified is true). Cloning any
    ++ other type of node simply returns a copy of this node.
  deepCloneNode : % -> %;
    ++ Returns a duplicate of this node, where the children nodes are clones
    ++ too. It has no parent, the cost of the operation is directly 
    ++ proportional to the size of the tree beneath this node.
  normalize : % -> %;
    ++ (introduced in DOM Level 2)
    ++ Puts all text nodes in the full depth of the sub-tree underneath this 
    ++ node, including attribute nodes, into a "normal" form where only
    ++ structure seperates Text nodes.
  isSupported : (DOMString(UCH),DOMString(UCH))  -> Boolean;
    ++ (introduced in DOM Level 2)
    ++ Tests whether the DOM implementation implements a specific feature and
    ++ that feature is supported by this node.
  hasAttributes : % -> B;
    ++ (introduced in DOM Level 2)
    ++ Returns whether this node (if it is an element) has any attributes
  childNodes : % -> NodeList(UCH);
    ++ A NodeList that contains all children of this node. If there are no 
    ++ children, this is a NodeList containing no nodes
  attributes : % -> NamedNodeMap(UCH);
    ++ A NamedNodeMap containing the attributes of this node (if it is an 
    ++ element) or null otherwise
  ownerDocument : % -> Document(UCH);
    ++ (introduced in DOM Level 2)
    ++ The Document object associated with this node. This is also the 
    ++ Document object used to create new nodes. When this node is a Document 
    ++ or a DocumentType which is not used with any Document yet, this is null
  -- methods
  insertBefore : (%,MI,%) -> ();
    ++ Inserts the node newChild (the first parameter) before the index 
    ++ child node, refChild (the second parameter). 
  replaceChild : (%,MI,%) -> ();
    ++ replaces the child node oldChild (the second parameter) with newChild
    ++ (the first parameter) in the list of children, and returns the oldChild
    ++ node.
  removeChild : (MI,%) -> ();
    ++ Removes the child node indicated by oldChild from the list of children,
    ++ and returns it.

  default {
    ELEMENT__NODE:MI == 1;
    ATTRIBUTE__NODE:MI == 2;
    TEXT__NODE:MI == 3;
    CDATA__SECTION__NODE:MI == 4;
    ENTITY__REFERENCE__NODE:MI == 5;
    ENTITY__NODE:MI == 6;
    PROCESSING__INSTRUCTION__NODE:MI == 7;
    COMMENT__NODE:MI == 8;
    DOCUMENT__NODE:MI == 9;
    DOCUMENT__TYPE__NODE:MI == 10;
    DOCUMENT__FRAGMENT__NODE:MI == 11;
    NOTATION__NODE:MI == 12;
}}

define NodeEx(UCH:UniCodeCharacter):Category == with {
  null : () ->% ;
    ++ returns a {\it null} node. This is represented as having type {\it 0} 
    ++ and all other attributes {\it failed}
}

+++ The Attr interface represents an attribute in an Element object. Typically 
+++ the allowable values for the attribute are defined in a document type 
+++ definition.
--define AttrCat(UCH:UniCodeCharacter):Category == NodeCat(UCH) with {
define AttrCat(UCH:UniCodeCharacter):Category == with {
  name : % -> DOMString(UCH);
    ++ Returns the name of this attribute
  specified : % -> Boolean;
    ++ If this attribute was explicitly given a value in the original document,
    ++ this is true; otherwise it is false.
  value :  % -> DOMString(UCH);
    ++ On retrieval, the value of the attribute is returned as a string.
    ++ Character and general entity references are replaced with their values.
  ownerElement : % -> Element(UCH);
    ++ The Element node this attribute is attached to, or null if this 
    ++ attribute is not in use.
  setOwnerElement : (%,Element(UCH)) -> %;
    ++ attach this attribute to an element
}

--define ElementCat(UCH:UniCodeCharacter):Category == NodeCat(UCH) with {
define ElementCat(UCH:UniCodeCharacter):Category == with {
  import from Machine;

  tagName : % -> DOMString(UCH);
     ++ The name of the element.
  getAttribute : (%,DOMString(UCH)) -> DOMString(UCH);
    ++ Retrieves an attribute value by name. If the attribute does not exist 
    ++ returns ""
  setAttribute :  (%,DOMString(UCH),DOMString(UCH)) -> Attr(UCH);
    ++ Adds a new attribute. If an attribute with that name is allready present
    ++ in the element, its value is changed to be that of the parameter. This
    ++ value is a simple string.
  removeAttribute : (%,DOMString(UCH)) -> Attr(UCH);
    ++ removes an attribute by name. If the removed attribute is known to have
    ++ a default value an attribute immediately appears containing the default 
    ++ value as well as the corresponding namespace URI, local name and prefix
    ++ when applicable.
  getAttributeNS : (%,DOMString(UCH),DOMString(UCH)) -> DOMString(UCH);
    ++ (introduced in DOM Level 2)
    ++ Retrieves an attribute value by local name and namespace URI.
  setAttributeNS : (%,DOMString(UCH),DOMString(UCH),DOMString(UCH)) -> Attr(UCH);
    ++ (introduced in DOM Level 2)
    ++ Adds a new attribute. If an attribute with the same local name and 
    ++ namespace URI is already present on the element, its prefix is changed 
    ++ to be the prefix part of the qualifiedName and its value changed to be
    ++ the value parameter.
  removeAttributeNS : (%,DOMString(UCH),DOMString(UCH)) -> Attr(UCH);
    ++ (introduced in DOM Level 2)
    ++ Removes an attribute by local name and namespace URI. If the removed 
    ++ attribute has a default value it is replaced. The replaceing attribute 
    ++ has the same namespace URI and local name, as well as the original 
    ++ prefix.
  hasAttribute : (%,DOMString(UCH)) -> Boolean;
    ++ Returns true when an attribute with a given name is specified on this
    ++ element or has a default value, returns false otherwise.
  hasAttributeNS : (%,DOMString(UCH),DOMString(UCH)) -> Boolean;
    ++ (introduced in DOM Level 2)
    ++ Returns true when an attribute with a given local name and namespace URI
    ++ is specified on this element or has a default value, returns false 
    ++ otherwise.
-- *** It was considered that in our model, the following functions are not 
--     required ***
--  getAttributeNode : (%,DOMString(UCH)) -> Attr(UCH);
--   ++ Retrieves an attribute node by name.
--  setAttributeNode : (%,Attr(UCH)) -> Attr(UCH);
--    ++ Adds a new attribute node. If an attribute with that name (nodename) is
--    ++ allready present in the element, it is replaced by the new one.
--  removeAttributeNode :  (%,Attr(UCH)) -> Attr(UCH);
--    ++ Removes an attribute by name. If the removed attribute is known to have
--    ++ a default value, an attribute immediately appears containing the default
--    ++ value as well as the corresponding namespace URI, local name, and prefix
--    ++ when applicable.
  getElementsByTagName : (%,DOMString(UCH)) -> NodeList(UCH);
    ++ Returns a NodeList of all descendant Elements with a given tag name, in
    ++ the order in which they are encountered.
--  getAttributeNodeNS : (%,DOMString(UCH),DOMString(UCH)) -> Attr(UCH);
--    ++ (introduced in DOM Level 2)
--    ++ Retrieves an Attr node by local name and namespace URI.
--  setAttributeNodeNS : (%,Attr(UCH)) -> Attr(UCH);
--    ++ (introduced in DOM Level 2)
--    ++ Adds a new attribute. If an attribute with that local name and that name
--    ++ space URI is already present in the element, it is replaced by the new 
--    ++ one.
  getElementsByTagNameNS : (%,DOMString(UCH),DOMString(UCH)) -> NodeList(UCH);
    ++ (introduced in DOM Level 2)
    ++ Returns a NodeList of all the descending Elements with a given local 
    ++ name and namespace URI in the order in which thet are encountered in a 
    ++ preorder traversal of this Element tree.
}

+++ Objects implementing the NamedNodeMap interface are used to represent
+++ collections of nodes that can be accessed by name
define NamedNodeMapCat(UCH:UniCodeCharacter) : Category == with {
  length : % -> MI;
    ++ The number of nodes in this map
  getNamedItem : (%,DOMString(UCH)) -> Node(UCH);
    ++ Retrieves a Node specified by NodeName. If no node exists with that name
    ++ returns null()
  setNamedItem : (%,Node(UCH)) -> Node(UCH);
    ++ Adds a node using its nodeName attribute. If a node with that name 
    ++ is already present in this map, it is replaced by the new one
  removeNamedItem : (%,DOMString(UCH)) -> Node(UCH);
    ++ Removes a node specified by name. When this map contains the attributes
    ++ attached to an element, if the removed attribute is known to have a 
    ++ default value, an attribute immediately appears containing the default
    ++ value as well as the corresponding namespace URI, local name and prefix
    ++ when applicable
  item : (%,MI) -> Node(UCH);
    ++ Returns the indexth item in the map (where index is the parameter). If
    ++ index is greater or equal to the number of nodes in this map, this 
    ++ returns null.
  getNamedItemNS : (%,DOMString(UCH),DOMString(UCH)) -> Node(UCH);
    ++ (introduced in DOM Level 2)
    ++ Retrieves a node specified by local name and namespace URI. HTML-only
    ++ DOM implementations do not need to implement this method
  setNamedItemNS : (%,Node(UCH)) -> Node(UCH);
    ++ (introduced in DOM Level 2)
    ++ Adds a node using its namespaceURI and localName. If a node with that
    ++ namespace URI and that local name is already present in this map, it is
    ++ replaced by the new one. HTML-only DOM implementations do not need to
    ++ implement this method
  removeNamedItemNS : (%,DOMString(UCH),DOMString(UCH)) -> Node(UCH);
    ++ (introduced in DOM Level 2)
    ++ Removes a node specified by local name and namespace URI. A removed
    ++ attribute may be known to have a default value when this map contains 
    ++ the attributes attached to an element, as returned by the attributes
    ++ attribute of the node interface. If so an attribute immediately appears 
    ++ containing the default value as well as the corresponding namespace URI,
    ++ local name and prefix when applicable. HTML-only DOM implementations do 
    ++ not need to implement this method
}

+++ The NodeList interface provides the abstraction of an ordered collection of
+++ nodes, without defining or constraining how this collection is implemented.
+++ indexing is from 0
define NodeListCat(UCH:UniCodeCharacter):Category == with {
  length : % -> MI;
    ++ The number of nodes in the list. The range of valid child node indices
    ++ is 0 to length - 1
  item : (%,MI) -> Node(UCH);
    ++ Returns the indexth item in the collection. If index is greater than or 
    ++ equal to the number of nodes in the list, this returns null.
  addChild : (Node(UCH),%) -> %;
    ++ Add a child to the NodeList.
}

+++ This Interface inherits from CharacterData and represents the content of
+++ a comment between the starting '<!--@ and ending '-->'
define CommentCat(UCH:UniCodeCharacter):Category == Join(CharacterDataCat(UCH),NodeCat(UCH));

+++ The CharacterData interface extends Node with a set of attributes and
+++ methods for accessing character data in the DOM. For clarity this set is 
+++ defined here rather than on each object that uses these attributes and
+++ methods. No DOM objects correspond directly to CharacterData, though Text
+++ and others do inherit the interface from it. All offsets in this interface
+++ start from 0.
define CharacterDataCat(UCH:UniCodeCharacter):Category == with {
  import from Machine;
  data : % -> DOMString(UCH);
    ++ The character data of the node that implements this interface.
  length : % -> MI;
    ++ The number of 16-bit units that are available through data and the.
    ++ substring data methods below.
  substringData : (%,MI,MI) -> DOMString(UCH);
    ++ Extracts a range of data from the node.
  appendData : (%,DOMString(UCH)) -> ();
    ++ Append the string to the end of the character data of the node. Upon
    ++ success, data provides access to the concatenation of data and the 
    ++ DOMString(UCH) specified.
  insertData : (%,MI,DOMString(UCH)) -> ();
    ++ Insert a string at the specified 16-bit unti offset.
  deleteData : (%,MI,MI) -> ();
    ++ Remove a range of 16-bit units from the node. Upon success data and 
    ++ length reflect the change.
  replaceData : (%,MI,MI,DOMString(UCH)) -> ();
    ++ Replace the characters starting at the first argument and finishing at 
    ++ the secondargument with the specified string.
}

--define NotationCat(UCH:UniCodeCharacter):Category == NodeCat(UCH) with {
define NotationCat(UCH:UniCodeCharacter):Category == with {
  publicId : % -> DOMString(UCH);
    ++ The public identifier of this notation. If the public identifier was
    ++ not specified, this is null.
  systemId : % -> DOMString(UCH);
    ++ The system identifier of this notation. If the system identifier was
    ++ not specified, this is null.
}

+++ The Document interface represents the entire XML document. Conceptually, 
+++ it is the root of the document tree and provides the primary access to the 
+++ documents data.
define DocumentCat(UCH:UniCodeCharacter):Category == with {
  doctype : % -> DocumentType(UCH);
    ++ The Document Type Decleration associated with this document.
  implementation : % -> DOMImplementation(UCH);
    ++ The DOMImplementation object that handles this document.
  documentElement : % -> Element(UCH);
    ++ This is a convenience attribute that allows direct access to the childs
    ++ node that is the root element of the document.
  createElement : (DOMString(UCH),NamedNodeMap(UCH),NodeList(UCH)) -> Element(UCH);
    ++ Creates an element of the type specified.
  createDocumentFragment : () -> DocumentFragment(UCH);
    ++ Creates an empty DocumentFragment object.
  createTextNode : DOMString(UCH) -> Text(UCH);
    ++ Creates a Text node given the specified string.
  createComment : DOMString(UCH) -> Comment(UCH);
    ++ Creates a Comment node given the specified string.
  createCDATASection : DOMString(UCH) -> CDATASection(UCH);
    ++ Creates a CDATASection node whos value is the specified string.
  createProcessingInstruction : (DOMString(UCH),DOMString(UCH)) -> ProcessingInstruction(UCH);
    ++ Creates a ProcessingInstruction node given the specified name and
    ++ data strings.
  createAttribute : (DOMString(UCH),DOMString(UCH)) -> Attr(UCH);
    ++ Creates an Attr of the given node.
  createEntityReference : DOMString(UCH) -> EntityReference(UCH);
    ++ Creates an EntityReference object. In addition, if the refernced entity
    ++ is known, the child list of the EntityReference node is made the same
    ++ as that of the corresponding Entity node.
  getElementsByTagName : (DOMString(UCH),Document(UCH)) -> NodeList(UCH);
    ++ Returns a NodeList of all the Elements with a given tag name in the 
    ++ order in which they are encountered in a preorder traversal of the 
    ++ Document tree.
  importNode : (Node(UCH),Boolean) -> Node(UCH);
    ++ (introduced in DOM Level 2)
    ++ Imports a node from another document to this document. The returned
    ++ node has no parent; (parentNode is null). The source node is not
    ++ altered or removed from the original document.
  createElementNS : (DOMString(UCH),DOMString(UCH),NamedNodeMap(UCH),NodeList(UCH)) -> Element(UCH);
    ++ (introduced in DOM Level 2)
    ++ Creates an element of the given qualified name and namespace URI.
  createAttributeNS : (DOMString(UCH),DOMString(UCH),DOMString(UCH)) -> Attr(UCH);
    ++ (introduced in DOM Level 2)
    ++ Creates an attribute of the given qualified name and namespace URI.
  getElementByTagNameNS : (DOMString(UCH),DOMString(UCH),Document(UCH)) -> NodeList(UCH);
    ++ (introduced in DOM Level 2)
    ++ Returns a NodeList of all the Elements with a given local name and 
    ++ namespace URI in the order in which they are encountered in a preorder
    ++ traversal of the Document tree.
  getElementById : (DOMString(UCH),Document(UCH)) -> Element(UCH);
    ++ (introduced in DOM Level 2)
    ++ Returns the Element whose ID is given by elementID. If no such element
    ++ exists, returns null. Behaviour is not defined if more than one element
    ++ has this ID.
}

--+++ Entity Reference objects may be inserted into the structure model when an
--+++ entity reference is in the source document, or when the user wishes to
--+++ insert an entity reference.
--define EntityReferenceCat(UCH:UniCodeCharacter):Category == {};

+++ The ProcessingInstruction interface represents a "processing instruction",
+++ used in XML as a way to keep processor-specific information in the text 
+++ of the document
--define ProcessingInstructionCat(UCH:UniCodeCharacter):Category == NodeCat(UCH) with {
define ProcessingInstructionCat(UCH:UniCodeCharacter):Category == with {
  target : % -> DOMString(UCH);
    ++ The target of this processing instruction.
  data : % -> DOMString(UCH);
    ++ The content of this processing instruction.
}

+++ CDATA sections are used to escape large blocks of text containing
+++ characters which would otherwise be regarded as mark up.
--define CDATASectionCat(UCH:UniCodeCharacter):Category == Join(CharacterDataCat(UCH),NodeCat(UCH)) with {
define CDATASectionCat(UCH:UniCodeCharacter):Category == with {
  splitText : (%,MI) -> NodeList(UCH);
    ++ Breaks this node into two nodes at the specified offset, keeping both
    ++ in the tree as siblings
}

+++ The Text interface inherits from CharacterData and represents the textual 
+++ content of an Element or Attr.
--define TextCat(UCH:UniCodeCharacter):Category == Join(CharacterDataCat(UCH),NodeCat(UCH)) with {
define TextCat(UCH:UniCodeCharacter):Category == with {
  splitText : (%,MI) -> NodeList(UCH)
    ++ Breaks this node into two nodes at the specified offset, keeping both
    ++ in the tree as siblings
}

--+++ DocumentFragment is a "lightweight" or "minimal" Document object. 
--+++ Intended for holding a part of a Document tree.
--define DocumentFragmentCat(UCH:UniCodeCharacter):Category == NodeCat(UCH);

+++ The Category for DocumentType, this stores all the DTD stuff for a document
define DocumentTypeCat(UCH:UniCodeCharacter):Category == with {
  name : % -> DOMString(UCH);
  entities : % -> NamedNodeMap(UCH);
  notations : % -> NamedNodeMap(UCH);
  publicID : % -> DOMString(UCH);
  systemID : % -> DOMString(UCH);
  internalSubset : % -> DOMString(UCH);
  new : (DOMString(UCH),NamedNodeMap(UCH),NamedNodeMap(UCH),DOMString(UCH),DOMString(UCH),DOMString(UCH)) -> %;
}
