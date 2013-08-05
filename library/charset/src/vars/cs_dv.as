-------------------------------------------------------------------------
--
-- cs_dv.as
--
-------------------------------------------------------------------------

#include "charset.as"

import from Array Symbol;


+++\begin{addescription}{implements indeterminates for differential rings}
+++These indeterminates are created by attaching derivations to the indeterminates \adcode{VARS}. \adcode{DSYMS} holds the \adtype{Symbol}{}s to be used for the derivations. Application of a derivation denotes juxtapositioning the \adtype{Symbol}{}s to the indeterminates of \adcode{VARS}. \adcode{ORDER} is used as order on the indeterminates.
+++\end{addescription}
+++\begin{adremarks}
+++The \adname[DifferentialVariableOrderToolsType]{<} function of \adcode{ORDER} (i.e.: \adtype{DifferentialVariableOrderToolsType}) is evaluated \emph{exactly} once. The comparison function for \adcode{DVARS} (i.e.: the result of calling \adcode{ORDER}'s \adname[DifferentialVariableOrderToolsType]{<} function) is then stored internally. This stored function is then used to compare \adcode{DVARS}.
+++\end{adremarks}
DifferentialVariable(

  VARS  : FiniteVariableType, 
  DSYMS : Array Symbol,
  ORDER : DifferentialVariableOrderToolsType == DifferentialVariableOrderlyEliminationOrderTools

): with {
    CopyableType;
    DifferentialVariableType( VARS );
    if ORDER has DifferentialVariableEliminationOrderToolsType then
    {
	EliminationOrderedDifferentialVariableType( VARS );
    }
	
} == DifferentialVariableTools( VARS, %, DSYMS ) add {


    Rep == Record( varIdx: Integer, ord: Array Integer );
    import from Rep;

    
    --------------------------------------------------------------

    
    =(a:%,b:%):Boolean == {
      local repA := rep a;
      local repB := rep b;
      (repA.varIdx=repB.varIdx) and (repA.ord=repB.ord);
    }

    
    --------------------------------------------------------------

    
    orderFunc == (<$ORDER)( VARS, % );
    <(a:%,b:%):Boolean == (orderFunc(a,b));
    
    
    --------------------------------------------------------------

    
    variable( n: Integer ):% == {
	assert( 1 <= n and n<= coerce (#$VARS) );
	per record( n, new( # DSYMS, 0 ) );
    }

    
    --------------------------------------------------------------

    
    copy( a: % ):% == {
	local repA := rep a;
	per record( repA.varIdx, copy repA.ord );
    }

    
    --------------------------------------------------------------


    coerce( v: VARS ):% == {
	    import from List VARS;

	    local found?:Boolean;
	    local i:MachineInteger;
	    local foundVar: VARS;
	    (found?, i, foundVar) := linearSearch ( v, (minToMax$VARS) );
	    ~ found? => throw ListException;
	    variable( coerce (next i - firstIndex$(List VARS) ) );
    }

    
    --------------------------------------------------------------


    class(a:%):Integer == {
      (rep a).varIdx;
    }

    
    --------------------------------------------------------------


    order( a: % ): Array Integer == {
      copy ((rep a).ord);
    }

    
    --------------------------------------------------------------

    
    derivationSymbolsCount: Integer == (coerce # DSYMS);

    
    --------------------------------------------------------------

    
    derivationSymbols(): Array Symbol == {
      copy DSYMS;
    }

    
    --------------------------------------------------------------

    
    derivationFunction( sym: Symbol ): % -> % == {
	import from MachineInteger;
	for symbolIndex in (firstIndex$(Array Symbol)) .. (firstIndex$(Array Symbol))+prev #DSYMS | DSYMS.symbolIndex = sym repeat 
	{
	   return derivationFunction coerce symbolIndex;
	}
	never;
    }
    --------------------------------------------------------------

    
    derivationFunction( idx: Integer ): % -> % == {
        assert( 0$Integer <= idx );
      	assert( idx <= max$MachineInteger::Integer);

        local machineIdx := machine idx;
	( a: % ): % +-> {
	    import from MachineInteger;
	    import from Integer;
	    local repA := rep a;
	    local newOrd : Array Integer := copy (repA.ord);
	    newOrd.machineIdx := next newOrd.machineIdx;
	    return per record( repA.varIdx, newOrd );
	}
    }

    
    --------------------------------------------------------------


    differentiate( a: %, ords: Array Integer ):% == {
	import from MachineInteger;
	assert( # ords = # DSYMS ); 
	local repA := rep a;
	local newOrd := copy repA.ord;
	for idx in (firstIndex$(Array Integer)) .. (firstIndex$(Array Integer))+prev #DSYMS repeat 
	{
	    assert( ords.idx >= 0 );
	    newOrd.idx := newOrd.idx + ords.idx;
	}
	return per record( repA.varIdx, newOrd );
    }

    
    --------------------------------------------------------------

    differentiate( a:%, sym: Symbol, n:Integer == 0) : % == {
	import from MachineInteger;
	assert(n >= 0);
	local repA := rep a;
	
	n = 0 => return per record( repA.varIdx, copy repA.ord );

	for symbolIndex in (firstIndex$(Array Symbol)) .. (firstIndex$(Array Symbol))+prev # DSYMS | DSYMS.symbolIndex = sym repeat 
	{
	    local newOrd := copy repA.ord;
	    newOrd.symbolIndex := newOrd.symbolIndex + n;
	    return per record( repA.varIdx, newOrd );
	}
	never;
    }

    ------------------------------------------------

    differentiate( a:%, idx: Integer, n:Integer == 0 ) : % == {

	assert(n >= 0);
	local repA := rep a;
	n = 0 => return per record( repA.varIdx, copy repA.ord );

	local newOrd := copy repA.ord;
	local machineIdx := machine idx;
	newOrd.machineIdx := newOrd.machineIdx + n;
	per record( repA.varIdx, newOrd );
    }

    ------------------------------------------------

};
