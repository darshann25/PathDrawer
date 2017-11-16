//
//  Matrix.swift
//  Geometry
//
//  Created by URMISH M BHATT on 10/10/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation

class Matrix{

    var a : Double;
    var b : Double;
    var c : Double;
    var d : Double;
    var e : Double;
    var f : Double;

    init() {
        self.a = 0;
        self.b = 0;
        self.c = 0;
        self.d = 0;
        self.e = 0;
        self.f = 0;
    }


    init(a:Double,b:Double,c:Double,d:Double,e:Double,f:Double){
        self.a=a;
        self.b=b;
        self.c=c;
        self.d=d;
        self.e=e;
        self.f=f;
    }

    func copy()->Matrix{ //prototype conversion pending
        return Matrix(a: self.a, b: self.b,c: self.c,d: self.d,e: self.e,f: self.f);
    }


    func identityMatrix()->Matrix{
        return Matrix(a: 1,b: 0,c: 0,d: 1,e: 0,f: 0);
    }


    func scaleMatrix(scale:Double)->Matrix{
        return Matrix(a: scale, b: 0, c: 0, d: scale, e: 0, f: 0);
    }


    func translateMatrix(dx:Double,dy:Double)->Matrix{
        return Matrix(a: 1,b: 0,c: 0,d: 1,e: dx,f: dy);
    }

    func rotateMatrix(theta:Double)->Matrix{
        let cosVal = Double(cos(theta));
        let sinVal = Double(sin(theta));
        
        return Matrix(a: cosVal,b: sinVal,c: -sinVal,d: cosVal,e: 0,f: 0);
    }

    // type verification
    func times(that:Matrix)->Matrix{     //prototype conversion pending
        return Matrix(a: self.a*that.a+self.c*that.b,
        b: self.b*that.a+self.d*that.b,
        c: self.a*that.c+self.c*that.d,
        d: self.b*that.c+self.d*that.d,
        e: self.a*that.e+self.c*that.f+self.e,
        f: self.b*that.e+self.d*that.f+self.f);
    }

    // type verification
    func timesPoint(point: Point) -> Point{     //prototype conversion pending
        // pending connection to point class
        return Point(x: self.a * point.x + self.c * point.y + self.e,
        y: self.b * point.x + self.d * point.y + self.f);
    }

    func det()->Double{     //prototype conversion pending
        return self.a*self.d - self.b*self.c;
    }

    func inverse()-> Matrix{ //prototype conversion pending
        let det = Double(self.det());

        return Matrix (a: Double(self.d)/Double(det),
        b: Double(-self.b) / Double(det),
        c: Double(-self.c) / Double(det),
        d: Double(self.a) / Double(det),
        e: Double((self.c * self.f - self.d * self.e)) / Double(det),
        f: Double((self.b * self.e - self.a * self.f)) / Double(det) );
    }


    func toArray()-> Array<Double>{   //prototype conversion pending
        return [self.a, self.b, self.c, self.d, self.e, self.f];
    }

    func fromArray(a:[Int])-> Matrix{
        return Matrix (a: Double(a[0]), b: Double(a[1]), c: Double(a[2]), d: Double(a[3]), e: Double(a[4]), f: Double((a[5])));
    }

}


