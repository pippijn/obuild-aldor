-- cdq.as contains domains for querying OpenMath content dictionaries
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

#include "aldor.as"

#include "xmllib.as"
#include "openmath.as"

M ==> Machine;
B ==> Boolean;
L ==> List;
I ==> Integer;
MI ==> MachineInteger;
TW ==> TextWriter;
DF ==> DoubleFloat;
SF ==> SingleFloat;
STR ==> String;
GMPF ==> GMPFloat;

import from String;

+++ This category contains function signatures for query functions on XML
+++ objects which constitute OpenMath content dictionaries
define CDQueryCat(UCH:UniCodeCharacter):Category == with {
  -- first signatures for functions which query the header info
  CDName : Element(UCH) -> DOMString(UCH);
    ++ return the name of this content dictionary
  CDURL : Element(UCH) -> DOMString(UCH);
    ++ return the URL of this content dictionary
  CDReviewDate : Element(UCH) -> DOMString(UCH);
    ++ return the review date of this content dictionary
  CDStatus : Element(UCH) -> DOMString(UCH);
    ++ return the status of this content dictionary
  CDDate : Element(UCH) -> DOMString(UCH);
    ++ return the date this content dictionary was written
  CDVersion : Element(UCH) -> DOMString(UCH);
    ++ return the version number of this content dictionary
  CDRevision : Element(UCH) -> DOMString(UCH);
    ++ return the revision date of this content dictionary
  CDUses : Element(UCH) -> L(DOMString(UCH));
    ++ return a list of the content dictioanries used by this content dictionary
  Description : Element(UCH) -> DOMString(UCH);
    ++ return the discription of this content dictionary

  symbolNames : Element(UCH) -> L(DOMString(UCH));
    ++ return a list of the names of the symbols in this content dictionary
  -- now for signatures for functions which query the symbol definitions
  symbolDescription : (Element(UCH),DOMString(UCH)) -> DOMString(UCH);
    ++ return a discription of the symbol specified by symbol name
    ++ (the second parameter) in this content dictionary (the first parameter)
  symbolCMPs : (Element(UCH),DOMString(UCH)) -> L(Element(UCH));
    ++ return a list of the CMPs (Commented Mathematical Properties) of the
    ++ symbol specified by symbol name (the second parameter) in this
    ++ content dictionary (the first parameter)
  symbolFMPs : (Element(UCH),DOMString(UCH)) -> L(Element(UCH));
    ++ return a list of the FMPs (Formal Mathematical Properties) of the
    ++ symbol specified by symbol name (the second parameter) in this
    ++ content dictionary (the first parameter)
  symbolExamples : (Element(UCH),DOMString(UCH)) -> L(Element(UCH));
    ++ return a list of the Examples of the symbol specified by symbol 
    ++ name (the second parameter) in this content dictionary 
    ++ (the first parameter)
}

+++ This domain contains functions which query OpenMath content dictionaries
CDQuery(UCH:UniCodeCharacter):CDQueryCat(UCH) == add {
  CDNameString:DOMString(UCH) == ["CDName"];
  CDName(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDNameString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  CDURLString:DOMString(UCH) == ["CDURL"];
  CDURL(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDURLString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  CDReviewDateString:DOMString(UCH) == ["CDReviewDate"];
  CDReviewDate(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDReviewDateString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  CDStatusString:DOMString(UCH) == ["CDStatus"];
  CDStatus(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDStatusString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }


  CDDateString:DOMString(UCH) == ["CDDate"];
  CDDate(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDDateString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  CDVersionString:DOMString(UCH) == ["CDVersion"];
  CDVersion(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDVersionString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  CDRevisionString:DOMString(UCH) == ["CDRevision"];
  CDRevision(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = CDRevisionString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  cdusesString:DOMString(UCH) == ["CDUses"];
  CDUses(el:Element(UCH)):L(DOMString(UCH)) == {
    import from Text(UCH),MI;
    cdusesnl:NodeList(UCH) := getElementsByTagName(el,cdusesString);
    cduses:Node(UCH) := item(cdusesnl,0);
    names:L(DOMString(UCH)) := [];
    for c in childNodes cduses repeat {
      names := cons(data(retract(firstChild(c))@Text(UCH)),names);
    }
    names
  }

  DescriptionString:DOMString(UCH) == ["Description"];
  Description(el:Element(UCH)):DOMString(UCH) == {
    import from Node(UCH),Text(UCH),MachineInteger;
    cs:NodeList(UCH) := childNodes cast el;
    for c in cs repeat {
      if localName c = DescriptionString then 
        return(data retract item(childNodes c,0))
    }
    error "invalid CD"
  }

  CDDefinitionString:DOMString(UCH) == ["CDDefinition"];
  NameString:DOMString(UCH) == ["Name"];
  symbolNames(el:Element(UCH)):L(DOMString(UCH)) == {
    import from Text(UCH),Node(UCH),MI;
    -- get a node list of all the symbol definitions
    cddefinitionnl:NodeList(UCH) := getElementsByTagName(el,CDDefinitionString);
    symbols:L(DOMString(UCH)) := [];
    -- for each one
    for symboldef in cddefinitionnl repeat {
      -- get the name and append to the accumulation list
      symbols := cons(data(retract(firstChild item(getElementsByTagName(retract(symboldef)@Element(UCH),NameString),0))@Text(UCH)),symbols)
    }
    symbols
  }

  symbolDescription(el:Element(UCH),name:DOMString(UCH)):DOMString(UCH) == {
    import from Text(UCH),Node(UCH),MI;
    -- get a node list of all the symbol definitions
    cddefinitionnl:NodeList(UCH) := getElementsByTagName(el,CDDefinitionString);
    -- first we must find the symbol
    name := stripWS name;
    for symboldef in cddefinitionnl repeat {
      symbDef:Element(UCH) := retract(symboldef);
      if name=stripWS data(retract(firstChild item(getElementsByTagName(symbDef,NameString),0))@Text(UCH)) then {
        -- this is the required symbol
        return(data(retract(firstChild item(getElementsByTagName(symbDef,DescriptionString),0))@Text(UCH)))
      }
    }
    return [""]
  }

  cmpstring:DOMString(UCH) := ["CMP"];
  symbolCMPs(el:Element(UCH),name:DOMString(UCH)):L(Element(UCH)) == {
    import from Text(UCH),Node(UCH),MI;
    ret :L(Element(UCH)) := [];
    cddefinitionnl:NodeList(UCH) := getElementsByTagName(el,CDDefinitionString);
    -- first we must find the symbol
    name := stripWS name;
    for symboldef in cddefinitionnl repeat {
      symbDef:Element(UCH) := retract(symboldef);
      if name=stripWS data(retract(firstChild item(getElementsByTagName(symbDef,NameString),0))@Text(UCH)) then {
        -- this is the required symbol
        nl:NodeList(UCH) := getElementsByTagName(symbDef,cmpstring);
        nla:Array(Node(UCH)) := cast(nl);
        for n in nla repeat {
          ret := cons(retract n,ret)
        }
        return ret
      }
    }
    error "symbol not found"
  }

  fmpstring:DOMString(UCH) := ["FMP"];
  symbolFMPs(el:Element(UCH),name:DOMString(UCH)):L(Element(UCH)) == {
    import from Text(UCH),Node(UCH),MI;
    ret :L(Element(UCH)) := [];
    cddefinitionnl:NodeList(UCH) := getElementsByTagName(el,CDDefinitionString);
    -- first we must find the symbol
    name := stripWS name;
    for symboldef in cddefinitionnl repeat {
      symbDef:Element(UCH) := retract(symboldef);
      if name=stripWS data(retract(firstChild item(getElementsByTagName(symbDef,NameString),0))@Text(UCH)) then {
        -- this is the required symbol
        nl:NodeList(UCH) := getElementsByTagName(symbDef,fmpstring);
        nla:Array(Node(UCH)) := cast(nl);
        for n in nla repeat {
          ret := cons(retract n,ret)
        }
        return ret
      }
    }
    error "symbol not found"
  }

  examplestring:DOMString(UCH) := ["Example"];
  symbolExamples(el:Element(UCH),name:DOMString(UCH)):L(Element(UCH)) == {
    import from Text(UCH),Node(UCH),MI;
    ret :L(Element(UCH)) := [];
    cddefinitionnl:NodeList(UCH) := getElementsByTagName(el,CDDefinitionString);
    -- first we must find the symbol
    name := stripWS name;
    for symboldef in cddefinitionnl repeat {
      symbDef:Element(UCH) := retract(symboldef);
      if name=stripWS data(retract(firstChild item(getElementsByTagName(symbDef,NameString),0))@Text(UCH)) then {
        -- this is the required symbol
        nl:NodeList(UCH) := getElementsByTagName(symbDef,examplestring);
        nla:Array(Node(UCH)) :=  cast(nl);
        for n in nla repeat {
          ret := cons(retract n,ret)
        }
        return ret
      }
    }
    error "symbol not found"
  }
}
