-------------------------------------------------------------------------
--
-- eio_matp.as
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


+++\begin{addescription}{implements a \adtype{ParserReader} for \Mathematica's FullForm format.}
+++\end{addescription}
+++\begin{adremarks}
+++  \adthistype ignores escaping of characters in \Mathematica's strings.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{MathematicaFullFormTools}
+++\end{adseealso}
MathematicaFullFormParser: ParserReader == add {
    

    macro Rep == Record(
      endOfReader?: Boolean,        -- true iff at end of Reader
      lastError   : MachineInteger, -- the last errer that occured
      skipMode?   : Boolean,        -- true iff newlines and spaces are to be skipped
      lookAhead   : Character,      -- the next character in the string stream
      reader      : TextReader      -- the stream
    );
    
    import from Rep;
    
    import from Character;
    import from CharacterNames;
    import from String;
    import from Symbol;


    --the following few lines define which Operation is mapped to which ExpressionTreeOperator
        
    macro ETOCapsule == Record( eto: ExpressionTreeOperator ); --using ExpressionTreeOperator's causes bugs with the current compiler. Wrapping in a record as a work around for this
    import from ETOCapsule;
    import from Cross( String, ETOCapsule );                   -- a structure for a mapping
    macro MAPPING( STRING, OP ) == { mapping: Cross( String, ETOCapsule ) := ( STRING, record( OP ) ) }; --adding a mapping to the hash table
    
    local mathematicaToAldorFunctions: ChainingHashTable( String, ETOCapsule ) := [ 
      MAPPING( "Power",  ExpressionTreeExpt ),
      MAPPING( "List",  ExpressionTreeList ),
      MAPPING( "Plus",  ExpressionTreePlus ),
      MAPPING( "Times",  ExpressionTreeTimes ),
      MAPPING( "D",  ExpressionTreePrefix( -"diff" ) )
      -- Derivative is handled directly in parseRep!
    ];
    
    -----------------------------------------------------------  
    
    
    eof?( a: % ): Boolean == {
	(rep a). endOfReader?;
    }

	
    -----------------------------------------------------------  

    
    lastError( a: % ): MachineInteger == {
	(rep a). lastError;
    }

	
    -----------------------------------------------------------  
    
    local skipCharacter?( ch : Character ): Boolean == {
	ch = (space$CharacterNames) => true;
	ch = newline => true;
	false;
    }
    
    -----------------------------------------------------------
    
    
    local mathematicaLetter?( ch : Character ): Boolean == {
	latinSmallLetterA <= ch and ch <= latinSmallLetterZ => true;
	latinCapitalLetterA <= ch and ch <= latinCapitalLetterZ => true;
	false;
    }
    
    -----------------------------------------------------------
    
    
    local nextLookAhead( repA: Rep ): Character == {

	repA . endOfReader? => eof;
	
	local stream := repA . reader;
	local ch := read! stream;

	if repA . skipMode? then
	{
	    while skipCharacter? ch repeat
	    {
		ch := read! stream;
	    }
	}
	if ch = eof then {
	    repA.endOfReader? := true;
	}
	repA.lookAhead := ch;
    }
        

    -----------------------------------------------------------  
    

    --initializes parser
    parser( reader: TextReader ): % == {
	local repA := record( false, 0, true, (space$CharacterNames), reader );
	nextLookAhead repA;
	per repA;
    }

	
    -----------------------------------------------------------  

   
    local disableSkipMode!( repA: Rep ):() == {
	repA.skipMode? := false;
    }

	
    -----------------------------------------------------------  

    
    local enableSkipMode!( repA: Rep ):() == {
	repA . skipMode? := true;
	if skipCharacter? repA . lookAhead then
	{
	    nextLookAhead repA;
	}
    }

	
    -----------------------------------------------------------  


    local parseNonEmptyEnumeration!( repA: Rep ): Partial List ExpressionTree == {
	local la := repA.lookAhead;
	local elements : DoubleEndedList ExpressionTree := empty();
	local pElement : Partial ExpressionTree;

        --parse first element
	pElement := parseRep! repA;
	if failed? pElement then
	{
	    return failed;
	}
	elements := concat!( elements, retract pElement );
	la := repA.lookAhead;

	
	--pares elements as long as there are commas
	while la = comma repeat
	{
	    la := nextLookAhead repA;
	    pElement := parseRep! repA;
	    if failed? pElement then
	    {
		return failed;
	    }

	    elements := concat!( elements, retract pElement );
	    la := repA.lookAhead;
	}
	
	
	--pass back the results
	[ (firstCell elements) ];	
    }
    
    
    -----------------------------------------------------------  

    
    --parses the parameters of a function call in Mathematcias FullForm notation
    local parseParameters!( repA: Rep ): Partial List ExpressionTree == {

	import from ExpressionTree;
	
	--has to start with a left square bracket 
	repA . lookAhead ~= leftSquareBracket => failed;
	local la := nextLookAhead repA;

 	-- if and return is used instead of =>, due to compiler problems
	if la = eof then {
	    return failed;
	} 
	
	if la = rightSquareBracket then
	{   --empty list of parameters
	    nextLookAhead repA;
	    return (bracket$(Partial List ExpressionTree)) (empty$(List ExpressionTree));
	}

	--list of parameters is not empty	
	local pETs: Partial List ExpressionTree := parseNonEmptyEnumeration! repA;
	if failed? pETs then
	{
	    return failed;
	}

	--assert proper termination of the list of parameters
	repA . lookAhead ~= rightSquareBracket => failed;
	nextLookAhead repA;
	
	pETs;

    }
    
    
    -----------------------------------------------------------  
    
    
    parse!( a: % ): Partial ExpressionTree == {
	parseRep! rep a;
    }
    
    
    -----------------------------------------------------------  


    local parseRep!( repA: Rep ): Partial ExpressionTree == {

	import from ExpressionTree;
	
	local la := repA.lookAhead;
	local pETs : Partial List ExpressionTree;
	
	import from Character, MachineInteger;
	
	
	if digit? la or la = hyphenMinus then 
	{
	    -- parsing a (possibly negative) number

            --no characters to be skipped, as a space between digits indicates a new number
	    disableSkipMode! repA;

	    local numberString: String := coerce la;	    
	    
	    la := nextLookAhead repA;
	    while digit? la repeat
	    {
		numberString := numberString + coerce la;
		la := nextLookAhead repA;
	    }
	    
	    if la = fullStop then 
	    {   --floating point number 
		numberString := numberString + coerce la;
		la := nextLookAhead repA;
		
		while digit? la repeat
		{
		    numberString := numberString + coerce la;
		    la := nextLookAhead repA;
		}
		--Mathematica adds trailing Symbols for huge numbers
		if la = graveAccent then
		{
		    la := nextLookAhead repA;
		}
	    }

            --parsed number. turning on skipping mode, so spaces,... need not be treated
	    enableSkipMode! repA;
	    
	    return  (parse!$InfixExpressionParser) ( (parser$InfixExpressionParser) (numberString::TextReader) );
	    
	} else if la = quotationMark then {

	    -- parsing a string
	    
            --no characters to be skipped, as spaces are part of the strings
	    disableSkipMode! repA;
	    local stringString: String := empty;
	    
	    --skip the opening quotation mark
	    la := nextLookAhead repA;
	    
	    --append choracters until either another quotation mark or eof occurs
	    while la ~= quotationMark and la ~= eof repeat
	    {
		stringString := stringString + coerce la;
		la := nextLookAhead repA;
	    }

	    if la = eof then
	    {
		--missing closing quotation mark
		return failed;	    
	    }
	    
	    assert( la = quotationMark );
	    --skipping closing quotation mark
	    la := nextLookAhead repA;
	    
	    return [ extree stringString ];

	} else if la = leftCurlyBracket then {

	    -- parsing a list

            -- skipping opening brace
	    la := nextLookAhead repA;

 	    if la = eof then {
		--premature end of input ... not even a closing brace
		return failed;
	    } 
	    
	    if la = rightCurlyBracket then
	    {
                --emply list
		nextLookAhead repA;
		return (bracket$(Partial ExpressionTree)) ExpressionTreeList . (empty$(List ExpressionTree));
	    }
	    
	    assert( la ~= rightCurlyBracket and la ~= eof );

            -- the list is not empty
 	    pETs := parseNonEmptyEnumeration! repA;
	    if failed? pETs then
	    {
		return failed;
	    }
	    
	    --check for the closing brace
	    if repA . lookAhead ~= rightCurlyBracket then
	    {
		return failed;	    
	    }
	    nextLookAhead repA;
	    
	    return (bracket$(Partial ExpressionTree)) ExpressionTreeList . (retract pETs);	    
	    
	} else	if mathematicaLetter? la then {

	    -- parsing a function or symbol

	    -- a skip character indicates a new symbol, so turn off skipping
	    disableSkipMode! repA;	    
	    
	    -- la is first character of the function name or symbol
	    local functionName: String := coerce la;
	    
            --read furtther characters in function name or symbol
	    la := nextLookAhead repA;
	    while mathematicaLetter? la or digit? la repeat
	    {
		functionName := functionName + coerce la;
		la := nextLookAhead repA;
	    }
	    
	    --done reading the functions nmae or symbol. Spaces con be skipped again from now on
	    enableSkipMode! repA;
	    
	    --if the next character is NOT a left square bracket, then a symbol has been parsed
	    if repA . lookAhead ~= leftSquareBracket then
	    { 
		-- have parsed a symbol
		import from Symbol;
		return [ extree (- functionName) ];
	    }
	    
	    -- parsing a function
	    
	    --grabbing the functions parameters
	    pETs := parseParameters! repA;
	    if failed? pETs then
	    {
		return failed;
	    }
	    
	    --reslving the function to an ExpressionTreeOperator for the rest of the branch
	    
	    local op: ExpressionTreeOperator;
	    --lookup of the function name
	    local pCapsule : Partial ETOCapsule := find( functionName, mathematicaToAldorFunctions);

	    if failed? pCapsule then
	    {
		--function name is not entered in the mathematicaToAldorFunctions hash table. So converting to an apply or derivation is necessary
		
		import from Symbol;

		if functionName = "Derivative" then
		{
		    --converting to a derivation in \Aldor's notation
		    op := ExpressionTreePrefix ( - "diff" );

                    import from List ExpressionTree;
		    import from ExpressionTreeLeaf;
		    import from Integer;
		    local ders := retract pETs;

		    local pVars := parseParameters! repA;
		    local pDeps := parseParameters! repA;
		    if failed? pVars or failed? pDeps then
		    {
			return failed;			
		    }
		    local vars := retract pVars;
		    local deps := retract pDeps;
		
		    -- checking if dep is a list of exactly one element, an
		    -- ExpressionTreeLeaf of a symbol;

		    if empty? vars or ~ empty? rest vars then
		    {
			return failed;
		    }
		    local fVar := first vars;
		    if ~ leaf? fVar then
		    {
			return failed;
		    }
		    local fVarLeaf := leaf fVar;
		    if ~ symbol? fVarLeaf then
		    {
			return failed;
		    }		   
			
		    local ET : ExpressionTree := (ExpressionTreePrefix ( symbol fVarLeaf )) . deps;
		    
		    for derET in ders for depET in deps repeat 
		    {
			--checking the dependence
			if ~ leaf? depET then
			{
			    return failed;
			}
			local depLeaf := leaf depET;
			if ~ symbol? depLeaf then
			{
			    return failed;
			}		

			-- checking how often to derivate
			if ~ leaf? derET then
			{
			    return failed;
			}
			local derLeaf := leaf derET;
			if ~ integer? derLeaf then
			{
			    return failed;
			}		
			local times := integer derLeaf;
			if times < 0 then			
			{
			    return failed;
			}
			if times > 0 then			
			{
			    for i in 1 .. times repeat
			    {
				ET := op . [ ET, depET ];
			    }
			}
		    }
		    if # ders ~= # deps then
		    {
			return failed;
		    }
		    return (bracket$(Partial ExpressionTree)) ET;
		}
		 
		--no derivatition. So using as the functionname for function application
		op := ExpressionTreePrefix ( - functionName );
		
	    } else {
		--function name is entered in the mathematicaToAldorFunctions hash table. So converting to an apply or derivation is necessary
		op := (retract pCapsule).eto;
	    }
	    
	    --finally, applying the operater to its arguments
	    return (bracket$(Partial ExpressionTree)) op . (retract pETs);	    	    
	}
	failed;
    }

	
    -----------------------------------------------------------  
    
    
}

#endif