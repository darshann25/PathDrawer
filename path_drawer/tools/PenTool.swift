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
    var color : CGColor
    var size : CGFloat
    var alpha : CGFloat
    
    init () {
        color = UIColor.black.cgColor
        size = CGFloat(10)
        alpha = CGFloat(1.0)
    }
    
    var points = [CGPoint]();
    var startPoint = CGPoint.zero;
    
    func onDown(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            if startPoint == point {
                startPoint = CGPoint.zero;
            } else {
                startPoint = point;
                points.append(point);
            }
        }
    }
    
    func onMove(touches: Set<UITouch>, sceneView: SceneView){
        // holds the distance of the interpolation between two points
        // var euclid_dist = 0;
        
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            //if !(prevPoint.x == point.x && prevPoint.y == point.y){
            //    euclid_dist = interpolate_points(start: &prevPoint, end: &point);
            //}
            points.append(point);
        }
    }
    
    func onUp(scene: inout Scene, sceneView: SceneView){
        //points.append(point);
        let lastPoint = points[points.count - 1];
        
        if lastPoint != startPoint {
            let pItem = PathItem(pointsArr: points);
            scene.addItem(item: pItem);
        }
        points = [CGPoint]();
        sceneView.refreshView();
    }
    
    
    func euclidean_dist(start : CGPoint, end : CGPoint) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        return Int(dist)
    }
    
    func setColor(to: CGColor){
        color = to
    }
    
    func setSize(to: CGFloat){
        size = to
    }
    
    func setAlpha(to: CGFloat){
        alpha = to
    }
    
    
    /*
     // Fix interpolation
     func interpolate_points(start: inout CGPoint, end : inout CGPoint) -> Int {
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
     }*/
    
}

