-------------------------------------------------------------------------
--
-- eio_expl.as
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

+++\begin{addescription}{adds functions to copy \adthistype{}s.}
+++\end{addescription}
extend ExpressionTreeLeaf : with {

    CopyableType;

} == add {

    copy( a: % ): % == {

	if boolean? a then
	{
	    leaf boolean a;
	    
	} else if doubleFloat? a then {
	    
	    import from DoubleFloat;
	    
	    leaf copy doubleFloat a;
	    
#if GMP
	} else if float? a then {

	    import from Float;
	    leaf copy float a;
#endif	    
	} else if integer? a then {
	    
	    if Integer has CopyableType then
	    {
		import from Integer;
		
		leaf copy integer a;
	    } else {
		leaf integer a;
	    }

	} else if singleFloat? a then {
	    
	    import from SingleFloat;
	    
	    leaf copy singleFloat a;
	    
	} else if machineInteger? a then {
	    
	    import from MachineInteger;
	    
	    leaf copy machineInteger a;
	    
	} else if string? a then {
	    
	    import from String;
	    
	    leaf ((copy$String) string a );
	    
	} else { 
	    assert( symbol? a );
	    
	    leaf symbol a;
	    
	}
	    
    }
}

#endif