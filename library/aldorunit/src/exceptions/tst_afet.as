-------------------------------------------------------------------------
--
-- tst_afet.as
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

#include "aldorunit"

+++\begin{addescription}{provides a type for \LibAldorUnit's exceptions.}
+++ Exceptions of this type are thrown by \adcode{assert...} functions and indicate that a test failed.
+++\end{addescription}
define AldorUnitFailedExceptionType : Category == with {

#if LibraryAldorUnitRequiresLibraryExtIO
    ExceptionType;
#endif

}
