-------------------------------------------------------------------------
--
-- cs_vmrgr.as
--
-------------------------------------------------------------------------

#include "charset.as"

--geht nicht mit 
--macro VAR11  == (-"y1");
--macro VAR12  == (-"y2");
--macro VAR13  == (-"y3");
--macro VARS1  == OrderedVariableList(reverse! [ VAR11, VAR12, VAR13 ]);	
--macro VAR21  == (-"y4");
--macro VAR22  == (-"y5");
--macro VAR23  == (-"y6");
--macro VARS2  == OrderedVariableList(reverse! [ VAR21, VAR22, VAR23 ]);
--macro VARS12 == VariableMerger( VARS1, VARS2 );
--
--
-- Es wird immer
--   coerce: VAR1 -> %;
-- aufgerufen und nie
--   coerce: VAR2 -> %;
--
--Deshalb  OrderedVariableList2 und VariableMergerTools

+++\begin{addescription}{merges indeterminate domains}
+++Given two domains for indeterminates (\adcode{VAR1} and \adcode{VAR2}), \adthistype allows to merge them to a new domain for indeterminates. This new domains carries the indeterminates of \adcode{VAR1} and \adcode{VAR2}. 
+++
+++The lifted indeterminates of \adcode{VAR1} are ordered as in \adcode{VAR1} itself. Accordingly, the lifted indeterminates of \adcode{VAR2} are ordered as in \adcode{VAR2} itself. Indeterminates of \adcode{VAR1} are considered smaller than those of \adcode{VAR2}.
+++\end{addescription}
+++\begin{adremarks}
+++Note that \adthistype is not limited to \adtype{FinitieVariableType} and may therefore be used especially for domains with infinitely many indeterminates.
+++
+++The \Aldor compiler has its glitches if both \adcode{VAR1} and \adcode{VAR2} are of the same \adtype{VariableType}. For example, if both \adcode{VAR1} and \adcode{VAR2} are \adtype{OrderedVariableList}{}s, the \Aldor compiler does not produce correct working executables. However, it suffices migrate the indetereminates of either \adcode{VAR1} or \adcode{VAR2} to a different domain. Therefore, for example \adthistype{OrderedVariableList2} can be used.
+++\end{adremarks}
+++\begin{adseealso}
+++  \adtype{OrderedVariableList2}
+++  \adtype{VariableMergerTools}
+++\end{adseealso}
VariableMerger(
  VAR1: VariableType,
  VAR2: VariableType
): with {

    MergedVariableType( VAR1, VAR2 );

} == add {
    
    import from VAR1;
    import from VAR2;
    
    -----------------------------------

    Rep == Union( var1: VAR1, var2: VAR2 );
    import from Rep;
    
    -----------------------------------
    
    =( a: %, b: % ): Boolean == {
	local repA := rep a;
	local repB := rep b;
	repA case var1 and repB case var1 => (=$VAR1)( repA . var1, repB . var1 );
	repA case var2 and repB case var2 => (=$VAR2)( repA . var2, repB . var2 );
	false;
    }

    -----------------------------------
    
    <( a: %, b: % ): Boolean == {
	local repA := rep a;
	local repB := rep b;
	repA case var1 => {
	    repB case var1 => (<$VAR1)( repA . var1, repB . var1 );
	    assert repB case var2;
	    true;
	}
	assert repA case var2;
	repB case var2 => (<$VAR2)( repA . var2, repB . var2 );
	assert repB case var1;
	false;
    }

    -----------------------------------
    
    extree( a: % ): ExpressionTree == {
	local repA := rep a;
	repA case var1 => extree( repA . var1 );
	assert repA case var2;
	extree( repA . var2 );
    }
  
    -----------------------------------
    
    hash( a: % ): MachineInteger == {
	local repA := rep a;
	repA case var1 => hash( repA . var1 );
	assert repA case var2;	
	hash( repA . var2 );
    }

    -----------------------------------

    <<( reader: BinaryReader ): % == {
	import from MachineInteger;
	import from Byte;
	zero?( read! reader :: MachineInteger ) => per [ (<<$VAR1) reader ];
	per [ (<<$VAR2) reader ]
    }

    -----------------------------------
    
    <<( writer: BinaryWriter, a: % ): BinaryWriter == {
	import from MachineInteger;
	import from Byte;
	local repA := rep a;
	repA case var1 => writer << ( lowByte 0 ) << ( repA . var1 );
	assert repA case var2;	
	writer << ( lowByte 1 ) << ( repA . var2 );
    }

    -----------------------------------
    
    eval( etl: ExpressionTreeLeaf ): Partial % == {
	import from Partial VAR1;
	import from Partial VAR2;
	local pVar1: Partial VAR1 := (eval$VAR1) etl;
	~ failed? pVar1 => [ per [ retract pVar1 ] ];

	local pVar2: Partial VAR2 := (eval$VAR2) etl;
	~ failed? pVar2 => [ per [ retract pVar2 ] ];
	
	failed;
    }

    -----------------------------------
    
    eval( operator: MachineInteger, operands: List ExpressionTree ): Partial % == {
	import from Partial VAR1;
	import from Partial VAR2;
	local pVar1: Partial VAR1 := (eval$VAR1) ( operator, operands );
	~ failed? pVar1 => [ per [ retract pVar1 ] ];

	local pVar2: Partial VAR2 := (eval$VAR2) ( operator, operands );
	~ failed? pVar2 => [ per [ retract pVar2 ] ];
	
	failed;
    }

    -----------------------------------

    variable( sym: Symbol ): Partial % == {
	import from Partial VAR1;
	import from Partial VAR2;
	local pVar1: Partial VAR1 := (variable$VAR1) sym;
	~ failed? pVar1 => [ per [ retract pVar1 ] ];

	local pVar2: Partial VAR2 := (variable$VAR2) sym;
	~ failed? pVar2 => [ per [ retract pVar2 ] ];
	
	failed;
    }

    -----------------------------------
    
    symbol( a: % ): Symbol == {
	local repA := rep a;
	repA case var1 => symbol ( repA . var1 );
	symbol ( repA . var2 );
    }
	
    -----------------------------------

    coerce( a: VAR1 ): % == {
      per [ a ]
    }
	
    -----------------------------------

    coerce( a: VAR2 ): % == {
	per [ a ]
    }
	
    -----------------------------------
    
    coerce( a: % ): VAR1 == {
	assert ( rep a ) case var1;
	( rep a ) . var1;
    }
	
    -----------------------------------

    coerce( a: % ): VAR2 == {
	assert ( rep a ) case var2;
	( rep a ) . var2;
    }
	
    -----------------------------------

    isFromVar1?( a: % ): Boolean == {
	( rep a ) case var1;
    }	
    
    -----------------------------------

    isFromVar2?( a: % ): Boolean == {
	( rep a ) case var2;
    }	
    
    -----------------------------------
    
}