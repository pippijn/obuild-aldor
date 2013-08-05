-------------------------------------------------------------------------
--
-- cs_dmdeg.as
--
-------------------------------------------------------------------------

#include "algebra"

+++\begin{addescription}{stores the main indeterminate and its degree explicitly}
+++This wrapper of the polynomial ring \adcode{PR} mainly uses \adcode{PR} as representation of polynomials. But additionally, \adthistype explicitly stores the main indeterminate of a polynomial and the polynomials degree with respect to the main indeterminate. An extra flag stores whether or not a polynomial is a constant.
+++
+++For example, if \adcode{PR} models a polynomial ring in $w$, $x$, $y$, and $z$, with $w < x < y < z$
+++$$2xy^2+w^4x^2$$
+++is stored by a \adtype{Record} of \adtype{Boolean}, \adcode{V}, \admacro{Integer}, and \adcode{PR}. The \adtype{Boolean} slots holds \adname[Boolean]{false}, as the polynomial is not a constant. The main indeterminate (i.e.: $y$) of the polynomial is stored in the slot of type \adcode{V}. The slot of type \admacro{Integer} holds $2$ which denotes the polynomials degree with respect to the main indeterminate ($y$). The slot of type \adcode{PR} holds \adcode{PR}{}'s representation of the polynomial.
+++
+++For constants, the given \adtype{Record} structure stores \adname[Boolean]{true} in the \adtype{Boolean} slot. The slot of type \adcode{V} contains unusable data and the \admacro{Integer} slot is set to $0$. \adcode{PR}{}'s representation of the constant is stored in the slot of type \adcode{PR}.
+++\end{addescription}
PolynomialRingWithMainVariableAndDegree(
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
    import from Integer;
    
    --if const?, then mainVar contains garbage, degMainVar is 0
    macro Rep == Record( const?: Boolean, mainVar: V, degMainVar: Integer, poly: PR );

    macro createPolynomial( c, m, d, p ) == per record( c, m , d, p );
    macro createConstant( p ) == per record( true, (nil$Pointer) pretend V, 0, p );

    macro repA == { rep a };
    macro aConst? == repA . const?;
    macro aMainVar == repA . mainVar;
    macro aDegMainVar == repA . degMainVar;
    macro aPoly == repA . poly;

    macro repB == rep b;
    macro bConst? == repB . const?;
    macro bMainVar == repB . mainVar;
    macro bDegMainVar == repB . degMainVar;
    macro bPoly == repB . poly;
    
    macro MAXVAR( a, b ) == if a < b then b else a;
    
    import from Rep;

    ---------------------------

    copy( a: % ): % == {
	createPolynomial( aConst?, aMainVar, aDegMainVar, copy aPoly );
    }
    
    ---------------------------

    =( a: %, b: % ): Boolean == {
	aConst? => {
	    bConst? and aPoly = bPoly;
	}
    
	assert( ~ aConst? );

	 ~ bConst? and aMainVar = bMainVar and aDegMainVar = bDegMainVar and aPoly = bPoly;
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
	    
	    createPolynomial( false, bMainVar, bDegMainVar, aPoly + bPoly );
	}

	assert( ~ aConst? );
	
	bConst? => {
	    --a is not a constant, but b is. However, no cancellation of the
	    --main variable is possible
	    createPolynomial( false, aMainVar, aDegMainVar, aPoly + bPoly );
	}

	assert( ~ bConst? );
	
	aMainVar > bMainVar => {
	    --a and b are both not constant. Since the main variable of a
	    --is bigger than that of b, the main variable of the sum is a.
	    createPolynomial( false, aMainVar, aDegMainVar, aPoly + bPoly );
	}

	aMainVar < bMainVar => {
	    --a and b are both not constant. Since the main variable of a
	    --is bigger than that of b, the main variable of the sum is a.
	    createPolynomial( false, bMainVar, bDegMainVar, aPoly + bPoly );
	}
	
	assert( aMainVar = bMainVar );
	
	--a and b are both not constant and their main varibales coincide.

	aDegMainVar > bDegMainVar => {
	    --a and b are both not constant and their main variables coincide.
	    --However, the main variable cannot vanish as the degrees in the main variable differ
	    createPolynomial( false, aMainVar, aDegMainVar, aPoly + bPoly );
	}

	aDegMainVar < bDegMainVar => {
	    --a and b are both not constant and their main variables coincide.
	    --However, the main variable cannot vanish as the degrees in the main variable differ
	    createPolynomial( false, bMainVar, bDegMainVar, aPoly + bPoly );
	}
	
	assert( aDegMainVar = bDegMainVar );

	local sum: PR := aPoly+bPoly;
	ground? sum => {
	    createConstant( sum );
	}
	local mV := mainVariable sum;
	createPolynomial( false, mV, degree( sum, mV ), sum );
    }
    
    ---------------------------

    (*)( a: %, b: % ): % == {

	aConst? => {
	    zero? a => createConstant( 0 );

	    bConst? => {
		createConstant( aPoly * bPoly );
	    }

	    assert( ~ bConst? );
	    createPolynomial( false, bMainVar, bDegMainVar, aPoly * bPoly );
	}

	assert( ~ aConst? );
	assert( ~ zero? a );
	
	bConst? => {
	    zero? b => createConstant( 0 );
	    assert( ~ zero? b );
	    createPolynomial( false, aMainVar, aDegMainVar, aPoly * bPoly );
	}

	assert( ~ bConst? );
	assert( ~ zero? b );
	
	aMainVar > bMainVar => {
	    createPolynomial( false, aMainVar, aDegMainVar, aPoly * bPoly );
	}
	
	aMainVar < bMainVar => {
	    createPolynomial( false, bMainVar, bDegMainVar, aPoly * bPoly );
	}

	assert( aMainVar = bMainVar );

	createPolynomial( false, aMainVar, aDegMainVar + bDegMainVar, aPoly * bPoly );

    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {

	zero? r => {
	    createConstant( 0 );
	}

	assert( ~ zero? r );

	createPolynomial( bConst?, bMainVar, bDegMainVar, r * bPoly );
    
    }

    ---------------------------

    -( a: % ): % == {

	createPolynomial( aConst?, aMainVar, aDegMainVar, - aPoly );
	
    }
    
    ---------------------------

    0: % == createConstant( 0 );
    
    ---------------------------    

    1: % == createConstant( 1 );
    
    ---------------------------

    commutative?: Boolean == true;
    
    ---------------------------
    
    coerce( v: V ): % == {

	createPolynomial( false, v, 1, v::PR );

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
	local mV := mainVariable red;
	createPolynomial( false, mV, degree( red, mV ), red );	
    
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
		    local mV := mainVariable pr;
		    yield ( r, createPolynomial( false, mV, degree( pr, mV ), pr ) )	  
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
	    createPolynomial( false, v, d, times( aPoly, r, v, d ) );
	}
	
	assert( ~ aConst? );

	aMainVar > v => {
	    createPolynomial( false, aMainVar, aDegMainVar, times( aPoly, r, v, d ) );	
	}

	aMainVar < v => {
	    createPolynomial( false, v, d, times( aPoly, r, v, d ) );	
	}
	
	assert( aMainVar = v );

	createPolynomial( false, v, aDegMainVar + d, times( aPoly, r, v, d ) );	
	
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	zero? d => r*a;

	assert( ~ zero? r and d > 0 );
	
	aConst? => {
	    createPolynomial( false, v, d, times!( aPoly, r, v, d ) );
	}
	
	assert( ~ aConst? );

	aMainVar > v => {
	    createPolynomial( false, aMainVar, aDegMainVar, times!( aPoly, r, v, d ) );	
	}

	aMainVar < v => {
	    createPolynomial( false, v, d, times!( aPoly, r, v, d ) );	
	}
	
	assert( aMainVar = v );

	createPolynomial( false, v, aDegMainVar + d, times!( aPoly, r, v, d ) );	
	
    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {

	aConst? => 0;
	
	assert( ~ aConst? );
	
	v > aMainVar => 0;
	
	v = aMainVar => aDegMainVar;

	assert( v < aMainVar );
	
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

	v = aMainVar and d > aDegMainVar => {
	    createConstant( 0 );
	}

	local coeff: PR := coefficient( aPoly, v, d );
	ground? coeff => {
	    createConstant( coeff );
	}
	local mV := mainVariable coeff;
	createPolynomial( false, mV, degree( coeff, mV ), coeff );
    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	
	assert( ~ zero? r );
	
	zero? d => r::%;
	
	assert( d > 0 );

	createPolynomial( false, v, d, term( r, v, d ) );
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
	local mV := mainVariable a;
	createPolynomial( false, mV, degree( a, mV ), a );
    }

    ---------------------------

    coerce( a: % ): PR == {
	aPoly
    }

    ---------------------------

}
 
