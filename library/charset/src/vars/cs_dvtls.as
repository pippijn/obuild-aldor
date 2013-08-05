-------------------------------------------------------------------------
--
-- cs_dvtls.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{provides type conversions to and from differential indeterminates}
+++\adcode{DVARS} denotes the differential indeterminates. \adcode{VARS} is used solely to specify the type of \adcode{DVARS}. \adcode{DSYMS} has to denote the \adtype{Symbol}{}s for the derivations of \adcode{DVARS}.
+++\end{addescription}
DifferentialVariableTools(
  VARS  : FiniteVariableType,
  DVARS  : DifferentialVariableType( VARS ),
  DSYMS : Array Symbol
): with {

    +++\begin{addescription}{evaluates an expression tree leaf to a differential indeterminate}
    +++\end{addescription}
    eval: ExpressionTreeLeaf -> Partial DVARS;

    +++\begin{addescription}{tries to evaluate an expression tree operator and leaves to a differential indeterminate}
    +++The \adtype{MachineInteger} denotes the \adname[ExpressionTreeOperator]{uniqueId} of an \adtype{ExpressionTreeOperator}. The \adtype{List} of expression trees is interpreted as if the \adtype{MachineInteger}'s corresponding \adtype{ExpressionTreeOperator} is applied to the \adtype{List}.
    +++\end{addescription}
    +++\begin{adremarks}
    +++\adthisname is constantly failing intentionally.
    +++Expression trees of differential indeterminates are built of \adtype{ExpressionTreePrefix} nodes. Each instantiation of \adtype{ExpressionTreePrefix} shares the same \adname[ExpressionTreePrefix]{uniqueId}, regardless by what \adtype{Symbol} is prefixed. Therefore, it is not possible to determine by what \adtype{Symbol} an \adtype{ExpressionTreePrefix} prefixes, if only the \adname[ExpressionTreeOperator]{uniqueId} (i.e.: the parameter of \adtype{MachineInteger}) is given. As a result, the signature of \adthisname, does not provide enough information to parse to a value of \adcode{DVARS}. However, \adtype{Parsable} requires a function with this signature. Therefore, \adthisname with the given signature is provided by \adthistype.
    +++\end{adremarks}
    eval: (MachineInteger, List ExpressionTree) -> Partial DVARS;
    
    +++\begin{addescription}{evaluates an expression tree to a differential indeterminate}
    +++\end{addescription}
    eval: ExpressionTree -> Partial DVARS;
    
    +++\begin{addescription}{converts a differential indterminate to an expression tree}
    +++\end{addescription}
    extree: DVARS -> ExpressionTree;

    +++\begin{addescription}{gives a symbol for a differential indeterminate}
    +++\end{addescription}
    symbol: DVARS -> Symbol;
    
    +++\begin{addescription}{interpretes a symbol as differential indeterminate}
    +++\end{addescription}
    variable: Symbol -> Partial DVARS;

} == add {


    --------------------------------------------------------------


    eval(e:ExpressionTreeLeaf):Partial( DVARS ) == {
	import from MachineInteger;
	~ empty? DSYMS => failed;
	~ symbol? e => failed;

	local pVVar: Partial VARS := (variable$VARS) symbol e;
	failed? pVVar => failed;
	return [ (coerce$DVARS) retract pVVar ];
    }


    --------------------------------------------------------------


    eval( op: MachineInteger, expressions: List( ExpressionTree )): Partial( DVARS ) == {
	failed;
    }


    --------------------------------------------------------------


    eval( e: ExpressionTree): Partial( DVARS ) == {
	import from DifferentialExpressionTreeOperatorTools;

	if leaf? e then {
	    return eval leaf e;
	} 
	local op:ExpressionTreeOperator := operator e;
	local opUniqueId : MachineInteger := grabOperatorUniqueId op;
	if opUniqueId = ExpressionTreePrefixId then {

	    import from Symbol;
	    import from Partial Symbol;
	    import from List ExpressionTree;

	    local opName:Symbol := grabOperatorName op;

            local pVar : Partial DVARS;

	    local subTrees := arguments e;

            if PrefixSymbolDiff = opName then {
                -- so some expression tree with "diff"

		-- checking for correct number of elments in tree
		if # subTrees ~= 2 then 
		{
		    return failed;
		}											    

                -- checking the element to differentiate
		pVar:Partial DVARS := eval first subTrees;
		if failed? pVar then 
		{
		    return failed;
		}
                -- checking the symbol to differentiate for
		local pDiffSymbol := (eval$Symbol) subTrees.2;
		if failed? pDiffSymbol then
		{
		    return failed;
		}
		local diffSymbol := retract pDiffSymbol;
		if member?( diffSymbol, DSYMS ) then
		{
		    return [ (differentiate$DVARS)( retract pVar, diffSymbol ) ];
	        }
		return failed;

	    } else {

		--try to interpret opName as variable
		local pVVar: Partial VARS := (variable$VARS) opName;

		--could opName be interpreted as one of V
		if failed? pVVar then
		{
		    return failed$(Partial DVARS);
		}

		-- retracting is done when the arguments are ok
		-- i.e. right in the return statement

		--is the ExpressionTree dependent on correct symbols?
		--creating array of symbols first
		import from List Symbol;
		local subTreeCount := # subTrees;
		local dependenceSymbols: Array Symbol := new( subTreeCount );
		for subTree in subTrees 
		for idx in firstIndex$(Array Symbol) .. prev (firstIndex$(Array Symbol)) + subTreeCount repeat 
		{
		    if ~ leaf? subTree then
		    {
			return failed;
		    }
		    local subTreeLeaf: ExpressionTreeLeaf := leaf subTree;
		    if ~ symbol? subTreeLeaf then
		    {
			return failed;
		    }
		    dependenceSymbols.idx := symbol subTreeLeaf;
		}
		if dependenceSymbols ~= DSYMS then
		{
		    return failed$(Partial DVARS);
		}

		--a proper differential variable
		return [ (coerce$DVARS) retract pVVar ];
	    }
	}
	return eval(opUniqueId,arguments e);

    }


    --------------------------------------------------------------


    extree( a: DVARS ): ExpressionTree == {
	import from Integer;
	import from Array Integer;
	import from ExpressionTree;
  	import from List ExpressionTree;
	import from DifferentialExpressionTreeOperatorTools;
	import from Symbol;
	import from Array Symbol;
	import from VARS;
	local classA := class a;
	local orderA := order( a );

	empty? DSYMS => extree symbol ( a :: VARS );

	local ret:ExpressionTree;

	-- getting the symbol into ret

	ret := (ExpressionTreePrefix symbol ( a :: VARS ) ) . [ 
	  generate for sym in DSYMS repeat
	  {
	      yield extree sym;
	  }
	];

	for symOrder in orderA for sym in DSYMS repeat
	{
	    if symOrder > 0 then {
		--applying differentiation as often as needed
		for i in 1..symOrder repeat 
		{
		    ret := (ExpressionTreePrefix PrefixSymbolDiff) . [ ret , extree sym ];
		}
	    }
	}

	ret;
    }


    --------------------------------------------------------------


    symbol( a: DVARS ) : Symbol == {
        import from ExpressionTree;
	import from MachineInteger;
	import from List VARS;

	local sb : StringBuffer := new();
	(sb :: TextWriter) << a;
	(- string sb);

    }


    --------------------------------------------------------------


    variable(a:Symbol): Partial DVARS == {
	import from Partial VARS;

	import from Partial ExpressionTree;
	import from ExpressionTree;
	import from String;
	import from Symbol;
	import from InfixExpressionParser;

	local pET: Partial ExpressionTree := parse! parser((name a)::TextReader);
	failed? pET => failed;
	eval retract pET;

    }


    --------------------------------------------------------------




};
