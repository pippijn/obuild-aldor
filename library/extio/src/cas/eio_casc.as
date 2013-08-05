-------------------------------------------------------------------------
--
-- eio_casc.as
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

+++\begin{addescription}{encapsulates functions for converting expressions to and from a computer algebra system.}
+++ \adthistype provides functions for encoding \adtype{ExpressionTree}s to \adtype{String}s, which are in a format that is understood by the described computer algebra system. Furthermore, a \adtype{ParserReader} is provided that can parse strings from the described computer algebra system to expression trees.
+++\end{addescription}
+++\begin{adremarks}
+++ Several computer algebra systems accept several different formats of strings. For example, \Mathematica is not limited to inputting expressions in its internal FullForm format, but can also deal with input in StandardForm or InputForm. In such cases, it is suggested to not cover all possible formats of a one \adthistype, but implement each format seperated from the others. This allows a fine graded selection of which format to parse or output.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{MapleTools}
+++  \adtype{MathematicaFullFormTools}
+++\end{adseealso}
ComputerAlgebraSystemType: Category == with {

    +++\begin{addescription}{identifies a computer algebra system.}
    +++\end{addescription}
    +++\begin{adremarks}
    +++If a computer algebra system supports more than one syntax format, it is suggested to postfix the name of the computer algebra system with the format that is dealt with in the current implementation.
    +++For example, \adtype{MathematicaFullFormTools} is used to deal with the FullForm format of \Mathematica.
    +++\end{adremarks}
    identifier: Symbol;
    
    
    +++\begin{addescription}{parses strings in the format specified by \adname{identifier}.}
    +++  \adthisname is used to convert strings in the format specified by \adname{identifier} to \adtype{ExpressionTree}s. These \adtype{ExpressionTree}s can then be converted to values of \Aldor domains that have \adtype{Parsable}.
    +++\end{addescription}
    +++\begin{adseealso}
    +++  \adtype{ParserReader}
    +++  \adtype{Parser}
    +++  \adtype{Parsable}
    +++\end{adseealso}
    parserDomain: ParserReader;

    -------------------------------
    
    +++\begin{addescription}{encodes a given \adtype{String} as string in the computer algebra system's format.}
    +++\end{addescription}
    encodeAsString: String -> String;
 
    +++\begin{addescription}{encodes an \adtype{ExpressionTree} to a string in the computer algebra system's format.}
    +++ \adthisname can be used to convert \Aldor expressions that have \adtype{ExpressionType} to expressions of the computer algebra system. All input parameters may be destroyed be the function.
    +++\end{addescription}
    encodeAsString!: ExpressionTree -> String;
 
    +++\begin{addescription}{encodes a given \adtype{String} to an error message in the computer algebra system's format.}
    +++  \adthisname takes a \adtype{String} \adcode{str} as parameter and returns a \adtype{String}. If the returned string is evaluated in the computer algebra system, it produces an error with the message \adcode{str}. The parameter \adcode{str} has to be in \Aldor's format, as it is translated to the computer algebra system's format automatically within this function.
    +++\end{addescription}
    encodeAsError: String -> String;
 
    +++\begin{addescription}{encodes a given \adtype{String} to a warning message in the computer algebra system's format.}
    +++  \adthisname takes a \adtype{String} \adcode{str} as parameter and returns a \adtype{String}. If the returned string is evaluated in the computer algebra system, it produces an warning with the message \adcode{str}. The parameter \adcode{str} has to be in \Aldor's format, as it is translated to the computer algebra system's format automatically within this function.
    +++\end{addescription}
    encodeAsWarning: String -> String;
  
}

#endif