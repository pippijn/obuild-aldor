--* From BMT%WATSON.vnet.ibm.com@yktvmv.watson.ibm.com  Tue Oct 25 17:25:19 1994
--* Received: from yktvmv-ob.watson.ibm.com by watson.ibm.com (AIX 3.2/UCB 5.64/930311)
--*           id AA19275; Tue, 25 Oct 1994 17:25:19 -0400
--* Received: from watson.vnet.ibm.com by yktvmv.watson.ibm.com (IBM VM SMTP V2R3)
--*    with BSMTP id 5791; Tue, 25 Oct 94 17:25:17 EDT
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id <A.BMT.NOTE.VAGENT2.6527.Oct.25.17:25:15.-0400>
--*           for asbugs@watson; Tue, 25 Oct 94 17:25:16 -0400
--* Received: from YKTVMV by watson.vnet.ibm.com with "VAGENT.V1.0"
--*           id 6517; Tue, 25 Oct 1994 17:25:14 EDT
--* Received: from watson.ibm.com by yktvmv.watson.ibm.com
--*    (IBM VM SMTP V2R3) with TCP; Tue, 25 Oct 94 17:25:13 EDT
--* Received: by watson.ibm.com (AIX 3.2/UCB 5.64/900524)
--*           id AA26604; Tue, 25 Oct 1994 17:27:10 -0400
--* Date: Tue, 25 Oct 1994 17:27:10 -0400
--* From: bmt@watson.ibm.com
--* X-External-Networks: yes
--* Message-Id: <9410252127.AA26604@watson.ibm.com>
--* To: asbugs@watson.ibm.com
--* Subject: [3] gets export not found at runtime for domain using extend

--@ Fixed  by: <Who> <Date>
--@ Tested by: <Name of new or existing file in test directory>
--@ Summary:   <Description of real problem and the fix>


-- Command line: asharp -grun -lasdem mpolytest3.as
-- Version: 1.0.2
-- Original bug file name: mpolytest3.as

---
---
---         Extend di Polynomial.
---
---

#include "axllib"
#pile
#library DemoLib      	"asdem"

import from DemoLib

extend Polynomial(S: EuclideanDomain,Expon: OrderedAbelianGroup): with

	coefficients : %  -> List S
	mindeg  : %       -> Expon
	content : %       -> S
	norma : % 	     -> S

== add

  import from List S
  import from Partial %
  import from Integer

--- Estrae i coefficienti di un polinomio e li restituisce in una lista
  coefficients(u:%): List S ==
     zero? u => []
     cons(leadingCoefficient u, coefficients reductum u)

--- Determina il grado minimo
  mindeg(u:%): Expon ==
      zero? (dp:Expon:=degree u) => 0
      while ~zero? (u:= reductum u) repeat
            dp:= degree u
      dp

--- Calcola il content
  content(p:%): S == reduce(gcd,coefficients p,0)

--- Calcola la norma di un polinomio
  norma(m:%):S ==	
	reduce(+,map(eleva , coefficients m),0$S)

--- Eleva al quadrato un elemento di S
  eleva(s:S):S ==
	s*s


----------------------
+++
+++
+++ Routine generali per polinomi in piu variabili
+++
+++

import from String

Mpoly(LW:String,dim:SingleInteger):
      PolynomialCategory(Integer,HomogeneousDirectProduct (dim)) with
	coefficients : %  -> List Integer
	mindeg  : %       -> HomogeneousDirectProduct(dim)
	content : %       -> Integer
	norma : % 	     -> Integer
 	mapply : (%,List Integer) -> Integer
	mulapply : (%,List Integer,List Boolean) -> %

==  Polynomial(Integer,HomogeneousDirectProduct(dim)) add

	B ==> Boolean
	INT ==> Integer
	SI  ==> SingleInteger
	import from B
	import from INT
	import from SI
	HDPLW ==> HomogeneousDirectProduct (dim)
	import from HDPLW

	mapply(u:%,l:List INT): INT ==
	        du:=degree u
                zero? du => leadingCoefficient u
	        lu:=leadingCoefficient u
                lu*valutamonomial(du,l)+mapply(reductum u,l)

 	valutamonomial(du:HDPLW,l:List INT):INT ==
 		ris:INT:=1
		for i:SI in 1..(dim ) repeat
			ll:=(first l)::SI
			ris:=ris* (ll ^ du.i)::INT
			l:= rest l
		ris

	mulapply(u:%,l:List INT,var:List B) : % ==
	        du:=degree u
                zero? du => monomial(leadingCoefficient u,0$HDPLW)
	        lu:INT:=leadingCoefficient u
	        lu*mulvalutamonomial(du,l,var)+mulapply(reductum u,l,var)

---- manca moltiplicazione SI * unitVector
---  come posso definire un nuovo tipo di mpoly?
 	mulvalutamonomial(du:HDPLW,l:List INT,var:List B) : % ==
 		ris:INT:=1
		lu:HDPLW:=0
		for i:SI in 1..(dim ) repeat
			ll:=(first l)::SI
			if var.i then
				ris:=ris*(ll ^ du.i)::INT
			else
				l:SI:=du.i
				d:HDPLW:=0
				while ~zero? l repeat
					d:=d+unitVector(i)
					l:SI:=l-1
				lu:=lu+d
			l:= rest l
		monomial(ris,lu)



------
+++
+++
+++ Routine generali per polinomi in piu variabili
+++
+++

import from SingleInteger

LW ==> "xyz"
poly ==> Mpoly(LW,3)
import from poly

HDP ==> HomogeneousDirectProduct (3)
import from HDP

v1:HDP := vector (1,0,0)
x:poly:= monomial(1,v1)
y:poly:= monomial(1,(vector (0,1,0))$HDP)
v:poly:= monomial(1,(vector (0,0,1))$HDP)

z:poly:= x^3*y^3*v^3 + x^2*y^2*v^2 + x^1*y^1*v^1 +30*x^0

print << z << newline

l: List Integer := [3,2,3]
print << l << newline

print << mapply(z,l) << newline

lB: List Boolean := [true,false,false]
print << mulapply(z,l,lB) << newline

print << coefficients z << newline



----
