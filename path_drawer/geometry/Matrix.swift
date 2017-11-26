//
//  Matrix.swift
//  Geometry
//
//  Created by URMISH M BHATT on 10/10/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation

//////////////////
// Matrix class //
//////////////////

/* Using the same convention as in the canvas, the matrix is defined as
 *
 *     / a c e \
 *     | b d f |
 *     \ 0 0 1 /
 */

/*
 Represents an affine linear transformation of the two dimensional plane as a 3x3 matrix with 6 parameters, a,b,c,d,e,f. The full matrix is [a c e; b d f; 0 0 1], that is the first, second and third row of this matrix, respectively, are [a c e], [b d f] and [0 0 1]. Every linear transformation of the plane can be represented as a 2x2 matrix [a c; b d], and the two parameters e,f correspond to an affine shifts of the x and y coordinates, respectively.
 @summary Represents an affine linear transformation of the two dimensional plane as a 3x3 matrix with 6 parameters, [a c e; b d f; 0 0 1].
 @constructor
 @param {Number} a Entry (1,1) in the matrix.
 @param {Number} b Entry (1,2) in the matrix.
 @param {Number} c Entry (2,1) in the matrix.
 @param {Number} d Entry (2,2) in the matrix.
 @param {Number} e Entry (3,1) in the matrix.
 @param {Number} f Entry (3,2) in the matrix.
 
 */

class Matrix{

    var a : Double
    var b : Double
    var c : Double
    var d : Double
    var e : Double
    var f : Double

    init() {
        self.a = 0
        self.b = 0
        self.c = 0
        self.d = 0
        self.e = 0
        self.f = 0
    }


    init(a : Double, b : Double, c : Double, d : Double, e : Double, f : Double){
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.e = e
        self.f = f
    }

    /*
     Returns the identity matrix, that is the affine linear transformation which leaves all points fixed.
     @return {Matrix} The identity matrix.
     */
    func identityMatrix() -> Matrix{
        return Matrix(a: 1,b: 0,c: 0,d: 1,e: 0,f: 0)
    }

    /*
     Returns a scaling matrix. When applied, this matrix takes every point (x,y) to the point (x*scale,y*scale). Note that if the scaling parameter is negative, this is both a scaling of the magnitude of each vector, as well as a reflection.
     @param {Number} scale The scaling parameter.
     @return {Matrix} The scaling matrix.
     */
    func scaleMatrix(scale : Double)-> Matrix {
        return Matrix(a: scale, b: 0, c: 0, d: scale, e: 0, f: 0)
    }


    /*
     Returns a translation matrix. When applied, this takes every point (x,y) to (x+dx,y+dy).
     @param {Number} dx The translation in the x direction.
     @param {Number} dy The translation in the y direction.
     @return {Matrix} The translation matrix.
     @example
     var A=new Matrix(a,b,c,d,e,f);
     var translation=Matrix.translate(1,0,0,1,dx,dy);
     composition=translation.times(A);
     //The composition matrix above, which corresponds to applying
     //a general linear transformation followed by a translation
     //will result in the matrix [a c e+dx; b d f+dy; 0 0 1].
     //That is, e is increased by dx and f is increased by dy.
     //Hence multiplying by the correct translation, we can change
     //e and f into any other values.
     */
    func translateMatrix(dx:Double,dy:Double)->Matrix{
        return Matrix(a: 1,b: 0,c: 0,d: 1,e: dx,f: dy)
    }

    /*
     Returns a rotation matrix that rotates by angle theta in the clockwise direction. Remember that since the y coordinate is flipped, a positive rotation will appear to be clockwise.
     @param {Number} theta The angle of rotation.
     @return {Matrix} The rotation matrix.
     */
    func rotateMatrix(theta:Double)->Matrix{
        let cosVal = Double(cos(theta))
        let sinVal = Double(sin(theta))
        
        return Matrix(a: cosVal,b: sinVal,c: -sinVal,d: cosVal,e: 0,f: 0)
    }

    /*
     Multiplies the inputed matrix on the left by this matrix. The result is this*that.
     @param {Matrix} that The inputed matrix.
     @return {Matrix} The matrix this*that.
     */
    func times(that:Matrix)->Matrix{
        return Matrix(a: self.a * that.a + self.c * that.b,
        b: self.b * that.a + self.d * that.b,
        c: self.a * that.c + self.c * that.d,
        d: self.b * that.c + self.d * that.d,
        e: self.a * that.e + self.c * that.f + self.e,
        f: self.b * that.e + self.d * that.f + self.f)
    }

    /*
     Returns the coordinates of a point after transformation by this matrix.
     @param {Point} point The point to be transformed.
     @return {Point} The resulting transformed point.
     */
    func timesPoint(point: Point) -> Point{
        // pending connection to point class
        return Point(x: self.a * point.x + self.c * point.y + self.e,
        y: self.b * point.x + self.d * point.y + self.f)
    }
    
    /*
     Returns a copy of this matrix.
     @return {Matrix} A copy of this matrix.
     */
    func copy() -> Matrix {
        return Matrix(a : self.a, b : self.b, c : self.c, d : self.d, e : self.e, f : self.f)
    }

    /*
     Calculates the determinant of the matrix.
     @return {Number} The determinant of the matrix.
     */
    func det()->Double{
        return self.a*self.d - self.b*self.c
    }

    /*
     Returns the inverse linear transformation corresponding to this matrix.
     @return {Matrix} The inverse matrix.
     */
    func inverse()-> Matrix{
        let det = Double(self.det());

        return Matrix (a: Double(self.d)/Double(det),
        b: Double(-self.b) / Double(det),
        c: Double(-self.c) / Double(det),
        d: Double(self.a) / Double(det),
        e: Double((self.c * self.f - self.d * self.e)) / Double(det),
        f: Double((self.b * self.e - self.a * self.f)) / Double(det) );
    }

    /*
     Returns a 1-dimensional array of length 6 containing the parameters of the matrix. In order, those 6 parameters are a,b,c,d,e,f.
     @return {Array} A 1-dimensional array of length 6 containing the parameters of the matrix.
     */
    func toArray()-> Array<Double>{   //prototype conversion pending
        return [self.a, self.b, self.c, self.d, self.e, self.f];
    }

    /*
     Returns a matrix with parameters given by the inputed array, where the first 6 elements of the array will become the parameters a,b,c,d,e,f, in that order, for the new matrix. This function will return an error if the length of the array is less than 6 or if any of the first 6 elements of the array are not non-negative numbers. If the array has length >6, this function will still run using the first 6 elements of the array, however this is not recommended.
     @summary Given an array of non-negative numbers, returns a matrix with parameters given by the first 6 elements of the array.
     @return {Matrix} The resulting matrix.
     */
    func fromArray(a:[Int])-> Matrix{
        return Matrix (a: Double(a[0]), b: Double(a[1]), c: Double(a[2]), d: Double(a[3]), e: Double(a[4]), f: Double((a[5])));
    }
    
    func fromArray(a : [Double]) -> Matrix {
        return Matrix(a : a[0], b : a[1], c : a[2], d : a[3], e : a[4], f : a[5]);
    }
}


