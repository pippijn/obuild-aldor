-------------------------------------------------------------------------
--
-- cs_plain.as
--
-------------------------------------------------------------------------

#include "algebra"
#include "extio"

+++\begin{addescription}{wraps a ploynomial ring}
+++No functionality is added by \adthistype to the polynomial ring \adcode{PR}. \adthistype is solely used to measure the inherent penalty for wrapping a polynomial ring. This penalty is important when discussing the speed-up of other polynomial ring wrappers (e.g.: \adtype{PolynomialRingWithMainVariable}).
+++\end{addescription}
+++\begin{adremarks}
+++To give a better estimate for the warpping penalty, the internal representation of \adthistype is not \adcode{PR}, but \adcode{Record( poly: PR )}. As a result, \adthistype reimplements most functions of \adtype{PolynomialRing0} to reflect the change of the representation. These reimplementation consist merely of delegating the function calls to \adcode{PR}.
+++\end{adremarks}
PlainPolynomialRingWrapper(
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
    
    macro Rep == Record( poly: PR );

    import from Rep;
    import from PR;

    macro createConstant( r ) == per record( r::PR );
    macro createPolynomial( pr ) == per record pr;
    
    macro repA == rep a;
    macro aPoly == repA . poly;
    
    macro repB == rep b;
    macro bPoly == repB . poly;
    
    import from MachineInteger;
    
    ---------------------------

    copy( a: % ): % == {
	createPolynomial( copy aPoly );
    }
    
    ---------------------------

    =( a: %, b: % ): Boolean == {
	aPoly = bPoly;
    }
    
    ---------------------------

    extree( a: % ): ExpressionTree == {
	extree aPoly;
    }
    
    ---------------------------

    +( a: %, b: % ): % == {
	createPolynomial( aPoly + bPoly )
    }
    
    ---------------------------

    (*)( a: %, b: % ): % == {
	createPolynomial( aPoly * bPoly )
    }
    
    ---------------------------

    (*)( r: R, b: % ): % == {
	createPolynomial( r * bPoly )
    }

    ---------------------------

    -( a: % ): % == {
	createPolynomial( - aPoly )
    }
    
    ---------------------------

    0: % == createConstant( 0$R );
    
    ---------------------------    

    1: % == createConstant( 1$R );
    
    ---------------------------

    commutative?: Boolean == true;
    
    ---------------------------
    
    coerce( v: V ): % == {
	createPolynomial( v::PR )
    }
    
    ---------------------------

    variable?( a: % ): Boolean == {
	variable? aPoly
    }
    
    ---------------------------
    
    variable( a: % ): V == {
	variable aPoly;
    }
    
    ---------------------------
    
    variables( a: % ): List V == {
	variables aPoly;
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
	createPolynomial reductum aPoly;
    }
    
    ---------------------------
    
    support( a: % ): Generator Cross( R, % ) == {

	generate {
	    for subSupport in support aPoly repeat
	    {
		local coeff: R;
		local subPoly: PR;
		( coeff, subPoly ) := subSupport;
		yield ( coeff, createPolynomial subPoly );
	    }
	}
    }

    ---------------------------

    variableProduct( a: % ): Generator Cross( V, Integer ) == {
	variableProduct aPoly;
    }
    
    ---------------------------

    times( a: %, r: R, v: V, d: Integer ): % == {
	createPolynomial times( aPoly, r, v, d );
    }
    
    ---------------------------

    times!( a: %, r: R, v: V, d: Integer ): % == {
	createPolynomial times!( aPoly, r, v, d );
    }
    
    ---------------------------

    degree( a: %, v: V ): Integer == {
	degree( aPoly, v );
    }
    
    ---------------------------

    coefficient( a: %, v: V, d: Integer ): % == {
	createPolynomial coefficient( aPoly, v, d );
    }
    
    ---------------------------

    term( r: R, v: V, d: Integer ): % == {
	createPolynomial term( r, v, d );
    }
    
    ---------------------------

    coerce( r: Integer ): % == {
	createPolynomial( r :: PR );
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
	createPolynomial( a );
    }

    ---------------------------

    coerce( a: % ): PR == {
	aPoly;
    }

    ---------------------------

}