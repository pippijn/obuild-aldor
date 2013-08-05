-------------------------------------------------------------------------
--
-- cs_dmain.as
--
-------------------------------------------------------------------------

#include "algebra"

+++\begin{addescription}{stores the main indeterminate explicitly}
+++This wrapper of the polynomial ring \adcode{PR} mainly uses \adcode{PR} as representation of polynomials. But additionally, \adthistype explicitly stores the main indeterminate of a polynomial. Since in the indeterminate framework of the \LibAldor library constants cannot provide a main indeterminate, an extra flag is needed to indicate whether or not a polynomial is a constant.
+++
+++For example, if \adcode{PR} models a polynomial ring in $w$, $x$, $y$, and $z$, with $w < x < y < z$
+++$$2xy^2+w^4x^2$$
+++is stored by a \adtype{Record} of \adtype{Boolean}, \adcode{V}, and \adcode{PR}. The \adtype{Boolean} slots holds \adname[Boolean]{false}, as the polynomial is not a constant. The main indeterminate (i.e.: $y$) of the polynomial is stored in the slot of type \adcode{V}. The slot of type \adcode{PR} holds \adcode{PR}{}'s representation of the polynomial.
+++
+++For constants, the given \adtype{Record} structure stores \adname[Boolean]{true} in the \adtype{Boolean} slot. The slot of type \adcode{V} contains unusable data. \adcode{PR}{}'s representation of the constant is stored in the slot of type \adcode{PR}.
+++\end{addescription}
PolynomialRingWithMainVariable(
  R: with{ 
      CommutativeRing; 
      CopyableType;
      CharacteristicZero;
  },
  V: VariableType,
  PR: PolynomialRing0( R, V )
): with {
 
    PolynomialRing0( R, V );

    +++\begin{addescription}{lifts a polynomial from the wrapped polynomial ring}
    +++\end{addescription}
    coerce: PR -> %;

    +++\begin{addescription}{pushes a polynomial back to the wrapped polynomial ring}
    +++\end{addescription}
    coerce: % -> PR;
    
} == add {
    
    import from PR;
  
    --if const?, then mainVar contains garbage
    macro Rep == Record( const?: Boolean, mainVar: V, poly: PR );

    macro createPolynomial( c, m, p ) == per record( c, m , p );
    macro createConstant( p ) == per record( true, (nil$Pointer) pretend V , p );

    macro repA == { rep a };
    macro aConst? == repA . const?;
    macro aMainVar == repA . mainVar;
    macro aPoly == repA . poly;

    macro repB == rep b;
    macro bConst? == repB . const?;
    macro bMainVar == repB . mainVar;
    macro bPoly == repB . poly;
    
    macro MAXVAR( a, b ) == if a < b then b else a;
    
    import from Rep;

    ---------------------------

    copy( a: % ): % == {
	createPolynomial( aConst?, aMainVar, copy aPoly );
    }
    
    ---------------------------

    =( a: %, b: % ): Boolean == {
	aConst? => {
	    bConst? and aPoly = bPoly;
	}
    
	assert( ~ aConst? );

	 ~ bConst? and aMainVar = bMainVar and aPoly = bPoly;
    }
    
    ---------------------------

    extree( a: % ): ExpressionTree == {

	extree aPoly;

    }
    
    ---------------------------

    +( a: %, b: % ): % == {

	aConst? => {
	    -- a is a constant
	    bConst? => {
		-- b is a constant
		createConstant( aPoly + bPoly );
	    }

	    assert( ~ bConst? );
	    
	    --a is a constant, b is not. Therefore, no cancellation of the
	    --main variable is possible
	    
	    createPolynomial( false, bMainVar, aPoly + bPoly );
	}

	assert( ~ aConst? );
	
	bConst? => {
	    --a is not a constant, but b is. However, no cancellation of the
	    --main variable is possible
	    createPolynomial( false, aMainVar, aPoly + bPoly );
	}

	assert( ~ bConst? );
	
	aMainVar > bMainVar => {
	    --a and b are both not constant. Since the main variable of a
	    --is bigger than that of b, the main variable of the sum is a.
	    createPolynomial( false, aMainVar, aPoly + bPoly );
	}

	aMainVar < bMainVar => {
	    --a and b are both not constant. Since the main variable of a
	    --is bigger than that of b, the main variable of the sum is a.
	    createPolynomial( false, bMainVar, aPoly + bPoly );
	}
	
	assert( aMainVar = bMainVar );
	
	--a and b are both not constant and their main varibales coincide.
	local sum: PR := aPoly+bPoly;
	ground? sum => {
	    createConstant( sum );
	}
	createPolynomial( false, mainVariable sum, sum );
    }
    
    ---------------------------

    (*)( a: %, b: % ): % == {

	aConst? => {
	    zero? a => createConstant( 0 );
	    
	    bConst? => {
		createConstant( aPoly * bPoly );
	    }

	    assert( ~ bConst? );
	    createPolynomial( false, bMainVar, aPoly * bPoly );
	}

	assert( ~ aConst? );
	assert( ~ zero? a );
	
	bConst? => {
	    zero? b => createConstant( 0 );	    
	    assert( ~ zero? b );	    
	    createPolynomial( false, aMainVar, aPoly * bPoly );
	}

	assert( ~ bConst? );
	assert( ~ zero? b );
	
	createPolynomial( false, MAXVAR( aMainVar, bMainVar ), aPoly * bPoly );
    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {

	zero? r => {
	    createConstant( 0 );
	}

	assert( ~ zero? r );

	createPolynomial( bConst?, bMainVar, r * bPoly );
    }

    ---------------------------

    -( a: % ): % == {

	createPolynomial( aConst?, aMainVar, - aPoly );
    }
    
    ---------------------------

    0: % == createConstant( 0 );
    
    ---------------------------    

    1: % == createConstant( 1 );
    
    ---------------------------

    commutative?: Boolean == true;
    
    ---------------------------
    
    coerce( v: V ): % == {

	createPolynomial( false, v, v::PR );

    }
    
    ---------------------------

    variable?( a: % ): Boolean == {

	aConst? => false;
	variable? aPoly;
    }
    
    ---------------------------
    
    variable( a: % ): V == {

	assert( ~ aConst? );
	assert( variable? a );
	aMainVar;
    }
    
    ---------------------------
    
    variables( a: % ): List V == {

	variables aPoly;
    }
    
    ---------------------------
    
    mainVariable( a: % ): V == {

	assert( ~ aConst? );
	aMainVar;
    }
    
    ---------------------------
    
    trailingCoefficient( a: % ): R == {

	trailingCoefficient aPoly;
	
    }
    
    ---------------------------
    
    leadingCoefficient( a: % ): R == {

	leadingCoefficient aPoly;

    }
    
    ---------------------------
    
    reductum( a: % ): % == {

	local red := reductum aPoly;
	ground? red => {
	    createConstant( red );
	}
	createPolynomial( false, mainVariable red, red );	
    
    }
    
    ---------------------------
    
    support( a: % ): Generator Cross( R, % ) == {

	generate {
	    for genElement in support aPoly repeat
	    {
		local r: R;
		local pr: PR;
		( r, pr ) := genElement;
		if (ground? pr) then
		{
		    yield ( r, createConstant( pr ) )
		} else {
		    yield ( r, createPolynomial( false, mainVariable pr, pr ) )	  
		}
	    }
	}
    }
    
    ---------------------------

    variableProduct( a: % ): Generator Cross( V, Integer ) == {

	variableProduct aPoly;
    }
    
    ---------------------------

    times( a: %, r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	zero? d => r*a;

	assert( ~ zero? r and d > 0 );
	
	aConst? => {
	    createPolynomial( false, v, times( aPoly, r, v, d ) );
	}
	
	assert( ~ aConst? );

	createPolynomial( false, MAXVAR( v, aMainVar ), times( aPoly, r, v, d ) );	
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	zero? d => r*a;

	assert( ~ zero? r and d > 0 );
	
	aConst? => {
	    createPolynomial( false, v, times!( aPoly, r, v, d ) );
	}
	
	assert( ~ aConst? );

	createPolynomial( false, MAXVAR( v, aMainVar ), times!( aPoly, r, v, d ) );	
    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {

	aConst? => 0;
	
	assert( ~ aConst? );
	
	v > aMainVar => 0;
	
	assert( v <= aMainVar );
	
	degree( aPoly, v );
    }
    
    ---------------------------

    coefficient( a: %, v: V, d: Integer ): % == {


	assert( d >= 0 and (<$Integer)( d, (coerce$Integer)(max$MachineInteger) ) );

	aConst? => {
	    zero? d => {		    
		createConstant( aPoly );
	    }
	    
	    assert( ~ zero? d );
	    
	    createConstant( 0 );
	}
	
	assert( ~ aConst? );
		
	~ zero? d and v > aMainVar => {
	    createConstant( 0 );
	}

	local coeff: PR := coefficient( aPoly, v, d );
	ground? coeff => {
	    createConstant( coeff );
	}
	createPolynomial( false, mainVariable coeff, coeff );
    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	
	assert( ~ zero? r );
	
	zero? d => r::%;
	
	assert( d > 0 );

	createPolynomial( false, v, term( r, v, d ) );
    }
    
    ---------------------------

    coerce( r: Integer ): % == {
	createConstant( r::PR );
    }
    
    ---------------------------

    if R has FiniteCharacteristic then
    {
	pthPower( a: % ): % == {
	    a^(characteristic$R);
	}
    }
    
    ---------------------------

    coerce( a: PR ): % == {
	ground? a => {
	    createConstant( a );
	}
	createPolynomial( false, mainVariable a, a );
    }

    ---------------------------

    coerce( a: % ): PR == {
	aPoly;
    }

    ---------------------------
    
}
 
