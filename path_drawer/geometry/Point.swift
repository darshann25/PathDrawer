//
//  Point.swift
//  Geometry
//
//  Created by URMISH M BHATT on 10/10/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

/////////////////
// Point Class //
/////////////////

/*
 Represents a point on the plane in cartesian coordinates. (Used eg. by {@link Rect} and Matrix classes.)
 @constructor
 @param {Number} x The x coordinate.
 @param {Number} y The y coordinate.
 */

import Foundation
import UIKit

class Point{
    
    var x : Double
    var y : Double
    
    init(x: Double, y: Double){
        
        self.x = x
        self.y = y
        
    }
    
    /*
     * Returns a 1-dimensional array of length 2 containing the x and y coordinates, in order,
     * of the point.
     * @returns a 1-dimensional array containing the point's x and y coordinates, in order.
     */
    func toArray() -> [Any] {
        
        return [self.x, self.y]
        
    }
    
    /*
     * Construct a point from a 1-dimensional array of length 2 with x and y coordinates, in order.
     * @return {Point} the resulting point
     */
    func fromArray(a: [Double]) -> Point{
        
        return Point(x: a[0], y: a[1])
        
    }
    
    /*
     * @param {number} xDist horizontal distance
     * @param {number} yDist vertical distance
     * @return {Point} the current point translated
     */
    func translate(xDist: Double,yDist: Double)-> Point {
        
        return Point(x : self.x + xDist, y : self.y + yDist)
        
    }
    
}

func convertFromCGPoint(point : CGPoint) -> Point {
    
    return Point(x : Double(point.x), y : Double(point.y));
    
}

func convertToCGPoint(point : Point) -> CGPoint {
    
    return CGPoint(x: point.x, y: point.y);
    
}

func convertFromCGPoint(points : [CGPoint]) -> [Point] {
    
    var pts = [Point]()
    for i in 0...(points.count - 1) {
        pts.append(convertFromCGPoint(point: points[i]))
    }
    return pts
    
}

func convertToCGPoint(points : [Point]) -> [CGPoint] {
    
    var cgpts = [CGPoint]()
    for i in 0...(points.count - 1) {
        cgpts.append(convertToCGPoint(point: points[i]))
    }
    return cgpts
    
}


