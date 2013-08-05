-------------------------------------------------------------------------
--
-- eio_cht.test.as
--
-------------------------------------------------------------------------
--
-- Copyright (C) 2005  Research Institute for Symbolic Computation, 
-- J. Kepler University, Linz, Austria
--
-- Written by Christian Aistleitner
-- 
-- This program is free software; you can redistribute it and/or          
-- modify it under the terms of the GNU General Public License version 2, 
-- as published by the Free Software Foundation.                          
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
-- MA  02110-1301, USA.
--

#include "extio"
#include "aldorunit"
#include "testcases"


macro KEY == MachineInteger;
macro VALUE == String;
macro TABLE == ChainingHashTable( KEY, VALUE );

TestChainingHashTable : TestCaseType with {

#include "eio_htt.test.signatures.as"
#include "eio_cht.test.signatures.as"

} == HashTableTester( KEY, TABLE ) add {
}