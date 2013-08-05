-------------------------------------------------------------------------
--
-- dm_demo.as
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

import from MachineInteger;

+++\begin{addescription}{provides a sample domain.}
+++\end{addescription}
SampleDomain: with {
        +++\begin{addescription}{provides a sample constant.}
        +++\end{addescription}
        +++\begin{adseealso}
        +++  \adname{Two}
        +++  \adname{Three}
        +++\end{adseealso}
	One: MachineInteger;

        +++\begin{addescription}{provides another sample constant.}
        +++\end{addescription}
        +++\begin{adseealso}
        +++  \adname{One}
        +++  \adname{Three}
        +++\end{adseealso}
	Two: MachineInteger;

        +++\begin{addescription}{provides a third sample constant.}
        +++\end{addescription}
        +++\begin{adseealso}
        +++  \adname{One}
        +++  \adname{Two}
        +++\end{adseealso}
	Three: MachineInteger;
	
} == add {
	One: MachineInteger == 1;
	Two: MachineInteger == 2;
	Three: MachineInteger == 3;
}
