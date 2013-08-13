#include "aldor"
--#include "aldorio"

-- mygen.as an Aldor Category for MyGen(Type)
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

#library GL "xml__gener.ao"

import from GL;

MyGen(Ty:Type) : with {
        step!: % -> %;
        empty?: % -> Boolean;
        value: % -> Ty;
        generator: % -> %;
        generator: Generator(Ty) -> %;
        secondVal : % -> Ty;
} == Generator(Ty) add {
--  Rep ==> Record(first:Union(nul:'nul',val:Ty),gen:Generator(Ty),
--                 end:Boolean);
  Rep ==> Record(first:Ty, gen:Generator(Ty), end:Boolean);

  import from Rep;

  step!(g:%):% == {
    repg := rep g;
    if empty?(repg.gen) then {
      repg.end := true;}
    else {
      repg.first := value(repg.gen);step!(repg.gen)}
    per repg
--    repg.first := if repg.end then [nul] else [value repg.gen];
--    if empty?(repg.gen) then repg.end := true;
--      else repg.end := false; 
--    step!(repg.gen);
--    per repg
  }

  value(g:%):Ty == {
--    if rep(g).first case nul then {
--      value(rep(g).gen)
--    }
--    else {
--      rep(g).first.val
--    }
    rep(g).first
  }

  secondVal(g:%):Ty == {
    repg := rep g;
--    if repg.first case nul then {
--      repg.first := [value(repg.gen)];step!(repg.gen)}
    value(repg.gen)
  }

  empty?(g:%):Boolean == {
    rep(g).end
  }

  generator(g:Generator(Ty)):% == {
    import from Boolean;
--    per [[nul],g,false]
    per [value g,step! g,empty? g]
}

  generator(g:%):% == {g
--    repg := rep(g);
--    repg.first := [nul];repg.end := false;g
  }
}
