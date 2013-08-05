-------------------------------------------------------------------------
--
-- eio_char.as
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

+++\begin{addescription}{provides unicode \cite{Unicode} character names for the first $128$ characters.}
+++Besides the primary names, \adthistype also provides the appropriate alias names.
+++\end{addescription}
CharacterNames : with {

    +++\begin{addescription}{provides a name for the unicode character 0000(hexadecimal).}
    +++\end{addescription}
    null               : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0001(hexadecimal).}
    +++\end{addescription}
    startOfHeading     : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0002(hexadecimal).}
    +++\end{addescription}
    startOfText        : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0003(hexadecimal).}
    +++\end{addescription}
    endOfText          : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0004(hexadecimal).}
    +++\end{addescription}
    endOfTransmission  : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0005(hexadecimal).}
    +++\end{addescription}
    enquiry            : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0006(hexadecimal).}
    +++\end{addescription}
    acknowledge        : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0007(hexadecimal).}
    +++\end{addescription}
    bell               : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0008(hexadecimal).}
    +++\end{addescription}
    backspace          : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0009(hexadecimal).}
    +++\end{addescription}
    characterTabulation: Character ;

    +++\begin{addescription}{provides a name for the unicode character 000A(hexadecimal).}
    +++\end{addescription}
    +++\begin{adseealso}
    +++  \adname{carriageReturn}
    +++\end{adseealso}
    lineFeed           : Character ;

    +++\begin{addescription}{provides a name for the unicode character 000B(hexadecimal).}
    +++\end{addescription}
    lineTabulation     : Character ;

    +++\begin{addescription}{provides a name for the unicode character 000C(hexadecimal).}
    +++\end{addescription}
    formFeed           : Character ;

    +++\begin{addescription}{provides a name for the unicode character 000D(hexadecimal).}
    +++\end{addescription}
    +++\begin{adseealso}
    +++  \adname{lineFeed}
    +++\end{adseealso}
    carriageReturn     : Character ;

    +++\begin{addescription}{provides a name for the unicode character 000E(hexadecimal).}
    +++\end{addescription}
    shiftOut           : Character ;

    +++\begin{addescription}{provides a name for the unicode character 000F(hexadecimal).}
    +++\end{addescription}
    shiftIn            : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0010(hexadecimal).}
    +++\end{addescription}
    dataLinkEscape     : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0011(hexadecimal).}
    +++\end{addescription}
    deviceControlOne   : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0012(hexadecimal).}
    +++\end{addescription}
    deviceControlTwo   : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0013(hexadecimal).}
    +++\end{addescription}
    deviceControlThree : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0014(hexadecimal).}
    +++\end{addescription}
    deviceControlFour  : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0015(hexadecimal).}
    +++\end{addescription}
    negativeAcknowledge: Character ;

    +++\begin{addescription}{provides a name for the unicode character 0016(hexadecimal).}
    +++\end{addescription}
    synchronousIdle    : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0017(hexadecimal).}
    +++\end{addescription}
    endOfTransmissionBlock: Character ;

    +++\begin{addescription}{provides a name for the unicode character 0018(hexadecimal).}
    +++\end{addescription}
    cancel             : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0019(hexadecimal).}
    +++\end{addescription}
    endOfMedium        : Character ;

    +++\begin{addescription}{provides a name for the unicode character 001A(hexadecimal).}
    +++\end{addescription}
    substitute         : Character ;

    +++\begin{addescription}{provides a name for the unicode character 001B(hexadecimal).}
    +++\end{addescription}
    escape             : Character ;

    +++\begin{addescription}{provides a name for the unicode character 001C(hexadecimal).}
    +++\end{addescription}
    informationSeparatorFour: Character ;

    +++\begin{addescription}{provides a name for the unicode character 001D(hexadecimal).}
    +++\end{addescription}
    informationSeparatorThree: Character ;

    +++\begin{addescription}{provides a name for the unicode character 001E(hexadecimal).}
    +++\end{addescription}
    informationSeparatorTwo: Character ;

    +++\begin{addescription}{provides a name for the unicode character 001F(hexadecimal).}
    +++\end{addescription}
    informationSeparatorOne: Character ;

    +++\begin{addescription}{provides a name for the unicode character 0020(hexadecimal).}
    +++\end{addescription}
    space              : Character ;
    
    +++\begin{addescription}{provides a name for the unicode character 0021(hexadecimal).}
    +++Its textual representation is \verb|!|.
    +++\end{addescription}
    exclamationMark    : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0022(hexadecimal).}
    +++Its textual representation is \verb|"|.
    +++\end{addescription}
    quotationMark      : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0023(hexadecimal).}
    +++Its textual representation is \verb|#|.
    +++\end{addescription}
    numberSign         : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0024(hexadecimal).}
    +++Its textual representation is \verb|$|.
    +++\end{addescription}
    dollarSign         : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0025(hexadecimal).}
    +++Its textual representation is \verb|%|.
    +++\end{addescription}
    percentSign        : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0026(hexadecimal).}
    +++Its textual representation is \verb|&|.
    +++\end{addescription}
    ampersand          : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0027(hexadecimal).}
    +++Its textual representation is \verb|'|.
    +++\end{addescription}
    apostrophe         : Character ;
    +++\begin{addescription}{is an alias for \adname{apostrophe}.}
    +++\end{addescription}
    apostropheQuote    : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0028(hexadecimal).}
    +++Its textual representation is \verb|(|.
    +++\end{addescription}
    leftParenthesis    : Character ;
    +++\begin{addescription}{is an alias for \adname{leftParenthesis}.}
    +++\end{addescription}
    openingParenthesis    : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0029(hexadecimal).}
    +++Its textual representation is \verb|)|.
    +++\end{addescription}
    rightParenthesis   : Character ;
    +++\begin{addescription}{is an alias for \adname{rightParenthesis}.}
    +++\end{addescription}
    closingParenthesis : Character ;
    +++\begin{addescription}{provides a name for the unicode character 002A(hexadecimal).}
    +++Its textual representation is \verb|*|.
    +++\end{addescription}
    asterisk           : Character ;
    +++\begin{addescription}{provides a name for the unicode character 002B(hexadecimal).}
    +++Its textual representation is \verb|+|.
    +++\end{addescription}
    plusSign           : Character ;
    +++\begin{addescription}{provides a name for the unicode character 002C(hexadecimal).}
    +++Its textual representation is \verb|,|.
    +++\end{addescription}
    comma              : Character ;
    +++\begin{addescription}{provides a name for the unicode character 002D(hexadecimal).}
    +++Its textual representation is \verb|-|.
    +++\end{addescription}
    hyphenMinus        : Character ;
    +++\begin{addescription}{provides a name for the unicode character 002E(hexadecimal).}
    +++Its textual representation is \verb|.|.
    +++\end{addescription}
    fullStop           : Character ;
    +++\begin{addescription}{is an alias for \adname{fullStop}.}
    +++\end{addescription}
    period             : Character ;
    +++\begin{addescription}{provides a name for the unicode character 002F(hexadecimal).}
    +++Its textual representation is \verb|/|.
    +++\end{addescription}
    solidus            : Character ;
    +++\begin{addescription}{is an alias for \adname{solidus}.}
    +++\end{addescription}
    slash              : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0030(hexadecimal).}
    +++Its textual representation is \verb|0|.
    +++\end{addescription}
    digitZero          : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0031(hexadecimal).}
    +++Its textual representation is \verb|1|.
    +++\end{addescription}
    digitOne           : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0032(hexadecimal).}
    +++Its textual representation is \verb|2|.
    +++\end{addescription}
    digitTwo           : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0033(hexadecimal).}
    +++Its textual representation is \verb|3|.
    +++\end{addescription}
    digitThree         : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0034(hexadecimal).}
    +++Its textual representation is \verb|4|.
    +++\end{addescription}
    digitFour          : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0035(hexadecimal).}
    +++Its textual representation is \verb|5|.
    +++\end{addescription}
    digitFive          : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0036(hexadecimal).}
    +++Its textual representation is \verb|6|.
    +++\end{addescription}
    digitSix           : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0037(hexadecimal).}
    +++Its textual representation is \verb|7|.
    +++\end{addescription}
    digitSeven         : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0038(hexadecimal).}
    +++Its textual representation is \verb|8|.
    +++\end{addescription}
    digitEight         : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0039(hexadecimal).}
    +++Its textual representation is \verb|9|.
    +++\end{addescription}
    digitNine          : Character ;
    +++\begin{addescription}{provides a name for the unicode character 003A(hexadecimal).}
    +++Its textual representation is \verb|:|.
    +++\end{addescription}
    colon              : Character ;
    +++\begin{addescription}{provides a name for the unicode character 003B(hexadecimal).}
    +++Its textual representation is \verb|;|.
    +++\end{addescription}
    semicolon          : Character ;
    +++\begin{addescription}{provides a name for the unicode character 003C(hexadecimal).}
    +++Its textual representation is \verb|<|.
    +++\end{addescription}
    lessThanSign       : Character ;
    +++\begin{addescription}{provides a name for the unicode character 003D(hexadecimal).}
    +++Its textual representation is \verb|=|.
    +++\end{addescription}
    equalsSign         : Character ;
    +++\begin{addescription}{provides a name for the unicode character 003E(hexadecimal).}
    +++Its textual representation is \verb|>|.
    +++\end{addescription}
    greaterThanSign    : Character ;
    +++\begin{addescription}{provides a name for the unicode character 003F(hexadecimal).}
    +++Its textual representation is \verb|?|.
    +++\end{addescription}
    questionMark       : Character ;

    +++\begin{addescription}{provides a name for the unicode character 0040(hexadecimal).}
    +++Its textual representation is \verb|@|.
    +++\end{addescription}
    commercialAt       : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0041(hexadecimal).}
    +++Its textual representation is \verb|A|.
    +++\end{addescription}
    latinCapitalLetterA: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0042(hexadecimal).}
    +++Its textual representation is \verb|B|.
    +++\end{addescription}
    latinCapitalLetterB: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0043(hexadecimal).}
    +++Its textual representation is \verb|C|.
    +++\end{addescription}
    latinCapitalLetterC: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0044(hexadecimal).}
    +++Its textual representation is \verb|D|.
    +++\end{addescription}
    latinCapitalLetterD: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0045(hexadecimal).}
    +++Its textual representation is \verb|E|.
    +++\end{addescription}
    latinCapitalLetterE: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0046(hexadecimal).}
    +++Its textual representation is \verb|F|.
    +++\end{addescription}
    latinCapitalLetterF: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0047(hexadecimal).}
    +++Its textual representation is \verb|G|.
    +++\end{addescription}
    latinCapitalLetterG: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0048(hexadecimal).}
    +++Its textual representation is \verb|H|.
    +++\end{addescription}
    latinCapitalLetterH: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0049(hexadecimal).}
    +++Its textual representation is \verb|I|.
    +++\end{addescription}
    latinCapitalLetterI: Character ;
    +++\begin{addescription}{provides a name for the unicode character 004A(hexadecimal).}
    +++Its textual representation is \verb|J|.
    +++\end{addescription}
    latinCapitalLetterJ: Character ;
    +++\begin{addescription}{provides a name for the unicode character 004B(hexadecimal).}
    +++Its textual representation is \verb|K|.
    +++\end{addescription}
    latinCapitalLetterK: Character ;
    +++\begin{addescription}{provides a name for the unicode character 004C(hexadecimal).}
    +++Its textual representation is \verb|L|.
    +++\end{addescription}
    latinCapitalLetterL: Character ;
    +++\begin{addescription}{provides a name for the unicode character 004D(hexadecimal).}
    +++Its textual representation is \verb|M|.
    +++\end{addescription}
    latinCapitalLetterM: Character ;
    +++\begin{addescription}{provides a name for the unicode character 004E(hexadecimal).}
    +++Its textual representation is \verb|N|.
    +++\end{addescription}
    latinCapitalLetterN: Character ;
    +++\begin{addescription}{provides a name for the unicode character 004F(hexadecimal).}
    +++Its textual representation is \verb|O|.
    +++\end{addescription}
    latinCapitalLetterO: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0050(hexadecimal).}
    +++Its textual representation is \verb|P|.
    +++\end{addescription}
    latinCapitalLetterP: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0051(hexadecimal).}
    +++Its textual representation is \verb|Q|.
    +++\end{addescription}
    latinCapitalLetterQ: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0052(hexadecimal).}
    +++Its textual representation is \verb|R|.
    +++\end{addescription}
    latinCapitalLetterR: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0053(hexadecimal).}
    +++Its textual representation is \verb|S|.
    +++\end{addescription}
    latinCapitalLetterS: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0054(hexadecimal).}
    +++Its textual representation is \verb|T|.
    +++\end{addescription}
    latinCapitalLetterT: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0055(hexadecimal).}
    +++Its textual representation is \verb|U|.
    +++\end{addescription}
    latinCapitalLetterU: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0056(hexadecimal).}
    +++Its textual representation is \verb|V|.
    +++\end{addescription}
    latinCapitalLetterV: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0057(hexadecimal).}
    +++Its textual representation is \verb|W|.
    +++\end{addescription}
    latinCapitalLetterW: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0058(hexadecimal).}
    +++Its textual representation is \verb|X|.
    +++\end{addescription}
    latinCapitalLetterX: Character ;
    +++\begin{addescription}{provides a name for the unicode character 0059(hexadecimal).}
    +++Its textual representation is \verb|Y|.
    +++\end{addescription}
    latinCapitalLetterY: Character ;
    +++\begin{addescription}{provides a name for the unicode character 005A(hexadecimal).}
    +++Its textual representation is \verb|Z|.
    +++\end{addescription}
    latinCapitalLetterZ: Character ;
    +++\begin{addescription}{provides a name for the unicode character 005B(hexadecimal).}
    +++Its textual representation is \verb|[|.
    +++\end{addescription}
    leftSquareBracket  : Character ;
    +++\begin{addescription}{is an alias for \adname{leftSquareBracket}.}
    +++\end{addescription}
    openingSquareBracket: Character ;
    +++\begin{addescription}{provides a name for the unicode character 005C(hexadecimal).}
    +++Its textual representation is \verb|\|.
    +++\end{addescription}
    reverseSolidus     : Character ;
    +++\begin{addescription}{is an alias for \adname{reverseSolidus}.}
    +++\end{addescription}
    backslash: Character ;
    +++\begin{addescription}{provides a name for the unicode character 005D(hexadecimal).}
    +++Its textual representation is \verb|]|.
    +++\end{addescription}
    rightSquareBracket : Character ;
    +++\begin{addescription}{is an alias for \adname{rightSquareBracket}.}
    +++\end{addescription}
    closingSquareBracket: Character ;
    +++\begin{addescription}{provides a name for the unicode character 005E(hexadecimal).}
    +++Its textual representation is \verb|^|.
    +++\end{addescription}
    circumflexAccent   : Character ;
    +++\begin{addescription}{provides a name for the unicode character 005F(hexadecimal).}
    +++Its textual representation is \verb|_|.
    +++\end{addescription}
    lowLine            : Character ;
    +++\begin{addescription}{is an alias for \adname{lowLine}.}
    +++\end{addescription}
    spacingUnderscore: Character ;

    +++\begin{addescription}{provides a name for the unicode character 0060(hexadecimal).}
    +++\end{addescription}
    graveAccent        : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0061(hexadecimal).}
    +++Its textual representation is \verb|a|.
    +++\end{addescription}
    latinSmallLetterA  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0062(hexadecimal).}
    +++Its textual representation is \verb|b|.
    +++\end{addescription}
    latinSmallLetterB  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0063(hexadecimal).}
    +++Its textual representation is \verb|c|.
    +++\end{addescription}
    latinSmallLetterC  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0064(hexadecimal).}
    +++Its textual representation is \verb|d|.
    +++\end{addescription}
    latinSmallLetterD  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0065(hexadecimal).}
    +++Its textual representation is \verb|e|.
    +++\end{addescription}
    latinSmallLetterE  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0066(hexadecimal).}
    +++Its textual representation is \verb|f|.
    +++\end{addescription}
    latinSmallLetterF  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0067(hexadecimal).}
    +++Its textual representation is \verb|g|.
    +++\end{addescription}
    latinSmallLetterG  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0068(hexadecimal).}
    +++Its textual representation is \verb|h|.
    +++\end{addescription}
    latinSmallLetterH  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0069(hexadecimal).}
    +++Its textual representation is \verb|i|.
    +++\end{addescription}
    latinSmallLetterI  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 006A(hexadecimal).}
    +++Its textual representation is \verb|j|.
    +++\end{addescription}
    latinSmallLetterJ  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 006B(hexadecimal).}
    +++Its textual representation is \verb|k|.
    +++\end{addescription}
    latinSmallLetterK  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 006C(hexadecimal).}
    +++Its textual representation is \verb|l|.
    +++\end{addescription}
    latinSmallLetterL  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 006D(hexadecimal).}
    +++Its textual representation is \verb|m|.
    +++\end{addescription}
    latinSmallLetterM  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 006E(hexadecimal).}
    +++Its textual representation is \verb|n|.
    +++\end{addescription}
    latinSmallLetterN  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 006F(hexadecimal).}
    +++Its textual representation is \verb|o|.
    +++\end{addescription}
    latinSmallLetterO  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0070(hexadecimal).}
    +++Its textual representation is \verb|p|.
    +++\end{addescription}
    latinSmallLetterP  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0071(hexadecimal).}
    +++Its textual representation is \verb|q|.
    +++\end{addescription}
    latinSmallLetterQ  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0072(hexadecimal).}
    +++Its textual representation is \verb|r|.
    +++\end{addescription}
    latinSmallLetterR  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0073(hexadecimal).}
    +++Its textual representation is \verb|s|.
    +++\end{addescription}
    latinSmallLetterS  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0074(hexadecimal).}
    +++Its textual representation is \verb|t|.
    +++\end{addescription}
    latinSmallLetterT  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0075(hexadecimal).}
    +++Its textual representation is \verb|u|.
    +++\end{addescription}
    latinSmallLetterU  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0076(hexadecimal).}
    +++Its textual representation is \verb|v|.
    +++\end{addescription}
    latinSmallLetterV  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0077(hexadecimal).}
    +++Its textual representation is \verb|w|.
    +++\end{addescription}
    latinSmallLetterW  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0078(hexadecimal).}
    +++Its textual representation is \verb|x|.
    +++\end{addescription}
    latinSmallLetterX  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 0079(hexadecimal).}
    +++Its textual representation is \verb|y|.
    +++\end{addescription}
    latinSmallLetterY  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 007A(hexadecimal).}
    +++Its textual representation is \verb|z|.
    +++\end{addescription}
    latinSmallLetterZ  : Character ;
    +++\begin{addescription}{provides a name for the unicode character 007B(hexadecimal).}
    +++Its textual representation is \verb|{|.
    +++\end{addescription}
    leftCurlyBracket   : Character ;
    +++\begin{addescription}{is an alias for \adname{leftCurlyBracket}.}
    +++\end{addescription}
    openingCurlyBracket: Character ;
    +++\begin{addescription}{provides a name for the unicode character 007C(hexadecimal).}
    +++Its textual representation is \verb+|+.
    +++\end{addescription}
    verticalLine       : Character ;
    +++\begin{addescription}{is an alias for \adname{verticalLine}.}
    +++\end{addescription}
    verticalBar        : Character ;
    +++\begin{addescription}{provides a name for the unicode character 007D(hexadecimal).}
    +++Its textual representation is \verb|}|.
    +++\end{addescription}
    rightCurlyBracket  : Character ;
    +++\begin{addescription}{is an alias for \adname{rightCurlyBracket}.}
    +++\end{addescription}
    closingCurlyBracket: Character ;
    +++\begin{addescription}{provides a name for the unicode character 007E(hexadecimal).}
    +++Its textual representation is \verb|~|.
    +++\end{addescription}
    tilde              : Character ;
    +++\begin{addescription}{provides a name for the unicode character 007F(hexadecimal).}
    +++\end{addescription}
    delete             : Character ;

  } == add {
    import from MachineInteger;
    import from Character;

    null               : Character  == char   0;
    startOfHeading     : Character  == char   1;
    startOfText        : Character  == char   2;
    endOfText          : Character  == char   3;
    endOfTransmission  : Character  == char   4;
    enquiry            : Character  == char   5;
    acknowledge        : Character  == char   6;
    bell               : Character  == char   7;
    backspace          : Character  == char   8;
    characterTabulation: Character  == char   9;
    lineFeed           : Character  == char  10;
    lineTabulation     : Character  == char  11;
    formFeed           : Character  == char  12;
    carriageReturn     : Character  == char  13;
    shiftOut           : Character  == char  14;
    shiftIn            : Character  == char  15;
    dataLinkEscape     : Character  == char  16;
    deviceControlOne   : Character  == char  17;
    deviceControlTwo   : Character  == char  18;
    deviceControlThree : Character  == char  19;
    deviceControlFour  : Character  == char  20;
    negativeAcknowledge: Character  == char  21;
    synchronousIdle    : Character  == char  22;
    endOfTransmissionBlock: Character  == char  23;
    cancel             : Character  == char  24;
    endOfMedium        : Character  == char  25;
    substitute         : Character  == char  26;
    escape             : Character  == char  27;
    informationSeparatorFour: Character  == char  28;
    informationSeparatorThree: Character  == char  29;
    informationSeparatorTwo: Character  == char  30;
    informationSeparatorOne: Character  == char  31;

    space              : Character == char  32;
    exclamationMark    : Character == char  33;
    quotationMark      : Character == char  34;
    numberSign         : Character == char  35;
    dollarSign         : Character == char  36;
    percentSign        : Character == char  37;
    ampersand          : Character == char  38;
    apostrophe         : Character == char  39;
    apostropheQuote    : Character == apostrophe;
    leftParenthesis    : Character == char  40;
    openingParenthesis : Character == leftParenthesis;
    rightParenthesis   : Character == char  41;
    closingParenthesis : Character == rightParenthesis;
    asterisk           : Character == char  42;
    plusSign           : Character == char  43;
    comma              : Character == char  44;
    hyphenMinus        : Character == char  45;
    fullStop           : Character == char  46;
    period             : Character == fullStop;
    solidus            : Character == char  47;
    slash              : Character == solidus;
    digitZero          : Character == char  48;
    digitOne           : Character == char  49;
    digitTwo           : Character == char  50;
    digitThree         : Character == char  51;
    digitFour          : Character == char  52;
    digitFive          : Character == char  53;
    digitSix           : Character == char  54;
    digitSeven         : Character == char  55;
    digitEight         : Character == char  56;
    digitNine          : Character == char  57;
    colon              : Character == char  58;
    semicolon          : Character == char  59;
    lessThanSign       : Character == char  60;
    equalsSign         : Character == char  61;
    greaterThanSign    : Character == char  62;
    questionMark       : Character == char  63;

    commercialAt       : Character == char  64;
    latinCapitalLetterA: Character == char  65;
    latinCapitalLetterB: Character == char  66;
    latinCapitalLetterC: Character == char  67;
    latinCapitalLetterD: Character == char  68;
    latinCapitalLetterE: Character == char  69;
    latinCapitalLetterF: Character == char  70;
    latinCapitalLetterG: Character == char  71;
    latinCapitalLetterH: Character == char  72;
    latinCapitalLetterI: Character == char  73;
    latinCapitalLetterJ: Character == char  74;
    latinCapitalLetterK: Character == char  75;
    latinCapitalLetterL: Character == char  76;
    latinCapitalLetterM: Character == char  77;
    latinCapitalLetterN: Character == char  78;
    latinCapitalLetterO: Character == char  79;
    latinCapitalLetterP: Character == char  80;
    latinCapitalLetterQ: Character == char  81;
    latinCapitalLetterR: Character == char  82;
    latinCapitalLetterS: Character == char  83;
    latinCapitalLetterT: Character == char  84;
    latinCapitalLetterU: Character == char  85;
    latinCapitalLetterV: Character == char  86;
    latinCapitalLetterW: Character == char  87;
    latinCapitalLetterX: Character == char  88;
    latinCapitalLetterY: Character == char  89;
    latinCapitalLetterZ: Character == char  90;
    leftSquareBracket  : Character == char  91;
    openingSquareBracket: Character == leftSquareBracket;
    reverseSolidus     : Character == char  92;
    backslash          : Character == reverseSolidus;
    rightSquareBracket : Character == char  93;
    closingSquareBracket: Character == rightSquareBracket;
    circumflexAccent   : Character == char  94;
    lowLine            : Character == char  95;
    spacingUnderscore  : Character == lowLine;

    graveAccent        : Character == char  96;
    latinSmallLetterA  : Character == char  97;
    latinSmallLetterB  : Character == char  98;
    latinSmallLetterC  : Character == char  99;
    latinSmallLetterD  : Character == char 100;
    latinSmallLetterE  : Character == char 101;
    latinSmallLetterF  : Character == char 102;
    latinSmallLetterG  : Character == char 103;
    latinSmallLetterH  : Character == char 104;
    latinSmallLetterI  : Character == char 105;
    latinSmallLetterJ  : Character == char 106;
    latinSmallLetterK  : Character == char 107;
    latinSmallLetterL  : Character == char 108;
    latinSmallLetterM  : Character == char 109;
    latinSmallLetterN  : Character == char 110;
    latinSmallLetterO  : Character == char 111;
    latinSmallLetterP  : Character == char 112;
    latinSmallLetterQ  : Character == char 113;
    latinSmallLetterR  : Character == char 114;
    latinSmallLetterS  : Character == char 115;
    latinSmallLetterT  : Character == char 116;
    latinSmallLetterU  : Character == char 117;
    latinSmallLetterV  : Character == char 118;
    latinSmallLetterW  : Character == char 119;
    latinSmallLetterX  : Character == char 110;
    latinSmallLetterY  : Character == char 121;
    latinSmallLetterZ  : Character == char 122;
    leftCurlyBracket   : Character == char 123;
    openingCurlyBracket: Character == leftCurlyBracket;
    verticalLine       : Character == char 124;
    verticalBar        : Character == verticalLine;
    rightCurlyBracket  : Character == char 125;
    closingCurlyBracket: Character == rightCurlyBracket;
    tilde              : Character == char 126;
    delete             : Character == char 127;
    
}


