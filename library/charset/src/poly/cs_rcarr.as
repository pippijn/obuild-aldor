-------------------------------------------------------------------------
--
-- cs_rcarr.as
--
-------------------------------------------------------------------------

#include "charset.as"
#include "extio"

+++\begin{addescription}{provides recursive, multivariate polynomials}
+++The implementation of \adthistype is focused on taking coefficients efficiently.
+++If the modelled polynomial is a constant, it is represented by an element of \adcode{R}. If it is not a constant, it is modelled by a \adtype{ChainingHashTable}. The keys of this \adtype{ChainingHashTable} are the indeterminates occurring in the polynomial. The values are \adtype{Array}{}s of \adthistype containing the coefficients with respect to the corresponding key of the \adtype{Array}.
+++\end{addescription}
+++\begin{adremarks}
+++In contrast to most other polynomial ring implementations of the \LibCharSet library, \adthistype is not a wrapper for another polynomial ring implementation, but a proper, new implementation of polynomial rings.
+++
+++Note that typical implementations of recursive, spare polynomial rings only store a polynomial's coefficients with respect to its main indeterminate. However, \adthistype stores the coefficients with respect to \emph{all} indeterminates occurring in a polynomial.
+++
+++Be aware that due to the high costs of polynomial manipulation (addition, multiplication, and the like), \adthistype's performance is typically weak compared to other polynomial ring implementations. However, taking coefficients is extremely cheap, regardless by which indeterminate or power. Therefore, it is recommended to use \adthistype only either for comparisons of polynomial ring implementatinos or when taking lots of coefficients and performing hardly any manipulations of polynomials.
+++\end{adremarks}
RecursivePolynomialRingAllCoefficients(
  R: with {
      CommutativeRing; 
      CopyableType;
      CharacteristicZero;
  },
  V: VariableType
): PolynomialRing0( R, V ) == add {

    macro VarCoeffs == Array( % );

#if CIRCULARFIXED
    macro NENTRIESHASHTABLE( a ) == { # a };
    macro EMPTY?HASHTABLE( a ) == { empty? a };
    macro Vars == ChainingHashTable( V, Array % );
#else
    macro NENTRIESHASHTABLE( a ) == { numberOfEntries a };
    macro EMPTY?HASHTABLE( a ) == { zero? numberOfEntries a};
    hashV( var: V ): MachineInteger == { hash var };

    --If the argument hashV is missing, the HashTable causes problems :(    
    macro Vars == HashTable( V,  Array %, hashV );
    
    contained?( a: Vars, b: Vars ): Boolean == {

        import from V;
        import from VarCoeffs;
        import from Partial VarCoeffs;

        for keyValueCross in a repeat 
        {
            import from Partial VarCoeffs;
            local key: V;
            local valueA: VarCoeffs;
            ( key, valueA ) := keyValueCross;

            local pValueB := find( key, b );
            if failed? pValueB then
            {
                return false;
            }

            if valueA ~= retract pValueB then
            {
                return false;
            }
        }

        true;
    }       

    ---------------------------

    =( a: Vars, b: Vars ): Boolean == {
        import from MachineInteger;
        numberOfEntries a = numberOfEntries b and contained?( a, b ) and contained?( b, a );
    }       
#endif

    macro Rep == Record( const: R, vars: Vars );

    import from VarCoeffs;
    import from Vars;
    import from R;
    import from V;
    import from Rep;
    import from MachineInteger;

    macro createConstant( r )      == per record( r, table() );
    macro createPolynomial( c, v ) == per record( c, v       );

    macro repA == rep a;
    macro aConst? == EMPTY?HASHTABLE ( repA . vars );
    macro aPoly? == ~ aConst?;
    macro aConst == repA . const;
    macro aVars == repA . vars;

    macro repB == rep b;
    macro bConst? == EMPTY?HASHTABLE ( repB . vars );
    macro bPoly? == ~ bConst?;
    macro bConst == repB . const;
    macro bVars == repB . vars;

    ---------------------------

    local normalizeRepresentation!( a: % ): % == {

	local newVars: Vars := table();

	for varCrossA in aVars repeat
	{
	    local varA: V;
	    local varCoeffsA: VarCoeffs;	    
	    ( varA, varCoeffsA ) := varCrossA;
	    local highestIdx := prev # varCoeffsA;
	    for idx in 0 .. highestIdx repeat
	    {
		varCoeffsA . idx := normalizeRepresentation!( varCoeffsA . idx );
	    }
	    local nonZeroIdx := highestIdx;

	    while nonZeroIdx > 0 and zero? varCoeffsA . nonZeroIdx repeat {
		nonZeroIdx := prev nonZeroIdx;
	    }
	    if nonZeroIdx ~= highestIdx then {
		if ~ zero? nonZeroIdx then {
		    -- the degree of a with respect to varA does not vanish, but shrink
		    newVars . varA := [ varCoeffsA . idx for idx in 0 .. nonZeroIdx ];
		} -- else varA vanishes
	    } else {
		--nothing changed
		newVars . varA := varCoeffsA;
	    }
	}
	
	createPolynomial( aConst, newVars );
    }
    
    ---------------------------

    deepCopy( vars: Vars ): Vars == {
	local ret: Vars := table();
	for varsCross in vars repeat
	{
	    local var: V;
	    local varCoeffs: VarCoeffs;
	    ( var, varCoeffs ) := varsCross;
	    ret . var := [ copy varCoeff for varCoeff in varCoeffs ]
	}
	ret;
    }

    ---------------------------

    copy( a: % ): % == {
	createPolynomial( copy aConst, deepCopy aVars );	
    }
    
    ---------------------------

    zero?( a: % ): Boolean == {
	aConst? and zero? aConst;
    }

    ---------------------------

    one?( a: % ): Boolean == {
	aConst? and one? aConst;
    }

    ---------------------------

    =( a: %, b: % ): Boolean == {
	aConst = bConst and aVars = bVars;
    }
    
    ---------------------------

     extree( a: % ): ExpressionTree == {
        import from Integer;

	aConst? => {
	    extree aConst;
	}

	assert( aPoly? );

	local summands: List ExpressionTree := empty;

	--all coefficients are stored. However, the coeficients to the main variable define the ploynomial completely.
	local mainVar := mainVariable a;
	local mVET := extree mainVar;

	local pVarCoeffs: Partial VarCoeffs := find( mainVar, repA . vars );
	assert( ~ failed? pVarCoeffs );
	local varCoeffs := retract pVarCoeffs;

	assert( # varCoeffs >= 1 );

	if ( # varCoeffs > 1 ) then
	{
	    if ( # varCoeffs > 2 ) then
	    {
		--powers >= 2 are built by exponentiation
		for idx in prev # varCoeffs .. 2 by -1 | ~ zero? varCoeffs . idx repeat 
		{
		    if ( one? varCoeffs . idx ) then
		    {
			summands := insert!( ExpressionTreeExpt . [ mVET, extree (idx::Integer) ], summands );
		    } else {
			summands := insert!( ExpressionTreeTimes . [ extree varCoeffs . idx, ExpressionTreeExpt . [ mVET, extree (idx::Integer) ] ], summands );
		    }
		}
	    }	  	    
	    if ~ zero? ( varCoeffs . 1 ) then
	    {
		if ( one? varCoeffs . 1 ) then
		{
		    summands := insert!( mVET, summands );
		} else {
		    summands := insert!( ExpressionTreeTimes . [ extree varCoeffs . 1, mVET ], summands );
		}
	    }
	}	    

	if ~ zero? ( varCoeffs . 0 ) then
	{
	    summands := insert!( extree varCoeffs . 0, summands );
	}

	assert( # summands >= 1 );
	one? # summands => summands . (firstIndex$(List ExpressionTree));
	ExpressionTreePlus . summands;
    }
    
    ---------------------------

    +( a: %, b: % ): % == {
        zero? a => {
	    copy b;
	}
        zero? b => {
	    copy a;
	}

        assert( ~ zero? a and ~ zero? b );
    
	local retConst: R := aConst + bConst;
	local retVars: Vars := table();
	local varCoeffsRet: VarCoeffs;
	--add b to every coefficient in a
	for varCrossA in aVars repeat {
	    local varA: V;
	    local varCoeffsA: VarCoeffs;
	    ( varA, varCoeffsA ) := varCrossA;
	    assert( (<$Integer)( degree( b, varA ) , (coerce$Integer)(max$MachineInteger) ) );
	    local degB := (machine$Integer) degree( b, varA );
	    varCoeffsRet := new( max( # varCoeffsA, next degB ), createConstant( 0 ) );
	    for idx in 0 .. prev # varCoeffsA repeat 
	    {
		varCoeffsRet . idx := varCoeffsA . idx + coefficient( b, varA, (coerce$Integer) idx );
	    }
	    for idx in # varCoeffsA .. degB repeat 
	    {
		varCoeffsRet . idx := copy coefficient( b, varA, (coerce$Integer) idx );
	    }
	    retVars . varA := varCoeffsRet;
	}
		
	--those variables appearing in b but not in a are still missing in the result. So these are added now.
	for varCrossB in bVars repeat {
	    local varB: V;
	    local varCoeffsB: VarCoeffs;
	    ( varB, varCoeffsB ) := varCrossB;
	    local pVarCoeffsA: Partial VarCoeffs := find( varB, aVars );
	    
	    --only the failed ones are of interest, as the non failed ones have already been dealt with	    
	    if failed? pVarCoeffsA then
	    {
	        varCoeffsRet := [ copy varCoeffsB . deg for deg in 0 .. prev # varCoeffsB ];
		varCoeffsRet . 0 := a + varCoeffsRet . 0;
		retVars . varB := varCoeffsRet;
	    }
	}
	
	normalizeRepresentation!( createPolynomial( retConst, retVars ) );
    }
    
    ---------------------------
    
    (*)( a: %, b: % ): % == {
        zero? a or zero? b => {
	    createConstant( 0$R );
	}

        assert( ~ zero? a and ~ zero? b );
        
	one? a => {
	    copy b;
	}
        one? b => {
	    copy a;
	}
        
	assert( ~ one? a and ~ one? b );
	
	local retConst: R := aConst * bConst;
	local retVars: Vars := table();
	local varCoeffsB: VarCoeffs;
	
	--add b to every coefficient in a
	for varCrossA in aVars repeat {
	    local varA: V;
	    local varCoeffsA: VarCoeffs;
	    ( varA, varCoeffsA ) := varCrossA;

	    local pVarCoeffsB: Partial VarCoeffs := find( varA, repB . vars );
	    if failed? pVarCoeffsB then
	    {
		--varA does not occur in b
		retVars . varA := [ varCoeffsA . deg * b for deg in 0 .. prev # varCoeffsA ];
	    } else {
		--varA does not occur in b
		local varCoeffsB := retract pVarCoeffsB;

                --asserting degree does not exceed maximum of MachineInteger
		assert( 
		  (<$Integer)(
		    (+$Integer)(
		      (coerce$Integer) prev # varCoeffsA,
		      (coerce$Integer) # varCoeffsB
		    ),
		    (coerce$Integer)(max$MachineInteger) 
		  )
		);
		--not using createConstant in the constructor, as this would initialize
		--every slot with the SAME constant.
		retVars . varA := new( prev # varCoeffsA + # varCoeffsB );
		for idx in 0 .. prev # varCoeffsA + prev # varCoeffsB repeat
		{
		    retVars . varA . idx := createConstant( 0 ); 
		}
		for idxA in 0 .. prev # varCoeffsA repeat
		{
		    for idxB in 0 .. prev # varCoeffsB repeat
		    {
			retVars . varA . ( idxA + idxB ) := retVars . varA . ( idxA + idxB ) + varCoeffsA . idxA * varCoeffsB . idxB;
		    }
		}
	    }	    	  
	}
		
	--those variables appearing in b but not in a are still missing in the result. So these are added now.
	for varCrossB in bVars repeat {
	    local varB: V;
	    ( varB, varCoeffsB ) := varCrossB;
	    local pVarCoeffsA: Partial VarCoeffs := find( varB, aVars );
	    
	    --only the failed ones are of interest, as the non failed have already been dealt with	    
	    if failed? pVarCoeffsA then
	    {
		retVars . varB := [ a * varCoeffsB . deg for deg in 0 .. prev # varCoeffsB ];
	    }
	}
	createPolynomial( retConst, retVars );
    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {
        zero? r => createConstant( 0$R );
        assert( ~ zero? r );
	local retConst: R := r * bConst;
	local retVars: Vars := table();

	for varCrossB in bVars repeat {
	    local varB: V;
	    local varCoeffsB: VarCoeffs;
	    ( varB, varCoeffsB ) := varCrossB;
	    retVars . varB := [ r * varCoeffsB . deg for deg in 0 .. prev # varCoeffsB ];
	}
	createPolynomial( retConst, retVars );
    }

    ---------------------------

    -( a: % ): % == {
	local retConst: R := -aConst;
	local retVars: Vars := table();

	for varCrossA in aVars repeat {
	    local varA: V;
	    local varCoeffsA: VarCoeffs;
	    ( varA, varCoeffsA ) := varCrossA;
	    retVars . varA := [ - varCoeffsA . deg for deg in 0 .. prev # varCoeffsA ];
	}
	
	createPolynomial( retConst, retVars );
    }
    
    ---------------------------

    0: % == createConstant( 0$R );
    
    ---------------------------    

    1: % == createConstant( 1$R );
    
    ---------------------------

    commutative?: Boolean == true;
    
    ---------------------------
    
    coerce( v: V ): % == {
	local retConst: R := copy 0;
	
	local varCoeffs: VarCoeffs := new( 2 );
	varCoeffs . 0 := createConstant( 0 );
	varCoeffs . 1 := createConstant( 1 );

	local retVars: Vars := table();
	retVars . v := varCoeffs;
	
	createPolynomial( retConst, retVars );
    }
    
    ---------------------------

    variable?( a: % ): Boolean == {
        ~ zero? aConst => {
	    false;
	}
	aConst? => {
	    false
	}
	~ one? NENTRIESHASHTABLE aVars => {
	    false
	}
	local var: V;
	local varCoeffs: VarCoeffs;
	import from Generator Cross( V, VarCoeffs);
	( var, varCoeffs ) := next! generator aVars;

	# varCoeffs ~= 2 => {
	    false;
	}
	
	varCoeffs . 0 ~= 0 => {
	    false;
	}
	
	varCoeffs . 1 = createConstant( 1$R );
    }
    
    ---------------------------
    
    variable( a: % ): V == {
	assert( variable? a );
	
        local var: V;
	local varCoeffs: VarCoeffs;
	import from Generator Cross( V, VarCoeffs);
	( var, varCoeffs ) := next! generator aVars;
	var;
    }
    
    ---------------------------
    
    variables( a: % ): List V == {

	sort!( [ keys aVars ], > );

    }
    
    ---------------------------
    
    mainVariable( a: % ): V == {
	import from List V;
	assert( aPoly? );
	
	first sort!( [ keys aVars ], > );
    }
    
    ---------------------------
    
    trailingCoefficient( a: % ): R == {
	aConst? => {
	    aConst;
	}
	
	assert( aPoly? );
	
	local pVarCoeffsA: Partial VarCoeffs := find( mainVariable a, aVars );

	assert( ~ failed? pVarCoeffsA );

	for coeff in retract pVarCoeffsA | ~ zero? coeff repeat 
	{
	    return trailingCoefficient coeff;
	}
	never;
    }
    
    ---------------------------
    
    leadingCoefficient( a: % ): R == {
	aConst? => {
	    aConst;
	}
	
	assert( aPoly? );
	
	local pVarCoeffsA: Partial VarCoeffs := find( mainVariable a, aVars );

	assert( ~ failed? pVarCoeffsA );

	local varCoeffsA: VarCoeffs := retract pVarCoeffsA;
	leadingCoefficient varCoeffsA . ( prev # varCoeffsA );
    }
    
    ---------------------------
    
    leadingTerm( a: % ): % == {
	aConst? => {
	    createConstant( aConst );
	}
	
	assert( aPoly? );
	
	local mVA: V := mainVariable a;
	local pVarCoeffsA: Partial VarCoeffs := find( mVA, aVars );

	assert( ~ failed? pVarCoeffsA );

	local varCoeffsA: VarCoeffs := retract pVarCoeffsA;
	local deg := prev # varCoeffsA;
	term( 1, mVA, (coerce$Integer) deg ) * leadingTerm varCoeffsA . deg;
    }
    
    ---------------------------
    
    reductum( a: % ): % == {
	a - leadingTerm a;
    }
    
    ---------------------------
    
    support( a: % ): Generator Cross( R, % ) == {
	aConst? => generate {
	    if ~ zero? aConst then
	    {
		yield ( aConst, createConstant( 1$R ) );
	    }
	}

	assert( aPoly? );
	
	local mVA: V := mainVariable a;
	local pVarCoeffs: Partial VarCoeffs := find( mVA, aVars );

	assert( ~ failed? pVarCoeffs );
	
	local varCoeffs: VarCoeffs := retract pVarCoeffs;

	generate {
	    for deg in 0 .. prev # varCoeffs repeat
	    {
		for subSupport in support varCoeffs . deg repeat
		{
		    local subCoeff: R;
		    local subTerm: %;
		    ( subCoeff, subTerm ) := subSupport;
		    yield ( subCoeff, subTerm * term( 1, mVA, (coerce$Integer) deg ) );
		}
	    }
	}
    }
    
    ---------------------------

    variableProduct( a: % ): Generator Cross( V, Integer ) == {
	aConst? => generate {
	}

	assert( aPoly? );
	assert( zero? aConst );

	generate {
	    for varCross in aVars repeat {
		local var: V;
		local varCoeffs: VarCoeffs;
		( var, varCoeffs ) := varCross;
#if DEBUG
		if # varCoeffs >= 2 then
		{
		    for deg in 0 .. prev prev # varCoeffs repeat
		    {
			assert( zero? varCoeffs . deg );
		    }
		}
#endif	    
		yield( var, (coerce$Integer) prev # varCoeffs );
	    }
	}
    }
    
    ---------------------------

    times( a: %, r: R, v: V, d: Integer ): % == {
	times!( copy a, r, v, d );
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {
        zero? r => {
	    createConstant( 0 );
	} 
	
	zero? d => {
	    r * a;
	}

	a * term( r, v, d );
    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {
	0$Integer;
	aConst? => {
	    0;
	}

	assert( aPoly? );
	
	local pVarCoeffs: Partial VarCoeffs := find( v, aVars );
	
	failed? pVarCoeffs => {
	    0;
	}

	(coerce$Integer) prev # retract pVarCoeffs;
    }
    
    ---------------------------

    coefficient( a: %, v: V, d: Integer ): % == {
	aConst? => {
	    zero? d => {
		a;
	    }
	    createConstant( 0 );
	}

	assert( aPoly? );
	
	local pVarCoeffs: Partial VarCoeffs := find( v, aVars );
	
	failed? pVarCoeffs => {
	    zero? d => {
		a;
	    }
	    createConstant( 0 );
	}

	local varCoeffs := retract pVarCoeffs;
	
	assert( d >= 0 and (<$Integer)( d, (coerce$Integer)(max$MachineInteger) ) );

	d >= (coerce$Integer) # varCoeffs => {
	    createConstant( 0 );
	}
	
	varCoeffs . (machine d);
    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {
	zero? r => {
	    createConstant( 0$R );
	}

	zero? d => {
	    createConstant( r );
	}

	assert( d > 0 and (<$Integer)( d, (coerce$Integer)(max$MachineInteger) ) );

	local varCoeffs: VarCoeffs := new( machine next d, createConstant( 0$R ) );
	varCoeffs . ( machine d ) := createConstant( r );
	createPolynomial( 0, [ ( v, varCoeffs )@Cross( V, VarCoeffs ) ] );
    }
    
    ---------------------------

    coerce( r: Integer ): % == {
	createConstant( r :: R );
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