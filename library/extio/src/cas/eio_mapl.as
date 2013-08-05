-------------------------------------------------------------------------
--
-- eio_mapl.as
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

import from String;


+++\begin{addescription}{provides conversions between \Aldor and \Maple's format.}
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{ComputerAlgebraSystemTools}
+++\end{adseealso}
MapleTools: ComputerAlgebraSystemType == add {
    
    
    -----------------------------------------------------------  

    
    identifier: Symbol == -"maple";
    
    
    -----------------------------------------------------------  

    
    parserDomain: ParserReader == InfixExpressionParser;

    
    -----------------------------------------------------------  

    
    encodeAsString( str: String ): String == {
	"_""+str+"_"";
    }

    
    -----------------------------------------------------------  

    
    encodeAsString!( e: ExpressionTree ): String == {
	local sb: StringBuffer := new();
	maple( (sb::TextWriter), e);
	string sb;
    }

    
    -----------------------------------------------------------  

    
    encodeAsError( str: String ): String == {
	"ERROR("+(encodeAsString str)+");";
    }

    
    -----------------------------------------------------------  
    
    
    encodeAsWarning( str: String ): String == {
	"WARNING("+(encodeAsString str)+");";
    }

    
    -----------------------------------------------------------   
    
}

#endif
