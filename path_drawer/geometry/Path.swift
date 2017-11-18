//
//  Path.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/15/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class Path {
    
    // Empty Paths are set to this NullPath instance
    public static var nullPath : Path = NullPath()
    
    public var pointBuffer : PointBuffer
    public var s0 : Int
    public var s1 : Int
    public var cubicData : Any
    public var nextPath : Any
    
    
    init(buffer: PointBuffer, s0: Int, s1: Int, nextPath : Path? = nil) {
        // assuming s0 < s1
        self.pointBuffer = buffer
        self.s0 = s0
        self.s1 = s1
        
        if (self.s0 >= self.s1) {
            // This shouldn't happen, but let's react appropriately if it does
            NSLog("Path constructor called with s0 >= s1");
            // The most appropriate behavior is for the path item simply not to exist
            // But I don't think this is implemented yet.
        }
        
        if (self.s0 < 0) {
            // Also, this shouldn't happen.
            // clamp to zero instead
            NSLog("Path constructor called with s0 < 0; setting to 0")
            self.s0 = 0
        } else {
            self.s0 = s0
        }
        if (self.s1 > pointBuffer.xs.count - 1) {
            // End index is erroneously high; set to length - 1
            NSLog("Path constructor called with s1 > length - 1; setting to length - 1")
            self.s1 = pointBuffer.xs.count - 1
        } else {
            self.s1 = s1
        }
        
        if(buffer.xs.count == 0) {
            // ONLY CALLED WHEN NULLPATH IS INITIALIZED
            self.nextPath = NSNull()
        } else {
            self.nextPath = Path.nullPath
        }
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
        if ((self.nextPath as! Path) === Path.nullPath) {
            
            // there's not another path, so clamp s to be at most the maximum value
            // s = Math.min(self.s1, s);
            if (self.s1 < s) {
                NSLog("Path parameter out of range")
                //throw 'Path parameter out of range';
            }
            
        } else if (s > self.s1) {
            
            // the parameter is beyond this path's (s0, s1) range, so go to the next path
            return (self.nextPath as! Path).getPoint(s : s - self.s1 + (self.nextPath as! Path).s0);
        
        }
        return self.pointBuffer.getPoint(s : Double(s));
    }
    
    // returns a new Path starting with this Path and continuing with the given path
    // assumes this Path's last point is the starting point for path
    func join(path : Path) {
        // TODO
    }
    
    // returns a new Path, which is a subpath of this Path from parameter s0 to s1.
    func subPath(s0 : Int, s1 : Int) {
        // TODO
    }
    
    // traces out the path using linear data
    func traceLinear(ctx : CGContext) {
        let points = convertToCGPoint(points : self.pointBuffer.toArray());
        ctx.addLines(between: points)
    };
    
    // traces out the path using cubic data (does not support joined paths)
    func traceCubic(ctx : CGContext) {
        if (self.cubicData != nil) {
            var err = 2.5;
            // TODO : LinearToCubic in Items
            // this.cubicData = linearToCubic.linearToCubic(this.pointBuffer.xs, this.pointBuffer.ys, err);
            var points = convertToCGPoint(points : self.pointBuffer.toArray());
            ctx.move(to : points[0]);
            if (points.count <= 2) {
                for i in 1...(points.count - 1) {
                    ctx.addLine(to : points[i])
                }
            }
            
            //for (var i = 0; i < self.cubicData.count; i++) {
            //    var cd = self.cubicData[i];
            //    ctx.bezierCurveTo(cd[0], cd[1], cd[2], cd[3], cd[4], cd[5]);
            //}
        }
        
    }
    
    
    // determines the smallest rectangle that bounds this path after matrix has been applied to this path
    func computeBoundingRectLinear(matrix : Matrix) -> Rect{
        // calculate boundingRect
        let points = self.pointBuffer.toArray()
        let p0 = matrix.timesPoint(point : points[0])
        var left = p0.x
        var right = p0.x
        var top = p0.y
        var bottom = p0.y
        for i in 0...(points.count - 1) {
            let p = matrix.timesPoint(point : points[i])
            left = min(left, p.x)
            right = max(right, p.x)
            top = min(top, p.y)
            bottom = max(bottom, p.y)
        }
        let rect = Rect(left: left, top: top, width: right - left, height: bottom - top)
        return rect
    }
    
    func computeBoundingRectCubic(matrix : Matrix) -> Rect {
        
        if (self.cubicData != nil) {
            var err = 2.5;
            // TODO : LinerToCubic.js in Items
            // self.cubicData = linearToCubic.linearToCubic(self.pointBuffer.xs, self.pointBuffer.ys, err);
        }
        var points = self.pointBuffer.points;
        var p_start = matrix.timesPoint(point : points[0])
        var left = p_start.x
        var right = p_start.x
        var top = p_start.y;
        var bottom = p_start.y;
        
        // TODO : LinerToCubic.js in Items
        /*
        for i in 0...(self.cubicData.count - 1) {
            var cd = self.cubicData[i];
            var v1 = Point(cd[0], cd[1]);
            var v2 = Point(cd[2], cd[3]);
            var v3 = Point(cd[4], cd[5]);
            var p1 = matrix.timesPoint(v1);
            var p2 = matrix.timesPoint(v2);
            var p3 = matrix.timesPoint(v3);
            var box = curveRect(p_start, p1, p2, p3);
            left = min(left, box.left);
            right = max(right, box.right);
            top = min(top, box.top);
            bottom = max(bottom, box.bottom);
            p_start = p3;
        }
         */
        let rect = Rect(left: left, top: top, width: right - left, height: bottom - top)
        return rect
    }
    
    // computes the winding number of the point with respect to this path (assumes path is closed)
    func computeWindingNumberLinear(point : Point) {
        // TODO
    }
    
    func intersectsParallelogram(parallelogram : Parallelogram) -> Bool {
        var rect = parallelogram.rect;
        var matrix = parallelogram.inverseMatrix;
        var points = self.pointBuffer.points;
        var left = rect.left;
        var top = rect.top;
        var right = rect.right();
        var bottom = rect.bottom();
        
        // Define the states
        var stateDoesIntersect = 0;
        func stateAbove(p0 : Point, p1 : Point) -> String {
            if (p1.y < top) {
                return "stateAbove";
            }
            if (p0.x < left && p1.x < left) {
                return "stateOnLeft";
            }
            if (p0.x > right && p1.x > right) {
                return "stateOnRight";
            }
            return "stateDoesIntersect";
        }
        
        func stateOnLeft(p0 : Point, p1 : Point) -> String{
            if (p1.x < left) {
                return "stateOnLeft";
            }
            if (p0.y < top && p1.y < top) {
                return "stateAbove";
            }
            if (p0.y > bottom && p1.y > bottom) {
                return "stateBelow";
            }
            return "stateDoesIntersect";
        }
        
        func stateOnRight(p0 : Point, p1 : Point) -> String {
            if (p1.x > right) {
                return "stateOnRight";
            }
            if (p0.y < top && p1.y < top) {
                return "stateAbove";
            }
            if (p0.y > bottom && p1.y > bottom) {
                return "stateBelow";
            }
            return "stateDoesIntersect";
        }
        
        func stateBelow(p0 : Point, p1 : Point) -> String {
            if (p1.y > bottom) {
                return "stateBelow";
            }
            if (p0.x < left && p1.x < left) {
                return "stateOnLeft";
            }
            if (p0.x > right && p1.x > right) {
                return "stateOnRight";
            }
            return "stateDoesIntersect";
        }
        // Determine the start state
        var state = "stateDoesIntersect";
        var p0 = matrix.timesPoint(point : points[0]);
        if (p0.x < left) {
            state = "stateOnLeft";
        }
        if (p0.x > right) {
            state = "stateOnRight";
        }
        if (p0.y < top) {
            state = "stateAbove";
        }
        if (p0.y > bottom) {
            state = "stateBelow";
        }
        
        var i = 1;
        var p1 : Point;
        while (state != "stateDoesIntersect" && i < points.count) {
            p1 = matrix.timesPoint(point : points[i]);
            //state = state(p0: p0,p1: p1);
            p0 = p1;
            i += 1;
        }
        return state == "stateDoesIntersect";
    }
    
    // returns a potentially empty array of paths (for partial erase) (does not support joined paths)
    func removeParallelogram(parallelogram : Parallelogram) {
        // TODO
    }

}

private class NullPath : Path {
    let emptyBuffer : PointBuffer = PointBuffer(pointsArray: [Point]())
    
    init() {
        super.init(buffer: emptyBuffer, s0: 0, s1: 0)
    }
    
}

func curveRect(p0 : Point, p1 : Point, p2 : Point, p3 : Point) -> Dictionary<String, Double> {
    let EPSILON = 1e-12;
    
    var ax = 3 * (-p0.x + 3 * p1.x - 3 * p2.x + p3.x);
    var bx = -6 * (-p0.x + 2 * p1.x - p2.x);
    var cx = 3 * (-p0.x + p1.x);
    var x0 = p0.x;
    var x1 = p3.x;
    var ay = 3 * (-p0.y + 3 * p1.y - 3 * p2.y + p3.y);
    var by = -6 * (-p0.y + 2 * p1.y - p2.y);
    var cy = 3 * (-p0.y + p1.y);
    var y0 = p0.y;
    var y1 = p3.y;
    var left = min(x0, x1);
    var right = max(x0, x1);
    var top = min(y0, y1);
    var bottom = max(y0, y1);
    
    // TODO : LinerToCubic.js in Items
    /*
    if (abs(ax) < EPSILON) {
        if (abs(bx) > EPSILON) {
            var t = -cx / bx;
            if (t >= 0 && t <= 1) {
                var xr = linearToCubic._test.evalBezier(0, p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, t).x;
                left = min(left, xr);
                right = max(right, xr);
            }
        }
    } else {
        var xr1;
        var xr2;
        if (bx * bx >= 4 * ax * cx) {
            var t_r1 = (-bx + sqrt(bx * bx - 4 * ax * cx)) / (2 * ax);
            var t_r2 = (-bx - sqrt(bx * bx - 4 * ax * cx)) / (2 * ax);
            if (t_r1 >= 0 && t_r1 <= 1) {
                xr1 = linearToCubic._test.evalBezier(0, p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, t_r1).x;
                left = min(left, xr1);
                right = max(right, xr1);
            }
            if (t_r2 >= 0 && t_r2 <= 1) {
                xr2 = linearToCubic._test.evalBezier(0, p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, t_r2).x;
                left = min(left, xr2);
                right = max(right, xr2);
            }
        }
    }
    if (abs(ay) < EPSILON) {
        if (abs(by) > EPSILON) {
            var t = -cy / by;
            if (t >= 0 && t <= 1) {
                var yr = linearToCubic._test.evalBezier(0, p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, t).y;
                top = min(top, yr);
                bottom = max(bottom, yr);
            }
        }
    } else {
        var yr1;
        var yr2;
        if (by * by >= 4 * ay * cy) {
            var t_r1 = (-by + sqrt(by * by - 4 * ay * cy)) / (2 * ay);
            var t_r2 = (-by - sqrt(by * by - 4 * ay * cy)) / (2 * ay);
            if (t_r1 >= 0 && t_r1 <= 1) {
                yr1 = linearToCubic._test.evalBezier(0, p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, t_r1).y;
                top = min(top, yr1);
                bottom = max(bottom, yr1);
            }
            if (t_r2 >= 0 && t_r2 <= 1) {
                yr2 = linearToCubic._test.evalBezier(0, p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, t_r2).y;
                top = min(top, yr2);
                bottom = max(bottom, yr2);
            }
        }
    }
     */
    
    return [
        "left": left,
        "right": right,
        "top": top,
        "bottom": bottom,
    ];
}

