-------------------------------------------------------------------------
--
-- eio_cast.as
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

+++\begin{addescription}{provides a repository for implementations of \adtype{ComputerAlgebraSystemType}.}
+++ \adthistype serves as system wide repository for implementations for \adtype{ComputerAlgebraSystemType}. Its purpose is to register implementations, enumerate registered implementaitons, and search them by their identifier.
+++\end{addescription}
+++\begin{adremarks}
+++  When issuing \adcode{#assert REGISTER_COMPUTER_ALGEBRA_SYSTEMS} before including \file{extio.as} (\projectname's main include file), all implementations of \adtype{ComputerAlgebraSystemType} of \projectname are registered in \adthistype.
+++
+++Developers of further implementiations of \adtype{ComputerAlgebraSystemType} are strongly requested to follow this scheme, as it allows to incorporate all implementations of \adtype{ComputerAlgebraSystemType} of a library, without having to state all these implementations within the source file. See the \file{extio.as} in the include directory to get an example.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{MathematicaFullFormTools}
+++  \adtype{MapleTools}
+++\end{adseealso}
ComputerAlgebraSystemTools : with {

    SingletonRepositoryType( ComputerAlgebraSystemType );
    
    +++\begin{addescription}{registers an implementation of \adtype{ComputerAlgebraSystemType}.}
    +++ \adthisname returns \adname[Boolean]{true}, iff the passed implementation of \adtype{ComputerAlgebraSystemType} has been registered successfully.
    +++\end{addescription}
    +++\begin{adremarks}
    +++A registration of a \adtype{ComputerAlgebraSystemType}, fails when a the identifiers of an already registered \adtype{ComputerAlgebraSystemType} and the \adtype{ComputerAlgebraSystemType} to register aro equal. Therefore, registration the same \adtype{ComputerAlgebraSystemType} twice, will fail.
    +++
    +++\adthisname is an abbreviation of \adtype{SingletonRepositoryType}s \adname[SingletonRepositoryType]{register}.
    +++\end{adremarks}
    register: ComputerAlgebraSystemType -> Boolean;
    
} == SingletonRepository( ComputerAlgebraSystemType ) add {
--    local repository: Rep := table();

    -----------------------------------------------------------	

    
    local getIdentifierForCas( cas: ComputerAlgebraSystemType ):Symbol == {
	import from cas;
	identifier;
    }
    
    
    -----------------------------------------------------------	

    
    register( casParam: ComputerAlgebraSystemType ): Boolean == {
	import from Symbol;
        
	local casParamId := getIdentifierForCas(casParam);
	register( casParamId, casParam );
    }
    
    
    -----------------------------------------------------------	
    
    
}


#endif