-------------------------------------------------------------------------
--
-- cs_dprt.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{collects functions for differential polynomial rings}
+++\adcode{DIDOM} denotes the coefficient domain and \adcode{DVARS} denotes the indeterminates of the differential polynomial ring. \adcode{VARS} is only needed to specify the type of \adcode{DVARS} correctly.
+++
+++The ``application of a derivation'' of \adthistype's \adtype{DifferentialType} refers to letting the derivation act on the elements of the differential polynomial ring. 
+++\end{addescription}
DifferentialPolynomialRingType(
  DIDOM  : with{ IntegralDomain; DifferentialType; },
  VARS  : FiniteVariableType,
  DVARS : DifferentialVariableType( VARS )
) : Category == with { 

    PolynomialRing0( DIDOM, DVARS );
    DifferentialType;
    RankedType;

    CommutativeRing;

    if DIDOM has CharacteristicZero then
    {
	CharacteristicZero;
    }

    if DIDOM has FiniteCharacteristic then
    {
	FiniteCharacteristic
    }

    if DIDOM has Parsable then 
    {
	Parsable;
    }

    +++\begin{addescription}{gives the separant of a differential polynomial}
    +++Let $a$ be a differential polynomial. If $a$ is a constant, \adcode{separant(a)} gives \adcode{0}. If $a$ is not a constant, let $x$ denote its main indeterminate. $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i$$ with $d$ denoting the degree of $a$ with respect to $x$ and each $c_i$ not containing $x$. \adcode{separant(a)} gives $$\sum_{i=1}^{d}ic_ix^{i-1}.$$
    +++\end{addescription}
    separant: % -> %;

    +++\begin{addescription}{gives the initial of a differential polynomial}
    +++Let $a$ be a differential polynomial. If $a$ is a constant, \adcode{initial(a)} gives $a$. If $a$ is not a constant, let $x$ denote its main indeterminate. $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i$$ with $d$ denoting the degree of $a$ with respect to $x$ and each $c_i$ not containing $x$. \adcode{inital(a)} gives $c_d$.
    +++\end{addescription}
    initial: % -> %;

    +++\begin{addescription}{divides by an indeterminate}
    +++Let $a$ be a differential polynomial and $x$ a differential indeterminate. Furthermore, let $d$ denote $a$'s degree with respect to $x$. If $d$ is $0$, \adcode{quotient( a, x )} gives zero. If $d$ is not $0$, $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i,$$ each $c_i$ not containing $x$. \adcode{quotient( a, x )} yields $$\sum_{i=1}^{d}c_ix^{i-1}.$$
    +++\end{addescription}
    quotient: ( %, DVARS ) -> %;

    +++\begin{addescription}{divides by an indeterminate}
    +++Let $a$ denote a differential polynomial and $x$ a differential indeterminate. Furthermore, let $d$ denote $a$'s degree with respect to $x$. If $d$ is $0$, \adcode{quotient( x )( a )} gives zero. If $d$ is not $0$, $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i,$$ each $c_i$ not containing $x$. \adcode{quotient( x )( a )} yields $$\sum_{i=1}^{d}c_ix^{i-1}.$$
    +++\end{addescription}
    quotientBy: DVARS -> % -> %;
    
    +++\begin{addescription}{divides by an indeterminate}
    +++Let $a$ denote a differential polynomial, $x$ denote a differential indeterminate, and $n$ denote a non-negative integer. Furthermore, let $d$ denote $a$'s degree with respect to $x$. If $d < n$, \adcode{quotient( x, n )( a )} gives zero. Otherwise, $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i,$$ each $c_i$ not containing $x$. \adcode{quotient( x, n )( a )} yields $$\sum_{i=n}^{d}c_ix^{i-n}.$$
    +++\end{addescription}
    quotientBy: ( DVARS, Integer ) -> % -> %;

    +++\begin{addescription}{computes partial derivatives}
    +++Let $a$ denote a differential polynomial and $x$ denote a differential indeterminate. Futhermore, let $d$ denote $a$'s degree with respect to $x$. $a$ can be written as $$a=\sum_{i=0}^{d}c_ix^i,$$ each $c_i$ not containing $x$. \adcode{differentiate( a, x )} yields $$\sum_{i=1}^{d}ic_ix^{i-1}.$$
    +++\end{addescription}
    differentiate: ( %, DVARS ) -> %;

    ----------------------------------------------------------------

    default {

        reciprocal(a:%):Partial(%) == {
	    import from DIDOM;
	    import from Partial DIDOM;
	    ~ ground? a => failed;
	    local pA := reciprocal leadingCoefficient a;
	    failed? pA => failed;
	    [ (retract pA) :: % ]
	}

	-------------------------------------------

	differentiate( a:%, dv:DVARS ): % == {

            import from Integer;
	    local ret:% := 0;
	    local accumulatedDVar:% := 1;
	    local dvPR: % := dv::%;
	    for power in 1..degree( a, dv ) repeat 
	    {
		ret := ret + power*coefficient( a, dv, power )*accumulatedDVar;
		accumulatedDVar := dvPR * accumulatedDVar;
	    }
	    ret;
	}           

	
	-------------------------------------------	  


	quotient( a: %, dv: DVARS ): % == {
	    (quotientBy dv) a;
	}


	-------------------------------------------


	quotientBy( dv: DVARS ): % -> % == {
	    quotientBy( dv, 1$Integer );
	}

	
	-------------------------------------------


	quotientBy( dv: DVARS, n: Integer ): % -> % == {
	    local dvPoly : % := dv::%;
	    assert( n >= 0 );
	    ( a: % ): % +-> {
		local result: % := 0;
		local varPoly: % := 1;
		for deg in n .. degree( a, dv ) repeat 
		{
		    result := add!( result, coefficient( a, dv, deg) * varPoly );
		    varPoly := times!( varPoly, dvPoly );
		}
		result
	    }
	}


	-------------------------------------------

	macro DERIVATIONFUNCTION == {
	    	    ( a: % ): % +-> {		      
		import from List DVARS;
		import from DVARS;
		local ret : % := (map fldDerivation) a;
		for var in variables a repeat
		{
		    ret := add! ( ret, differentiate( a, var ) * term( 1$DIDOM, varDerivation var, 1$Integer) );
		}
		ret;
	    }
	}
	
	-------------------------------------------


	derivationFunction( idx: Integer ): % -> % == {
	    local varDerivation: DVARS -> DVARS := (derivationFunction$DVARS) idx;
	    local fldDerivation: DIDOM -> DIDOM := (derivationFunction$DIDOM) idx;
	    DERIVATIONFUNCTION;
	};


	-------------------------------------------


	derivationFunction( sym: Symbol ): % -> % == {
	    local varDerivation: DVARS -> DVARS := (derivationFunction$DVARS) sym;
	    local fldDerivation: DIDOM -> DIDOM := (derivationFunction$DIDOM) sym;
	    DERIVATIONFUNCTION;
	};


	-------------------------------------------

        <(a:%,b:%):Boolean == {
	    import from DVARS;
	    import from Integer;

	    ground? b => false;
	    assert( not ground? b );

	    ground? a => true;
	    assert( not ground? a );

	    local mainVariableA := mainVariable a;
	    local mainVariableB := mainVariable b;

	    mainVariableA < mainVariableB => true;

	    mainVariableA > mainVariableB => false;

	    assert( mainVariableA = mainVariableB );
	    degree( a, mainVariableA ) < degree( b, mainVariableB );	    
	}

        -------------------------------------------

        >(a:%,b:%):Boolean == {
	    b<a;
	}

        -------------------------------------------

        separant( a: % ): % == {
	    ground? a => 0;
	    differentiate( a, mainVariable a);
	}

        -------------------------------------------

        initial( a: % ): % == {
	    ground? a => a;
	    local mainVariableA := mainVariable a;
	    coefficient( a, mainVariableA, degree( a, mainVariableA ) );
	}

        -------------------------------------------

    }

};
