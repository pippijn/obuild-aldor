-------------------------------------------------------------------------
--
-- cs_ect.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{provides default implementations for functions on exponents}
+++Among the required functions for the category \adtype{ExponentCategory} of the \LibAlgebra library (and its parent \adtype{GeneralExponentCategory}, which can again be found in the \LibAlgebra library), there are several functions which may be achieved by a default implementation. However, \adtype{ExponentCategory} does not provide these default implementations. To ease the development of exponent domains, \adthistype provides these default implementations.
+++\end{addescription}
+++\begin{adremarks}
+++\adtype{GeneralExponentCategory} and \adtype{ExponentCategory} sometimes denote exponents additively and sometime multipicatively. Therefore, in the description of \adthistype, we explicitely state for every function which notation is used.
+++\end{adremarks}
ExponentCategoryTools(

  VARS: VariableType,
  EXP : ExponentCategory( VARS )

): with {

    +++\begin{addescription}{tests if the exponent is trivial}
    +++If the passed exponent does not contain any indeterminate, \adthisname gives \adname[Boolean]{true}. Otherwise, it gives \adname[Boolean]{false}.
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as additively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    zero?: EXP -> Boolean;
    
    +++\begin{addescription}{adds the same exponent again and again}
    +++Let $e$ denote the \adcode{EXP} parameter and $n$ denote the parameter of type \admacro{Integer}. \adcode{n} has to be non negative. Then, \adthisname returns
    +++$$\begin{array}{c}
    +++\underbrace{e + e + \cdots + e}\\
    +++n\text{ times}
    +++\end{array}$$
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as additively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    times: ( Integer, EXP ) -> EXP;

    +++\begin{addescription}{adds the same indeterminate again and again to an exponent}
    +++Let $e$ denote the \adcode{EXP} parameter, $v$ denote the \adcode{VAR} parameter and $n$ denote the parameter of type \admacro{Integer}. \adcode{n} has to be non negative. Then, \adthisname returns
    +++$$\begin{array}{ccc}
    +++ e & + & \underbrace{v + v + \cdots + v}\\
    +++   &   & n\text{ times}
    +++\end{array}$$
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as additively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    add!: ( EXP, VARS, Integer ) -> EXP;
    
    +++\begin{addescription}{contructs an exponent from lists}
    +++Let $v_1, v_2, \ldots$ denote the elements of the parameter \adtype{List} \adcode{VARS} and let $d_1, d_2,\ldots$ denote the corresponding elements of the parameter \adtype{List} \admacro{Integer}. Each $d_i$ has to be non negative. Then, \adthisname returns
    +++$$\begin{array}{ccccc}
    +++ \underbrace{v_1 + v_1 + \cdots + v_1} & + & \underbrace{v_2 + v_2 + \cdots + v_2} & + & \ldots \\
    +++ d_1 \text{ times}                     &   & d_2 \text{ times}
    +++\end{array}$$
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as additively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    exponent: ( List VARS, List Integer ) -> EXP;

    +++\begin{addescription}{contructs an exponent from a generator}
    +++Let $c_1, c_2, \ldots$ denote the elements of the generator. Furthermore, let $v_i$ denote the \adcode{VARS} part of $c_i$ and let $d_i$ denote the \admacro{Integer} part of $c_i$. Each $d_i$ has to be non negative. Then, \adthisname returns
    +++$$\begin{array}{ccccc}
    +++ \underbrace{v_1 + v_1 + \cdots + v_1} & + & \underbrace{v_2 + v_2 + \cdots + v_2} & + & \ldots \\
    +++ d_1 \text{ times}                     &   & d_2 \text{ times}
    +++\end{array}$$
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as additively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    exponent: Generator( Cross( VARS, Integer ) ) -> EXP;
    
    +++\begin{addescription}{computes the total degree}
    +++Let $v_1, v_2, \ldots$ denote elements of \adcode{VARS} and let $d_1,d_2,\ldots$ denote \admacro{Integer}{}s. For an exponent $$v_1^{d_1}v_2^{d_2}\ldots,$$ \adthisname gives $d_1 + d_2 + \ldots.$
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as multiplicatively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    totalDegree: EXP ->  Integer;

    +++\begin{addescription}{computes the total degree with respect to some indeterminates}
    +++Let \adcode{e} denote the \adcode{EXP} parameter and let $l$ denote parameter of type \adtype{List} \adcode{VARS}. Let $v_1, v_2, \ldots$ denote elements of \adcode{VARS} and let $d_1,d_2,\ldots$ denote \admacro{Integer}{}s, such that $$e=v_1^{d_1}v_2^{d_2}\ldots.$$ Furthermore, let $$I=\left\{ \; i \; | \; v_i \in l \; \right\}.$$ Then \adcode{exponent( e, l )} yield $$\sum_{i \in I}d_i.$$
    +++
    +++In other words, \adthisname adds up the degrees to those indeterminates, whose corresponding indeterminates occur in $l$.
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as multiplicatively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++
    +++Although the \Aldoc documentation of \adtype{ExponentCategory} does not specify the behaviour of its \adname[ExponentCategory]{totalDegree} function, the documentation of source code for the category clearly states, degrees of an indeterminate occurring more than once in $l$ have to be counted only once.
    +++\end{adremarks}
    totalDegree: ( EXP, List VARS ) -> Integer;
    
    +++\begin{addescription}{computes the cofactor to the least common multiple.}
    +++Let \adcode{a} denote the first parameter and \adcode{b} the second one. Let $l$ denote the least common multiple of \adcode{a} and \adcode{b}. Let \adcode{c} be an exponent, such that $a = l c$. Accordingly, let \adcode{d} be an exponent, such that $b = l d$. Then, \adcode{syzygy( a, b )} gives \adcode{( c, d )}.
    +++\end{addescription}
    +++\begin{adremarks}
    +++The description of \adthisname denotes exponents as multiplicatively written free monoid, generated be the indeterminates \adcode{VARS}.
    +++\end{adremarks}
    syzygy: ( EXP, EXP ) -> ( EXP, EXP );
    
    if EXP has CopyableType then
    {
	+++\begin{addescription}{adds exponents}
	+++Let \adcode{a} denote the first parameter and \adcode{b} the second one. Let $v_1, v_2, \ldots, u_1, u_2, \ldots$ denote elements of \adcode{VARS} and $d_1, d_2, \ldots, c_1, c_2, \ldots$, such that
	+++$$\begin{array}{ccccc}
	+++ \underbrace{v_1 + v_1 + \cdots + v_1} & + & \underbrace{v_2 + v_2 + \cdots + v_2} & + & \ldots \\
	+++ d_1 \text{ times}                     &   & d_2 \text{ times}
	+++\end{array}$$
	+++and
	+++$$\begin{array}{ccccc}
	+++ \underbrace{u_1 + u_1 + \cdots + u_1} & + & \underbrace{u_2 + u_2 + \cdots + u_2} & + & \ldots .\\
	+++ c_1 \text{ times}                     &   & c_2 \text{ times}
	+++\end{array}$$
	+++Then, \adcode{a + b} yields
	+++$$\begin{array}{ccccccc}
	+++   & \underbrace{v_1 + v_1 + \cdots + v_1} & + & \underbrace{v_2 + v_2 + \cdots + v_2} & + & \ldots & +\\
	+++   & d_1 \text{ times}                     &   & d_2 \text{ times} \\
	+++ + & \underbrace{u_1 + u_1 + \cdots + u_1} & + & \underbrace{u_2 + u_2 + \cdots + u_2} & + & \ldots\\
	+++   & c_1 \text{ times}                     &   & c_2 \text{ times}
	+++\end{array}$$
	+++\end{addescription}
	+++\begin{adremarks}
	+++The description of \adthisname denotes exponents as additively written free monoid, generated be the indeterminates \adcode{VARS}.
	+++\end{adremarks}
	+: ( EXP, EXP ) -> EXP;
    }
    
} == add {

    import from EXP;
    
    -----------------------------------------

    zero?( a:EXP ):Boolean == {
	a = 0;
    }

    -----------------------------------------

    times( n:Integer, a:EXP ):EXP == {
	assert(n>=0);
	n = 0 => 0;
	n = 1 => if EXP has CopyableType then { copy a; } else { (+$EXP)( a, 0 ); }

	local result := (+$EXP)( a, a );
	for i in 3..n repeat {
	    result := add!( result, a );
	}

	result;		    
    }

    -----------------------------------------

    add!( a: EXP, dv: VARS, n: Integer ): EXP == {
	(add!$EXP)( a, exponent( dv, n ) );
    }

    -----------------------------------------

    exponent( dvs: List VARS, ns: List Integer ): EXP == {
	assert( (=$MachineInteger) ( #dvs, #ns ) );
	local ret:EXP := 0;
	for dv in dvs for n in ns repeat
	{
	    ret := (add!$EXP)( ret, dv, n );
	}
	ret;
    }

    -----------------------------------------

    exponent( gen: Generator( Cross( VARS, Integer ) ) ): EXP == {
	import from Integer;
	local ret:EXP := 0;
	for cross in gen repeat
	{
	    ( dv, n ) := cross;
	    assert( n >= 0 );
	    assert( n <= coerce (max$MachineInteger) );
	    ret := (add!$EXP)( ret, dv, n );
	}
	ret;
    }

    -----------------------------------------

    totalDegree( a: EXP ): Integer == {
	local ret: Integer := 0;
	for cross in terms a repeat
	{
	    ( dv, n ) := cross;
	    ret := ret + n;
	}
	ret;
    }

    -----------------------------------------

    totalDegree( a: EXP, dvs: List VARS ): Integer == {
	local ret: Integer := 0;
	for cross in terms a repeat
	{
	    ( dv, n ) := cross;
	    if member?( dv, dvs ) then
	    {
		ret := ret + n;
	    }
	}
	ret;
    }

    -----------------------------------------

    syzygy( x: EXP, y: EXP ): ( EXP, EXP ) == {
	import from Partial EXP;
	local lcmxy := lcm( x, y );
	assert( cancel?( lcmxy, x ) );
	assert( cancel?( lcmxy, y ) );
	( retract cancelIfCan( lcmxy, x ), retract cancelIfCan( lcmxy, y ) );
    }

    -----------------------------------------


    if EXP has CopyableType then
    {
	+( a: EXP, b: EXP ): EXP == {
	    add!( copy a, b );
	}
    }

    
    -----------------------------------------------------------
    

};


