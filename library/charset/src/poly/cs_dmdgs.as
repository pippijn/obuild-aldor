-------------------------------------------------------------------------
--
-- cs_dmdgs.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{stores the main indeterminate and the degrees of a polynomial explicitly}
+++This wrapper of the polynomial ring \adcode{PR} mainly uses \adcode{PR} as representation of polynomials. But additionally, \adthistype explicitly stores the main indeterminate of a polynomial and the degrees with respect to every indeterminate occurring in a polynomial. An extra flag stores whether or not a polynomial is a constant.
+++
+++For example, if \adcode{PR} models a polynomial ring in $w$, $x$, $y$, and $z$, with $w < x < y < z$
+++$$2xy^2+w^4x^2$$
+++is stored by a \adtype{Record} of \adtype{Boolean}, \adcode{V}, \admacro{ChainingHashTable}, and \adcode{PR}. The \adtype{Boolean} slot holds \adname[Boolean]{false}, as the polynomial is not a constant. The main indeterminate (i.e.: $y$) of the polynomial is stored in the slot of type \adcode{V}. The \adtype{ChainingHashTable} slot contains pairs of indeterminate and corresponding degree. For the given polynomial, this slot contains the three entries $(w,4)$, $(x,2)$, and $(y,2)$. The slot of type \adcode{PR} holds \adcode{PR}{}'s representation of the polynomial.
+++
+++For constants, the given \adtype{Record} structure stores \adname[Boolean]{true} in the \adtype{Boolean} slot. The slot of type \adcode{V} contains unusable data. The \adtype{ChainingHashTable} is empty, and the \adcode{PR} slot holds \adcode{PR}{}'s representation of the constant.
+++\end{addescription}
PolynomialRingWithMainVariableAndDegrees(
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

    macro DegTable == ChainingHashTable( V, Integer );
      
    --if const?, then mainVar contains garbage, degs is a new, empty table
    macro Rep == Record( const?: Boolean, mainVar: V, degs: DegTable, poly: PR );

    macro createPolynomial( c, m, d, p ) == per record( c, m , d, p );
    macro createConstant( p ) == per record( true, (nil$Pointer) pretend V, table(), p );

    macro repA == { rep a };
    macro aConst? == repA . const?;
    macro aMainVar == repA . mainVar;
    macro aDegs == repA . degs;
    macro aPoly == repA . poly;

    macro repB == rep b;
    macro bConst? == repB . const?;
    macro bMainVar == repB . mainVar;
    macro bDegs == repB . degs;
    macro bPoly == repB . poly;
    
    macro MAXVAR( a, b ) == if a < b then b else a;
    
    macro FILLTABLE( degTable, poly ) == {
	import from List V;
	for var in variables poly repeat
	{
	    set!( degTable, var, degree( poly, var ) );
	}
    }
    
    import from DegTable;
    import from Rep;

    ---------------------------

    copy( a: % ): % == {
	createPolynomial( aConst?, aMainVar, copy aDegs, copy aPoly );
    }
    
    ---------------------------

    =( a: %, b: % ): Boolean == {
	aConst? => {
	    bConst? and aPoly = bPoly;
	}
    
	assert( ~ aConst? );

	~ bConst? and aMainVar = bMainVar and aDegs = bDegs and aPoly = bPoly;
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
	    
	    --a is a constant, b is not. Therefore, no change in the degrees
	    --is possible
	    
	    createPolynomial( false, bMainVar, copy bDegs, aPoly + bPoly );
	}

	assert( ~ aConst? );
	
	bConst? => {
	    --a is not a constant, but b is. However, no change in the degrees
	    --is possible
	    createPolynomial( false, aMainVar, copy aDegs, aPoly + bPoly );
	}

	assert( ~ bConst? );
	
	local sum := aPoly + bPoly;
	local degTable: DegTable;

	aMainVar > bMainVar => {
	    degTable := table();
	    FILLTABLE( degTable, sum );	    
	    --a and b are both not constant. Since the main variable of a
	    --is bigger than that of b, the main variable of the sum is a.	    
	    createPolynomial( false, aMainVar, degTable, sum );
	}

	aMainVar < bMainVar => {
	    degTable := table();
	    FILLTABLE( degTable, sum );	    
	    --a and b are both not constant. Since the main variable of a
	    --is bigger than that of b, the main variable of the sum is a.
	    createPolynomial( false, bMainVar, degTable, sum );
	}

	assert( aMainVar = bMainVar );
	ground? sum => {
	    createConstant( sum );
	}
	degTable := table();
	FILLTABLE( degTable, sum );	    
	createPolynomial( false, mainVariable sum, degTable, sum );
	
    }
    
    ---------------------------

    (*)( a: DegTable, b: DegTable ): DegTable == {
	local ret: DegTable := copy a;
	for cross in generator b repeat
	{
	    local var: V;
	    local deg: Integer;
	    ( var, deg ) := cross;
	    local pDegVarRet: Partial Integer := find( var, ret );
	    if ~ failed? pDegVarRet then
	    {
		 ret . var := deg + retract pDegVarRet;
	    } else {
		 ret . var := deg;
	    }
	}
	ret
    }
    
    ---------------------------

    (*)( a: %, b: % ): % == {

	aConst? => {
	    zero? a => createConstant( 0 );

	    bConst? => {
		createConstant( aPoly * bPoly );
	    }

	    assert( ~ bConst? );
	    createPolynomial( false, bMainVar, copy bDegs, aPoly * bPoly );
	}

	assert( ~ aConst? );
	assert( ~ zero? a );
	
	bConst? => {
	    zero? b => createConstant( 0 );
	    assert( ~ zero? b );
	    createPolynomial( false, aMainVar, copy aDegs, aPoly * bPoly );
	}

	assert( ~ bConst? );
	assert( ~ zero? b );
	
	createPolynomial( false, MAXVAR( aMainVar, bMainVar ), aDegs * bDegs, aPoly * bPoly );

    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {

	zero? r => {
	    createConstant( 0 );
	}

	assert( ~ zero? r );

	createPolynomial( bConst?, bMainVar, copy bDegs, r * bPoly );
    
    }

    ---------------------------

    -( a: % ): % == {

	createPolynomial( aConst?, aMainVar, copy aDegs, - aPoly );
	
    }
    
    ---------------------------

    0: % == createConstant( 0 );
    
    ---------------------------    

    1: % == createConstant( 1 );
    
    ---------------------------

    commutative?: Boolean == true;
    
    ---------------------------
    
    coerce( v: V ): % == {

	local degTable: DegTable := table();
	set!( degTable, v, 1$Integer );
	createPolynomial( false, v, degTable, v::PR );

    }
    
    ---------------------------

    variable?( a: % ): Boolean == {

	aConst? => false;
	
	(one?$MachineInteger) # aDegs and variable? aPoly;
	
    }
    
    ---------------------------
    
    variable( a: % ): V == {

	assert( ~ aConst? );
	assert( variable? a );

	aMainVar;
	
    }
    
    ---------------------------
    
    variables( a: % ): List V == {

	sort!( [ keys aDegs ], > );
	
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
	local degTable := table();
        FILLTABLE( degTable, red );
	createPolynomial( false, mV, degTable, red );	
    
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
		    local degTable := table();
		    FILLTABLE( degTable, pr );
		    yield ( r, createPolynomial( false, mV, degTable, pr ) )	  
		}
	    }
	}
    }
    
    ---------------------------

    variableProduct( a: % ): Generator Cross( V, Integer ) == {

	generator aDegs;
    
    }
    
    ---------------------------

    times( a: %, r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	zero? d => r*a;

	assert( ~ zero? r and d > 0 );
	
	local degTable: DegTable;
	aConst? => {
	    degTable := table();
	    degTable . v := d;
	    createPolynomial( false, v, degTable, times( aPoly, r, v, d ) );
	}
	
	assert( ~ aConst? );

	degTable: DegTable := copy aDegs;
	local pPrevDegV: Partial Integer := find( v, degTable );

	local prevDegV: Integer := 0;
	if ~ failed? pPrevDegV then
	{
	    prevDegV := retract pPrevDegV;
	}
	degTable . v := d + prevDegV;
	createPolynomial( false, MAXVAR( aMainVar, v ), degTable, times( aPoly, r, v, d ) );
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	zero? d => r*a;

	assert( ~ zero? r and d > 0 );
	
	local degTable: DegTable;
	aConst? => {
	    degTable := table();
	    degTable . v := d;
	    createPolynomial( false, v, degTable, times( aPoly, r, v, d ) );
	}
	
	assert( ~ aConst? );

	degTable: DegTable := aDegs;
	local pPrevDegV: Partial Integer := find( v, degTable );

	local prevDegV: Integer := 0;
	if ~ failed? pPrevDegV then
	{
	    prevDegV := retract pPrevDegV;
	}
	degTable . v := d + prevDegV;
	createPolynomial( false, MAXVAR( aMainVar, v ), degTable, times( aPoly, r, v, d ) );

    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {

	aConst? => 0;
	
	assert( ~ aConst? );
	
	v > aMainVar => 0;
	
	local pDegV: Partial Integer := find( v, aDegs );
	failed? pDegV => 0;

	assert( ~ failed? pDegV );
	
	retract pDegV;

    }
    
    ---------------------------

    coefficient( a: %, v: V, d: Integer ): % == {


	assert( d >= 0 );

	aConst? => {
	    zero? d => {		    
		createConstant( aPoly );
	    }
	    
	    assert( ~ zero? d );
	    
	    createConstant( 0 );
	}
	
	assert( ~ aConst? );
		
	local degTable: DegTable := table();
	local coeff: PR;
	zero? d => {
	    coeff := coefficient( aPoly, v, d );
	    ground? coeff => {
		createConstant( coeff );
	    }
	    FILLTABLE( degTable, coeff );
	    createPolynomial( false, mainVariable coeff, degTable, coeff );
	}

	assert( ~ zero? d );

	local pDegV: Partial Integer := find( v, aDegs );
	
	failed? pDegV => {
	    createConstant( 0 );
	}
	
	assert( ~ failed? pDegV );
	d > (retract pDegV) => {
	    createConstant( 0 );
	}

	coeff := coefficient( aPoly, v, d );
	ground? coeff => {
	    createConstant( coeff );
	}
	FILLTABLE( degTable, coeff );
	createPolynomial( false, mainVariable coeff, degTable, coeff );
    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	
	assert( ~ zero? r );
	
	zero? d => r::%;
	
	assert( d > 0 );

	local degTable: DegTable := table();
	degTable . v := d;
	createPolynomial( false, v, degTable, term( r, v, d ) );
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
	degTable := table();
	FILLTABLE( degTable, a );	    
	createPolynomial( false, mainVariable a, degTable, a );
    }

    ---------------------------

    coerce( a: % ): PR == {
	aPoly;
    }

    ---------------------------
}
 
