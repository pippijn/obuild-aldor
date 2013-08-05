-------------------------------------------------------------------------
--
-- eio_list.as
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

#if LibraryExtIORequiresLibraryAlgebra

+++\begin{addescription}{adds functions for conversion.}
+++This extension provides functions to convert a \adthistype to \adtype{String}{}s and parse \adtype{ExpressionTree}{}s to \adthistype{}s.
+++\end{addescription}
extend List( T: Type ) : with {

    if T has Parsable then {
	Parsable;
    }
    
    if T has ExpressionType then {
	ExpressionType;
    }

    if T has PrimitiveType then
    {
	+++\begin{addescription}{removes subsequent equal entries}
	+++Given a list
	+++\begin{adsnippet}
	+++ [ a, a, a, b, b, c, d, d, d, d, d, a, d ]
	+++\end{adsnippet}
	+++\adthisname computes the list
	+++\begin{adsnippet}
	+++ [ a, b, c, d, a, d ]
	+++\end{adsnippet}
	+++. For sorted lists, like
	+++\begin{adsnippet}
	+++ [ a, a, a, a, b, b, c, d, d, d, d, d, d ]
	+++\end{adsnippet}
	+++\adthisname gives
	+++\begin{adsnippet}
	+++ [ a, b, c, d, a, d ]
	+++\end{adsnippet}
	+++and effectively removes all duplicate entries.
	+++\end{addescription}
	condenseRuns!: % -> %;
    }

 } == add {

    if T has ExpressionType then 
    {
	extree( a: % ): ExpressionTree == {
	    import from T;
	    
	    local elementsET: DoubleEndedList ExpressionTree := empty();
	    for elementA in a repeat
	    {
		elementsET := concat!( elementsET, extree elementA );
	    }
	    ExpressionTreeList . (firstCell elementsET);		
	}
    }
    
    if T has Parsable then 
    {
	eval(e:ExpressionTreeLeaf):Partial(%) == 
	{
            failed;
        }

        eval( op: MachineInteger, ops: List ExpressionTree ) : Partial % == 
	{
	    if op = uniqueId$ExpressionTreeList then {
              local result:% := [];
              for listElemExpressionTree in (generator$(List ExpressionTree)) ops repeat {
                local pListElem:Partial T;
                pListElem := (eval$T)(listElemExpressionTree);
                if failed? pListElem then {
                  return failed;
                } else {
		    result := append!(result, retract pListElem);
                }
              }
              bracket(result);
            } else {
              failed;
            }
        }

    }	


    if T has PrimitiveType then
    {
	condenseRuns!( a: % ): % == {
	    import from T;
	    empty? a => empty;
	    empty? rest a => a;
	    assert( ~ empty? a );
	    while ~ empty? rest a and first rest a = first a repeat
	    {
		a := rest a;
		assert( ~ empty? a );
	    }
	    cons( first a, condenseRuns!( rest a ) );
	}
    }
}

#endif