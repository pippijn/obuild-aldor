-------------------------------------------------------------------------
--
-- cs_rarr.as
--
-------------------------------------------------------------------------

#include "algebra"
#include "extio"

+++\begin{addescription}{provides recursive, sparse, multivariate polynomials}
+++The implementation of \adthistype is similar to \adtype{SparseMultivariatePolynomial} of the \LibAlgebra library. However, \adtype{SparseMultivariatePolynomial} internally uses \adtype{SparseUnivariatePolynomial} to represent polynomials. \adthistype uses its own data structures and does not rely on other domains. Therefore, a drastic overall performance gain can be observed.
+++\end{addescription}
+++\begin{adremarks}
+++In contrast to most other polynomail ring implementations of the \LibCharSet library, \adthistype is not a wrapper for another polynomial ring implementation, but a proper, new implementation of polynomial rings.
+++\end{adremarks}
RecursivePolynomialRingViaPercentArray(
  R: with{ 
      CommutativeRing; 
      CopyableType;
      CharacteristicZero;
  },
  V: VariableType
): with {
 
    PolynomialRing0( R, V );
    
} == add {
    
    --the var of each polyfactor is less than the var of the current RecursiveStructure
    macro RecursiveStructure == Record( var: V, polyFactors: Array % );
    macro Rep == Union( coeff: R, recursiveStructure: RecursiveStructure );

    macro createConstant( r ) == per union r;
    
    -- swapping two elements
    macro SWAP( a, b ) == {
	( a, b ) := ( b, a );
    }
    
    import from Rep;
    import from Array %;
    import from MachineInteger;
    
    ---------------------------

    --this function normalizes the representation of arr and constructs a value of % in ( v, arr )
    local trimLeadingZerosToPercent!( arr: Array %, v: V ): % == {
	local prevOldSize := prev # arr;
	local prevNewSize := prevOldSize;

	while prevNewSize > 0 and zero? arr . prevNewSize repeat 
	{
	    prevNewSize := prev prevNewSize;
	}

	prevNewSize = 0 => {
	    arr . 0;
	}

	assert( prevNewSize > 0 and prevNewSize <= prevOldSize );
	if prevNewSize < prevOldSize then
	{
	    arr := resize!( arr, next prevNewSize );
	}
	
	per union record( v, arr );	
    }

    ---------------------------

    copy( a: % ): % == {
	(rep a) case coeff => {
	    per union copy ( (rep a) . coeff );
	}

	assert( (rep a) case recursiveStructure );
	
	per union record( 
	  (rep a) . recursiveStructure . var, 
	  [ (copy arrAElement) for arrAElement in (rep a) . recursiveStructure . polyFactors ] 
	);
    }
    
    ---------------------------

    =( a: %, b: % ): Boolean == {
	(rep a) case coeff => {
	    (rep b) case coeff => (rep a).coeff = (rep b).coeff;
	    false;
	}
	
	assert( (rep a) case recursiveStructure );

	(rep b) case coeff => false;
	
	assert( (rep b) case recursiveStructure );

	(rep a) . recursiveStructure . var ~= (rep b) . recursiveStructure . var => {
	    false
	}
	
	assert( (rep a) . recursiveStructure . var = (rep b) . recursiveStructure . var );

	local arrA := (rep a) . recursiveStructure . polyFactors;
	local arrB := (rep b) . recursiveStructure . polyFactors;

	# arrA ~= # arrB => {
	    false
	}
	
	assert( # arrA = # arrB );

	local equal?: Boolean := true;
	for idx in 0 .. prev # arrA while equal? repeat {
	    equal? := arrA . idx = arrB . idx;
	}
	equal?;
    }
    
    ---------------------------

    extree( a: % ): ExpressionTree == {
	(rep a) case coeff => {
	    extree ( (rep a) . coeff );
	}

	assert( (rep a) case recursiveStructure );
	
	import from List ExpressionTree;
	import from Integer;
	
	local vET := extree ( (rep a) . recursiveStructure . var );
	local factors := (rep a) . recursiveStructure . polyFactors;
	assert( # factors >= 1 );
	local summands: List ExpressionTree := empty;

	if ( # factors > 1 ) then
	{
	    if ( # factors > 2 ) then
	    {
		--powers >= 2 are built by exponentiation
		for idx in prev # factors .. 2 by -1 | ~ zero? factors . idx repeat 
		{
		    if ( one? factors . idx ) then
		    {
			summands := insert!( ExpressionTreeExpt . [ vET, extree (idx::Integer) ], summands );
		    } else {
			summands := insert!( ExpressionTreeTimes . [ extree factors . idx, ExpressionTreeExpt . [ vET, extree (idx::Integer) ] ], summands );
		    }
		}
	    }	  	    
	    if ~ zero? ( factors . 1 ) then
	    {
		if ( one? factors . 1 ) then
		{
		    summands := insert!( vET, summands );
		} else {
		    summands := insert!( ExpressionTreeTimes . [ extree factors . 1, vET ], summands );
		}
	    }
	}	    
	if ~ zero? ( factors . 0 ) then
	{
	    summands := insert!( extree factors . 0, summands );
	}
	assert( # summands >= 1 );
	one? # summands => summands . (firstIndex$(List ExpressionTree));
	ExpressionTreePlus . summands;
    }
    
    ---------------------------

    +( r: R, b: % ): % == {
	(rep b) case coeff => {
	    per union ( r + (rep b).coeff );
	}
	assert( (rep b) case recursiveStructure );
	local arr := copy ( (rep b) . recursiveStructure . polyFactors );
	arr . 0 := r + arr . 0 ;
	per union record( (rep b) . recursiveStructure . var, arr );
    }
    
    ---------------------------

    +( a: %, b: % ): % == {
	(rep a) case coeff => {
	    (rep a) . coeff + b;
	}
	assert( (rep a) case recursiveStructure );
	(rep b) case coeff => {
	    (rep b) . coeff + a;
	}
	assert( (rep b) case recursiveStructure );
	local varA := (rep a) . recursiveStructure . var;
	local varB := (rep b) . recursiveStructure . var;

        if ( varA < varB ) then
	{
	    SWAP( a, b );
	    SWAP( varA, varB );
	}

	assert( varA = (rep a) . recursiveStructure . var );
	assert( varB = (rep b) . recursiveStructure . var );
	assert( varA >= varB );

	local arr: Array %;
	varA = varB => {	    
	    local arrA := (rep a) . recursiveStructure . polyFactors;
	    local arrB := (rep b) . recursiveStructure . polyFactors;
	    local nArrA := # arrA;
	    local nArrB := # arrB;
	    if ( nArrA = nArrB ) then
	    {
		arr := [ arrAElement + arrBElement for arrAElement in arrA for arrBElement in arrB ];	    
	    } else if ( nArrA < nArrB ) then {
		arr := copy arrB;
		for idx in 0 .. prev nArrA repeat
		{
		    arr.idx := arr.idx + arrA.idx; 
		}
	    } else {
		assert( nArrA > nArrB );
		arr := copy arrA;
		for idx in 0 .. prev nArrB repeat
		{
		    arr.idx := arr.idx + arrB.idx; 
		}
	    }

	    trimLeadingZerosToPercent!( arr, varA );
	}
	
	assert( varA > varB );
	arr := copy ( (rep a) . recursiveStructure . polyFactors );
	arr . 0 := add!( arr . 0, b );
	per union record( varA, arr );
    }
    
    ---------------------------

    (*)( a: %, b: % ): % == {
	(rep a) case coeff => {
	    (rep a) . coeff * b;
	}
	assert( (rep a) case recursiveStructure );
	(rep b) case coeff => (rep b) . coeff * a;
	assert( (rep b) case recursiveStructure );
	local varA := (rep a) . recursiveStructure . var;
	local varB := (rep b) . recursiveStructure . var;

        if ( varA < varB ) then
	{
	    SWAP( a, b );
	    SWAP( varA, varB );
	}

	assert( varA = (rep a) . recursiveStructure . var );
	assert( varB = (rep b) . recursiveStructure . var );
	assert( varA >= varB );

	varA = varB => {
	    local arrA := (rep a) . recursiveStructure . polyFactors;
	    local arr: Array %;
	    local arrB := (rep b) . recursiveStructure . polyFactors;
	    assert( 
	      { 
		  import from Integer;
		  prev ( # arrA )::Integer + ( # arrB )::Integer < (max$MachineInteger)::Integer 
	      } 
	    );
	    arr := new ( prev # arrA + # arrB, 0 );
	    for idxA in 0 .. prev # arrA repeat 
	    {
		for idxB in 0 .. prev # arrB repeat 
		{
		    arr . ( idxA + idxB ) := arr . ( idxA + idxB ) + arrA . idxA * arrB . idxB;
		}
	    }
	    per union record( varA, arr );
	}
	
	assert( varA > varB );
	per union record( varA, [ arrAElement * b for arrAElement in (rep a) . recursiveStructure . polyFactors ] );
    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {
        zero? r => createConstant( 0$R );
	(rep b) case coeff => {
	    per union ( r * (rep b) . coeff );
	}
	
	assert( (rep b) case recursiveStructure );

	per union record( 
	  (rep b) . recursiveStructure . var, 
	  [ r * arrBElement for arrBElement in (rep b) . recursiveStructure . polyFactors ] 
	);
    }

    ---------------------------

    -( a: % ): % == {
	(rep a) case coeff => {
	    per union ( - (rep a) . coeff );
	}
	
	assert( (rep a) case recursiveStructure );

	per union record( 
	  (rep a) . recursiveStructure . var, 
	  [ - arrAElement for arrAElement in (rep a) . recursiveStructure . polyFactors ] 
	);
    }
    
    ---------------------------

    0: % == createConstant( 0$R );
    
    ---------------------------    

    1: % == createConstant( 1$R );
    
    ---------------------------

    commutative?: Boolean == true;
    
    ---------------------------
    
    coerce( v: V ): % == {
	local arr := new 2;
	arr . 0 := createConstant( 0$R );
	arr . 1 := createConstant( 1$R );
	per union record( v, arr );
    }
    
    ---------------------------

    variable?( a: % ): Boolean == {
	(rep a) case coeff => {
	    false;
	}
	
	assert( (rep a) case recursiveStructure );
	
	local arr: Array % := (rep a) . recursiveStructure . polyFactors;
        
	# arr ~= 2 => {
	    false;
	}
	
	arr . 0 ~= 0 => {
	    false;
	}
	
	arr . 1 = createConstant( 1$R );
    }
    
    ---------------------------
    
    variable( a: % ): V == {
	
	assert( variable? a );
	
	(rep a) . recursiveStructure . var;
    
    }
    
    ---------------------------
    
    variables( a: % ): List V == {
	(rep a) case coeff => {
	    empty;
	}
	
	assert( (rep a) case recursiveStructure );
	
	local res: List V := empty;
	for arrElement in (rep a) . recursiveStructure . polyFactors repeat
	{
	    res := merge!( res, variables arrElement, > );
	}
	condenseRuns!( cons( (rep a) . recursiveStructure . var, res ) );
    }
    
    ---------------------------
    
    mainVariable( a: % ): V == {
	
	assert( (rep a) case recursiveStructure );
	
	(rep a) . recursiveStructure . var;
    }
    
    ---------------------------
    
    trailingCoefficient( a: % ): R == {
	(rep a) case coeff => {
	    (rep a) . coeff;
	}
	
	assert( (rep a) case recursiveStructure );
	
	for arrElement in (rep a) . recursiveStructure . polyFactors | ~ zero? arrElement repeat
	{
	    return trailingCoefficient arrElement;
	}
	never;
    }
    
    ---------------------------
    
    leadingCoefficient( a: % ): R == {
	(rep a) case coeff => {
	    (rep a) . coeff;
	}
	
	assert( (rep a) case recursiveStructure );
	
	local arr := (rep a) . recursiveStructure . polyFactors;
	return leadingCoefficient arr . ( prev # arr );
    }
    
    ---------------------------
    
    reductum( a: % ): % == {
	(rep a) case coeff => {
	    createConstant( 0$R );
	}

	assert( (rep a) case recursiveStructure );
	
	local arr := (rep a) . recursiveStructure . polyFactors;
	local ret := new # arr;
	local prevSize := prev # arr;
	for idx in 0 .. prev prevSize repeat
	{
	    ret . idx := copy arr . idx;
	}
	ret . prevSize := reductum arr . prevSize;
	trimLeadingZerosToPercent!( ret, (rep a) . recursiveStructure . var );
    }
    
    ---------------------------
    
    support( a: % ): Generator Cross( R, % ) == {
	(rep a) case coeff => generate {
	    if ~ zero? ( (rep a) . coeff ) then
	    {
		yield ( (rep a) . coeff, createConstant( 1$R ) );
	    }
	}

	assert( (rep a) case recursiveStructure );

	local varPoly := ( (rep a) . recursiveStructure . var ) :: %;
	local poweredVarPoly: % := createConstant( 1$R );
	generate {
	    for arrElement in (rep a) . recursiveStructure . polyFactors repeat
	    {
		for subSupport in support arrElement repeat
		{
		    local subCoeff: R;
		    local subTerm: %;
		    ( subCoeff, subTerm ) := subSupport;
		    yield ( subCoeff, subTerm * poweredVarPoly );
		}
		poweredVarPoly := poweredVarPoly * varPoly;
	    }
	}
    }
    
    ---------------------------

    variableProduct( a: % ): Generator Cross( V, Integer ) == {
	(rep a) case coeff => generate {
	}

	assert( (rep a) case recursiveStructure );

	generate {
	    local arr := (rep a) . recursiveStructure . polyFactors;
	    yield( (rep a) . recursiveStructure . var, (coerce$Integer) (prev # arr) );
#if DEBUG
	    if # arr >= 2 then
	    {
		for deg in 0 .. prev prev # arr repeat
		{
		    assert( zero? arr . deg );
		}
	    }
#endif	    
	    for subGeneratorElement in variableProduct( arr . ( prev # arr ) ) repeat
	    {
		yield subGeneratorElement;
	    }
	    
	}
    }
    
    ---------------------------

    times( a: %, r: R, v: V, d: Integer ): % == {
	times!( copy a, r, v, d );
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {
	zero? a or zero? r => {
	    createConstant( 0 );
	}
	
	zero? d => {
	    r * a;
	}

	assert( d > 0 and (<$Integer)( d, (coerce$Integer)(max$MachineInteger) ) );

	(rep a) case coeff => {
	    term( (rep a) . coeff * r, v, d );
	}

	assert( (rep a) case recursiveStructure );
	
	local varA := (rep a) . recursiveStructure . var;
	local arr := (rep a) . recursiveStructure . polyFactors;

	varA > v => {
	    per union record( varA, [ times!( arrElement, r, v, d ) for arrElement in arr ] );
	}
	local machineD: MachineInteger := machine d;
	local newArr: Array %;
	varA = v => {
	    assert( {  import from Integer; ( # arr )::Integer + d < (max$MachineInteger)::Integer } );
	    newArr := new( # arr + machineD, createConstant( 0$R ) );
	    for idx in 0 .. prev # arr repeat {
		newArr . ( machineD + idx ) := r * arr . idx;
	    }
	    per union record( varA, newArr );
	}

	assert( varA < v );
	
	newArr := new( next machineD, createConstant( 0$R ) );
	newArr . machineD := r * a;
	per union record( v, newArr );

    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {
	(rep a) case coeff => {
	    0;
	}

	assert( (rep a) case recursiveStructure );
	
	local varA := (rep a) . recursiveStructure . var;

	varA < v => {
	    0;
	}

	varA = v => {
	    (coerce$Integer)( prev # ( (rep a) . recursiveStructure . polyFactors ) );
	}

	assert( varA > v );
	
	local arr := (rep a) . recursiveStructure . polyFactors;
	local maxDeg: Integer := 0;
	for arrElement in arr repeat {
	    maxDeg := max( maxDeg, degree( arrElement, v ) );
	}
	maxDeg;
    }
    
    ---------------------------

    coefficient( a: %, v: V, d: Integer ): % == {
	
	assert( d >= 0 and (<$Integer)( d, (coerce$Integer)(max$MachineInteger) ) );

	(rep a) case coeff => {
	    zero? d => {		
		( (rep a) . coeff ) :: %;
	    }
	    assert( d > 0 );
	    createConstant( 0$R );
	}

	assert( (rep a) case recursiveStructure );
	
	local varA := (rep a) . recursiveStructure . var;
	
	--the following condition is only met, when v does not appear in a at all.
	varA < v => {
	    zero? d => copy a;
	    createConstant( 0$R );
	}

	local arr := (rep a) . recursiveStructure . polyFactors;
	varA = v => {
	    local machineD: MachineInteger := machine d;
	    machineD >= #arr => {
		createConstant( 0$R );
	    }
	    copy arr . machineD;
	}

	assert( varA > v );
	
	local ret: % := createConstant( 0$R );
	for arrElement in arr for coeffVarDeg in 0 .. (coerce$Integer)(max$MachineInteger) repeat 
	{
	    local nextCoeff := coefficient( arrElement, v, d );
	    if ~ zero? nextCoeff then
	    {
		ret := ret + nextCoeff * term( 1, varA, coeffVarDeg );
	    }
	}
	
	ret;

    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {
	zero? r => {
	    createConstant( 0$R );
	}

	zero? d => {
	    per union r;
	}

	assert( d > 0 and (<$Integer)( d, (coerce$Integer)(max$MachineInteger) ) );

	local arr: Array % := new( machine next d, createConstant( 0$R ) );
	arr . ( machine d ) := per union r;
	per union record( v, arr );
    }
    
    ---------------------------

    coerce( r: Integer ): % == {
	per union (r :: R);
    }
    
    ---------------------------

    if R has FiniteCharacteristic then
    {
	pthPower( a: % ): % == {
	    a^(characteristic$R);
	}
    }
    
    ---------------------------

}