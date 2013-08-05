-------------------------------------------------------------------------
--
-- cs_sgbpr.as
--
-------------------------------------------------------------------------

#include "charset.as"

macro AS == AutoreducedSet( PR, RT );

#if NOCOMPILERBUG
#else
+++\begin{addescription}{computes Gröbner bases of saturated ideals}
+++\adcode{PR} denotes the domain for the elements of the saturated ideals to compute a Gröbner basis for. The result of the computations are Gröbner bases with respect to the reduction \adcode{RT}, which has to implement polynomial reduction on the elements of \adcode{T}. \adname[TriangularizationReductionType]{consequences} of \adcode{RT} has to compute S-polynomials.
+++\end{addescription}
+++\begin{adremarks}
+++The Gröbner bases are computed by applying the Rabinowitsch trick and then using \adtype{ReducedGroebnerBasisTools} to compute the Gröbner basis. For the Rabinowitsch trick it is necessary to introduce new indeterminates and migrate the polynomials to a new polynomial ring domain. Basically, the \Aldor language allows to formulate the used Gröbner basis algorithm and the new polynomial ring as parameters to \adthistype. However, the compiler cannot produce working code when such parameters are introduced. Therefore, some domains (for example the use of \adtype{ReducedGroebnerBasisTools} to compute the Gröbner bases) are hard coded into \adthistype.
+++\end{adremarks}
SaturatedGroebnerBasisWrtPolynomialReductionTools( 
  R    : with {
      Field;
      CharacteristicZero;
  },
  VARS : VariableType,
  EXP : ExponentCategory VARS,
  PR   : RankedTriangularizationTType with {
      PolynomialRing0( R, VARS );
      IndexedFreeModule( R, EXP );
  },
  RT: TriangularizationReductionType PR
) : with {
    SaturatedReducedGroebnerBasisAlgorithmType( PR, RT );    
} == add {
#endif
#if NOCOMPILERBUG
SaturatedGroebnerBasisWrtPolynomialReductionTools( 
  R    : with {
      Field;
      CharacteristicZero;
  },
  VARS : VariableType,
  EXP : ExponentCategory VARS,
  PR   : RankedTriangularizationTType with {
      PolynomialRing0( R, VARS );
      IndexedFreeModule( R, EXP );
  },
  RT: TriangularizationReductionType PR
  ,
  EXTGBALGFUNC: 
  ( SOME__T: RankedTriangularizationTType, SOME__RT: TriangularizationReductionType SOME__T ) 
  -> ReducedGroebnerBasisAlgorithmType( SOME__T, SOME__RT )
  == 
  { 
      ( SOME__T : RankedTriangularizationTType, SOME__RT: TriangularizationReductionType SOME__T ): ReducedGroebnerBasisAlgorithmType( SOME__T, SOME__RT ) +-> { 
	  ReducedGroebnerBasisTools( SOME__T, SOME__RT, GroebnerBasisTools( SOME__T, SOME__RT ), AutoreducedSetTools( SOME__T, SOME__RT, BasicSetSortedTools( SOME__T, SOME__RT ) ) );
      }
  }
) : with {
    SaturatedReducedGroebnerBasisAlgorithmType( PR, RT );    
} == add {
#endif

    -------------------------------------------
    
    macro EXTRTTYPE == PolynomialReductionWithoutDivisionTools;
    --macro EXTRTTYPE == PolynomialReductionTools;
    
    -------------------------------------------

    macro GROEBNERBASISWOSATURATION( F ) == {
 	( asElements, sats ) := (groebnerBasis$( ReducedGroebnerBasisTools( PR, RT, GroebnerBasisTools( PR, RT ), AutoreducedSetTools( PR, RT, BasicSetSortedTools( PR, RT ) ) ) ) ) (F@(List PR));
    }

    -------------------------------------------

    macro GROEBNERBASIS( F, I ) == {
	if empty? I then 
	{
 	    GROEBNERBASISWOSATURATION( F );
	} else {
 	    ( asElements: List PR, sats: Set PR ) := groebnerBasisWSaturation( F, I );
	}
    }
    -------------------------------------------

    groebnerBasisWSaturation( F: List PR, I: Set PR ): ( List PR, Set PR ) == {
        -- 4 steps:
        --  prepare domains
	--  migrate from PR to EXTPR
	--  calulate Groebner basis

	--  migrate from EXTPR to PR

	assert( ~ empty? I );
	local asElements: List PR := empty;
        local sats: Set PR := empty;
	
	-- prepare domains

	import from Set PR;
	import from Integer;
	( EXTVARS: FiniteVariableType , COMBVARS: MergedVariableType( VARS, EXTVARS ) ) == (extension$VariableMergerTools)( VARS, coerce # I );
	import from EXTVARS;
	import from COMBVARS;
	EXTEXP: ExponentCategory COMBVARS == SortedListExponent COMBVARS;
	EXTPR  == DistributivePolynomialRingLeadingTermOrderExtension( R, COMBVARS, EXTEXP, DistributedMultivariatePolynomial1( R, COMBVARS, EXTEXP ) );
	EXTRT  == EXTRTTYPE( R, COMBVARS, EXTEXP, EXTPR );
	EXTAS  == AutoreducedSet( EXTPR, EXTRT );	
#if NOCOMPILERBUG
	EXTGBALG == EXTGBALGFUNC( EXTPR, EXTRT );
#endif	

	-- migrate from PR to EXTPR

	import from List EXTVARS;
	import from EXP;
	import from PR;
	import from EXTEXP;
	import from EXTPR;
	local extElements: DoubleEndedList EXTPR := empty();
	local extPoly : EXTPR;

	macro migratePRtoEXTPR( FROM, TO ) == {
	    TO := 0;
	    for monomialFrom in terms FROM repeat
	    {
		( r, e: EXP ) := monomialFrom;
		extELst: List Cross ( COMBVARS, Integer ) := empty;
		for partE in terms e repeat 
		{
		    ( varPartE, powerPartE ) := partE ;
		    extELst := insert!( ( coerce varPartE, powerPartE ), extELst );
		}
		TO := add!( TO, term( r, exponent generator extELst ) );
	    }
	}

	for f in F repeat 
	{
	    migratePRtoEXTPR( f, extPoly );
	    extElements := concat!( extElements, extPoly );
	}

	for i in I for var in minToMax repeat 
	{
	    migratePRtoEXTPR( i, extPoly );
	    extPoly := extPoly * ( var :: COMBVARS :: EXTPR ) - 1;
	    extElements := concat!( extElements, extPoly );
	}

	-- calulate Groebner basis	

	import from EXTVARS;

#if NOCOMPILERBUG
        ( extRgb: EXTAS, extPremultRed: Set EXTPR ) := (triangularize$EXTGBALG) firstCell extElements;
#else	
 	( extRgb: EXTAS, extPremultRed: Set EXTPR ) := (triangularize$( ReducedGroebnerBasisTools( EXTPR, EXTRT, GroebnerBasisTools( EXTPR, EXTRT ), AutoreducedSetTools( EXTPR, EXTRT, BasicSetSortedTools( EXTPR, EXTRT ) ) ) ) )   (firstCell extElements);
#endif
	-- migrate from EXTPR to PR
	macro migrateEXTPRtoPR( FROM, TO ) == {
	    for elementFROM in FROM repeat 
	    {
		processTerm? := true;
		local poly : PR := 0;
		for monomialElement in terms elementFROM while processTerm? repeat
		{
		    ( r, extE: EXTEXP ) := monomialElement;
		    eLst: List Cross ( VARS, Integer ) := empty;
		    for partExtE in terms extE  while processTerm? repeat 
		    {
			( varPartExtE, powerPartExtE ) := partExtE ;
			if isFromVar1? varPartExtE then
			{
			    eLst := insert!( ( coerce varPartExtE, powerPartExtE ), eLst );
			} else {
			    processTerm? := false;
			}
		    }
		    poly := add!( poly, term( r, exponent generator eLst ) );
		}
		if processTerm? then
		{
		    TO := insert!( poly, TO );
		}
	    }
	}

	migrateEXTPRtoPR( extRgb, asElements );
	
	( asElements, sats );
    }

    -------------------------------------------

    groebnerBasis( F: List PR, I: Set PR ): ( List PR, Set PR ) == {
	local asElements: List PR;
	local sats: Set PR;

	GROEBNERBASIS( F, I );

	( asElements, sats );
    }

    -------------------------------------------

    groebnerBasis( genF: Generator PR, genI: Generator PR ): ( List PR, Set PR ) == {
	local asElements: List PR;
	local sats: Set PR;
	local F: List PR := [ genF ];
	local I: Set  PR := [ genI ];

	GROEBNERBASIS( F, I );

	( asElements, sats );
    }

    -------------------------------------------

    triangularize( genF: Generator PR ): ( AS, Set PR ) == {
	local asElements: List PR;
	local sats: Set PR;
	local F: List PR := [ genF ];

	GROEBNERBASISWOSATURATION( F );
	
	local pAs: Partial AS := [ generator asElements ];
	assert ~ failed? pAs;
	( retract pAs, sats );
    }

    -------------------------------------------

    triangularize( F: List PR ): ( AS, Set PR ) == {
	local asElements: List PR;
	local sats: Set PR;
	GROEBNERBASISWOSATURATION( F );
	local pAs: Partial AS := [ generator asElements ];
	assert ~ failed? pAs;
	( retract pAs, sats );
    }

    -------------------------------------------

    triangularize( genF: Generator PR, genI: Generator PR ): ( AS, Set PR ) == {
	local asElements: List PR := empty;
	local sats: Set PR := empty;
	local F: List PR := [ genF ];
	local I: Set  PR := [ genI ];
	
	GROEBNERBASIS( F, I );
	
	local pAs: Partial AS := [ generator asElements ];
	assert ~ failed? pAs;
	( retract pAs, sats );
    }

    -------------------------------------------

    triangularize( F: List PR, I: Set PR ): ( AS, Set PR ) == {
	local asElements: List PR := empty;
	local sats: Set PR := empty;
	
	GROEBNERBASIS( F, I );
	
	local pAs: Partial AS := [ generator asElements ];
	assert ~ failed? pAs;
	( retract pAs, sats );
    }

    -------------------------------------------
}
