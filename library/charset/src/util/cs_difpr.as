-------------------------------------------------------------------------
--
-- cs_difpr.as
--
-------------------------------------------------------------------------

#include "charset.as"

#assert PROVIDEGCD

+++\begin{addescription}{models the field of rational functions}
+++A rational function is expressed via a \adtype{Fraction} of polynomials. The parameter \adcode{PR} denotes the coefficients to these polynomials. \adcode{CVARSYMS} holds the \adtype{Symbol}s for the indeterminates to these polynomials.
+++
+++To ``apply a derivation'' of \adtype{DifferentialType} refers to letting a derivation act on a rational function. The implemented derivations are partial differential derivations with respect to the \adtype{Symbol}{}s of \adcode{CVARSYMS}.
+++\end{addescription}
+++\begin{adremarks}
+++The polynomials are represented via \adtype{DistributedMultivariatePolynomial1} which is lifted to \adtype{GcdDomain}.
+++
+++\adthistype is usefull when creating coefficient domains for differential polynomials that are polynomials themselves.
+++\end{adremarks}
DifferentialPolynomialFractionRing(
  CR: with {
      PrimitiveType;
      GcdDomain;
      CharacteristicZero;
  } == AldorInteger2,
  CVARSYMS: List Symbol
):with {
    Field; 
    DifferentialType; 
    CharacteristicZero;
    Parsable;
    +++\begin{addescription}{gives the indeterminates}
    +++\end{addescription}
    variables: () -> List %;
}  == 
(
  macro CVARS  == OrderedVariableList2((reverse$(List Symbol)) CVARSYMS);	
  macro CEXP == ListSortedExponent( CVARS );
  macro PPR == DistributedMultivariatePolynomial1( CR, CVARS, CEXP );
  macro CPR == DistributivePolynomialRingLeadingTermOrderExtension( CR, CVARS, CEXP, PPR );
  macro IPR == DistributivePolynomialRingIntegralDomainExtension( CR, CVARS, CEXP, CPR );
  macro IPRRT == PseudoRemainderReductionTools( CR, CVARS, IPR );
  macro GCDPR == DistributivePolynomialRingSubResultantPRSGcdDomainExtension( CR, CVARS, CEXP, IPR, IPRRT );
  macro Rep == Fraction GCDPR; 

  Rep add {


      -----------------------------------    

      variables(): List % == {
	  import from List %;
	  import from CVARS;
	  import from Partial CVARS;
	  import from GCDPR;
	  import from Rep;

	  [ (per ((coerce retract variable varsym)*1)) for varsym in CVARSYMS ];
      }


      -----------------------------------    

      derivationFunction( sym: Symbol ): % -> % == {
	  import from CVARS;
	  import from MachineInteger;
	  local pVar: Partial CVARS := variable sym;
	  failed? pVar => (
	    ( a: % ): % +-> {  
                0;
	    }
          );
	  import from Integer;
	  derivationFunction coerce ( (#$CVARS) - index retract pVar);
      }


      -----------------------------------

      differentiate( a: GCDPR, diffVar: CVARS ): GCDPR == {
	  import from Integer;
	  local res                    : GCDPR := 0;
	  local accumulatedDiffVarGCDPR: GCDPR := 1;
	  local diffVarGCDPR       : GCDPR := diffVar::GCDPR;
	  for power in 1..degree( a, diffVar ) repeat 
	  {
	      res := res + power*coefficient( a, diffVar, power )*accumulatedDiffVarGCDPR;
	      accumulatedDiffVarGCDPR := diffVarGCDPR * accumulatedDiffVarGCDPR;
	  }
	  res;
      }

      -----------------------------------    

      derivationFunction( idx: Integer ): % -> % == {
	  import from MachineInteger;
	  import from List CVARS;
	  import from Rep;
	  idx >= 0 and (machine idx) <= prev (#$CVARS) => 
	  ( 
	    local diffVar: CVARS := (minToMax$CVARS) . ( (machine idx) + (firstIndex$(List CVARS)));
	    ( a: % ): % +-> {  
		f : GCDPR := numerator rep a;
		g : GCDPR := denominator rep a;
		fprime : GCDPR := differentiate( f, diffVar );
		gprime : GCDPR := differentiate( g, diffVar );
		per ( fprime/g-f*gprime/(g*g) );
	    }
	  );
	  ( a: % ): % +-> {  
              0;
	  }
      }

      -----------------------------------    

#if PROVIDEGCD
      gcd( a: %, b: % ): % == {
          import from Rep;
	  local numA: GCDPR := numerator rep a;
	  local denA: GCDPR  := denominator rep a;
	  local numB: GCDPR  := numerator rep b;
	  local denB: GCDPR  := denominator rep b;
	  local num: GCDPR := gcd( numA * denB, numB * denA );
	  local den: GCDPR := (denA * denB );
	  per ( num / den  );
      }

      -----------------------------------    

      gcd( gen: Generator % ): % == {
	  local res := 0;
	  for elementGen in gen repeat 
	  {
	      res := gcd( res, elementGen );
	  }
	  res;
      }
#endif
      ----------------------------------

  }    

)
