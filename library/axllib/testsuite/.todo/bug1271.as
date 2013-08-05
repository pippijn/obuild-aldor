--* From bill@scl.csd.uwo.ca  Tue Oct 31 17:00:28 2000
--* Received: from server-4.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with SMTP id RAA21465
--* 	for <ax-bugs@nag.co.uk>; Tue, 31 Oct 2000 17:00:26 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 20453 invoked from network); 31 Oct 2000 16:59:41 -0000
--* Received: from ptibonum.scl.csd.uwo.ca (129.100.16.102)
--*   by server-4.tower-4.starlabs.net with SMTP; 31 Oct 2000 16:59:41 -0000
--* Message-Id: <200010311659.LAA30535@ptibonum.scl.csd.uwo.ca>
--* Date: Tue, 31 Oct 2000 11:59:22 -0500
--* From: William Arthur Naylor <bill@scl.csd.uwo.ca>
--* To: ax-bugs@nag.co.uk
--* Subject: [9][compfault] outdated file

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -O -Fao -Fo -Fasy xmlbasiccats.as
-- Version: 1.1.12 for LINUX(glibc)
-- Original bug file name: /scl/people/bill/Aldor/MathML/xmlbasiccats.as

#include "axllib.as"

#library ByteLib "byte.ao"
#library BasicLibrary "xmlbasics.ao"

import from ByteLib;
import from BasicLibrary;

M ==> Machine;
B ==> Boolean;
SI ==> SingleInteger;

+++ This Category exports constants intended to indicate DOM errors
define DOMException : Category == with {
  import from SI;
  INDEX__SIZE__ERR : SI;
    ++ If an index or size is negative or greater than the allowed value
  DOMSTRING__SIZE__ERR : SI;
    ++ If the specified range of text does not fit into a DOMString
  HIERARCHY__REQUEST__ERR : SI;
    ++ If any node is inserted somewhere it doesn't belong
  WRONG__DOCUMENT__ERR : SI;
    ++ If a node is used in a different document than the one that created it
  INVALID__CHARACTER__ERR : SI;
    ++ If an invalid or illegal character is specified, such as in a name. See
    ++ production 2 in the XML specification for the definition of a legal 
    ++ character and production 5 for the definition of a legal name character.
  NO__DATA__ALLOWED__ERR : SI;
    ++ If data is specified for a node which does not support data.
  NO__MODIFICATION__ERR : SI;
    ++ If an attempt is made to modify an object where modifications are not 
    ++ allowed
  NOT__FOUND__ERR : SI;
    ++ If an attempt is made to reference a node in a context where it does 
    ++ not exist
  NOT__SUPPORTED__ERR : SI;
    ++ If the implementation does not support the type of object requested
  INUSE__ATTRIBUTE__ERR : SI;
    ++ If an attempt is made to add an attribute that is allready in use
    ++ elsewhere
  INVALID__STATE__ERR : SI;
    ++ (introduced in DOM Level 2)
    ++ If an attempt is made to use an object that is not, or is no longer 
    ++ useable
  SYNTAX__ERR : SI;
    ++ (introduced in DOM Level 2)
    ++ If an invalid or illegal string is specified
  INVALID__MODIFICATION__ERR : SI;
    ++ (introduced in DOM Level 2)
    ++ If an attempt is made to modify the type of the underlying object
  NAMESPACE__ERR : SI;
    ++ (introduced in DOM Level 2)
    ++ If an attempt is made to create or change an object in a way which is
    ++ incorrect with regard to namespaces
  INVALID__ACCESS__ERR : SI;
    ++ (introduced in DOM Level 2)
    ++ If a parameter or an operation is not supported by the underlying object

  default {
    import from SI;
    INDEX__SIZE__ERR : SI == 1;
    DOMSTRING__SIZE__ERR : SI == 2;
    HIERARCHY__REQUEST__ERR : SI == 3;
    WRONG__DOCUMENT__ERR : SI == 4;
    INVALID__CHARACTER__ERR : SI == 5;
    NO__DATA__ALLOWED__ERR : SI == 6;
    NO__MODIFICATION__ERR : SI == 7;
    NOT__FOUND__ERR : SI == 8;
    NOT__SUPPORTED__ERR : SI == 9;
    INUSE__ATTRIBUTE__ERR : SI == 10;
    INVALID__STATE__ERR : SI == 11;
    SYNTAX__ERR : SI == 12;
    INVALID__MODIFICATION__ERR : SI == 13;
    NAMESPACE__ERR : SI == 14;
    INVALID__ACCESS__ERR : SI == 15;
}}

+++ The Node type is the primary datatype for the DOM. It represents a single 
+++ node in the document tree.
define NodeCat:Category == with {
  -- constants to specify the different node types
  ELEMENT__NODE : SI;
    ++ The node is an Element
  ATTRIBUTE__NODE : SI;
    ++ The node is an Attr
  TEXT__NODE : SI;
    ++ The node is a Text node
  CDATA__SECTION__NODE : SI;
    ++ The node is a CDATA section
  ENTITY__REFERENCE__NODE : SI;
    ++ The node is an EntityReference
  ENTITY__NODE : SI;
    ++ The node is an Entity
  PROCESSING__INSTRUCTION__NODE : SI;
    ++ The node is a ProcessingInstruction
  COMMENT__NODE : SI;
    ++ The node is a Comment
  DOCUMENT__NODE : SI;
    ++ The node is a Document
  DOCUMENT__TYPE__NODE : SI;
    ++ The node is a DocumentType
  DOCUMENT__FRAGMENT__NODE : SI;
    ++ The node is a DocumentFragment
  NOTATION__NODE : SI;
    ++ The node is a Notation

  -- attributes
  nodeName : % -> DOMString;
    ++ The name of this node, depending on its type; see the table above.
  nodeValue : % -> DOMString;
    ++ The value of this node, depending on its type. When it is defined to 
    ++ be null, setting it has no effect
  nodeType : % -> SI;
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
  prefix : % -> DOMString;
    ++ (introduced in DOM Level 2)
    ++ The namespace prefix of this node, or null if it is unspecified
  localName : % -> DOMString;
    ++ (introduced in DOM Level 2)
    ++ Returns the local part of the qualified name of this node.
    ++ For nodes of any type other than ELEMENT_NODE and ATTRIBUTE_NODE and
    ++ nodes created with a DOM Level1 method such as createElement from the 
    ++ Document interface, this is allways null
  namespaceURI : % -> DOMString;
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
    ++ those generated by the XML processorto represent defaulted attributes,
    ++ but this method does not copy any text it contains unless it is a deep
    ++ clone, since the text is contained in a child Text node. Cloning an
    ++ attribute directly, as opposed to cloning as part of an Element cloning
    ++ operation returns a specified attribute (specified is true). Cloning any
    ++ other type of node simply returns a copy of this node.
  normalize : % -> %;
    ++ (introduced in DOM Level 2)
    ++ Puts all text nodes in the full depth of the sub-tree underneath this 
    ++ node, including attribute nodes, into a "normal" form where only
    ++ structure seperates Text nodes.
  isSupported : (DOMString,DOMString)  -> Boolean;
    ++ (introduced in DOM Level 2)
    ++ Tests whether the DOM implementation implements a specific feature and
    ++ that feature is supported by this node.
  hasAttributes : % -> B;
    ++ (introduced in DOM Level 2)
    ++ Returns whether this node (if it is an element) has any attributes

  default {
    ELEMENT__NODE:SI == 1;
    ATTRIBUTE__NODE:SI == 2;
    TEXT__NODE:SI == 3;
    CDATA__SECTION__NODE:SI == 4;
    ENTITY__REFERENCE__NODE:SI == 5;
    ENTITY__NODE:SI == 6;
    PROCESSING__INSTRUCTION__NODE:SI == 7;
    COMMENT__NODE:SI == 8;
    DOCUMENT__NODE:SI == 9;
    DOCUMENT__TYPE__NODE:SI == 10;
    DOCUMENT__FRAGMENT__NODE:SI == 11;
    NOTATION__NODE:SI == 12;
}} 

+++ The Attr interface represents an attribute in an Element object. Typically 
+++ the allowable values for the attribute are defined in a document type 
+++ definition.
define AttrCat:Category == with {
  name : % -> DOMString;
    ++ Returns the name of this attribute
  specified : % -> Boolean;
    ++ If this attribute was explicitly given a value in the original document,
    ++ this is true; otherwise it is false.
  value :  % -> DOMString;
    ++ On retrieval, the value of the attribute is returned as a string.
    ++ Character and general entity references are replaced with their values.
}

define ElementCat:Category == with {
  import from Machine;

  tagName : % -> DOMString;
     ++ The name of the element.
  getAttribute : (%,DOMString) -> DOMString;
    ++ Retrieves an attribut evalue by name.
  setAttribute :  (%,DOMString,DOMString) -> Ptr;
    ++ Adds a new attribute. If an attribute with that name is allready present
    ++ in the element, its value is changed to be that of the parameter. This
    ++ value is a simple string.
  removeAttribute : (%,DOMString) -> Ptr;
    ++ removes an attribute by name. If the removed attribute is known to have
    ++ a default value an attribute immediately appears containing the default 
    ++ value as well as the corresponding namespace URI, local name and prefix
    ++ when applicable.
  getAttributeNS : (%,DOMString,DOMString) -> DOMString;
    ++ (introduced in DOM Level 2)
    ++ Retrieves an attribute value by local name and namespace URI.
  setAttributeNS : (%,DOMString,DOMString,DOMString) -> Ptr;
    ++ (introduced in DOM Level 2)
    ++ Adds a new attribute. If an attribute with the same local name and 
    ++ namespace URI is already present on the element, its prefix is changed 
    ++ to be the prefix part of the qualifiedName and its value changed to be
    ++ the value parameter.
  removeAttributeNS : (%,DOMString,DOMString) -> Ptr;
    ++ (introduced in DOM Level 2)
    ++ Removes an attribute by local name and namespace URI. If the removed 
    ++ attribute has a default value it is replaced. The replaceing attribute 
    ++ has the same namespace URI and local name, as well as the original 
    ++ prefix.
  hasAttribute : (%,DOMString) -> Boolean;
    ++ Returns true when an attribute with a given name is specified on this
    ++ element or has a default value, returns false otherwise.
  hasAttributeNS : (%,DOMString,DOMString) -> Boolean;
    ++ (introduced in DOM Level 2)
    ++ Returns true when an attribute with a given local name and namespace URI
    ++ is specified on this element or has a default value, returns false 
    ++ otherwise.
}

+++ Objects implementing the NamedNodeMap interface are used to represent
+++ collections of nodes that can be accessed by name
define NamedNodeMapCat : Category == with {
  length : % -> SI;
    ++ The number of nodes in this map
}

+++ The NodeList interface provides the abstraction of an ordered collection of
+++ nodes, without defining or constraining how this collection is implemented.
define NodeListCat:Category == with {
  length : % -> SI;
    ++ The number of nodes in the list. The range of valid child node indices
    ++ is 0 to length - 1
}

define CharacterData:Category == with {
  import from M;

  data : DOMString -> %;
  length : % -> SI;
  substringData  : (%,SI,SI) -> DOMString;
  appendData : (%,DOMString) -> Ptr;
  insertData : (%,SI,DOMString) -> Ptr;
  deleteData : (%,SI,SI) -> Ptr;
  replaceData : (%,SI,SI,DOMString) -> Ptr;
}

