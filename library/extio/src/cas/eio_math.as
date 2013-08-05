-------------------------------------------------------------------------
--
-- eio_math.as
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

import from String;

+++\begin{addescription}{provides conversions between \Aldor and \Mathematica's FullForm format.}
+++\end{addescription}
+++\begin{adseealso}
+++  \adtype{ComputerAlgebraSystemTools}
+++  \adtype{MathematicaFullFormParser}
+++\end{adseealso}
MathematicaFullFormTools: ComputerAlgebraSystemType == add {
    
    
    -----------------------------------------------------------  

    
    identifier: Symbol == -"mathematica_full_form";
    
    
    -----------------------------------------------------------  

    
    parserDomain: ParserReader == MathematicaFullFormParser;

    
    -----------------------------------------------------------  

    
    encodeAsString( str: String ): String == {
	"_""+str+"_"";
    }

    
    -----------------------------------------------------------  

    
    --this function helps to compare two tree operators that are not both an a constant in the calling context
    local equalIds?( leftOP: ExpressionTreeOperator, rightOP: ExpressionTreeOperator ): Boolean == {
	import from MachineInteger;
	(uniqueId$leftOP) = (uniqueId$rightOP);
    }

   
    -----------------------------------------------------------  

    
    --this function is used to obtian the name of a tree operator that is not a constant in the calling context
    local getName( op: ExpressionTreeOperator ): String == {
	import from Symbol;
	name( name$op );
    }

    
    -----------------------------------------------------------  

    
    --this function is used to compare the name of a tree operator that is not a constant in the calling context to a string
    local hasName?( leftOP: ExpressionTreeOperator, nameRight: String ): Boolean == {
	import from Symbol;
	(name$leftOP) = (-nameRight);
    }

    
    -----------------------------------------------------------  


    --used to align print arguments to functions and list elements
    encodeAsString!( exps: List ExpressionTree ): Partial String == {
	local sb: StringBuffer := new();
	local sw: TextWriter := sb :: TextWriter;
	
	local notFirst := false; --used to determine if a comma has to be prpended
		
	for exp in exps repeat
	{
	    --prepending comma if necessary
	    if notFirst then 
	    {
		sw << ",";
	    } else {
		notFirst := true;
	    }
	    
	    --delegating the output of each member in the list
	    local pString : Partial String := encodeAsString! exp;
	    if failed? pString then
	    {
		return failed;
	    }
	    
	    --adding the textual representation of exp
	    sw << (retract pString );
	}

	[ string sb ];
    }
    
    
    -----------------------------------------------------------  
    
    encodeAsArgs!( exps: List ExpressionTree ): Partial String == {

	local pString : Partial String := encodeAsString! exps;
	if failed? pString then
	{
	    return failed;
	}
	
	[ "[" + retract pString + "]" ];
	
    }
    
    -----------------------------------------------------------  
    
    --note, that this version maps to Partial String. It is NOT the exported version, but used by the exported version
    local encodeAsString!( e: ExpressionTree ): Partial String == {
	import from MachineInteger;
	import from Integer;
	
	local pString : Partial String;
	
	if leaf? e then
	{
	    local etl: ExpressionTreeLeaf := leaf e;
            --strings have to be adjusted
	    if string? etl then {
		[ encodeAsString string etl ];
	    } else {
		--maple(!)'s output suffices for leaves
		local sb: StringBuffer := new();
		maple( sb::TextWriter, etl );
		[ string sb ];
	    }
	} else {
	    -- seperate treatment of each understood ExpressionTreeOperator
	    local op := operator e;
	    if equalIds?( op, ExpressionTreeExpt ) then {
		pString := encodeAsArgs! arguments e;
		if failed? pString then
		{
		    return failed;
		}
		[ "Power"+ retract pString ];
	    } else if equalIds?( op, ExpressionTreeList ) then {
		pString := encodeAsArgs! arguments e;
		if failed? pString then
		{
		    return failed;
		}
		[ "List"+ retract pString ];
	    } else if equalIds?( op, ExpressionTreePlus ) then {
		pString := encodeAsArgs! arguments e;
		if failed? pString then
		{
		    return failed;
		}
		[ "Plus"+ retract pString ];
	    } else if equalIds?( op, ExpressionTreeTimes ) then {
		pString := encodeAsArgs! arguments e;
		if failed? pString then
		{
		    return failed;
		}
		[ "Times"+ retract pString ];
	    } else if equalIds?( op, ExpressionTreePrefix( - "") ) then {
		if hasName?( op, "diff" ) then
		{   -- "diff" indicates derivation, which needs special treatment
		    local dSyms : List Symbol := empty;
		    local args: List ExpressionTree;

		    local eIsVar := false;
		    while ~ eIsVar repeat
		    {
			args := arguments e;
			op := operator e;
			if equalIds?( op, ExpressionTreePrefix( - "") ) then 
			{
			    if hasName?( op, "diff" ) then
			    {
				if # args ~= 2 then
				{
				    return failed;
				}
				local etDepSymbol : ExpressionTree := args . ( next (firstIndex$(List ExpressionTree)) );
				if leaf? etDepSymbol and symbol? leaf etDepSymbol then
				{
				    dSyms := insert!( symbol leaf etDepSymbol, dSyms );
				} else {
				    return failed;
				}

				e := args . (firstIndex$(List ExpressionTree));

			    } else {
				variableName := getName op;
				eIsVar := true;
			    }
			} else {
			    return failed;
			}
		    }
			
		    assert( getName operator e = variableName );
		    
		    local symDEList : DoubleEndedList Symbol := empty();
		    for arg in args repeat
		    {
			if leaf? etDepSymbol and symbol? leaf etDepSymbol then
			{
			    symDEList := concat!( symDEList, symbol leaf arg );
			} else {
			    return failed;
			}	
		    }
		    local syms: List Symbol := firstCell symDEList;
		    
		    local ns: Array Integer := new( # syms, 0 );
		    for dSym in dSyms repeat
		    {
			( found?, idx, t ) := linearSearch( dSym, syms );
			if found? then
			{
			    local arrayIdx := idx-(firstIndex$(List Symbol))+(firstIndex$(Array Integer));
			    ns . arrayIdx := next( ns . arrayIdx );
			} else {
			    return failed;
			}
		    }

                    pString := encodeAsArgs! arguments ExpressionTreeList . [ extree n for n in ns ];
		    local pString2: Partial String := encodeAsArgs! arguments e;
		    if failed? pString or failed? pString2 then
		    {
			return failed;
		    }
		    [ "Derivative" + retract pString + "[" + variableName + "]" + retract pString2 ];
		    
		} else {
		    pString := encodeAsArgs! arguments e;
		    if failed? pString then
		    {
			return failed;
		    }
		    
		    [ getName( op ) + retract pString ];
		    
		}
	    } else {
		
		failed;
		
	    }
	}
	
    }

    
    -----------------------------------------------------------  

    
    encodeAsString!( e: ExpressionTree ): String == {

	local pRes: Partial String := encodeAsString! e;
	
	if failed? pRes then
	{
	    encodeAsError "cannot interprete expression";
	} else {
	    retract pRes;
	}
	
    }
	
    -----------------------------------------------------------  

    encodeAsError( str: String ): String == {
	"Print[StringJoin[_"ERROR: _","+(encodeAsString str)+"]];$Failed";
    }

    
    -----------------------------------------------------------  
    
    
    encodeAsWarning( str: String ): String == {
	"WARNING("+(encodeAsString str)+");";
    }

    
    -----------------------------------------------------------  
    
    
}

#endif