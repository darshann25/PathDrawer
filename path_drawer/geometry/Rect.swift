//
//  Rect.swift
//  Geometry
//
//  Created by URMISH M BHATT on 10/10/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation

////////////////
// Rect Class //
////////////////

/*
 Represents a rectangle on the plane adapted to cartesian coordinates.
 @constructor
 @param {Number} left The x coordinate of the left side of the rectangle.
 @param {Number} top The y coordinate of the top side of the rectangle.
 @param {Number} width The width of the rectangle.
 @param {Number} height The height of the rectangle.
 */

class Rect{
    
    public static var nullRect = NullRect()
    
    var left : Double
    var top : Double
    var width : Double
    var height : Double
    
    init(left : Double, top : Double, width : Double , height : Double){
        
        self.left = left
        self.top = top
        self.width = width
        self.height = height
        
    }
    
    convenience init() {
        self.init(left : 0, top : 0, width : 0 , height : 0)
    }
    
    /*
    Creates the smallest Rect containing the two points.
    @param {Number} x0 The x coordinate of the first point.
    @param {Number} y0 The y coordinate of the first point.
    @param {Number} x1 The x coordinate of the second point.
    @param {Number} y1 The y coordinate of the second point.
    @return {Rect} The new Rect object.
    */
    func rectFromXYXY(x0 : Double, y0 : Double, x1 : Double, y1 : Double) -> Rect{
        
        var left : Double
        var right : Double
        var top : Double
        var bottom : Double
        
        if (x0 < x1) {
            left = x0
            right = x1
        } else {
            right = x0
            left = x1
        }
        if (y0 < y1) {
            top = y0
            bottom = y1
        } else {
            top = y1
            bottom = y0
        }
        return Rect(left: left, top: top, width: right - left, height: bottom - top)
        
    }
    
    /*
     Returns the x-coordinate of the right side of the rectangle.
     @return {Number} The x-value.
     */
    func right() -> Double {
        return (self.left + self.width)
    }
    
    /*
     Returns the y-coordinate of the bottom side of the rectangle.
     @return {Number} The y-value.
     */
    func bottom() -> Double {
        return (self.top + self.height)
    }
    
    /*
     Returns the area of the rectangle.
     @return {Number} The area.
     */
    func area() -> Double {
        return (self.width * self.height)
    }
    
    /*
     Determines whether this rectangle intersects the inputed rectangle.
     @param {Rect} that The inputed rectangle.
     @return {Boolean} True if the two rectangles intersect, false if they do not.
     */
    func intersects(that: Rect) -> Bool {
        return !(self.right() < that.left || that.right() < self..left || self.bottom() < that.top || that.bottom() < self.top )
    }
    
    /*
     Determines whether this rectangle contains the inputed rectangle.
     @param {Rect} that The inputed rectangle.
     @return {Boolean} True if this rectangle contains the inputed rectangle, false if it does not.
     */
    func contains(that : Rect) -> Bool {
        return (self.left <= that.left && self.top <= that.top && self.right() >= that.right() && self.bottom() >= that.bottom());
    }
    
    /*
     Determines whether the point lies inside the rectangle.
     @param {Number} x The inputed x-value.
     @param {Number} y The inputed y-value.
     @return {Boolean} True if the point is contained in this rectangle, false otherwise.
     */
    func containsPointXY(x : Double,y : Double) -> Bool {
        
        return (self.left <= x && self.right() >= x && self.top <= y && self.bottom() >= y)
        
    }
    
    func containsPoint(point: Point)-> Bool {
        return self.containsPointXY(x: point.x, y: point.y)
    }
    
    /*
     Returns a new rectangle that is the smallest rectangle containing both rectangles.
     @param {Rect} that The inputed rectangle.
     @return {Rect} The smallest rectangle containing both this rectangle and the inputed rectangle.
     */
    func union(that : Rect) -> Rect {
        
        let left = min(self.left, that.left)
        let top = min(self.top, that.top)
        let right = max(self.right(), that.right())
        let bottom = max(self.bottom(), that.bottom())
        
        return Rect(left: Double(left), top: Double(top), width: Double(right - left), height: Double(bottom - top))
    }
    
    /*
     Returns a new rectangle that is the largest rectangle contained in both this rectangle and the inputed rectangle. Returns null if there is no such rectangle exists.
     @param {Rect} that The inputed rectangle.
     @return {Rect} The largest rectangle contained in both this rectangle and the inputed rectangle.
     */
    func intersection(that:Rect) -> Rect {
        
        if (!self.intersects(that)) {
            return Rect.nullRect
        }
        
        let left = max(self.left, that.left)
        let top = max(self.top, that.top)
        let right = min(self.right(), that.right())
        let bottom = min(self.bottom(), that.bottom())
        
        return Rect(left: Double(left), top: Double(top), width: Double(right - left), height: Double(bottom - top))
        
    }
    
    /*
     Returns a new rectangle that bounds this rectangle after a transformation is applied. In general, this rectangle after a transformation is applied will be a parallelogram in the plane. This function returns the smallest axis-aligned rectangle containing the resulting parallelogram.
     @param {Matrix} matrix The inputed transformation matrix.
     @return {Rect} The output rectangle that contains the rectangle transformed by the matrix.
     */
    func boundsAfterMatrix(matrix : Matrix) -> Rect {

        var ulPoint = matrix.timesPoint(Point(self.left, self.top))
        var left = ulPoint.x
        var right = ulPoint.x
        var top = ulPoint.y
        var bottom = ulPoint.y

        var points = [matrix.timesPoint(Point(self.right(), self.top)),
        matrix.timesPoint(Point(self.right(), self.bottom())),
        matrix.timesPoint(Point(self.left, self.bottom()))]

        for point in points {
            left = min(left, point.x)
            right = max(right, point.x)
            top = min(top, point.y)
            bottom = max(bottom, point.y)
        }
        
        return Rect(left, top, right - left, bottom - top)
    }
    
    /*
     Returns a rectangle expanded by a given number of units in each direction. The left and top parameters are substracted by mdl and mdt units respectively, so that the left side and top side are expanded by mdl units and mdt units. The bottom and right parameters are increased by db and dr respectively so that the bottom and right side are expanded by db and dr respectively. For example, if all parameters are set to 5, then the rectangle will be expanded by 5 units in each direction. The function will accept negative numbers as parameters, however there is no check in place to return null if the resulting rectangle does not exist, and so negative numbers could result in an error.
     @summary Returns a rectangle expanded by a given number of units in each direction.
     @param {Number} mdl Number of units to expand the left side of the rectangle.
     @param {Number} mdt Number of units to expand the top side of the rectangle.
     @param {Number} dr Number of units to expand the right side of the rectangle.
     @param {Number} db Number of units to expand the bottom side of the rectangle.
     */
    func expandedBy(mdl : Double, mdt : Double, dr : Double, db : Double) -> Rect {
        return Rect(left: self.left - mdl, top: self.top - mdt, width: self.width + mdl + dr, height: self.height + mdt + db)
    }
    
    /*
     Returns a 1-dimensional array of length 4 containing the parameters of the rectangle. In order, those 4 parameters are left, top, width and height.
     @return {Array} A 1-dimensional array of length 4 containing the parameters of the rectangle.
     */
    func toArray()-> [Any] {
        return [self.left, self.top, self.width, self.height]
    }
    
    /*
     Returns a rectangle with parameters given by the inputed array, where the first four elements of the array will become left, top, width, height, in that order, for the new rectangle. This function will return an error if the length of the array is less than 4 or if any of the first four elements of the array are not non-negative numbers. If the array has length >4, this function will still run using the first 4 elements of the array, however this is not recommended.
     @summary Given an array of non-negative numbers, returns a rectangle with parameters given by the first four elements of the array.
     @return {Rect} The resulting rectangle.
     */
    func fromArray(a:[Double])->Rect{
        return Rect (left: a[0], top: a[1], width: a[2], height: a[3])
    }
    
    /*
     Returns a copy of this rectangle.
     @return {Rect} A copy of this rectangle.
     */
    func copy()-> Rect {
        return Rect(left: self.left, top: self.top, width: self.width, height: self.height)
    }
    
    func upperLeftPoint()->Point{
        return Point(x: self.left, y: self.top)
    }
    
}

private class NullRect : Rect {
    init() {
        
    }
    
}




