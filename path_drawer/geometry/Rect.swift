//
//  Rect.swift
//  Geometry
//
//  Created by URMISH M BHATT on 10/10/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation


class Rect{
    
    public static var nullRect = NullRect()
    
    var left = 0.00;
    var top = 0.00;
    var width = 0.00;
    var height = 0.00;
    
    init(left: Double, top: Double, width: Double , height: Double){
        
        self.left = left;
        self.top = top;
        self.width = width;
        self.height = height;
        
    }
    
    func rectFromXYXY(x0:Double, y0:Double, x1:Double, y1:Double)->Rect{
        
        var left=0.00;
        var right=0.00;
        var top=0.00;
        var bottom=0.00;
        
        if (x0 < x1) {
            left = x0;
            right = x1;
        } else {
            right = x0;
            left = x1;
        }
        if (y0 < y1) {
            top = y0;
            bottom = y1;
        } else {
            top = y1;
            bottom = y0;
        }
        return Rect(left: left, top: top, width: right - left, height: bottom - top);
        
        
        
    }
    
    func right()-> Double{    //prototype conversion pending
        
        return (self.left+self.width);
    }
    
    func bottom()->Double{   //prototype conversion pending
        
        return self.top+self.height;
    }
    
    func area()-> Double{        //prototype conversion pending
        
        return self.width*self.height;
        
    }
    
    // type verification
    func intersects(that: Rect)->Bool{     //prototype conversion pending
        
        return (self.left <= that.left && self.top <= that.top && self.right() >= that.right() && self.bottom() >= that.bottom());
        
    }
    
    // type verification
    func containsPointXY(x:Double,y:Double)-> Bool{    //prototype conversion pending
        
        return (self.left <= x &&
            self.right() >= x       &&
            self.top <= y           &&
            self.bottom() >= y  );
        
    }
    
    // type verification
    func containsPoint(point: Point)-> Bool{    //prototype conversion pending
        
        return self.containsPointXY(x: point.x, y: point.y);
        
    }
    
    // type verification
    func union(that:Rect)->Rect{   //prototype conversion pending
        
        
        
        let left = min(self.left, that.left);
        let top = min(self.top, that.top);
        let right = max(self.right(), that.right());
        let bottom = max(self.bottom(), that.bottom());
        
        return Rect(left: Double(left), top: Double(top), width: Double(right - left), height: Double(bottom - top));
        
        
    }
    
    // type verification
    func intersection(that:Rect)->Rect{    //prototype conversion pending
        
        /*  if (!self.intersects(that)) {
         return null;
         }
         
         */
        
        let left = max(self.left, that.left);
        let top = max(self.top, that.top);
        let right = min(self.right(), that.right());
        let bottom = min(self.bottom(), that.bottom());
        
        return Rect(left: Double(left), top: Double(top), width: Double(right - left), height: Double(bottom - top));
        
        
    }
    
    // type verification
    func boundsAfterMatrix(matrix:Matrix){  //prototype conversion pending
        
        /*     var ulPoint = matrix.timesPoint(new Point(self.left, self.top));
         var left = ulPoint.x;
         var right = ulPoint.x;
         var top = ulPoint.y;
         var bottom = ulPoint.y;
         
         var points = [matrix.timesPoint(new Point(self.right(), self.top)),
         matrix.timesPoint(new Point(self.right(), self.bottom())),
         matrix.timesPoint(new Point(self.left, self.bottom()))];
         points.forEach(function(point) {
         left = Math.min(left, point.x);
         right = Math.max(right, point.x);
         top = Math.min(top, point.y);
         bottom = Math.max(bottom, point.y);
         });
         
         
         return Rect(left, top, right - left, bottom - top);
         
         
         */
    }
    
    
    func expandedBy(mdl:Double, mdt:Double, dr:Double, db:Double)->Rect{  //prototype conversion pending
        
        return Rect(left: self.left - mdl, top: self.top - mdt, width: self.width + mdl + dr, height: self.height + mdt + db);
        
        
    }
    
    func toArray()-> Array<Any>{     //prototype conversion pending
        
        return [self.left, self.top, self.width, self.height];
        
    }
    
    func fromArray(a:[Double])->Rect{
        
        return Rect (left: a[0], top: a[1], width: a[2], height: a[3]);
        
    }
    
    func copy()->Rect{        //prototype conversion pending
        
        return Rect(left: self.left, top: self.top, width: self.width, height: self.height);
    }
    
    func upperLeftPoint()->Point{
        
        return Point(x: self.left, y: self.top);
        
    }
    
}

private class NullRect : Rect {
    init() {
        
    }
    
}




