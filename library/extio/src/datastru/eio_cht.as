-------------------------------------------------------------------------
--
-- eio_cht.as
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

#include "extio.as"

+++\begin{addescription}{implements a hash table.}
+++For colliding hashes, the chaining strategy is used. \adcode{K} is the domain for the keys in \adthistype and \adcode{V} the domain for the values.
+++\end{addescription}
+++\begin{adremarks}
+++By the domain \adtype{HashTable}, \LibAldor already provides a hash table. However, \adtype{HashTable} is conceptionally broken. For example, using a non-trivial \adname[HashTable]{remember} function for \adtype{HashTable}{}s allows to generate \adtype{HashTable}{}s with infinitely many elements. But \adtype{HashTable} has \adtype{BoundedFiniteLinearStructure}, which causes a semantic contradiction. Furthermore, \adtype{HashTable}'s \adname[HashTable]{#} function refers to the number of slots in the hash table, not to the number of entries, which raises another semantic contradiction.
+++
+++As there are even more such semantic contradictions, \adtype{HashTable} should not be used. \adthistype should be used as semantically correct alternative.
+++\end{adremarks}
+++\begin{adseealso}
+++\adtype{ChainingHashTableWithCustomHashFunction}
+++\end{adseealso}
ChainingHashTable( 
  K: HashType,
  V: Type
): with {

    TableType( K, V );
    
    if V has PrimitiveType then {
	PrimitiveType;
    }
    
    if V has PrimitiveType then
    {
        contained?:( %, % ) -> Boolean;
    }    

} == ChainingHashTableWithCustomHashFunction( K, V, hash$K ) add {}
