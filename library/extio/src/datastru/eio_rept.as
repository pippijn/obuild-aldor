-------------------------------------------------------------------------
--
-- eio_rept.as
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

+++\begin{addescription}{encapsulates functions for a repository.}
+++\adthistype takes one parameter. This parameter denotes the type of the elements in the repository.
+++\end{addescription}
+++\begin{adremarks}
+++The repositories of \adthistype are meant to be singleton. Therefore, the functions of \adthistype do not take a repository as input parameter.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{SingletonRepository}
+++  \adtype{ComputerAlgebraSystemTools}
+++\end{adseealso}
SingletonRepositoryType( TYPE: Type ): Category == with {

    +++\begin{addescription}{adds an element to the repository.}
    +++\adthisname takes two parameters, a \adtype{Symbol} and the element to add. The \adtype{Symbol} is used as key to the element. If the repository already contains an element with a key that matches the given \adtype{Symbol}, the new element is not inserted and \adname[Boolean]{false} is returned. If the element is entered, \adname[Boolean]{true} is returned.
    +++\end{addescription}
    register: ( Symbol, TYPE ) -> Boolean;
    
    +++\begin{addescription}{searches an element within the repository.}
    +++\adthisname takes a \adtype{Symbol} as parameter. This \adtype{Symbol} is compared to the keys of the elements within the repository. If a key matches the \adtype{Symbol}, the key's element is returned.
    +++\end{addescription}
    +++\begin{adexceptions}
    +++\adthrows{NotFoundException} if no key in the repository matches the passed \adtype{Symbol}.
    +++\end{adexceptions}
    find: Symbol -> TYPE throw NotFoundExceptionType;

    +++\begin{addescription}{enumerates the repository's elements.}
    +++\adthisname does not take any parameter and returns a \adtype{Generator} of the elements within the repository.
    +++\end{addescription}
    +++\begin{adremarks}
    +++The order of the elements in the returned \adtype{Generator} does not obey any sorting and cannot be relied on.
    +++\end{adremarks}
    generator: () -> Generator TYPE;

}
