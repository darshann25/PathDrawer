//
//  PenTool.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class PenTool {
    var points = [CGPoint]();
    var prevPoint = CGPoint.zero;
    
    init () {
    }
    
    func onDown(point: CGPoint) {
        // checks if the current point is not equal to start point
        points.append(point);
    }
    
    func onMove(point: CGPoint){
        // holds the distance of the interpolation between two points
        var euclid_dist = 0;
        if !(prevPoint.x == point.x && prevPoint.y == point.y){
            euclid_dist = interpolate_points(start: prevPoint, end: point);
        }
        points.append(point);
    }
    
    func onUp(point: CGPoint, scene: inout Scene){
        points.append(point);
        let pT = PathItem(pointsArr: points);
        scene.addPathItem(pathItem: pT);
    }
    
    
    func euclidean_dist(start : CGPoint, end : CGPoint) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        return Int(dist)
    }
    
    func interpolate_points(start: CGPoint, end : CGPoint) -> Int {
        var curr = start;
        
        while curr != end {
            if curr.x < end.x {
                curr.x += 1;
            }
            
            if curr.x > end.x {
                curr.x -= 1;
            }
            
            if curr.y < end.y {
                curr.y += 1;
            }
            
            if curr.y > end.y {
                curr.y -= 1;
            }
            
            points.append(curr)
        }
        
        return euclidean_dist(start: start, end: end)
    }
    
}
