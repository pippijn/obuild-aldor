-------------------------------------------------------------------------
--
-- cs_cstls.as
--
-------------------------------------------------------------------------

--tell all include files to register their implementations of ComputerAlgebraSystemType
#assert REGISTER_COMPUTER_ALGEBRA_SYSTEMS

#include "charset.as"

+++\begin{addescription}{exports the computation of a coherent autoreduced set to \C}
+++\end{addescription}
ExportedCoherentAutoreducedSetTools: with {
  
    +++\begin{addescription}{comuptes a coherent autoreduced set from string encoded differential polynomials}
    +++This function is a wrapper for the \adname[TriangularizationAlgorithmType]{triangularize} algorithm of \adtype{CoherentAutoreducedSetTools}. This wrapping is used to build the necessary domains for the coherent autoreduced set computation.
    +++
    +++This function takes five \adtype{Pointer}{}s as parameter and returns another Pointer. All \adtype{Pointer}{}s refer to null terminated, single byte character strings. The first input parameter refers to the identifier of an implementation of \adtype{ComputerAlgebraSystemType}. All further parameters are supposed to be stored in the format of this implementation. The second parameter refers to a list of differential polynomials for which a coherent autoreduced set is to be computed. The third and fourth parameter refer to the dependent and independent indeterminates of the domain for the differential polynomials. The fifth parameter allows to adjust further parameters for the domains for the differential polynomials. These further options have to be comma separated. If contradicting options are specified, the latter option has precedence. The possible options for the order of the derivatives are
    +++\begin{itemize}
    +++    \item \adcode{OrderlyEliminationOrder} \\ uses \adtype{DifferentialVariableOrderlyEliminationOrderTools} to order the derivatives,
    +++    \item \adcode{LexicographicEliminationOrder} \\ {\it(default)} uses \adtype{DifferentialVariableLexicographicEliminationOrderTools} to order the derivatives,
    +++\item \adcode{LexicographicOrder} \\ uses \adtype{DifferentialVariableLexicographicOrderTools} to order the derivatives, and
    +++\item \adcode{OrderlyOrder} \\ uses \adtype{DifferentialVariableOrderlyOrderTools} to order the derivatives.
    +++\end{itemize}
    +++
    +++The possible options for the exponent vectors are
    +++\begin{itemize}
    +++\item \adcode{presortClasses} \\ is only valid for orders which have \adtype{DifferentialVariableEliminationOrderToolsType} and refines the chosen exponent vector implementation by wrapping it with \adtype{ClassPresortedDifferentialExpontent},
    +++\item \adcode{SortedListExponent} \\ uses \adtype{SortedListExponent} for storing exponent vectors,
    +++\item \adcode{ListExponent} \\ uses \adtype{ListExponent} for storing exponent vectors,
    +++\item \adcode{ListSortedExponent} \\ uses \adtype{ListSortedExponent} for storing exponent vectors, and
    +++\item \adcode{CumulatedExponent} \\ uses \adtype{CumulatedExponent} for storing exponent vectors.
    +++\end{itemize}
    +++
    +++The possible options for the implementation of the polynomials are
    +++\begin{itemize}
    +++\item \adcode{RecursivePolynomialRingViaPercentArray} \\ models the polynomials by \adtype{RecursivePolynomialRingViaPercentArray} and
    +++\item \adcode{DistributedMultivariatePolynomial1} \\ models the polynomials by \adtype{DistributedMultivariatePolynomial1}.
    +++\end{itemize}
    +++
    +++The resulting \adtype{Pointer} of calling \adthisname is a list of polynomials, encoded as \C string using the format of the supplied computer algebra system. These polynomials are the result of the algorithm.
    +++\end{addescription}
    +++\begin{adseealso}
    +++  \cite{AldorUG}
    +++  \cite{Aistleitner2005}
    +++\end{adseealso}
    coherentAutoreducedSet: ( Pointer, Pointer, Pointer, Pointer, Pointer ) -> Pointer;
  
} == add {

    
    -----------------------------------------------------------

    
    --parses a expression encoded in a string in cas's format to an expression tree
    parseToExpressionTree( cas: ComputerAlgebraSystemType, stringPointer: Pointer ): Partial ExpressionTree == {
	import from Partial ExpressionTree;
	import from ExpressionTree;
	import from String;
	import from (parserDomain$cas);
	
	parse! parser((string stringPointer)::TextReader);
    }

    
    -----------------------------------------------------------

    
    --parses the depended symbols
    parseSymbols( cas: ComputerAlgebraSystemType, symbolStringPointer: Pointer ): Partial List Symbol == {
	import from ExpressionTree;
	import from String;
	import from (parserDomain$cas);
	
	local pExpTree:Partial ExpressionTree := parseToExpressionTree( cas, symbolStringPointer );
	failed? pExpTree => failed;
	local pResult: Partial List Symbol := (eval$(List Symbol)) retract pExpTree;

	(eval$(List Symbol)) retract pExpTree;
    }

    
    -----------------------------------------------------------


    --parses the independed symbols
    parseDerivationSymbols( cas: ComputerAlgebraSystemType, derivationSymbolsPointer: Pointer ): Partial Array Symbol == {
	import from Array Symbol;
	import from List Symbol;
	import from Partial List Symbol;
	local pSymbolList := parseSymbols( cas, derivationSymbolsPointer );
        failed? pSymbolList => failed;
	[ [ generator retract pSymbolList ] ];
    }
    
    
    -----------------------------------------------------------

  
    coherentAutoreducedSet( languagePointer: Pointer, polyPointer: Pointer, variablePointer: Pointer, derivationPointer: Pointer, optionsPointer: Pointer ): Pointer == {
        
        import from String;
	
	----- grabbing the desired computer algebra system ---------------------

	local Cas: ComputerAlgebraSystemType;
	try {
	    Cas := (find$ComputerAlgebraSystemTools) ( (-$Symbol) (string languagePointer));
	} catch E in {
	    E has NotFoundExceptionType => { return pointer "UNREGISTERED__COMPUTER__ALGEBRA__SYSTEM__ERROR"; }
	    never;
	}
	local CAS: ComputerAlgebraSystemType == Cas;

	import from CAS;
	
	----- variables --------------------------------------------------------

	import from List Symbol;
	import from Partial List Symbol;
	local pSymbolList: Partial List Symbol := parseSymbols( CAS, variablePointer );
	if (failed?$(Partial List Symbol)) pSymbolList then
	{ 
	    import from String; 
	    return pointer encodeAsError "cannot parse the variables";
	}
	local VARS: FiniteVariableType == ( OrderedVariableList( reverse! ( (retract$(Partial List Symbol)) pSymbolList ) ) );
	
	----- derivations ------------------------------------------------------

	import from Partial Array Symbol;
	import from Array Symbol;
	pSymbolList := parseSymbols( CAS, derivationPointer );
	if (failed?$(Partial List Symbol)) pSymbolList then
	{
	    return pointer encodeAsError "cannot parse the derivation symbols" ;
	}
	local MDSYMS: Array Symbol == [ generator retract pSymbolList ];
	
	----- options ----------------------------------------------------------

	import from StringTokenizer;

	local optionTokens: List String := [ tokenize( comma$CharacterNames, string optionsPointer ) ];

	----- options - order --------------------------------------------------

	local order : DifferentialVariableOrderToolsType := DifferentialVariableLexicographicEliminationOrderTools;

	for token in optionTokens repeat 
	{
	    if token = "OrderlyEliminationOrder" then 
	    {

		order := DifferentialVariableOrderlyEliminationOrderTools;

	    } else if token = "LexicographicEliminationOrder" then {
		
		order := DifferentialVariableLexicographicEliminationOrderTools; 

	    } else if token = "LexicographicOrder" then {
		
		order := DifferentialVariableLexicographicOrderTools; 

	    } else if token = "OrderlyOrder" then {

		order := DifferentialVariableOrderlyOrderTools;
		
	    }
	}


	MDVARS : DifferentialVariableType( VARS ) == DifferentialVariable( VARS, MDSYMS, order );

	----- options - field --------------------------------------------------
	
	MDFLD : with{ Field; CopyableType; DifferentialType; CharacteristicZero; } == DifferentialRational;

	----- options - exponent -----------------------------------------------

	local presortClasses? := false;
	local exp : with{ ExponentCategory( MDVARS ); CopyableType } :=  ListSortedExponent( MDVARS );
	
	
	for token in optionTokens repeat 
	{

	    if token = "presortClasses" then {

		presortClasses? := true;

	    } else if token = "SortedListExponent" then {

		exponent := SortedListExponent( MDVARS );
	    
	    } else if token = "ListExponent" then {
		
		exponent := ListExponent( MDVARS );

	    } else if token = "ListSortedExponent" then {
		
		exponent := ListSortedExponent( MDVARS );

	    } else if token = "CumulatedExponent" then {
		
		exponent := CumulatedExponent( MDVARS );

	    }
	}


	if presortClasses? then
	{
	    if MDVARS has EliminationOrderedDifferentialVariableType( VARS ) then
	    {

		exp := ClassPresortedDifferentialExponent( VARS, MDVARS pretend (EliminationOrderedDifferentialVariableType( VARS )) , exp );
	    } else {

		return pointer encodeAsError "cannot use presortClasses for differential variables, that do not have an elimination order";
	    }
	}          
	    
	EXP : ExponentCategory( MDVARS ) == exp;
	
	----- options - polynomials --------------------------------------------

	local dpr : DifferentialPolynomialRingType( MDFLD, VARS, MDVARS ) := DifferentiallyExtendedDistributivePolynomialRing( MDFLD, VARS, MDVARS, EXP, DistributedMultivariatePolynomial1( MDFLD, MDVARS, EXP ) );
	
	for token in optionTokens repeat 
	{
	    if token = "RecursivePolynomialRingViaPercentArray" then {

		dpr := DifferentiallyExtendedPolynomialRing( MDFLD, VARS, MDVARS, RecursivePolynomialRingViaPercentArray( MDFLD, MDVARS ) );

	    } else if token = "DistributedMultivariatePolynomial1" then {
		
		dpr := DifferentiallyExtendedDistributivePolynomialRing( MDFLD, VARS, MDVARS, EXP, DistributedMultivariatePolynomial1( MDFLD, MDVARS, EXP ) );
	    }
	}

	MDPR == dpr;

	----- polynomials ------------------------------------------------------

	import from Partial ExpressionTree;
	local pPolyListET: Partial ExpressionTree := parseToExpressionTree( CAS, polyPointer );
	failed? pPolyListET => pointer encodeAsError "cannot parse the polynomials" ;
	local pPolyList: Partial List MDPR := (eval$(List MDPR)) retract pPolyListET;
	failed? pPolyList => pointer encodeAsError "cannot parse the polynomials" ;
	local polyList: List MDPR := retract pPolyList;

	----- calculations -----------------------------------------------------

	macro RT == DifferentialPolynomialReductionTools( MDFLD, VARS, MDVARS, MDPR );
	macro AS == AutoreducedSet( MDPR, RT );
	
	local cAS: AS := (triangularize$(CoherentAutoreducedSetTools( MDPR, RT, BasicSetSortedTools( MDPR, RT ) ))) polyList;
	local charSetPolys: List MDPR := [ generator cAS ];

	----- returning --------------------------------------------------------

	return pointer encodeAsString!( extree charSetPolys );
	
    }

    -----------------------------------------------------------

}

--exporting the top level function
export { 

    __charset__coherentAutoreducedSet: ( Pointer, Pointer, Pointer, Pointer, Pointer ) -> Pointer ;

} to Foreign C;

--wrapping the desiced function in a top level function
__charset__coherentAutoreducedSet( languagePointer: Pointer, polyPointer: Pointer, variablePointer: Pointer, derivationPointer: Pointer, optionsPointer: Pointer ): Pointer == (coherentAutoreducedSet$ExportedCoherentAutoreducedSetTools)( languagePointer, polyPointer, variablePointer, derivationPointer, optionsPointer);


