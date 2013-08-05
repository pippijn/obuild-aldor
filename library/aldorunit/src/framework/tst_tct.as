-------------------------------------------------------------------------
--
-- tst_tct.as
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

+++\begin{addescription}{provides a base category for test cases.}
+++\end{addescription}
TestCaseType : Category == with {
    
    +++\begin{addescription}{is called each time before a test is executed.}
    +++\adthisname should be used to set up a clean environment for every test. This includes for examples opening files and setting commonly used variables to proper values.
    +++\end{addescription}
    setUp: () -> ();

    +++\begin{addescription}{is called each time after a test has been executed.}
    +++\adthisname should be used to clean up the environment after every test. This includes for examples closing files and freeing resources.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is called even if the \adname{setUp} function or the test function threw an unhandled exception or failed.
    +++\end{adremarks}
    tearDown:() -> ();

	default {
		setUp():() == {
		}
		tearDown():() == {
		}
	}
	
};
