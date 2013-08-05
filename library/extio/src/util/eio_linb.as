-------------------------------------------------------------------------
--
-- eio_linb.as
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


+++\begin{addescription}{provides stream filters}
+++\end{addescription}
StreamFormatter: with {
    

    +++\begin{addescription}{inserts line breaks if a line gets too wide}
    +++\adthisname gives a \adtype{TextWriter} and takes two parameters, a \adtype{TextWriter} \adcode{WRITER} and a \adtype{MachineInteger} \adcode{n}.
    +++The returned \adtype{TextWriter} basically copies all input to the \adcode{WRITER} \adtype{TextWriter}. However, if no line break occurred for the last \adcode{n} characters, \adthisname inserts one.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname can be used to make a text fit to a fixed number of columns.
    +++\end{adremarks}    
    lineBreaker: ( TextWriter, MachineInteger ) -> TextWriter;

} == add {

    ----------------------------------------------------------------------

    lineBreaker( writer: TextWriter, width: MachineInteger ): TextWriter == {
	local noCRCounter: MachineInteger := 0;
	local privWriter: ( Character -> () ) := ( c: Character ): () +-> {
	    free noCRCounter;
	    if c = newline then
	    {
		noCRCounter := 0;		
	    } else {
		noCRCounter := next noCRCounter;
		if noCRCounter > width then
		{
		    writer << newline;
		    noCRCounter := 1;
		}
	    }
	  writer << c;
	}
	textWriter privWriter;
    }


    ----------------------------------------------------------------------

}
