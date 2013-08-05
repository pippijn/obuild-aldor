-------------------------------------------------------------------------
--
-- cs_dprpt.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{allows to evaluate expression trees to differential polynomials}
+++The \adname{eval} functions try to evaluate expression trees to elements of \adcode{DPR}. \adcode{DSYMS} has to denote the \adtype{Symbol}{}s for the derivations of \adcode{DPR}.
+++\end{addescription}
DifferentialPolynomialRingParsingTools(
  DIDOM  : with{ IntegralDomain; DifferentialType; },
  VARS  : FiniteVariableType,
  DVARS : DifferentialVariableType( VARS ),
  DPR   : DifferentialPolynomialRingType( DIDOM, VARS, DVARS ),
  DSYMS : Array Symbol
) : with {
 
    if DIDOM has Parsable then 
    {
	+++\begin{addescription}{evaluates an expression tree leaf to a differential polynomial}
	+++\end{addescription}
	eval: ExpressionTreeLeaf -> Partial DPR;
    }

    if DIDOM has Parsable then 
    {
	+++\begin{addescription}{evaluates an expression tree operator and leaves to a differential polynomial}
	+++The \adtype{MachineInteger} denotes the \adname[ExpressionTreeOperator]{uniqueId} of an \adtype{ExpressionTreeOperator}. The \adtype{List} of expression trees is interpreted as if the \adtype{MachineInteger}'s corresponding \adtype{ExpressionTreeOperator} is applied to the \adtype{List}.
	+++
	+++For example \adcode{eval( UID__PLUS, [ extree 2, extree 3 ] )} would evaluate to \adcode{[ 5 ]}.
	+++\end{addescription}
	eval: (MachineInteger, List ExpressionTree) -> Partial DPR;
    }
    
    if DIDOM has Parsable then 
    {
	+++\begin{addescription}{evaluates an expression tree to a differential polynomial}
	+++\end{addescription}
	eval: ExpressionTree -> Partial DPR;
    }

} == add {

--    import PolynomialRing0( DIDOM, DVARS ) from DPR;
--    import DifferentialType               from DPR;
    import from DPR;

    ----------------------------------------------

    if DIDOM has Parsable then
    {
	eval(e:ExpressionTreeLeaf):Partial(DPR) == {
	    import from Symbol;
	    import from DVARS;
	    integer? e => bracket( (integer e)::DPR );
	    local pDVAR : Partial DVARS := (eval$DVARS) e;
	    failed? pDVAR => failed;
	    [ coerce(retract pDVAR) ];
	}
    }
    -------------------------------------------


    if DIDOM has Parsable then
    {
	eval(op:MachineInteger, expressions:List(ExpressionTree)):Partial(DPR) == {
	      import from DifferentialExpressionTreeOperatorTools;
	      import from ParsingTools DPR;

	      local pRet : Partial DPR;

	      -- evalArith does not handle the 
	      if op = ExpressionTreeQuotientId then 
	      {
		  assert( (# expressions) = 2 );
		  local pDividend : Partial DPR := (eval$DPR) first expressions;
		  local pDivisor : Partial DIDOM := (eval$DIDOM) first rest expressions;

		  if ~ ( failed? pDividend or failed? pDivisor ) then
		  {
		      local pInvDivisor := (reciprocal$DIDOM) retract pDivisor;
		      if ~ failed? pInvDivisor then
		      {
			  return [ ( retract pInvDivisor ) * ( retract pDividend ) ];
		      }
		  }		  
	      }

              -- if op = ExpressionTreeQuotientId, then it 
	      -- cannot be parsed via reciprocal, this does 
	      -- NOT impose that it cannot be evaluated via 
	      -- the eval functions of R, V.

	      pRet := evalArith( op, expressions );
	      ~ failed? pRet => pRet;
	      
	      local pRRet : Partial DIDOM := (eval$DIDOM)( op, expressions );
   	      ~ failed? pRRet => [ (retract pRRet)::DPR ];
	      
	      local pDVRet : Partial DVARS := (eval$DVARS)( op, expressions );
  	      failed? pDVRet => failed;
	      [ (retract pDVRet)::DPR ];

	  }
  }

  -------------------------------------------

  if DIDOM has Parsable then 
  {

      eval( e: ExpressionTree ): Partial DPR == {

	  import from DifferentialExpressionTreeOperatorTools;

	  leaf? e =>  (eval$DPR) leaf e;

	  local op:ExpressionTreeOperator := operator e;
	  local opUniqueId : MachineInteger := grabOperatorUniqueId op;
	  opUniqueId ~= ExpressionTreePrefixId => (eval$DPR)(opUniqueId,arguments e);

	  local opName:Symbol := grabOperatorName op;
	  import from Symbol;
	  if PrefixSymbolDiff = opName then 
	  {
              -- so some expression tree with "diff"
	      local subTrees: List ExpressionTree := arguments e;
	      
	      -- checking for correct number of elments in tree
	      if # subTrees ~= 2 then 
	      {
		  -- checking the element to differentiate
		  pDPR:Partial DPR := (eval$DPR) first subTrees;
		  if ~ failed? pDPR then 
		  {
		      -- checking the symbol to differentiate for
		      local pDiffSymbol: Partial Symbol := (eval$Symbol) subTrees.2;
		      if ~ failed? pDiffSymbol then
		      {
			  local diffSymbol := retract pDiffSymbol;
			  if member?( diffSymbol, DSYMS ) then
			  {
			      return [ (differentiate$DPR)( retract pDPR, diffSymbol ) ];
			  }
		      }
		  }
	      }
	      
	  }

	  local pDV:Partial DVARS := (eval$DVARS)(e);
	  failed? pDV => failed;
 	  [ (retract pDV)::DPR ];
     
      }
  }
}