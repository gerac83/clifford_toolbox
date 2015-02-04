(* ::Package:: *)

(* 	Copyright (c) 2011, Aragon-Camarasa, G., Aragon-Gonzalez, G.; Aragon J. L. &
	Rodriguez-Andrade, M. A.
	All rights reserved.

	Redistribution and use in source and binary forms, with or without modification,
	are	permitted provided that the following conditions are met:

		1. Redistributions of source code must retain the above copyright notice,
		   this list of conditions and the following disclaimer.

		2. Redistributions in binary form must reproduce the above copyright notice,
		   this list of conditions and the following disclaimer in the documentation
		   and/or other materials provided with the distribution.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS "AS IS" AND ANY EXPRESS OR IMPLIED
	WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
	FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS
	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
	ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
	ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	The views and conclusions contained in the software and documentation are those of the
	authors and should not be interpreted as representing official policies, either expressed
	or implied, of the copyright holders.
*)



(* Set up the Package Context. *)

(* :Title: Clifford Algebra with Mathematica *)

(* :Summary:
       This file contains declarations for calculations with Clifford
       algebra of a n-dimensional vector space.  When loaded,
       vectors (and multivectors) must be given as linear combinations
       of a canonical (orthonormal basis) that are denoted by
       e[1],e[2],..,e[n].
     
       Examples:     The vector {1,2,0,-1} should be written as
                     e[1] + 2 e[2] - e[4].
                     
                     The multivector a + 5e1 + e123 is written as
                     a + 5 e[1] + e[1]e[2]e[3].
   
       With the exception of the function Dual[m,n], it is not
       neccesary to define the dimension of the vector space, it
       is calculated automatically by the function dimensions[ ].
       The signature of the bilinear form is set by 
       $SetSignature, sets the indices (p,q,s) of the bilinear
       form (s is the degeneracy index) if not specified, the 
       default value is {20,20,20} *)

(* :References: 
	1. D. Hestenes, 1987. New Foundations for Classical Mechanics. 
	   D. Reidel Publishing Co. Holland  
	2. S. Gull, A. Lasenby and C. Doran, 1993.
	   Imaginary Numbers are not Real- The Geometric Algebra of Spacetime.
	   Foundations of Physics, Vol. 23, No. 9: 1175-1201.
	3. T. Wickham-Jones, 1994. Mathematica Graphics: Techniques and Applications.
	   Springer-Verlag New York Inc.; Har/Dsk edition (Dec 1994). *)
	   

BeginPackage["cliffordv07`"]


(* Usage message for the exported function and the Context itself *)

Clifford::usage = "Clifford.m is a package to resolve operations with
Clifford Algebra."

e::usage = "e is used to denote the elements of the canonical basis of Euclidean vector
space where the Clifford Algebra is defined, so e[i] is used as i-th basis
element"

i::usage = "i represents the first component of a quaternion. i^2=-1"

j::usage = "j represents the second component of a quaternion. j^2=-1"

k::usage = "k represents the third component of a quaternion. k^2=-1"

ntuple::usage = "..."

dimensions::usage = "..."

GeometricProduct::usage = "GeometricProduct[m1,m2,...] calculates the Geometric
Product of multivectors m1,m2,..."

Coeff::usage = "Coeff[m,b] gives the coefficient of the r-blade b in the multivector m."

Grade::usage = "Grade[m,r] gives the r-vector part of the multivector m."

HomogeneousQ::usage = "HomogeneousQ[x,r] gives True if x is a r-blade and False
otherwise."

Turn::usage = "Turn[m] gives the Reverse of the multivector m."

Magnitude::usage = "Magnitude[m] calculates the Magnitude of the multivector m."

Dual::usage = "Dual[m,n] calculates the Dual of the multivector m in a
n-dimensional space."

Dualize::usage = "Similar to Dual but for a nondegenerate metric"

InnerProduct::usage = "InnerProduct[m1,m2,...] calculates the Inner Product of
multivectors m1,m2,..."

OuterProduct::usage = "OuterProduct[m1,m2,...] calculates the Outer Product of
multivectors m1,m2,..."

GARotation::usage = "GARotation[v,w,x,theta] Rotates the vector v by an angle theta
(in degrees), along the plane defined by w and x. The sense of the rotation
is from w to x. Default value of theta is the  angle between w and x."

MultivectorInverse::usage = "MultivectorInverse[m] gives the inverse of a
multivector m."

GAReflection::usage = "GAReflection[v,w,x] reflects the vector v by the plane
formed by the vectors w and x."

GAProjection::usage = "GAProjection[v,w] calculate the projection of the vector v
on the subspace defined by the r-blade w."

GARejection::usage = "GARejection[v,w] calculate the rejection of the vector v on
the subspace defined by the r-blade w."

RegressiveProduct::usage = "RegressiveProduct[v,w] calculate the dual outer product
of v and w. If OuterProduct is meet, then this is join."

ToBasis::usage = "ToBasis[x] Transform the vector x from {a,b,...} to the
standard form used in this Package: a*e[1]+b*e[2]+...."

ToVector::usage ="ToVector[x,n] transform the n-dimensional vector x from
a*e[1]+b*e[2]+... to the standard Mathematica form {a,b,...}. The defaul value of
n is the highest of all e[i]'s."

ToVectorBase::usage = "..."

PointToBasis::usage "PointToBasis[vec] converts a homogenous point into the geometric algebra;
similar to ToBasis."

PlaneToBasis::usage "Same as ToBasis."

PointFromBasis::usage "PointFromBasis[x, n] converts the Clifford Algebra element x (a point)
of dimension n to the standard Mathematica form {a,b,...}."

PlaneFromBasis::usage "Same as ToVector."

QuaternionProduct::usage = "QuaternionProduct[q1,q2,...] gives the product of
quaternions q1,q2,..."

QuaternionInverse::usage = "QuaternionInverse[q] finds the inverse of a
quaternion q."

QuaternionMagnitude::usage = "QuaternionMagnitude[q] gives the magnitude of
a quaternion q."

QuaternionConjugate::usage = "QuaternionConjugate[q] gives the conjugated of a
quaternion q."

Pseudoscalar::usage = "Pseudoscalar[n] gives the n-dimensional pseudoscalar."

GeometricPower::usage = "GeometricPower[m,n] calculates the Geometic Product of
a multivector m, n-times."

GeometricProductSeries::usage = "GeometricProductSeries[sym,m,n] calculates the
series of the function sym, of a multivector m up to a power n. Default value of n is 10."

GeometricExp::usage = "GeometricExp[m,n] calculates the series of the function
Exp, of a multivector m up to a power n. Default value of n is 10."

GeometricSin::usage = "GeometricSin[m,n] calculates the series of the function
Sin, of a multivector m up to a power n. Default value of n is 10."

GeometricCos::usage = "GeometricCos[m,n] calculates the series of the function
Cos, of a multivector m up to a power n. Default value of n is 10."

GeometricTan::usage = "GeometricTan[m,n] calculates the series of the function
Tan, of a multivector m up to a power n. Default value of n is 10."

$SetSignature::usage = "$SetSignature sets the indices (p,q,s) of the bilinear form
used to define the Clifford Algebra (s is the index of degeneracy). Thus it is assumed
that for i>p+q+s we have GeometricProduct[e[i],e[i]]=0.
The default value is {20,0}. Once changed, it can be recovered by Clear[$SetSignature];."

$SetEpsilon::usage = "$SetEpsilon sets the machine working precision to be used for numerical
computations. The default value is 10^-14. Once changed, it can be recovered by Clear[$SetEpsilon];."

GADraw::usage = "GADraw function plots vectors, bi-vectors and trivectors in the canonical
basis of Clifford Algebra. To change the view of the plot, it must be
used the ViewPoint function, e.g. Draw[x,ViewPoint->{0,1,0}]. Default
value of ViewPoint is {1.3,-2.4,2}";


(* Set the indices (p,q,s) of the bilinear form *)
$SetSignature = {20,0,0}
$SetEpsilon = 10^-14

Begin["`Private`"]  (* Begin the Private Context *)

(* Unprotect functions Re, Im and Clear to define our rules *)
protected = Unprotect [Re, Im, Clear]


(* Error Messages *)
Clifford::messagevectors = "`1` function works only with vectors."
Clifford::messagedim = "Function works in three dimensions."
DrawBiVec::"Out of Dimension" = "Dimension must be less or equal to 3 dimension.";


(* Clear function *)
Clear[$SetSignature] := $SetSignature = {20,0,0}
Clear[$SetEpsilon] := $SetEpsilon = $MachineEpsilon

 
(* Output mimics standard mathematical notation *)
Format[e[x_]] := SubscriptBox[e, x] //DisplayForm


(* Begin Geometric Product Section *)
GeometricProduct[ _] := $Failed
GeometricProduct[x_, y_, z__] := Fold[GeometricProduct, x, {y, z}] // Simplify
GeometricProduct[x_ , y_ ] := Chop[Simplify[geoprod[Expand[x],Expand[y]]],$SetEpsilon] // Expand
geoprod[x_,y_] := Module[{
   nx = ntuple[Expand[x], Max[dimensions[Expand[x]], dimensions[Expand[y]]]], 
   ny = ntuple[Expand[y], Max[dimensions[Expand[x]], dimensions[Expand[y]]]], gp},
   gp = (Times @@ e /@ Flatten[Position[nx + ny, 1]]) * Apply[Times, Apply[bilinearform, Map[{e[#], e[#]} &, Flatten[Position[nx + ny, 2]]], {1}]];
   Return[gp*(-1)^Sum[ny[[m]]*nx[[n]], {m, Length[nx] - 1}, {n, m + 1, Length[ny]}]]]
geoprod[a_ x_,y_] := a geoprod[x,y] /; FreeQ[a,e[_?Positive]]
geoprod[x_,a_ y_] := a geoprod[x,y] /; FreeQ[a,e[_?Positive]]
geoprod[x_, y_] := x y /; (FreeQ[x, e[_?Positive]] || FreeQ[y, e[_?Positive]])
geoprod[x_,y_Plus] := Distribute[f[x,y],Plus] /. f->GeometricProduct
geoprod[x_Plus,y_] := Distribute[f[x,y],Plus] /. f->GeometricProduct
(* End of Geometric Product Section *)
 
 
(* Begin Grade Section *)
Grade[m_Plus,r_?NumberQ] := Distribute[tmp[m,r],Plus] /. tmp->Grade
Grade[m_,r_?NumberQ] := If[gradeAux[m]===r,m,0] (*Here was the bug. Before If[grados[m]==r,m,0]*)
gradeAux[a_] := 0 /; FreeQ[a,e[_?Positive]]
gradeAux[x_] := gradeAux[x] = Plus @@ ntuple[x,Max[dimensions[x]]]
gradeAux[a_ x_] := gradeAux[x] /; FreeQ[a,e[_?Positive]]
(* End of Grade Section *)


(* Begin Inner Product Section *)
InnerProduct[ _] := $Failed
InnerProduct[m1_,m2_,m3__] := tmp[InnerProduct[m1,m2],m3] /. tmp->InnerProduct
InnerProduct[m1_,m2_] := Chop[innprod[Expand[m1],Expand[m2]],$SetEpsilon] // Expand
innprod[a_,y_] := 0 /; FreeQ[a,e[_?Positive]]
innprod[x_,a_] := 0 /; FreeQ[a,e[_?Positive]]
innprod[x_,y_] := innprod[x,y] = Module[
      {p=Plus @@ ntuple[x,Max[dimensions[x],dimensions[y]]],
  q=Plus @@ ntuple[y,Max[dimensions[x],dimensions[y]]]},
  Grade[GeometricProduct[x,y],Abs[p-q]] ]
innprod[a_ x_,y_] := a innprod[x,y] /; FreeQ[a,e[_?Positive]]
innprod[x_,a_ y_] := a innprod[x,y] /; FreeQ[a,e[_?Positive]]
innprod[x_,y_Plus] := Distribute[tmp[x,y],Plus] /. tmp->innprod
innprod[x_Plus,y_] := Distribute[tmp[x,y],Plus] /. tmp->innprod
(* End of Inner Product Section *)


(* Begin Outer Product Section *)
OuterProduct[ _] := $Failed
OuterProduct[m1_,m2_,m3__] := tmp[OuterProduct[m1,m2],m3] /. tmp->OuterProduct
OuterProduct[m1_,m2_] := Chop[outprod[Expand[m1],Expand[m2]],$SetEpsilon] // Expand
outprod[a_,y_] := a y /; FreeQ[a,e[_?Positive]]
outprod[x_,a_] := a x /; FreeQ[a,e[_?Positive]]
outprod[x_,y_] := outprod[x,y] = Module[
      {p=Plus @@ ntuple[x,Max[dimensions[x],dimensions[y]]],
  q=Plus @@ ntuple[y,Max[dimensions[x],dimensions[y]]]},
  Grade[GeometricProduct[x,y],p+q] ]
outprod[a_ x_,y_] := a outprod[x,y] /; FreeQ[a,e[_?Positive]]
outprod[x_,a_ y_] := a outprod[x,y] /; FreeQ[a,e[_?Positive]]
outprod[x_,y_Plus] := Distribute[tmp[x,y],Plus] /. tmp->outprod
outprod[x_Plus,y_] := Distribute[tmp[x,y],Plus] /. tmp->outprod
(* End of Outer Product Section *)


(* Begin Turn Section *)
Turn[m_] := backside[Expand[m]]
backside[a_] := a /; FreeQ[a,e[_?Positive]]
backside[x_] := x /; Length[x]==1
backside[x_] := bakside[x] = GeometricProduct @@ e/@Reverse[dimensions[x]]
backside[a_ x_] := a backside[x] /; FreeQ[a,e[_?Positive]]
backside[x_Plus] := Distribute[tmp[x],Plus] /. tmp->backside
(* End of Turn Section *)


(* Pseudoscalar function *)
Pseudoscalar[x_?Positive] := Apply[Times, e /@ Range[x]]


(* HomogeneousQ function *)
HomogeneousQ[x_,r_?NumberQ] := SameQ[Expand[x],Expand[Grade[x,r]]]


(*  Magnitude function *)
Magnitude[v_] := Sqrt[Grade[GeometricProduct[v,Turn[v]],0]]


(* Dual function *)
Dual[v_,x_?Positive] := GeometricProduct[v,Turn[Pseudoscalar[x]]]

(* Dualize function.  Author: Charles Gunn, 2011 *) 
Dualize[v_,x_?Positive] := Block[{$SetSignature = {x,0,0}}, Dual[v, x]]

(* Function provided by Charles Gunn; leave it for reference
(* Polarize function *) 
Polarize[v_,x_?Positive] :=  GeometricProduct[v,Turn[Pseudoscalar[x]]] 
Dual[v_,x_?Positive] :=  Polarize[v,x] *)


(* Begin GARotation function *)
GARotation[v_,w_,x_,angle_:Automatic] := garotation[Expand[v],Expand[w],Expand[x],angle]
garotation[v_,w_,x_,angle_:Automatic] := Module[{r,theta=angle*Pi/180,
       plano=OuterProduct[w,x]},
       If[(!HomogeneousQ[v,1]) || (!HomogeneousQ[w,1]) || (!HomogeneousQ[x,1]),
           Message[Clifford::messagevectors,GARotation]; $Failed,
    If[angle === Automatic,
            theta=InnerProduct[w,x]/(Magnitude[w]*Magnitude[x]);
              r=Sqrt[(1+theta)/2]+Sqrt[(1-theta)/2]*plano/Magnitude[plano],
              r=Cos[theta/2]+Sin[theta/2]*plano/Magnitude[plano]];
    GeometricProduct[Turn[r],v,r]  ] ]
(* End of GARotation *)


(* Begin MultivectorInverse function *)
MultivectorInverse[v_] := Module[{v1=GeometricProduct[v,Turn[v]]},
             If[v1 === Grade[v1,0],
                Chop[Turn[v] / Magnitude[v]^2,$SetEpsilon],
                Return[ StringForm["MultivectorInverse[``]", InputForm[v] ] ]
               ]
         ]
(* End of MultivectorInverse *)


(* PointToBasis function. Author: Charles Gunn, 2011 *)
PointToBasis[vec_] := Dualize[ToBasis[vec], Length[vec]]


(* Update: 03/2011 version 0.7 *)
(* PointFromBasis function. Author: Charles Gunn, 2011 *)
PointFromBasis[x_, n_] := ToVector[Dualize[x,n], n]


(* GAProjection function *)
GAProjection[v_,w_] := GeometricProduct[InnerProduct[v,w],MultivectorInverse[w]]


(* Begin GAReflection function *)
GAReflection[v_,w_,x_] := Module[{u,plane=OuterProduct[w,x]},
      If[(!HomogeneousQ[v,1]) || (!HomogeneousQ[w,1]) || (!HomogeneousQ[x,1]),
           Message[Clifford::messagevectors,GAReflection]; $Failed,
          u=Dual[plane/Magnitude[plane],3];
		  (* Added by Charles Gunn, not used but left it JIC: 
		   u=Polarize[plano/Magnitude[plano],3]; *)
       GeometricProduct[-u,v,u] ] ]
(* End of GAReflection *)

(* RegressiveProduct function. Author: Charles Gunn, 2011 *)
RegressiveProduct[v_, w_] := RegressiveProduct[v, w, Total[$SetSignature]]
RegressiveProduct[v_, w_, x_?Positive] := Dualize[OuterProduct[Dualize[v, x], Dualize[w, x]], x]


(* GARejection function *)
GARejection[v_,w_] := GeometricProduct[OuterProduct[v,w],MultivectorInverse[w]]


(* Begin ToBasis function *)
ToBasis[x_?VectorQ] := Chop[Dot[x, List @@ e /@ Range[Length[x]]],$SetEpsilon]
(* PlaneToBasis function. Author: Charles Gunn, 2011 *)
(* PlaneToBasis[vec_] := ToBasis[vec] *)
(* End of ToBasis *)


(* Begin  ToVector funtion *)
ToVector[x_,d_:Automatic] := Module[{dim=d,aux,v=Expand[x]},
   If[HomogeneousQ[v,1],
           aux=Flatten[dimensions[v]];
             If[d === Automatic, dim=Max[aux]];
              Table[ Coefficient[v, e[k]], {k,dim}],
     Message[Clifford::messagevectors,ToVector]; $Failed ] ]
(* Update: 03/2011 version 0.7 *)
(* PlaneFromBasis function. Author: Charles Gunn, 2011 *)
(* PlaneFromBasis[x_, n_] := ToVector[x,n] *)
(* End of ToVector *)

(* Begin ToVectorBase function *)
(* Update: 03/2011 version 0.7*)
ToVectorBase[x_, W_: List] := If[(GeometricProduct @@ W - OuterProduct @@ W) == 0,
	Table[InnerProduct[x, W[[i]]]/GeometricProduct[W[[i]], W[[i]]], {i, Length[W]}],
	Print["The defined base is non-orthogonal"]]
(* End of ToVector *)


(* Coeff function *)
Coeff[x_,y_] := Grade[Coefficient[Expand[x],y],0]


(* Re function *)
Re[m_] := Grade[transform[Expand[m]],0]


(* Im function *)
Im[x_] := {Coefficient[x,i], Coefficient[x,j], Coefficient[x,k]}


(* Begin QuaternionProduct function *)
QuaternionProduct[ _] := $Failed
QuaternionProduct[q1_,q2_,q3__] := QuaternionProduct[QuaternionProduct[q1,q2],q3]
QuaternionProduct[q1_,q2_] := untransform[
                  GeometricProduct[transform[q1],transform[q2]] ]
(* End of QuaternionProduct *)


(* QuaternionInverse function *)
QuaternionInverse[q_] := untransform[MultivectorInverse[transform[Expand[q]]]]


(* QuaternionMagnitude function *)
QuaternionMagnitude[q_] := untransform[Magnitude[transform[Expand[q]]]]


(* QuaternionConjugate function *)
QuaternionConjugate[q_] := untransform[Turn[transform[Expand[q]]]]


(* Begin Geometric Power Section *)
GeometricPower[m_,n_Integer] := MultivectorInverse[GeometricPower[m,-n]] /; n < 0
GeometricPower[m_,0] := 1
GeometricPower[m_,n_Integer] := GeometricProduct[GeometricPower[m,n-1],m] /; n >= 1
(* End of Geometric Power *)


(* Geometric Exp function *)
GeometricExp[m_,n_:10] := GeometricProductSeries[Exp,m,n]


(* Geometric Sin function *)
GeometricSin[m_,n_:10] := GeometricProductSeries[Sin,m,n]


(* Geometric Cos function *)
GeometricCos[m_,n_:10] := GeometricProductSeries[Cos,m,n]


(* Geometric Tan function *)
GeometricTan[m_,n_:10] := GeometricProductSeries[Tan,m,n]


(* Begin Geometric Product Series function *)
GeometricProductSeries[sym_Symbol,m_,n_:10] := Module[
               {s=Series[sym[x],{x,0,n}],res=0,a=1},
           Do[If[i != 0, a=GeometricProduct[a,m]];
            res += Coefficient[s,x,i]*a, {i,0,n}];
               res     ] /; IntegerQ[n] && Positive[n]
(* End of Geometric Product Series *)


(* Begin bilinearform Section *)
bilinearform[e[i_],e[i_]] := 1 /; i <= $SetSignature[[1]]
bilinearform[e[i_],e[i_]] := -1 /; (i > $SetSignature[[1]]) && (i <= $SetSignature[[1]] + $SetSignature[[2]])
bilinearform[e[i_],e[i_]] := 0  /; i > $SetSignature[[1]] +  $SetSignature[[2]] + $SetSignature[[3]]

(* Same as Charles Gunn implementation*)
(*bilinearform[e[i_],e[i_]] := 0  /; (i <= $SetSignature[[1]] +  $SetSignature[[2]] + $SetSignature[[3]])*)

(* Begin dimensions Section *)
(*dimensions[x_] := dimensions[x] = List @@ x /. e[k_?Positive] -> k
dimensions[x_Plus] := dimensions /@ List @@ x 
dimensions[a_] := {0} /; FreeQ[a,e[_?Positive]]
dimensions[a_ x_] := dimensions[x] /; FreeQ[a,e[_?Positive]]*)

dimensions[x_] := List @@ x /. e[k_?Positive] -> k
dimensions[x_Plus] := dimensions /@ List @@ x 
dimensions[a_] := {0} /; FreeQ[a,e[_?Positive]]
dimensions[a_ x_] := dimensions[x] /; FreeQ[a,e[_?Positive]]
(* End of dimensions Section *)


(* Begin ntuple function *)
(* ntuple[x_,dim_] := ntuple[x,dim] = ReplacePart[ Table[0,{dim}], 1, List @@ x /.
                                     e[k_?Positive] -> {k}]
									 *)
ntuple[x_,dim_] := ReplacePart[ Table[0,{dim}], 1, List @@ x /.
                                     e[k_?Positive] -> {k}]
(* End of ntuple *)


(* transform function *)
transform[x_] := x //. {i -> -e[2]e[3], j -> e[1]e[3], k -> -e[1]e[2]}


(* untransform function *)
untransform[x_] := x //. {e[2]e[3] -> -i, e[1]e[3] -> j, e[1]e[2] -> -k}


Protect[Evaluate[protected]]   (* Restore protection of the functions *)


End[]  (* End the Private Context *)


(* Protect exported symbols *)

Protect[ GeometricProduct, Grade, Turn, Magnitude, Dual, InnerProduct,
         OuterProduct, GARotation, MultivectorInverse, GAReflection, HomogeneousQ,
         GAProjection, GARejection, ToBasis, ToVector, QuaternionProduct,
         QuaternionInverse, QuaternionMagnitude, QuaternionConjugate,
         GeometricPower, GeometricProductSeries, GeometricExp, GeometricSin,
         GeometricCos, GeometricTan, Pseudoscalar, e, i, j, k, Coeff, GADraw,
         ToVectorBase, PointToBasis, PointFromBasis, RegressiveProduct, Dualize, ntuple,dimensions]


EndPackage[]  (* End the Package Context *)
