-------------------------------------------------------------------------
--
-- cs_integ.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{is a clone of \adtype{AldorInteger} with less functionality}
+++\end{addescription}
+++\begin{adremarks}
+++\adthistype is handy, where it is necessary to have integers but additionally important not to use \adtype{AldorInteger} itself. This situation can for example occur in \adtype{PolynomialRing}, as this category provides two multiplication mappings:
+++\begin{itemize}
+++\item[]\adcode{*: ( R, % ) -> %} and
+++\item[]\adcode{*: ( Integer, % ) -> %}.
+++\end{itemize}
+++ Using \adthistype for \adcode{R} allows to disambiguate between the two functions and still use an implementation of integers for \adcode{R}.
+++
+++The functions and representation of \adthistype are inhereted from \admacro{Integer}. However, when compiling the debug version, the Aldor compiler cannot find some functions of \admacro{Integer} (e.g.: \adname[Integer]{-}). Therefore, these functions have been re-implemented for the debug variant of \projectname.
+++\end{adremarks}
AldorInteger2: with {
    IntegerType;
    GcdDomain;
    CharacteristicZero;
    CommutativeRing;
    CopyableType;
    
--The debug version of Integer cannot find the "-" in some scopes.
--The used workaround is to remove Integer from the add clause
--and inherit the required functions explicitely.
#if DEBUG
} == add { 
#else
} == AldorInteger add { 
#endif    

    Rep == AldorInteger;
    import from Rep;
    
#if GMP
    coerce( a: GMPInteger ): % == {
	per ((coerce$GMPInteger) a);
    }
#else    
    coerce( a: AldorInteger ): % == {
	per a;
    }
#endif
    
    --------------------------------------
    
    coerce( a: MachineInteger ): % == {
	(a::AldorInteger) pretend %;
    }
    
    --------------------------------------
    
    copy( a: % ): % == {
	prev next a;
    }
    
    --------------------------------------
    
--Aldor fails to find the "-" function in some places.
--See this domains add clause for further information.
#if DEBUG
    (-)( a: % ): % == {
	per (-(rep a));
    }
    
    --------------------------------------

    (-)( a: %, b: % ): % == {
	((a pretend AldorInteger)-(b pretend AldorInteger))::%
    }

    --------------------------------------

    gcd( a: %, b: % ): % == {
	(gcd(a pretend AldorInteger, b pretend AldorInteger))::%;
    }
    
    --------------------------------------

    gcd( gen: Generator % ): % == {
	local res: % := 0;
	for elementGen in gen repeat 
	{
	    res := gcd( res, elementGen );
	}
	res;
    }
    
    --------------------------------------

    (=)( a: %, b: % ): Boolean == {
	( rep a ) = ( rep b );
    }
    
    --------------------------------------

    0: % == per 0;    

    --------------------------------------

    characteristic: Integer == 0;    

    --------------------------------------

    1: % == per 1;    

    --------------------------------------

    (+)( a: %, b: % ): % == {
	per ( ( rep a ) + ( rep b ) );
    }
    
    --------------------------------------

    (*)( a: %, b: % ): % == {
	per ( ( rep a ) * ( rep b ) );
    }
    
    --------------------------------------

    (<)( a: %, b: % ): Boolean == {
	( rep a ) < ( rep b );
    }
    
    --------------------------------------

    (~)( a: % ): % == {
	per( ~ ( rep a ) );
    }
    
    --------------------------------------

    (/\)( a: %, b: % ): % == {
	per ( ( rep a ) /\ ( rep b ) );
    }
    
    --------------------------------------

    (\/)( a: %, b: % ): % == {
	per ( ( rep a ) \/ ( rep b ) );
    }
    
    --------------------------------------

    (<<)( rd: BinaryReader ): % == {
	per ( << rd );
    }
    
    --------------------------------------

    (<<)( wr: BinaryWriter, a: % ): BinaryWriter == {
	<<( wr, a );
    }
    
    --------------------------------------

    bit?( a: %, bitNr: MachineInteger ): Boolean == {
	bit?( rep a, bitNr );
    }
    
    --------------------------------------

    machine( a: % ): MachineInteger == {
	machine rep a;
    }
    
    --------------------------------------

    (quo)( a: %, b: % ): % == {
	per ( ( rep a ) quo ( rep b ) );
    }
    
    --------------------------------------

    (rem)( a: %, b: % ): % == {
	per ( ( rep a ) rem ( rep b ) );
    }
    
    --------------------------------------

    integer( lit: Literal ): % == {
	per integer lit;
    }
    
    --------------------------------------

    length( a: % ): MachineInteger == {
	length rep a;
    }
    
    --------------------------------------

    nthRoot( a: %, b: % ): ( Boolean, % ) == {
	( retA: Boolean, retB: Rep ) := nthRoot( rep a, rep b);
	( retA, per retB );
    }
    
    --------------------------------------

    random( a: MachineInteger ): % == {
	per random a;
    }
    
    --------------------------------------

    shift( a: %, b: MachineInteger ): % == {
	per shift( rep a, b );
    }
    
    --------------------------------------

    divide!( a: %, b: %, c: % ): ( %, % ) == {
	( retA: Rep, retB: Rep ) := divide!( rep a, rep b, rep c );
	( per retA, per retB );
    }
    
    --------------------------------------

    integer( a: % ): Integer == {
	rep a;
    }
    
    --------------------------------------

    extree( a: % ): ExpressionTree == {
	extree rep a;
    }
    
    --------------------------------------

    exactQuotient( a: %, b: % ): Partial % == {
	local ret: Partial Rep := exactQuotient( rep a, rep b);
	failed? ret => failed;
	[ per retract ret ];
    }
    
    --------------------------------------

    <<( reader: TextReader) : % == {
	per ( (<<) (reader) );
    }
    
    --------------------------------------

    divide( a: %, b: % ): ( %, % ) == {
	local retA: Rep;
	local retB: Rep;
	( retA, retB ) := (divide)( rep a, rep b );
	( per retA, per retB );
    }
    
    --------------------------------------

#endif
    
};
    
