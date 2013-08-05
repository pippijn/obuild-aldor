-------------------------------------------------------------------------
--
-- cs_ddegs.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{stores the degrees of polynomials explicitly}
+++This wrapper of the polynomial ring \adcode{PR} mainly uses \adcode{PR} as representation of polynomials. But additionally, \adthistype explicitly stores the degrees with respect to every indeterminate occurring in a polynomial. These degrees are stored in a \adtype{ChainingHashTable} of pairs. Each pair holds the indeterminate and its according degree.
+++
+++For example, if \adcode{PR} models a polynomial ring in $w$, $x$, $y$, and $z$,
+++$$2xy^2+w^4x^2$$
+++is stored by a \adtype{Record} of a \adcode{PR} and \adtype{ChainingHashTable}. The slot of type \adcode{PR} holds \adcode{PR}{}'s representation of the polynomial. The \adtype{ChainingHashTable} contains three pairs. These pairs are $(x,2)$, $(y,2)$, and $(w,4)$. There is no pair for $z$, as $z$ does not occur in the polynomial.
+++\end{addescription}
PolynomialRingWithDegrees(
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
    macro Rep == Record( degs: DegTable, poly: PR );

    macro createPolynomial( d, p ) == per record( d, p );
    macro createConstant( p ) == per record( table(), p );

    macro repA == rep a;
    macro aDegs == repA . degs;
    macro aPoly == repA . poly;

    macro repB == rep b;
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
	createPolynomial( copy aDegs, copy aPoly );
    }
    
    ---------------------------

    =( a: %, b: % ): Boolean == {
	aDegs = bDegs and aPoly = bPoly;
	--aPoly = bPoly;
     }
    
    ---------------------------

    extree( a: % ): ExpressionTree == {

	extree aPoly;

    }
    
    ---------------------------

    +( a: %, b: % ): % == {

	local sum := aPoly + bPoly;
	local degTable: DegTable := table();
	FILLTABLE( degTable, sum );	    
	createPolynomial( degTable, sum );
	
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
	zero? a or zero? b => {
	    createConstant( 0 );
	}
	createPolynomial( aDegs * bDegs, aPoly * bPoly );

    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {
	zero? r => {
	    createConstant( 0 );
	}

	createPolynomial( copy bDegs, r * bPoly );
    
    }

    ---------------------------

    -( a: % ): % == {

	createPolynomial( copy aDegs, - aPoly );
	
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
	createPolynomial( degTable, v::PR );

    }
    
    ---------------------------

    variable?( a: % ): Boolean == {

	(one?$MachineInteger) # aDegs and variable? aPoly;
	
    }
    
    ---------------------------
    
    variable( a: % ): V == {
	import from Generator V;
	next! keys aDegs;
	
    }
    
    ---------------------------
    
    variables( a: % ): List V == {

	sort!( [ keys aDegs ], (>$V) );
	
    }
    
    ---------------------------
    
    mainVariable( a: % ): V == {

	mainVariable aPoly;

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
	local degTable := table();
        FILLTABLE( degTable, red );
	createPolynomial( degTable, red );	
    
    }
    
    ---------------------------
    
    support( a: % ): Generator Cross( R, % ) == {

	generate {
	    for genElement in support aPoly repeat
	    {
		local r: R;
		local pr: PR;
		( r, pr ) := genElement;
		local degTable := table();
		FILLTABLE( degTable, pr );
		yield ( r, createPolynomial( degTable, pr ) )	  
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
	
	degTable: DegTable := copy aDegs;
	local pPrevDegV: Partial Integer := find( v, degTable );

	local prevDegV: Integer := 0;
	if ~ failed? pPrevDegV then
	{
	    prevDegV := retract pPrevDegV;
	}
	degTable . v := d + prevDegV;
	createPolynomial( degTable, times( aPoly, r, v, d ) );
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	zero? d => r*a;

	assert( ~ zero? r and d > 0 );
	
	degTable: DegTable := aDegs;
	local pPrevDegV: Partial Integer := find( v, degTable );

	local prevDegV: Integer := 0;
	if ~ failed? pPrevDegV then
	{
	    prevDegV := retract pPrevDegV;
	}
	degTable . v := d + prevDegV;
	createPolynomial( degTable, times( aPoly, r, v, d ) );

    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {

	local pDegV: Partial Integer := find( v, aDegs );
	failed? pDegV => 0;

	assert( ~ failed? pDegV );
	
	retract pDegV;

    }
    
    ---------------------------

    coefficient( a: %, v: V, d: Integer ): % == {


	assert( d >= 0 );

	local degTable: DegTable := table();
	local coeff: PR;
	zero? d => {
	    coeff := coefficient( aPoly, v, d );
	    FILLTABLE( degTable, coeff );
	    createPolynomial( degTable, coeff );
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
	FILLTABLE( degTable, coeff );
	createPolynomial( degTable, coeff );
    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {

	zero? r => createConstant( 0 );
	
	assert( ~ zero? r );
	
	zero? d => r::%;
	
	assert( d > 0 );

	local degTable: DegTable := table();
	degTable . v := d;
	createPolynomial( degTable, term( r, v, d ) );
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
	local degTable: DegTable := table();
	FILLTABLE( degTable, a );	    
	createPolynomial( degTable, a );
    }

    ---------------------------

    coerce( a: % ): PR == {
	aPoly;
    }

    ---------------------------

}
 
