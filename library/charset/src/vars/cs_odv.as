-------------------------------------------------------------------------
--
-- cs_odv.as
--
-------------------------------------------------------------------------

#include "charset.as"

import from Array Symbol;

+++\begin{addescription}{implements indeterminates for differential rings with only one derivation}
+++These indeterminates are created by attaching derivations to the indeterminates \adcode{VARS}. \adcode{DSYM} holds the \adtype{Symbol} to be used for the derivation. Application of the derivation denotes juxtapositioning the \adtype{Symbol} to the indeterminates of \adcode{VARS}. \adcode{ORDER} is used as order on the indeterminates.
+++\end{addescription}
+++\begin{adremarks}
+++The \adname[DifferentialVariableOrderToolsType]{<} function of \adcode{ORDER} (i.e.: \adtype{DifferentialVariableOrderToolsType}) is evaluated \emph{exactly} once. The comparison function for \adcode{DVARS} (i.e.: the result of calling \adcode{ORDER}'s \adname[DifferentialVariableOrderToolsType]{<} function) is then stored internally. This stored function is then used to compare \adcode{DVARS}.
+++
+++An implementation of differential indeterminates with more than one derivation can be found in \adtype{DifferentialVariable}.
+++\end{adremarks}
OrdinaryDifferentialVariable(
  VARS  : FiniteVariableType, 
  DSYM  : Symbol,
  ORDER : DifferentialVariableOrderToolsType == DifferentialVariableOrderlyEliminationOrderTools
): with {

    OrdinaryDifferentialVariableType( VARS );
    if ORDER has DifferentialVariableEliminationOrderToolsType then
    {
	EliminationOrderedDifferentialVariableType( VARS );
    }
	
} == DifferentialVariableTools( VARS, %, [ DSYM ] ) add {


    Rep == Record( varIdx: Integer, ord: Integer );
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
	per record( n, 0 );
    }

    
    --------------------------------------------------------------


    copy( a: % ):% == {
	local repA := rep a;
	per record( repA.varIdx, repA.ord );
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


    order( a: % ):Array Integer == {
      [ (rep a).ord ];
    }

    
    --------------------------------------------------------------

    
    derivationSymbolsCount: Integer == 1;

    
    --------------------------------------------------------------

    
    derivationSymbols(): Array Symbol == {
	[ DSYM ];
    }

    
    --------------------------------------------------------------

    
    derivationFunction( sym: Symbol ): % -> % == {
	import from MachineInteger;
	assert( sym = DSYM );
	differentiate;
    }

    --------------------------------------------------------------

    
    derivationFunction( idx: Integer ): % -> % == {
        assert( 0$Integer = idx );
	differentiate;
    }
    
    
    --------------------------------------------------------------

    
    differentiate( a: %, ords: Array Integer ):% == {
	import from MachineInteger;
	assert( # ords = 1 ); 
	n: Integer := ords.(firstIndex$(Array Integer));
        zero? n => copy a;
	differentiate( a, n );
    }

    
    --------------------------------------------------------------
    --
    -- Functions for OrdinaryDifferentialVariableType( VARS )
    --
    --------------------------------------------------------------


    order( a: % ): Integer == {
      (rep a).ord;
    }

    
    --------------------------------------------------------------

    
    differentiate( a: %, n: Integer ):% == {
	import from MachineInteger;
	assert( n >= 0);
	local repA := rep a;
	per record( repA.varIdx, repA.ord + n );
    }


    --------------------------------------------------------------

    
    differentiate( a: % ): % == {
	import from Integer;
	local repA := rep a;
	per record( repA.varIdx, next repA.ord );
    }

    
    --------------------------------------------------------------


};
