-------------------------------------------------------------------------
--
-- eio_stok.as
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


+++\begin{addescription}{provides functions to chop a string into substrings.}
+++\end{addescription}
StringTokenizer: with {
    

    +++\begin{addescription}{chops a string into substrings at a delimiter.}
    +++The \adtype{Character} argument in \adthisname denotes the delimiter character. The \adtype{String} parameter is split into substrings at each delimiter character that appears in the \adtype{String}.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname does not copy the passed \adtype{String}. Therefore, altering the passed \adtype{String} after calling \adthisname may cause side effects. However, the returned substrings do not share memory with the original \adtype{String}.
    +++
    +++The order of the elements in the returned \adtype{Generator} reflects the order of the substrings within the original \adtype{String}.
    +++
    +++Empty substrings are omitted from the \adtype{Generator}.
    +++\end{adremarks}    
    tokenize: ( Character, String ) -> Generator String;

} == add {

    import from String;
    
    ----------------------------------------------------------------------

    
    tokenize( separator : Character, tokenString: String ): Generator String == {
	import from List Character;

	generate {
	    local chs : DoubleEndedList Character := empty();
	    for ch in tokenString repeat
	    {
		if ch = separator then 
		{ 
		    if ~ empty? chs then 
		    {
			yield [ generator firstCell chs ];
			chs := empty();
		    }
		} else {
		    chs := concat!( chs, ch );
		}
	    }
	    if ~ empty? chs then 
	    {
		yield [ generator firstCell chs ];
	    }		    
	}
    }

    
    ----------------------------------------------------------------------


}
