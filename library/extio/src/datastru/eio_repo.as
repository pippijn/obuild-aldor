-------------------------------------------------------------------------
--
-- eio_repo.as
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

+++\begin{addescription}{provides an implementation of \adtype{SingletonRepositoryType}.}
+++\adthistype takes one parameter. This parameter denotes the type of the elements in the repository.
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{ComputerAlgebraSystemTools}
+++\end{adseealso}
SingletonRepository( TYPE: Type ): SingletonRepositoryType( TYPE ) == add {

    --storing the TYPE elements directly
    -- (i.e.: without the wrapping Record) causes segfaults.
    macro TType == Record( t: TYPE);
    import from TType;
    macro Rep == ChainingHashTable( Symbol, TType );
    import from Rep;

    local repository: Rep := table();

    -----------------------------------------------------------	
    
    import from Character;
    
    -----------------------------------------------------------	

    register( tParamId: Symbol, tParam: TYPE ): Boolean == {
	import from Symbol;
        
	local pRes : Partial TType := find( tParamId, repository );
	~ failed? pRes => false;

	free repository;
	repository.tParamId := record tParam;
	true;
    }
    
    
    -----------------------------------------------------------	

      find( identifier: Symbol ): TYPE throw NotFoundExceptionType == {

	  local pRes : Partial TType := find( identifier, repository );
	  failed? pRes => throw NotFoundException;

	  (retract pRes).t;

    }


    -----------------------------------------------------------


    generator(): Generator TYPE == {

	generate {
	    for repT in entries repository repeat {
		yield (repT.t);
	    }
	}
    }
    

    -----------------------------------------------------------
    
    
}
