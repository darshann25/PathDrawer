//
//  Point.swift
//  Geometry
//
//  Created by URMISH M BHATT on 10/10/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation
import UIKit

class Point{
    
    private var x = 0.00;
    private var y = 0.00;
    
    init(x: Double,y: Double){
        
        self.x=x;
        self.y=y;
        
    }
    
    func toArray()->Array<Any>{ //prototype conversion pending
        
        return [self.x,self.y];
        
    }
    
    func fromArray(a: Array<Double>)-> Point{
        
        return Point(x: Double(a[0]), y: Double(a[1]));
        
    }
    
    func translate (xDist: Double,yDist: Double)-> Point {    //prototype conversion pending
        
        return Point(x: self.x + xDist, y: self.y + yDist);
        
    }
    
    func getX() -> Double {
        return self.x
    }
    
    func getY() -> Double {
        return self.y
    }
    func setX(val : Double) {
        self.x = val
    }
    func setY(val : Double) {
        self.y = val
    }
    
}

func convertFromCGPoint(point : CGPoint) -> Point {
    
    return Point(x : Double(point.x), y : Double(point.y));
    
}

func convertToCGPoint(point : Point) -> CGPoint {
    
    return CGPoint(x: point.getX(), y: point.getY());
    
}

