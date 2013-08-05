-------------------------------------------------------------------------
--
-- eio_ansi.as
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

+++\begin{addescription}{provides ANSI codes for colors and text cursor manipulation.}
+++\end{addescription}
AnsiCodes : OutputType with {

    +++\begin{addescription}{moves the text cursor.}
    +++\adthisname takes two \adtype{Integer} parameters. The first parameter is the row and the second parameter is the column to set the text cursor to.
    +++\end{addescription}
    locateCursor: ( Integer, Integer ) -> %;

    +++\begin{addescription}{saves the current cursor position.}
    +++\end{addescription}
    saveCursor        : %;

    +++\begin{addescription}{recalls the last saved cursor position.}
    +++\end{addescription}
    recallCursor      : %;


    +++\begin{addescription}{clears the screen.}
    +++\end{addescription}
    clearScreen       : %;


    +++\begin{addescription}{clears to the end of the line.}
    +++\end{addescription}
    clearEol          : %;


    +++\begin{addescription}{resets the ansi modifications.}
    +++\end{addescription}
    reset             : %;


    +++\begin{addescription}{sets the bold style.}
    +++\end{addescription}
    bold              : %;


    +++\begin{addescription}{sets the underline style.}
    +++\end{addescription}
    underline         : %;


    +++\begin{addescription}{sets the blinking style.}
    +++\end{addescription}
    blink             : %;


    +++\begin{addescription}{inverts foreground and background.}
    +++\end{addescription}
    reverse           : %;


    +++\begin{addescription}{hides characters.}
    +++\end{addescription}
    nondisplayed      : %;


    +++\begin{addescription}{sets the foreground color to black.}
    +++\end{addescription}
    black             : %;


    +++\begin{addescription}{sets the foreground color to red.}
    +++\end{addescription}
    red               : %;


    +++\begin{addescription}{sets the foreground color to green.}
    +++\end{addescription}
    green             : %;


    +++\begin{addescription}{sets the foreground color to yellow.}
    +++\end{addescription}
    yellow            : %;


    +++\begin{addescription}{sets the foreground color to blue.}
    +++\end{addescription}
    blue              : %;


    +++\begin{addescription}{sets the foreground color to magenta.}
    +++\end{addescription}
    magenta           : %;


    +++\begin{addescription}{sets the foreground color to cyan.}
    +++\end{addescription}
    cyan              : %;


    +++\begin{addescription}{sets the foreground color to white.}
    +++\end{addescription}
    white             : %;


    +++\begin{addescription}{sets the background color to black.}
    +++\end{addescription}
    blackBackground   : %;


    +++\begin{addescription}{sets the background color to red.}
    +++\end{addescription}
    redBackground     : %;


    +++\begin{addescription}{sets the background color to green.}
    +++\end{addescription}
    greenBackground   : %;


    +++\begin{addescription}{sets the background color to yellow.}
    +++\end{addescription}
    yellowBackground  : %;


    +++\begin{addescription}{sets the background color to blue.}
    +++\end{addescription}
    blueBackground    : %;


    +++\begin{addescription}{sets the background color to magenta.}
    +++\end{addescription}
    magentaBackground : %;


    +++\begin{addescription}{sets the background color to cyan.}
    +++\end{addescription}
    cyanBackground    : %;


    +++\begin{addescription}{sets the background color to white.}
    +++\end{addescription}
    whiteBackground   : %;



} == add {
    Rep == (TextWriter -> TextWriter);

    import from Rep;

    import from MachineInteger;
    import from Character;
    import from String;

    <<( p : TextWriter, color : %):TextWriter == {
	p << char 27 << char 91;  
	(color pretend (TextWriter -> TextWriter)) p;
    }

    macro AnsiCode( code ) == per ( (p:TextWriter):TextWriter +-> { p << code } );
    macro AnsiColorCode( code ) == per ( (p:TextWriter):TextWriter +-> { p << code << "m" } );

    locateCursor( row: Integer, column: Integer ): % == {
	per ( 
	  (p:TextWriter):TextWriter +-> 
	  { 
	      p << row << ";" << column << "H";
	  }
	);
    }
    saveCursor        : % == AnsiCode( "s" );
    recallCursor      : % == AnsiCode( "u" );

    clearScreen       : % == AnsiCode( "2J" );
    clearEol          : % == AnsiCode( "K" );

    reset             : % == AnsiColorCode(  0 );
    bold              : % == AnsiColorCode(  1 );
    underline         : % == AnsiColorCode(  4 );
    blink             : % == AnsiColorCode(  5 );
    reverse           : % == AnsiColorCode(  7 );
    nondisplayed      : % == AnsiColorCode(  8 );

    black             : % == AnsiColorCode( 30 );
    red               : % == AnsiColorCode( 31 );
    green             : % == AnsiColorCode( 32 );
    yellow            : % == AnsiColorCode( 33 );
    blue              : % == AnsiColorCode( 34 );
    magenta           : % == AnsiColorCode( 35 );
    cyan              : % == AnsiColorCode( 36 );
    white             : % == AnsiColorCode( 37 );

    blackBackground   : % == AnsiColorCode( 40 );
    redBackground     : % == AnsiColorCode( 41 );
    greenBackground   : % == AnsiColorCode( 42 );
    yellowBackground  : % == AnsiColorCode( 43 );
    blueBackground    : % == AnsiColorCode( 44 );
    magentaBackground : % == AnsiColorCode( 45 );
    cyanBackground    : % == AnsiColorCode( 46 );
    whiteBackground   : % == AnsiColorCode( 47 );


}




