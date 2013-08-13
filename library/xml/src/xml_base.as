#include "aldor"
--#include "aldorio"

-- xmlbase.as contains stubs for domains in the XMLDOM set
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

import from ULib,BasicLibrary;

Comment(UCH:UniCodeCharacter) : with == add;
Attr(UCH:UniCodeCharacter) : with == add;
Element(UCH:UniCodeCharacter) : with == add;
NamedNodeMap(UCH:UniCodeCharacter) : with == add;
NodeList(UCH:UniCodeCharacter) : with == add;
Notation(UCH:UniCodeCharacter) : with == add;
Node(UCH:UniCodeCharacter) : with == add;
Document(UCH:UniCodeCharacter) : with == add;
EntityReference(UCH:UniCodeCharacter) : with == add;
ProcessingInstruction(UCH:UniCodeCharacter) : with == add;
CDATASection(UCH:UniCodeCharacter) : with == add;
CharacterData(UCH:UniCodeCharacter) : with == add;
Text(UCH:UniCodeCharacter) : with == add;
DocumentFragment(UCH:UniCodeCharacter) : with == add;
DOMImplementation(UCH:UniCodeCharacter) : with == add;
DocumentUniCodeCharacter(UCH:UniCodeCharacter) : with == add;
DocumentType(UCH:UniCodeCharacter) : with == add;
