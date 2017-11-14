//
//  PointBuffer.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class PointBuffer {
    
    private var points : [Point]
    public var xs : [Double]
    public var ys : [Double]
    
    init(pointsArray : [Point]) {
        self.points = pointsArray
        
        for i in 0...pointsArray.count {
            xs[i] = pointsArray[i].x
            ys[i] = pointsArray[i].y
        }
        
    }
    
    // returns the point at parameter s (using linear interpolation if s is not an integer)
    func getPoint(s : Double) -> Point {
        
        let fl_s = floor(s)
        let lambda = s - fl_s
        let x = (1 - lambda) * self.points[fl_s].x + lambda * self.points[fl_s + 1].x
        let y = (1 - lambda) * self.points[fl_s].y + lambda * self.points[fl_s + 1].y
        let pt = Point(x : x, y : y)
        
        return pt
    }
    
    func toArray() {
        return self.points;
    }
    
    func fromArray() {
        // TODO
    }

}
