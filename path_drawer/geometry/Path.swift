//
//  Path.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class Path {
    
    static let nullPath : Path = NullPath()
    
    public var pointBuffer : PointBuffer
    public var s0 : Int
    public var s1 : Int
    public var cubicData : Any
    public var nextPath : Path
    
    
    init(buffer: PointBuffer, s0: Int, s1: Int, nextPath : Path? = nil) {
        // assuming s0 < s1
        self.pointBuffer = buffer
        self.s0 = s0
        self.s1 = s1
        
        if (s0 >= s1) {
            // This shouldn't happen, but let's react appropriately if it does
            NSLog("Path constructor called with s0 >= s1");
            // The most appropriate behavior is for the path item simply not to exist
            // But I don't think this is implemented yet.
        }
        
        if (s0 < 0) {
            // Also, this shouldn't happen.
            // clamp to zero instead
            NSLog("Path constructor called with s0 < 0; setting to 0")
            self.s0 = 0
        } else {
            self.s0 = s0
        }
        if (s1 > pointBuffer.xs.count - 1) {
            // End index is erroneously high; set to length - 1
            NSLog("Path constructor called with s1 > length - 1; setting to length - 1")
            self.s1 = pointBuffer.xs.count - 1
        } else {
            self.s1 = s1
        }
        
        self.nextPath = Path.nullPath
        self.cubicData = NSNull()
        
    }
    
    // returns a new path tracing the rectangle counterclockwise (unless clockwise===true)
    func fromRect(rect : Rect, clockwise : Bool = false) {
        // TODO
    }
    
    // TODO: Error Handling
    // returns the point at parameter s using linear interpolation
    func getPoint(s : Int) -> Point {
        
        // clamp s to be at least the minimum index value
        // s = Math.max(self.s0, s);
        if (s < self.s0) {
        
            NSLog("Path parameter out of range")
            //throw 'Path parameter out of range';
        
        }
        if (self.nextPath === Path.nullPath) {
            
            // there's not another path, so clamp s to be at most the maximum value
            // s = Math.min(self.s1, s);
            if (self.s1 < s) {
                NSLog("Path parameter out of range")
                //throw 'Path parameter out of range';
            }
            
        } else if (s > self.s1) {
            
            // the parameter is beyond this path's (s0, s1) range, so go to the next path
            return self.nextPath.getPoint(s : s - self.s1 + self.nextPath.s0);
        
        }
        return self.pointBuffer.getPoint(s : Double(s));
    }
    
    // returns a new Path starting with this Path and continuing with the given path
    // assumes this Path's last point is the starting point for path
    func join(path : Path) {
        // TODO
    }
    
    
    /*
     
     
     
     
     // returns a new Path, which is a subpath of this Path from parameter s0 to s1.
     Path.prototype.subPath = function(s0, s1) {
     // TODO
     };
     
     // returns a new Path starting with this Path and continuing with the given path
     // assumes this Path's last point is the starting point for path
     Path.prototype.join = function(path) {
     // TODO
     };
     
     // traces out the path using linear data
     Path.prototype.traceLinear = function(ctx) {
     var points = this.pointBuffer.points;
     ctx.moveTo(points[0].x, points[0].y);
     for (var i = 1; i < points.length; i++) {
     ctx.lineTo(points[i].x, points[i].y);
     }
     };
     
     // traces out the path using cubic data (does not support joined paths)
     Path.prototype.traceCubic = function(ctx) {
     if (!this.cubicData) {
     var err = 2.5;
     this.cubicData = linearToCubic.linearToCubic(this.pointBuffer.xs, this.pointBuffer.ys, err);
     }
     var points = this.pointBuffer.points;
     ctx.moveTo(points[0].x, points[0].y);
     if (points.length <= 2) {
     for (var i = 1; i < points.length; i++) {
     ctx.lineTo(points[i].x, points[i].y);
     }
     }
     for (var i = 0; i < this.cubicData.length; i++) {
     var cd = this.cubicData[i];
     ctx.bezierCurveTo(cd[0], cd[1], cd[2], cd[3], cd[4], cd[5]);
     }
     };
     */
}

private class NullPath : Path {
    let emptyBuffer : PointBuffer = PointBuffer(pointsArray: [Point]())
    
    init() {
        super.init(buffer: emptyBuffer, s0: -1, s1: -1)
    }
    
}
