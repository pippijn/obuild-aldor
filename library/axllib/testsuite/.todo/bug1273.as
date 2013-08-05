--* From bill@scl.csd.uwo.ca  Thu Nov  2 16:41:18 2000
--* Received: from server-3.tower-4.starlabs.net (mail.london-1.starlabs.net [212.125.75.12])
--* 	by nagmx1.nag.co.uk (8.9.3/8.9.3) with SMTP id QAA11545
--* 	for <ax-bugs@nag.co.uk>; Thu, 2 Nov 2000 16:41:10 GMT
--* X-VirusChecked: Checked
--* Received: (qmail 21644 invoked from network); 2 Nov 2000 16:33:14 -0000
--* Received: from ptibonum.scl.csd.uwo.ca (129.100.16.102)
--*   by server-3.tower-4.starlabs.net with SMTP; 2 Nov 2000 16:33:14 -0000
--* Message-Id: <200011021640.LAA06914@ptibonum.scl.csd.uwo.ca>
--* Date: Thu, 2 Nov 2000 11:40:16 -0500
--* From: William Arthur Naylor <bill@scl.csd.uwo.ca>
--* To: ax-bugs@nag.co.uk
--* Subject: [5][compfault] Compiler bug...Bug: gen0Syme:  syme unallocated by gen0Vars

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>

-- Command line: axiomxl -O -Fao -Fo -Fasy xmlextend.as
-- Version: Aldor version 1.1.12 for LINUX(glibc)
-- Original bug file name: /scl/people/bill/Aldor/MathML/xmlextend.as

--+ #include "axllib.as"
--+ 
--+ #library BasicLibrary "xmlbasics.ao"
--+ #library BasicCats "xmlbasiccats.ao"
--+ 
--+ import from BasicLibrary;
--+ import from BasicCats;
--+ 
--+ B ==> Boolean;
--+ L ==> List;
--+ R ==> Record;
--+ T ==> Tuple;
--+ M ==> Machine;
--+ BY ==> Byte;
--+ SI ==> SingleInteger;
--+ STR ==> String;
--+ PTR ==> Pointer;
--+ NSP ==> NumberScanPackage;
--+ 
--+ define NodeCatExtend:Category == with {
--+   childNodes : % -> NodeList;
--+     ++ A NodeList that contains all children of this node. If there are no 
--+     ++ children, this is a NodeList containing no nodes
--+   attributes : % -> NamedNodeMap;
--+     ++ A NamedNodeMap containing the attributes of this node (if it is an 
--+     ++ element) or null otherwise
--+   ownerDocument : % -> Document;
--+     ++ (introduced in DOM Level 2)
--+     ++ The Document object associated with this node. This is also the 
--+     ++ Document object used to create new nodes. When this node is a Document 
--+     ++ or a DocumentType which is not used with any Document yet, this is null
--+ 
--+   -- methods
--+ --  insertBefore : (%,PTR(%)) -> PTR(%);
--+     ++ Inserts the node newChild (the first parameter) before the existing 
--+     ++ child node refChild (the second parameter). If refChild is null, insert 
--+     ++ newChild at the end of the list of children.<XML><BR></XML>
--+     ++ If newChild is a Document Fragment object, all of its children are 
--+     ++ inserted, in the same order before refChild. If the newChild is already
--+     ++ in the tree, it is first removed.
--+ --  replaceChild : (%,PTR(%)) -> PTR(%);
--+     ++ replaces the child node oldChild (the second parameter) with newChild
--+     ++ (the first parameter) in the list of children, and returns the oldChild
--+     ++ node.
--+ --  removeChild : PTR(%) -> %;
--+     ++ Removes the child node indicated by oldChild from the list of children,
--+     ++ and returns it.
--+ }
--+ 
--+ define CharacterDataCat:Category == Join(NodeCat,NodeCatExtend) with {
--+   import from Machine;
--+ 
--+   data : % -> DOMString;
--+     ++ The character data of the node that implements this interface.
--+   length : % -> SI;
--+     ++ The number of 16-bit units that are available through data and the.
--+     ++ substring data methods below.
--+   substringData : (%,SI,SI) -> DOMString;
--+     ++ Extracts a range of data from the node.
--+   appendData : (%,DOMString) -> Ptr;
--+     ++ Append the string to the end of the character data of the node. Upon
--+     ++ success, data provides access to the concatenation of data and the 
--+     ++ DOMString specified.
--+   insertData : (%,SI,DOMString) -> Ptr;
--+     ++ Insert a string at the specified 16-bit unti offset.
--+   deleteData : (%,SI,SI) -> Ptr;
--+     ++ Remove a range of 16-bit units from the node. Upon success data and 
--+     ++ length reflect the change.
--+   replaceData : (%,SI,SI,DOMString) -> Ptr;
--+     ++ Replace the characters starting at the specified 16-unit offset with 
--+     ++ the specified string.
--+ }
--+ 
--+ +++ This Interface inherits from CharacterData and represents the content of
--+ +++ a comment between the starting '<!--@ and ending '-->'
--+ Comment : CharacterDataCat with {
--+   makeComment : DOMString -> %;
--+     ++ make a Comment
--+ } == CharacterData add {
--+   Rep ==> DOMString;
--+   makeComment(str:DOMString):% == per str;
--+ }
--+ 
--+ define ElementCatExtend:Category == with {
--+   getAttributeNode : (%,DOMString) -> Attr;
--+    ++ Retrieves an attribute node by name.
--+   setAttributeNode : (%,Attr) -> Attr;
--+     ++ Adds a new attribute node. If an attribute with that name (nodename) is
--+     ++ allready present in the element, it is replaced by the new one.
--+   removeAttributeNode :  (%,Attr) -> Attr;
--+     ++ Removes an attribute by name. If the removed attribute is known to have
--+     ++ a default value, an attribute immediately appears containing the default
--+     ++ value as well as the corresponding namespace URI, local name, and prefix
--+     ++ when applicable.
--+   getElementsByTagName : (%,DOMString) -> NodeList;
--+     ++ Returns a NodeList of all descendant Elements with a given tag name, in
--+     ++ the order in which they are encountered.
--+   getAttributeNodeNS : (%,DOMString,DOMString) -> Attr;
--+     ++ (introduced in DOM Level 2)
--+     ++ Retrieves an Attr node by local name and namespace URI.
--+   setAttributeNodeNS : (%,Attr) -> Attr;
--+     ++ (introduced in DOM Level 2)
--+     ++ Adds a new attribute. If an attribute with that local name and that name
--+     ++ space URI is already present in the element, it is replaced by the new 
--+     ++ one.
--+   getElementsByTagNameNS : (%,DOMString,DOMString) -> NodeList;
--+     ++ (introduced in DOM Level 2)
--+     ++ Returns a NodeList of all the descending Elements with a given local 
--+     ++ name and namespace URI in the order in which thet are encountered in a 
--+     ++ preorder traversal of this Element tree.
--+ }
--+ 
--+ Attr:Join(AttrCat,NodeCat,NodeCatExtend) with {
--+   ownerElement : % -> Element;
--+     ++ The Element node this attribute is attached to, or null if this 
--+     ++ attribute is not in use.
--+   makeAttr : (DOMString,DOMString,Element) -> %;
--+     ++ make an instance of this domain, we note that to avoid infinite 
--+     ++ recursion we should specify the owner Element without this attribute
--+     ++ N.B. we need to change this to use pointers instead (I think)
--+ } == Node add {
--+   Rep ==> Record(name:DOMString,value:DOMString,owner:Element);
--+ 
--+   import from Rep;
--+ 
--+   makeAttr(name:DOMString,val:DOMString,el:Element):% == per [name,val,el];
--+ 
--+   ownerElement(a:%):Element == rep(a).owner;
--+ 
--+   name(a:%):DOMString == rep(a).name;
--+ 
--+   specified(a:%):Boolean == {
--+     error "not implemented yet"
--+   }
--+ 
--+   value(a:%):DOMString == rep(a).value;
--+ }
--+ 
--+ Element:Join(ElementCat,NodeCat,NodeCatExtend,ElementCatExtend) with {
--+   << : (TextWriter,%) -> TextWriter;
--+     ++ render this element
--+   makeElement : (DOMString,L(Attr),L(Node)) -> %;
--+     ++ make a value of this domain
--+ }== Node add {
--+   Rep ==> Record(tag:DOMString,atrList:L(atr:Attr),childList:L(Node));
--+ 
--+   import from Machine,Rep;
--+ 
--+   (w: TextWriter) << (e: %): TextWriter == {
--+     import from NodeList,SI,String,DOMString;
--+     erep := rep e;
--+     if length childNodes e = 0 then 
--+       return(print << "<" << (erep.tag) << "/>" << newline)
--+     else {
--+       w := print << "<" << (erep.tag) << ">" << newline;
--+       w := print << childNodes(e);
--+       w := print << "</" << (erep.tag) << ">" << newline;
--+     }
--+     w
--+   }
--+ 
--+   childNodes(e:%):NodeList == {
--+     makeNodeList(rep(e).childList)
--+   }
--+ 
--+   attributes(x:%):NamedNodeMap == error "not done yet";
--+ 
--+   makeElement(str:DOMString,la:L(Attr),ln:L(Node)):% == per([str,la,ln]);
--+ 
--+   tagName(e:%):DOMString == {
--+     erep:Rep := rep e;
--+     erep.tag
--+   }
--+ 
--+   getAttribute(e:%,str:DOMString):DOMString == {
--+     import from Attr,String;
--+     erep:Rep := rep e; atrlist:L(Attr) := erep.atrList;
--+     for atr in atrlist repeat name(atr) = str => value(atr);
--+     construct ""
--+   }
--+ 
--+   setAttribute(e:%,str1:DOMString,str2:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   removeAttribute(e:%,str:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   getAttributeNS(e:%,str1:DOMString,str2:DOMString):DOMString == {
--+     error "not done yet"
--+   }
--+ 
--+   setAttributeNS(e:%,str1:DOMString,str2:DOMString,str3:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   removeAttributeNS(e:%,str1:DOMString,str2:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   hasAttribute(e:%,str:DOMString):Boolean == {
--+     error "not done yet"
--+   }
--+ 
--+   hasAttributeNS(e:%,str1:DOMString,str2:DOMString):Boolean == {
--+     error "not done yet"
--+   }
--+ 
--+   getAttributeNode(e:%,str:DOMString):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   setAttributeNode(e:%,atr:Attr):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   removeAttributeNode(e:%,atr:Attr):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   getElementsByTagName(e:%,str:DOMString):NodeList == {
--+     error "not done yet"
--+   }
--+ 
--+   getAttributeNodeNS(e:%,str1:DOMString,str2:DOMString):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   setAttributeNodeNS(e:%,atr:Attr):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   getElementsByTagNameNS(e:%,str1:DOMString,str2:DOMString):NodeList == {
--+     error "not done yet"
--+   }
--+ }
--+ 
--+ +++ Objects implementing the NamedNodeMap interface are used to represent
--+ +++ collections of nodes that can be accessed by name
--+ NamedNodeMap : NamedNodeMapCat with {
--+   construct : List(Record(label:DOMString,value:DOMString)) -> %;
--+     ++ construct a value of this type;
--+   getNamedItem : DOMString -> Node;
--+     ++ Retrieves a Nodeode specified by NodeName
--+   setNamedItem : Node -> Node;
--+     ++ Adds a node using its nodeName attribute. If a node with that name 
--+     ++ is already present in this map, it is replaced by the new one
--+   removeNamedItem : DOMString -> Node;
--+     ++ Removes a node specified by name. When this map contains the attributes
--+     ++ attached to an element, if the removed attribute is known to have a 
--+     ++ default value, an attribute immediately appears containing the default
--+     ++ value as well as the corresponding namespace URI, local name and prefix
--+     ++ when applicable
--+   item : SI -> Node;
--+     ++ Returns the indexth item in the map (where index is the parameter). If
--+     ++ index is greater or equal to the number of nodes in this map, this 
--+     ++ returns null.
--+   getNamedItemNS : (DOMString,DOMString) -> Node;
--+     ++ (introduced in DOM Level 2)
--+     ++ Retrieves a node specified by local name and namespace URI. HTML-only
--+     ++ DOM implementations do not need to implement this method
--+   setNamedItemNS : Node -> Node;
--+     ++ (introduced in DOM Level 2)
--+     ++ Adds a node using its namespaceURI and localName. If a node with that
--+     ++ namespace URI and that local name is already present in this map, it is
--+     ++ replaced by the new one. HTML-only DOM implementations do not need to
--+     ++ implement this method
--+   removeNamedItemNS : (DOMString,DOMString) -> Node;
--+     ++ (introduced in DOM Level 2)
--+     ++ Removes a node specified by local name and namespace URI. A removed
--+     ++ attribute may be known to have a default value when this map contains 
--+     ++ the attributes attached to an element, as returned by the attributes
--+     ++ attribute of the node interface. If so an attribute immediately appears 
--+     ++ containing the default value as well as the corresponding namespace URI,
--+     ++ local name and prefix when applicable. HTML-only DOM implementations do 
--+     ++ not need to implement this method
--+ } == add {
--+   Rep ==> List(Record(label:DOMString,value:DOMString));
--+ 
--+   construct(l:Rep):% == per l;
--+ 
--+   length(nodes:%):SI  == {
--+     error "not done yet"
--+   }
--+ 
--+   getNamedItem(name:DOMString):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   setNamedItem(n:Node):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   removeNamedItem(name:DOMString):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   item(i:SI):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   getNamedItemNS(ns:DOMString,name:DOMString):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   setNamedItemNS(n:Node):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   removeNamedItemNS(ns:DOMString,name:DOMString):Node == {
--+     error "not done yet"
--+   }
--+ 
--+ }
--+ 
--+ NodeList:NodeListCat with {
--+   << : (TextWriter,%) -> TextWriter;
--+     ++ render this element
--+   makeNodeList : List(Node) -> %;
--+     ++ construct an element of this domain
--+   item : (%,SI) -> Node;
--+     ++ Returns the indexth item in the collection. If index is greater than or 
--+     ++ equal to the number of nodes in the list, this erturns null.
--+   addChild : (Node,%) -> %;
--+     ++ Add a child to the NodeList. 
--+ } == add {
--+   Rep ==> List(Node);
--+   import from Rep;
--+ 
--+   (w: TextWriter) << (e: %): TextWriter == error "";
--+ 
--+   makeNodeList(ln:L(Node)):% == per ln;
--+ 
--+   length(nl:%):SI == #(rep nl);
--+ 
--+   item(nl:%,i:SI):Node == {
--+     import from Node;
--+     rep(nl).i
--+   }
--+ 
--+   addChild(n:Node,nl:%):% == {
--+     per(cons(n,rep nl));
--+   }
--+ }
--+ 
--+ Node:Join(NodeCat,NodeCatExtend) with {
--+   makeNode : (DOMString,NamedNodeMap,NodeList) -> %;
--+     ++ makeNode(tag,attr,kids) creates a node with a tag value of <it>tag</it>,
--+     ++ attributes specified by <it>attr</it> and children specified by <it>
--+     ++ kids</it>. <b>Development and really skinny boney thing.</b>
--+   makeNode : Record(
--+     attributes:Union(val:NamedNodeMap,failed:'failed'),
--+     childNodes:Union(val:NodeList,failed:'failed'),
--+     firstChild:Union(val:%,failed:'failed'),
--+     lastChild:Union(val:%,failed:'failed'),
--+     localName:Union(val:DOMString,failed:'failed'),
--+     namespaceURI:Union(val:DOMString,failed:'failed'),
--+     nextSibling:Union(val:%,failed:'failed'),
--+     nodeName:Union(val:DOMString,failed:'failed'),
--+     nodeType:Union(val:SI,failed:'failed'),
--+     nodeValue:Union(val:DOMString,failed:'failed'),
--+     ownerDocument:Union(val:Document,failed:'failed'),
--+     parentNode:Union(val:%,failed:'failed'),
--+     prefix:Union(val:DOMString,failed:'failed'),
--+     previousSibling:Union(val:%,failed:'failed')) -> %;
--+     ++ make a value of Node
--+   makeNode : (NamedNodeMap,NodeList,%,%,DOMString,DOMString,%,DOMString,
--+     SI,DOMString,Document,%,DOMString,%) -> %;
--+     ++ make a value of Node, the parameters are in the following order
--+     ++ makeNode(attributes,childNodes,firstChild,lastChild,localName,
--+     ++ namespaceURI,nextSibling,nodeName,nodeType,nodeValue,ownerDocument,
--+     ++ parentNode,prefix,previousSibling)
--+ } == add {
--+   Rep ==> Record(
--+     attributes:Union(val:NamedNodeMap,failed:'failed'),
--+     childNodes:Union(val:NodeList,failed:'failed'),
--+     firstChild:Union(val:%,failed:'failed'),
--+     lastChild:Union(val:%,failed:'failed'),
--+     localName:Union(val:DOMString,failed:'failed'),
--+     namespaceURI:Union(val:DOMString,failed:'failed'),
--+     nextSibling:Union(val:%,failed:'failed'),
--+     nodeName:Union(val:DOMString,failed:'failed'),
--+     nodeType:Union(val:SI,failed:'failed'),
--+     nodeValue:Union(val:DOMString,failed:'failed'),
--+     ownerDocument:Union(val:Document,failed:'failed'),
--+     parentNode:Union(val:%,failed:'failed'),
--+     prefix:Union(val:DOMString,failed:'failed'),
--+     previousSibling:Union(val:%,failed:'failed'));
--+ 
--+   import from Rep;
--+ 
--+   makeNode(tag:DOMString,attrs:NamedNodeMap,kids:NodeList):% == error "kj";
--+ 
--+   makeNode(r:Rep):% == per r;
--+ 
--+   makeNode(a:NamedNodeMap,cn:NodeList,fc:%,lc:%,ln:DOMString,ns:DOMString,
--+               nxts:%,nn:DOMString,nt:SI,nv:DOMString,od:Document,pn:%
--+               ,prefx:DOMString,prevsib:%):% == per [[a],[cn],[fc],[lc],[ln],
--+     [ns],[nxts],[nn],[nt],[nv],[od],[pn],[prefx],[prevsib]];
--+ 
--+   -- attributes
--+   nodeName(n:%):DOMString == rep(n).nodeName.val;
--+ 
--+   nodeValue(n:%):DOMString == rep(n).nodeValue.val;
--+ 
--+   nodeType(n:%):SI ==  rep(n).nodeType.val;
--+ 
--+   parentNode(n:%):% ==  rep(n).parentNode.val;
--+   childNodes(n:%):NodeList ==  rep(n).childNodes.val;
--+ 
--+   firstChild(n:%):% ==  rep(n).firstChild.val;
--+ 
--+   lastChild(n:%):% ==  rep(n).lastChild.val;
--+ 
--+   previousSibling(n:%):% ==  rep(n).previousSibling.val;
--+ 
--+   nextSibling(n:%):% ==  rep(n).nextSibling.val;
--+ 
--+   attributes(n:%):NamedNodeMap == rep(n).attributes.val;
--+ 
--+   ownerDocument(n:%):Document == rep(n).ownerDocument.val;
--+ 
--+   prefix(n:%):DOMString == rep(n).prefix.val;
--+ 
--+   localName(n:%):DOMString == rep(n).localName.val;
--+ 
--+   namespaceURI(n:%):DOMString == rep(n).namespaceURI.val;
--+ 
--+   -- methods
--+ --  insertBefore(n:(%,PTR(%)) -> PTR(%);
--+ --  replaceChild(n:(%,PTR(%)) -> PTR(%);
--+ --  removeChild(n:PTR(%) -> %;
--+   appendChild(n1:%,newChild:%):% == {
--+     children:NodeList := childNodes(n1);
--+     -- check if in the tree ***Not Done***
--+ --    rep(n1).childNodes := [addChild(newChild,children)];
--+     n1
--+   }
--+ 
--+   hasChildNodes(n:%):Boolean == {
--+     rep(n).childNodes case val => true;
--+     false
--+   }
--+ 
--+   cloneNode(n:%):% == {
--+     error "not done yet"
--+   }
--+ 
--+   normalize(n:%):% == {
--+     error "not done yet"
--+   }
--+ 
--+   isSupported(str1:DOMString,str2:DOMString):Boolean == {
--+     error "not done yet"
--+   }
--+ 
--+   hasAttributes(n:%):B == {
--+     rep(n).attributes case val => true;
--+     false
--+   }
--+ }
--+ 
--+ +++ The Document interface represents the entire XML document. Conceptually, 
--+ +++ it is the root of the document tree and provides the primary access to the 
--+ +++ documents data.
--+ Document : Join(NodeCat,NodeCatExtend) with {
--+   doctype : % -> DocumentType;
--+     ++ The Document Type Decleration associated with this document.
--+   implementation : % -> DOMImplementation;
--+     ++ The DOMImplementation object that handles this document.
--+   documentElement : % -> Element;
--+     ++ This is a convenience attribute that allows direct access to the chils
--+     ++ node that is the root element of the document.
--+   createElement : DOMString -> Element;
--+     ++ Creates an element of the type specified.
--+   createDocumentFragment : () -> DocumentFragment;
--+     ++ Creates an empty DocumentFragment object.
--+   createTextNode : DOMString -> Text;
--+     ++ Creates a Text node given the specified string.
--+   createComment : DOMString -> Comment;
--+     ++ Creates a Comment node given the specified string.
--+   createCDATASection : DOMString -> CDATASection;
--+     ++ Creates a CDATASection node whos value is the specified string.
--+   createProcessingInstruction : (DOMString,DOMString) -> ProcessingInstruction;
--+     ++ Creates a ProcessingInstruction node given the specified name and
--+     ++ data strings.
--+   createAttribute : DOMString -> Attr;
--+     ++ Creates an Attr of the given node.
--+   createEntityReference : DOMString -> EntityReference;
--+     ++ Creates an EntityReference object. In addition, if the refernced entity
--+     ++ is known, the child list of the EntityReference node is made the same
--+     ++ as that of the corresponding Entity node.
--+   getElementsByTagName : DOMString -> NodeList;
--+     ++ Returns a NodeList of all the Elements with a given tag name in the 
--+     ++ order in which they are encountered in a preorder traversal of the 
--+     ++ Document tree.
--+   importNode : (Node,Boolean) -> Node;
--+     ++ (introduced in DOM Level 2)
--+     ++ Imports a node from another document to this document. The returned
--+     ++ node has no parent; (parentNode is null). The source node is not
--+     ++ altered or removed from the original document.
--+   createElementNS : (DOMString,DOMString) -> Element;
--+     ++ (introduced in DOM Level 2)
--+     ++ Creates an element of the given qualified name and namespace URI.
--+   createAttributeNS : (DOMString,DOMString) -> Attr;
--+     ++ (introduced in DOM Level 2)
--+     ++ Creates an attribute of the given qualified name and namespace URI.
--+   getElementByTagNameNS : (DOMString,DOMString) -> NodeList;
--+     ++ (introduced in DOM Level 2)
--+     ++ Returns a NodeList of all the Elements with a given local name and 
--+     ++ namespace URI in the order in which they are encountered in a preorder
--+     ++ traversal of the Document tree.
--+   getElementById : DOMString -> Element;
--+     ++ (introduced in DOM Level 2)
--+     ++ Returns the Element whose ID is given by elementID. If no such element
--+     ++ exists, returns null. Behaviour is not defined if more than one element
--+     ++ has this ID.
--+ } == Node add {
--+   Rep ==> Record(doctype:DocumentType,
--+                  implementation:DOMImplementation,
--+                  docElement:Element);
--+ 
--+   import from Rep;
--+ 
--+   doctype(d:%):DocumentType == rep(d).doctype;
--+ 
--+   implementation(d:%):DOMImplementation == rep(d).implementation;
--+ 
--+   documentElement(d:%):Element == rep(d).docElement;
--+ 
--+   createElement(el:DOMString):Element == {
--+     import from L(Attr),L(Node);
--+     makeElement(el,[],[])
--+   }
--+ 
--+   createDocumentFragment():DocumentFragment == {
--+     error "not done yet"
--+   }
--+ 
--+   createTextNode(tn:DOMString):Text == {
--+     error "not done yet"
--+   }
--+ 
--+   createComment(com:DOMString):Comment == {
--+     error "not done yet"
--+   }
--+ 
--+   createCDATASection(dataseg:DOMString):CDATASection == {
--+     error "not done yet"
--+   }
--+ 
--+   createProcessingInstruction(pi:DOMString,str:DOMString):ProcessingInstruction == {
--+     error "not done yet"
--+   }
--+ 
--+   createAttribute(at:DOMString):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   createEntityReference(eref:DOMString):EntityReference == {
--+     error "not done yet"
--+   }
--+ 
--+   getElementsByTagName(tname:DOMString):NodeList == {
--+     error "not done yet"
--+   }
--+ 
--+   importNode(n:Node,fl:Boolean):Node == {
--+     error "not done yet"
--+   }
--+ 
--+   createElementNS(ns:DOMString,name:DOMString):Element == {
--+     error "not done yet"
--+   }
--+ 
--+   createAttributeNS(ns:DOMString,at:DOMString):Attr == {
--+     error "not done yet"
--+   }
--+ 
--+   getElementByTagNameNS(ns:DOMString,tag:DOMString):NodeList == {
--+     error "not done yet"
--+   }
--+ 
--+   getElementById(id:DOMString):Element == {
--+     error "not done yet"
--+   }
--+ }
--+ 
--+ EntityReference : with {
--+   length : % -> SI;
--+ } == add {
--+   length(x:%):SI == 1;
--+ }
--+ 
--+ ProcessingInstruction : with {
--+   length : % -> SI;
--+ } == add {
--+   length(x:%):SI == 1;
--+ }
--+ 
--+ CDATASection : with {
--+   length : % -> SI;
--+ } == add {
--+   length(x:%):SI == 1;
--+ }
--+ 
--+ +++ The CharacterData interface extends Node with a set of attributes and
--+ +++ methods for accessing character data in the DOM. For clarity this set is 
--+ +++ defined here rather than on each object that uses these attributes and
--+ +++ methods. No DOM objects correspond directly to CharacterData, though Text
--+ +++ and others do inherit the interface from it. All offsets in this interface
--+ +++ start from 0.
--+ CharacterData:CharacterDataCat  == Node add {
--+   Rep ==> DOMString;
--+ 
--+   import from Machine,Rep;
--+ 
--+   data(cd:%):DOMString == {
--+     error "not done yet"
--+   }
--+ 
--+   length(cd:%):SI == {
--+     error "not done yet"
--+   }
--+ 
--+   substringData(cd:%,offset:SI,count:SI):DOMString == {
--+     error "not done yet"
--+   }
--+ 
--+   appendData(cd:%,arg:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   insertData(cd:%,offset:SI,arg:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   deleteData(cd:%,offset:SI,count:SI):Ptr == {
--+     error "not done yet"
--+   }
--+ 
--+   replaceData(cd:%,offset:SI,count:SI,arg:DOMString):Ptr == {
--+     error "not done yet"
--+   }
--+ }
--+ 
--+ +++ The Text interface inherits from CharacterData and represents the textual 
--+ +++ content of an Element or Attr.
--+ Text:CharacterDataCat with {
--+   splitText : (%,SI) -> %;
--+     ++ Breaks this noe into two nodes at the specified offset, keeping both
--+     ++ in the tree as siblings
--+ } == CharacterData add {
--+   splitText(text:%,offset:SI):% == {
--+     error "not done yet"
--+   }
--+ }
--+ 
--+ +++ DocumentFragment is a "lightweight" or "minimal" Document object. Intended
--+ +++ for holding a part of a Document tree.
--+ DocumentFragment : Join(NodeCat,NodeCatExtend) == Node;
--+ 
--+ +++ The DOMImplementation interface provides a number of methods for performing
--+ +++ operations that are independant of any particular instance of the document
--+ +++ object model.
--+ DOMImplementation : with {
--+   hasFeature : (DOMString,DOMString) -> B;
--+     ++ Tests if the DOM implementation implements a specific feature.
--+   createDocumentType : (DOMString,DOMString,DOMString) -> DocumentType;
--+     ++ Creates an empty DocumentType node. 
--+   createDocument : (DOMString,DOMString,DocumentType) -> Document;
--+     ++ Creates an XML Document object of the specified type with its document 
--+     ++ element.
--+ } == add {
--+ 
--+   hasFeature(feature:DOMString,version:DOMString):B == {
--+     error "not done yet"
--+   }
--+ 
--+   createDocumentType(name:DOMString,pid:DOMString,sid:DOMString):DocumentType == {
--+     error "not done yet"
--+   }
--+ 
--+   createDocument(ns:DOMString,name:DOMString,dtype:DocumentType):Document == {
--+     error "not done yet"
--+   }
--+ 
--+ }
--+ 
--+ DocumentType : Join(NodeCat,NodeCatExtend) with {
--+   name : % -> DOMString;
--+   entities : % -> NamedNodeMap;
--+   notations : % -> NamedNodeMap;
--+   publicId : % -> DOMString;
--+   systemId : % -> DOMString;
--+   internalSubset : % -> DOMString;
--+ } == Node add {
--+   name(x:%):DOMString  == {
--+     error "not done yet"
--+   }
--+ 
--+   entities(x:%):NamedNodeMap  == {
--+     error "not done yet"
--+   }
--+ 
--+   notations(x:%):NamedNodeMap  == {
--+     error "not done yet"
--+   }
--+ 
--+   publicId(x:%):DOMString  == {
--+     error "not done yet"
--+   }
--+  
--+   systemId(x:%):DOMString  == {
--+     error "not done yet"
--+   }
--+  
--+   internalSubset(x:%):DOMString   == {
--+     error "not done yet"
--+   }
--+ }
#include "axllib.as"

#library BasicLibrary "xmlbasics.ao"
#library BasicCats "xmlbasiccats.ao"

import from BasicLibrary;
import from BasicCats;

B ==> Boolean;
L ==> List;
R ==> Record;
T ==> Tuple;
M ==> Machine;
BY ==> Byte;
SI ==> SingleInteger;
STR ==> String;
PTR ==> Pointer;
NSP ==> NumberScanPackage;

define NodeCatExtend:Category == with {
  childNodes : % -> NodeList;
    ++ A NodeList that contains all children of this node. If there are no 
    ++ children, this is a NodeList containing no nodes
  attributes : % -> NamedNodeMap;
    ++ A NamedNodeMap containing the attributes of this node (if it is an 
    ++ element) or null otherwise
  ownerDocument : % -> Document;
    ++ (introduced in DOM Level 2)
    ++ The Document object associated with this node. This is also the 
    ++ Document object used to create new nodes. When this node is a Document 
    ++ or a DocumentType which is not used with any Document yet, this is null

  -- methods
--  insertBefore : (%,PTR(%)) -> PTR(%);
    ++ Inserts the node newChild (the first parameter) before the existing 
    ++ child node refChild (the second parameter). If refChild is null, insert 
    ++ newChild at the end of the list of children.<XML><BR></XML>
    ++ If newChild is a Document Fragment object, all of its children are 
    ++ inserted, in the same order before refChild. If the newChild is already
    ++ in the tree, it is first removed.
--  replaceChild : (%,PTR(%)) -> PTR(%);
    ++ replaces the child node oldChild (the second parameter) with newChild
    ++ (the first parameter) in the list of children, and returns the oldChild
    ++ node.
--  removeChild : PTR(%) -> %;
    ++ Removes the child node indicated by oldChild from the list of children,
    ++ and returns it.
}

define CharacterDataCat:Category == Join(NodeCat,NodeCatExtend) with {
  import from Machine;

  data : % -> DOMString;
    ++ The character data of the node that implements this interface.
  length : % -> SI;
    ++ The number of 16-bit units that are available through data and the.
    ++ substring data methods below.
  substringData : (%,SI,SI) -> DOMString;
    ++ Extracts a range of data from the node.
  appendData : (%,DOMString) -> Ptr;
    ++ Append the string to the end of the character data of the node. Upon
    ++ success, data provides access to the concatenation of data and the 
    ++ DOMString specified.
  insertData : (%,SI,DOMString) -> Ptr;
    ++ Insert a string at the specified 16-bit unti offset.
  deleteData : (%,SI,SI) -> Ptr;
    ++ Remove a range of 16-bit units from the node. Upon success data and 
    ++ length reflect the change.
  replaceData : (%,SI,SI,DOMString) -> Ptr;
    ++ Replace the characters starting at the specified 16-unit offset with 
    ++ the specified string.
}

+++ This Interface inherits from CharacterData and represents the content of
+++ a comment between the starting '<!--@ and ending '-->'
Comment : CharacterDataCat with {
  makeComment : DOMString -> %;
    ++ make a Comment
} == CharacterData add {
  Rep ==> DOMString;
  makeComment(str:DOMString):% == per str;
}

define ElementCatExtend:Category == with {
  getAttributeNode : (%,DOMString) -> Attr;
   ++ Retrieves an attribute node by name.
  setAttributeNode : (%,Attr) -> Attr;
    ++ Adds a new attribute node. If an attribute with that name (nodename) is
    ++ allready present in the element, it is replaced by the new one.
  removeAttributeNode :  (%,Attr) -> Attr;
    ++ Removes an attribute by name. If the removed attribute is known to have
    ++ a default value, an attribute immediately appears containing the default
    ++ value as well as the corresponding namespace URI, local name, and prefix
    ++ when applicable.
  getElementsByTagName : (%,DOMString) -> NodeList;
    ++ Returns a NodeList of all descendant Elements with a given tag name, in
    ++ the order in which they are encountered.
  getAttributeNodeNS : (%,DOMString,DOMString) -> Attr;
    ++ (introduced in DOM Level 2)
    ++ Retrieves an Attr node by local name and namespace URI.
  setAttributeNodeNS : (%,Attr) -> Attr;
    ++ (introduced in DOM Level 2)
    ++ Adds a new attribute. If an attribute with that local name and that name
    ++ space URI is already present in the element, it is replaced by the new 
    ++ one.
  getElementsByTagNameNS : (%,DOMString,DOMString) -> NodeList;
    ++ (introduced in DOM Level 2)
    ++ Returns a NodeList of all the descending Elements with a given local 
    ++ name and namespace URI in the order in which thet are encountered in a 
    ++ preorder traversal of this Element tree.
}

Attr:Join(AttrCat,NodeCat,NodeCatExtend) with {
  ownerElement : % -> Element;
    ++ The Element node this attribute is attached to, or null if this 
    ++ attribute is not in use.
  makeAttr : (DOMString,DOMString,Element) -> %;
    ++ make an instance of this domain, we note that to avoid infinite 
    ++ recursion we should specify the owner Element without this attribute
    ++ N.B. we need to change this to use pointers instead (I think)
} == Node add {
  Rep ==> Record(name:DOMString,value:DOMString,owner:Element);

  import from Rep;

  makeAttr(name:DOMString,val:DOMString,el:Element):% == per [name,val,el];

  ownerElement(a:%):Element == rep(a).owner;

  name(a:%):DOMString == rep(a).name;

  specified(a:%):Boolean == {
    error "not implemented yet"
  }

  value(a:%):DOMString == rep(a).value;
}

Element:Join(ElementCat,NodeCat,NodeCatExtend,ElementCatExtend) with {
  << : (TextWriter,%) -> TextWriter;
    ++ render this element
  makeElement : (DOMString,L(Attr),L(Node)) -> %;
    ++ make a value of this domain
}== Node add {
  Rep ==> Record(tag:DOMString,atrList:L(atr:Attr),childList:L(Node));

  import from Machine,Rep;

  (w: TextWriter) << (e: %): TextWriter == {
    import from NodeList,SI,String,DOMString;
    erep := rep e;
    if length childNodes e = 0 then 
      return(print << "<" << (erep.tag) << "/>" << newline)
    else {
      w := print << "<" << (erep.tag) << ">" << newline;
      w := print << childNodes(e);
      w := print << "</" << (erep.tag) << ">" << newline;
    }
    w
  }

  childNodes(e:%):NodeList == {
    makeNodeList(rep(e).childList)
  }

  attributes(x:%):NamedNodeMap == error "not done yet";

  makeElement(str:DOMString,la:L(Attr),ln:L(Node)):% == per([str,la,ln]);

  tagName(e:%):DOMString == {
    erep:Rep := rep e;
    erep.tag
  }

  getAttribute(e:%,str:DOMString):DOMString == {
    import from Attr,String;
    erep:Rep := rep e; atrlist:L(Attr) := erep.atrList;
    for atr in atrlist repeat name(atr) = str => value(atr);
    construct ""
  }

  setAttribute(e:%,str1:DOMString,str2:DOMString):Ptr == {
    error "not done yet"
  }

  removeAttribute(e:%,str:DOMString):Ptr == {
    error "not done yet"
  }

  getAttributeNS(e:%,str1:DOMString,str2:DOMString):DOMString == {
    error "not done yet"
  }

  setAttributeNS(e:%,str1:DOMString,str2:DOMString,str3:DOMString):Ptr == {
    error "not done yet"
  }

  removeAttributeNS(e:%,str1:DOMString,str2:DOMString):Ptr == {
    error "not done yet"
  }

  hasAttribute(e:%,str:DOMString):Boolean == {
    error "not done yet"
  }

  hasAttributeNS(e:%,str1:DOMString,str2:DOMString):Boolean == {
    error "not done yet"
  }

  getAttributeNode(e:%,str:DOMString):Attr == {
    error "not done yet"
  }

  setAttributeNode(e:%,atr:Attr):Attr == {
    error "not done yet"
  }

  removeAttributeNode(e:%,atr:Attr):Attr == {
    error "not done yet"
  }

  getElementsByTagName(e:%,str:DOMString):NodeList == {
    error "not done yet"
  }

  getAttributeNodeNS(e:%,str1:DOMString,str2:DOMString):Attr == {
    error "not done yet"
  }

  setAttributeNodeNS(e:%,atr:Attr):Attr == {
    error "not done yet"
  }

  getElementsByTagNameNS(e:%,str1:DOMString,str2:DOMString):NodeList == {
    error "not done yet"
  }
}

+++ Objects implementing the NamedNodeMap interface are used to represent
+++ collections of nodes that can be accessed by name
NamedNodeMap : NamedNodeMapCat with {
  construct : List(Record(label:DOMString,value:DOMString)) -> %;
    ++ construct a value of this type;
  getNamedItem : DOMString -> Node;
    ++ Retrieves a Nodeode specified by NodeName
  setNamedItem : Node -> Node;
    ++ Adds a node using its nodeName attribute. If a node with that name 
    ++ is already present in this map, it is replaced by the new one
  removeNamedItem : DOMString -> Node;
    ++ Removes a node specified by name. When this map contains the attributes
    ++ attached to an element, if the removed attribute is known to have a 
    ++ default value, an attribute immediately appears containing the default
    ++ value as well as the corresponding namespace URI, local name and prefix
    ++ when applicable
  item : SI -> Node;
    ++ Returns the indexth item in the map (where index is the parameter). If
    ++ index is greater or equal to the number of nodes in this map, this 
    ++ returns null.
  getNamedItemNS : (DOMString,DOMString) -> Node;
    ++ (introduced in DOM Level 2)
    ++ Retrieves a node specified by local name and namespace URI. HTML-only
    ++ DOM implementations do not need to implement this method
  setNamedItemNS : Node -> Node;
    ++ (introduced in DOM Level 2)
    ++ Adds a node using its namespaceURI and localName. If a node with that
    ++ namespace URI and that local name is already present in this map, it is
    ++ replaced by the new one. HTML-only DOM implementations do not need to
    ++ implement this method
  removeNamedItemNS : (DOMString,DOMString) -> Node;
    ++ (introduced in DOM Level 2)
    ++ Removes a node specified by local name and namespace URI. A removed
    ++ attribute may be known to have a default value when this map contains 
    ++ the attributes attached to an element, as returned by the attributes
    ++ attribute of the node interface. If so an attribute immediately appears 
    ++ containing the default value as well as the corresponding namespace URI,
    ++ local name and prefix when applicable. HTML-only DOM implementations do 
    ++ not need to implement this method
} == add {
  Rep ==> List(Record(label:DOMString,value:DOMString));

  construct(l:Rep):% == per l;

  length(nodes:%):SI  == {
    error "not done yet"
  }

  getNamedItem(name:DOMString):Node == {
    error "not done yet"
  }

  setNamedItem(n:Node):Node == {
    error "not done yet"
  }

  removeNamedItem(name:DOMString):Node == {
    error "not done yet"
  }

  item(i:SI):Node == {
    error "not done yet"
  }

  getNamedItemNS(ns:DOMString,name:DOMString):Node == {
    error "not done yet"
  }

  setNamedItemNS(n:Node):Node == {
    error "not done yet"
  }

  removeNamedItemNS(ns:DOMString,name:DOMString):Node == {
    error "not done yet"
  }

}

NodeList:NodeListCat with {
  << : (TextWriter,%) -> TextWriter;
    ++ render this element
  makeNodeList : List(Node) -> %;
    ++ construct an element of this domain
  item : (%,SI) -> Node;
    ++ Returns the indexth item in the collection. If index is greater than or 
    ++ equal to the number of nodes in the list, this erturns null.
  addChild : (Node,%) -> %;
    ++ Add a child to the NodeList. 
} == add {
  Rep ==> List(Node);
  import from Rep;

  (w: TextWriter) << (e: %): TextWriter == error "";

  makeNodeList(ln:L(Node)):% == per ln;

  length(nl:%):SI == #(rep nl);

  item(nl:%,i:SI):Node == {
    import from Node;
    rep(nl).i
  }

  addChild(n:Node,nl:%):% == {
    per(cons(n,rep nl));
  }
}

Node:Join(NodeCat,NodeCatExtend) with {
  makeNode : (DOMString,NamedNodeMap,NodeList) -> %;
    ++ makeNode(tag,attr,kids) creates a node with a tag value of <it>tag</it>,
    ++ attributes specified by <it>attr</it> and children specified by <it>
    ++ kids</it>. <b>Development and really skinny boney thing.</b>
  makeNode : Record(
    attributes:Union(val:NamedNodeMap,failed:'failed'),
    childNodes:Union(val:NodeList,failed:'failed'),
    firstChild:Union(val:%,failed:'failed'),
    lastChild:Union(val:%,failed:'failed'),
    localName:Union(val:DOMString,failed:'failed'),
    namespaceURI:Union(val:DOMString,failed:'failed'),
    nextSibling:Union(val:%,failed:'failed'),
    nodeName:Union(val:DOMString,failed:'failed'),
    nodeType:Union(val:SI,failed:'failed'),
    nodeValue:Union(val:DOMString,failed:'failed'),
    ownerDocument:Union(val:Document,failed:'failed'),
    parentNode:Union(val:%,failed:'failed'),
    prefix:Union(val:DOMString,failed:'failed'),
    previousSibling:Union(val:%,failed:'failed')) -> %;
    ++ make a value of Node
  makeNode : (NamedNodeMap,NodeList,%,%,DOMString,DOMString,%,DOMString,
    SI,DOMString,Document,%,DOMString,%) -> %;
    ++ make a value of Node, the parameters are in the following order
    ++ makeNode(attributes,childNodes,firstChild,lastChild,localName,
    ++ namespaceURI,nextSibling,nodeName,nodeType,nodeValue,ownerDocument,
    ++ parentNode,prefix,previousSibling)
} == add {
  Rep ==> Record(
    attributes:Union(val:NamedNodeMap,failed:'failed'),
    childNodes:Union(val:NodeList,failed:'failed'),
    firstChild:Union(val:%,failed:'failed'),
    lastChild:Union(val:%,failed:'failed'),
    localName:Union(val:DOMString,failed:'failed'),
    namespaceURI:Union(val:DOMString,failed:'failed'),
    nextSibling:Union(val:%,failed:'failed'),
    nodeName:Union(val:DOMString,failed:'failed'),
    nodeType:Union(val:SI,failed:'failed'),
    nodeValue:Union(val:DOMString,failed:'failed'),
    ownerDocument:Union(val:Document,failed:'failed'),
    parentNode:Union(val:%,failed:'failed'),
    prefix:Union(val:DOMString,failed:'failed'),
    previousSibling:Union(val:%,failed:'failed'));

  import from Rep;

  makeNode(tag:DOMString,attrs:NamedNodeMap,kids:NodeList):% == error "kj";

  makeNode(r:Rep):% == per r;

  makeNode(a:NamedNodeMap,cn:NodeList,fc:%,lc:%,ln:DOMString,ns:DOMString,
              nxts:%,nn:DOMString,nt:SI,nv:DOMString,od:Document,pn:%
              ,prefx:DOMString,prevsib:%):% == per [[a],[cn],[fc],[lc],[ln],
    [ns],[nxts],[nn],[nt],[nv],[od],[pn],[prefx],[prevsib]];

  -- attributes
  nodeName(n:%):DOMString == rep(n).nodeName.val;

  nodeValue(n:%):DOMString == rep(n).nodeValue.val;

  nodeType(n:%):SI ==  rep(n).nodeType.val;

  parentNode(n:%):% ==  rep(n).parentNode.val;
  childNodes(n:%):NodeList ==  rep(n).childNodes.val;

  firstChild(n:%):% ==  rep(n).firstChild.val;

  lastChild(n:%):% ==  rep(n).lastChild.val;

  previousSibling(n:%):% ==  rep(n).previousSibling.val;

  nextSibling(n:%):% ==  rep(n).nextSibling.val;

  attributes(n:%):NamedNodeMap == rep(n).attributes.val;

  ownerDocument(n:%):Document == rep(n).ownerDocument.val;

  prefix(n:%):DOMString == rep(n).prefix.val;

  localName(n:%):DOMString == rep(n).localName.val;

  namespaceURI(n:%):DOMString == rep(n).namespaceURI.val;

  -- methods
--  insertBefore(n:(%,PTR(%)) -> PTR(%);
--  replaceChild(n:(%,PTR(%)) -> PTR(%);
--  removeChild(n:PTR(%) -> %;
  appendChild(n1:%,newChild:%):% == {
    children:NodeList := childNodes(n1);
    -- check if in the tree ***Not Done***
--    rep(n1).childNodes := [addChild(newChild,children)];
    n1
  }

  hasChildNodes(n:%):Boolean == {
    rep(n).childNodes case val => true;
    false
  }

  cloneNode(n:%):% == {
    error "not done yet"
  }

  normalize(n:%):% == {
    error "not done yet"
  }

  isSupported(str1:DOMString,str2:DOMString):Boolean == {
    error "not done yet"
  }

  hasAttributes(n:%):B == {
    rep(n).attributes case val => true;
    false
  }
}

+++ The Document interface represents the entire XML document. Conceptually, 
+++ it is the root of the document tree and provides the primary access to the 
+++ documents data.
Document : Join(NodeCat,NodeCatExtend) with {
  doctype : % -> DocumentType;
    ++ The Document Type Decleration associated with this document.
  implementation : % -> DOMImplementation;
    ++ The DOMImplementation object that handles this document.
  documentElement : % -> Element;
    ++ This is a convenience attribute that allows direct access to the chils
    ++ node that is the root element of the document.
  createElement : DOMString -> Element;
    ++ Creates an element of the type specified.
  createDocumentFragment : () -> DocumentFragment;
    ++ Creates an empty DocumentFragment object.
  createTextNode : DOMString -> Text;
    ++ Creates a Text node given the specified string.
  createComment : DOMString -> Comment;
    ++ Creates a Comment node given the specified string.
  createCDATASection : DOMString -> CDATASection;
    ++ Creates a CDATASection node whos value is the specified string.
  createProcessingInstruction : (DOMString,DOMString) -> ProcessingInstruction;
    ++ Creates a ProcessingInstruction node given the specified name and
    ++ data strings.
  createAttribute : DOMString -> Attr;
    ++ Creates an Attr of the given node.
  createEntityReference : DOMString -> EntityReference;
    ++ Creates an EntityReference object. In addition, if the refernced entity
    ++ is known, the child list of the EntityReference node is made the same
    ++ as that of the corresponding Entity node.
  getElementsByTagName : DOMString -> NodeList;
    ++ Returns a NodeList of all the Elements with a given tag name in the 
    ++ order in which they are encountered in a preorder traversal of the 
    ++ Document tree.
  importNode : (Node,Boolean) -> Node;
    ++ (introduced in DOM Level 2)
    ++ Imports a node from another document to this document. The returned
    ++ node has no parent; (parentNode is null). The source node is not
    ++ altered or removed from the original document.
  createElementNS : (DOMString,DOMString) -> Element;
    ++ (introduced in DOM Level 2)
    ++ Creates an element of the given qualified name and namespace URI.
  createAttributeNS : (DOMString,DOMString) -> Attr;
    ++ (introduced in DOM Level 2)
    ++ Creates an attribute of the given qualified name and namespace URI.
  getElementByTagNameNS : (DOMString,DOMString) -> NodeList;
    ++ (introduced in DOM Level 2)
    ++ Returns a NodeList of all the Elements with a given local name and 
    ++ namespace URI in the order in which they are encountered in a preorder
    ++ traversal of the Document tree.
  getElementById : DOMString -> Element;
    ++ (introduced in DOM Level 2)
    ++ Returns the Element whose ID is given by elementID. If no such element
    ++ exists, returns null. Behaviour is not defined if more than one element
    ++ has this ID.
} == Node add {
  Rep ==> Record(doctype:DocumentType,
                 implementation:DOMImplementation,
                 docElement:Element);

  import from Rep;

  doctype(d:%):DocumentType == rep(d).doctype;

  implementation(d:%):DOMImplementation == rep(d).implementation;

  documentElement(d:%):Element == rep(d).docElement;

  createElement(el:DOMString):Element == {
    import from L(Attr),L(Node);
    makeElement(el,[],[])
  }

  createDocumentFragment():DocumentFragment == {
    error "not done yet"
  }

  createTextNode(tn:DOMString):Text == {
    error "not done yet"
  }

  createComment(com:DOMString):Comment == {
    error "not done yet"
  }

  createCDATASection(dataseg:DOMString):CDATASection == {
    error "not done yet"
  }

  createProcessingInstruction(pi:DOMString,str:DOMString):ProcessingInstruction == {
    error "not done yet"
  }

  createAttribute(at:DOMString):Attr == {
    error "not done yet"
  }

  createEntityReference(eref:DOMString):EntityReference == {
    error "not done yet"
  }

  getElementsByTagName(tname:DOMString):NodeList == {
    error "not done yet"
  }

  importNode(n:Node,fl:Boolean):Node == {
    error "not done yet"
  }

  createElementNS(ns:DOMString,name:DOMString):Element == {
    error "not done yet"
  }

  createAttributeNS(ns:DOMString,at:DOMString):Attr == {
    error "not done yet"
  }

  getElementByTagNameNS(ns:DOMString,tag:DOMString):NodeList == {
    error "not done yet"
  }

  getElementById(id:DOMString):Element == {
    error "not done yet"
  }
}

EntityReference : with {
  length : % -> SI;
} == add {
  length(x:%):SI == 1;
}

ProcessingInstruction : with {
  length : % -> SI;
} == add {
  length(x:%):SI == 1;
}

CDATASection : with {
  length : % -> SI;
} == add {
  length(x:%):SI == 1;
}

+++ The CharacterData interface extends Node with a set of attributes and
+++ methods for accessing character data in the DOM. For clarity this set is 
+++ defined here rather than on each object that uses these attributes and
+++ methods. No DOM objects correspond directly to CharacterData, though Text
+++ and others do inherit the interface from it. All offsets in this interface
+++ start from 0.
CharacterData:CharacterDataCat  == Node add {
  Rep ==> DOMString;

  import from Machine,Rep;

  data(cd:%):DOMString == {
    error "not done yet"
  }

  length(cd:%):SI == {
    error "not done yet"
  }

  substringData(cd:%,offset:SI,count:SI):DOMString == {
    error "not done yet"
  }

  appendData(cd:%,arg:DOMString):Ptr == {
    error "not done yet"
  }

  insertData(cd:%,offset:SI,arg:DOMString):Ptr == {
    error "not done yet"
  }

  deleteData(cd:%,offset:SI,count:SI):Ptr == {
    error "not done yet"
  }

  replaceData(cd:%,offset:SI,count:SI,arg:DOMString):Ptr == {
    error "not done yet"
  }
}

+++ The Text interface inherits from CharacterData and represents the textual 
+++ content of an Element or Attr.
Text:CharacterDataCat with {
  splitText : (%,SI) -> %;
    ++ Breaks this noe into two nodes at the specified offset, keeping both
    ++ in the tree as siblings
} == CharacterData add {
  splitText(text:%,offset:SI):% == {
    error "not done yet"
  }
}

+++ DocumentFragment is a "lightweight" or "minimal" Document object. Intended
+++ for holding a part of a Document tree.
DocumentFragment : Join(NodeCat,NodeCatExtend) == Node;

+++ The DOMImplementation interface provides a number of methods for performing
+++ operations that are independant of any particular instance of the document
+++ object model.
DOMImplementation : with {
  hasFeature : (DOMString,DOMString) -> B;
    ++ Tests if the DOM implementation implements a specific feature.
  createDocumentType : (DOMString,DOMString,DOMString) -> DocumentType;
    ++ Creates an empty DocumentType node. 
  createDocument : (DOMString,DOMString,DocumentType) -> Document;
    ++ Creates an XML Document object of the specified type with its document 
    ++ element.
} == add {

  hasFeature(feature:DOMString,version:DOMString):B == {
    error "not done yet"
  }

  createDocumentType(name:DOMString,pid:DOMString,sid:DOMString):DocumentType == {
    error "not done yet"
  }

  createDocument(ns:DOMString,name:DOMString,dtype:DocumentType):Document == {
    error "not done yet"
  }

}

DocumentType : Join(NodeCat,NodeCatExtend) with {
  name : % -> DOMString;
  entities : % -> NamedNodeMap;
  notations : % -> NamedNodeMap;
  publicId : % -> DOMString;
  systemId : % -> DOMString;
  internalSubset : % -> DOMString;
} == Node add {
  name(x:%):DOMString  == {
    error "not done yet"
  }

  entities(x:%):NamedNodeMap  == {
    error "not done yet"
  }

  notations(x:%):NamedNodeMap  == {
    error "not done yet"
  }

  publicId(x:%):DOMString  == {
    error "not done yet"
  }
 
  systemId(x:%):DOMString  == {
    error "not done yet"
  }
 
  internalSubset(x:%):DOMString   == {
    error "not done yet"
  }
}

