-------------------------------------------------------------------------
--
-- eio_ext.as
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

+++\begin{addescription}{provides a common category for exceptions.}
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{NotFoundExceptionType}
+++  \adtype{Exception}
+++  \adtype{RuntimeError}
+++\end{adseealso}
ExceptionType : Category == with {
    
    +++\begin{addescription}{prints a description of an exception.}
    +++The description is printed to the given \adtype{TextWriter}.
    +++\end{addescription}
    print: TextWriter -> TextWriter;
    
    default {
	print( p: TextWriter ): TextWriter == {
	    import from String;
	    p << "undefined exception of type " << ((name$Trace) %);
	}
	
    }
}