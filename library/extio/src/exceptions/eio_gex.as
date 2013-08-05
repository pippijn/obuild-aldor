-------------------------------------------------------------------------
--
-- eio_gex.as
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

+++\begin{addescription}{extends by \projectname's basic type for exceptions.}
+++\end{addescription}
+++\begin{adremarks}
+++Note that (due to compiler issues) this extension does not affect the \adthistype{}s thrown by any library that does not depend on \projectname. Especially the \adthistype's thrown by \LibAldor do not provide \adtype{ExceptionType}!
+++
+++Even if you use \projectname, the exceptions thrown by \LibAldor do not provide \adtype{ExceptionType}!
+++
+++However, if you use \projectname and you throw an \adthistype within \emph{your} code, then the thrown exception will have \adtype{ExceptionType}.
+++\end{adremarks}
extend GeneratorException : ExceptionType == add {
}

