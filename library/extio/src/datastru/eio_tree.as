-------------------------------------------------------------------------
--
-- eio_tree.as
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

#include "aldor"

+++\begin{addescription}{models an $n$-ary tree datastructure.}
+++The nodes in \adthistype are of type \adcode{LeafType}.
+++\end{addescription}
Tree(

  LeafType: Type

): with {

    DataStructureType;

    +++\begin{addescription}{holds an empty tree.}
    +++\end{addescription}
    empty: %;
    
    +++\begin{addescription}{constructs a tree without any initial children.}
    +++The passed \adcode{LeafType} is the value of the node.
    +++\end{addescription}
    tree: LeafType -> %;

    +++\begin{addescription}{constructs a tree with children.}
    +++The passed \adcode{LeafType} is the value of the node. The elements of the passed \adcode{List %} are inserted as children of the node.
    +++\end{addescription}
    tree: ( LeafType, List % ) -> %;

    +++\begin{addescription}{checks for a leaf node.}
    +++\adthisname returns true iff the passed \adthistype does not have any children.
    +++\end{addescription}
    isLeaf?: % -> Boolean;

    +++\begin{addescription}{returns the children of a tree.}
    +++\adthisname returns the \adtype{List} of children of the passed \adthistype.
    +++\end{addescription}
    children: % -> List %;

    +++\begin{addescription}{gives the value of a node.}
    +++The children are not taken into account. Only the node itself is converted to a \adcode{LeafType} value.
    +++\end{addescription}
    value: % -> LeafType;

    +++\begin{addescription}{lifts a function.}
    +++\adthistype takes a mapping from \adcode{LeafType} to \adcode{LeafType} and promotes it to a mapping from \adcode{%} to \adcode{%}. The promoted mapping acts by applying the mapping from \adcode{LeafType} to \adcode{LeafType} to every element in the tree.
    +++\end{addescription}
    map!: ( LeafType -> LeafType ) -> ( % -> % );
    
    
    if LeafType has PrimitiveType then
    {
	PrimitiveType;
    }
    
} == add {

    Node == Record( value: LeafType, children: List % );
    Rep == Union( empty: Boolean, node: Node );
    import from Rep;
    import from Node;    
    import from List %;
       
    ----------------------------------------

    empty?( a: % ): Boolean == {
	(rep a) case empty;
    }

    ----------------------------------------

    free!( a: % ): () == {
    }

    ----------------------------------------

    empty: % == per [ true ];
    
    ----------------------------------------

    tree( leaf: LeafType ): % == {
	per [ record( leaf, empty ) ];
    }
    
    ----------------------------------------

    tree( leaf: LeafType, children: List % ): % == {
	per [ record( leaf, children ) ];
    }
    
    ----------------------------------------

    isLeaf?( a: % ): Boolean == {
	(rep a) case empty or empty? ( (rep a) . node . children );
    }
    
    ----------------------------------------

    children( a: % ): List % == {
	empty? a => empty;
	(rep a) . node . children;
    }
    
    ----------------------------------------

    value( a: % ): LeafType == {
	assert( (rep a) case node );
	(rep a) . node . value;
    }
    
    ----------------------------------------
    
    map!( f: LeafType -> LeafType ): ( % -> % ) == {
	return {
	    ( a: % ): % +-> {
		local repA := rep a;
		repA case empty => a;
		assert( repA case node );
		local nodeStruct := repA . node;
		per [ record( f( nodeStruct . value ), [ map!(f)( elem) for elem in nodeStruct . children ] ) ];
	    }
	}
    }

    ----------------------------------------

    if LeafType has PrimitiveType then
    {
	=( a: %, b:% ): Boolean == {
	    local repA := rep a;
	    local repB := rep b;
	    repA case node and repB case node => {
		local nodeA := repA . node;
		local nodeB := repB . node;
		nodeA . value = nodeB . value and nodeA . children = nodeB . children;
	    }
	    empty? a and empty? b;
	}
    }

    ----------------------------------------


    
}
