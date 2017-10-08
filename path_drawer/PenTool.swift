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
    var startPoint = CGPoint.zero;
    
    init () {
    }
    
    func onDown(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            // sets the startPoint to avoid creating a dot
            //if startPoint == point {
            //    startPoint = CGPoint.zero;
            //} else {
            //    startPoint = point;
            points.append(point);
            //}
        }
    }
    
    func onMove(touches: Set<UITouch>, sceneView: SceneView){
        
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            points.append(point);
        }
    }
    
    func onUp(scene: inout Scene, sceneView: SceneView){
        let lastPoint = points[points.count - 1];
        
        if lastPoint != startPoint {
            let pItem = PathItem(pointsArr: points);
            scene.addPathItem(pathItem: pItem);
        }
        points = [CGPoint]();
        startPoint = CGPoint.zero;
        sceneView.refreshView();
    }
    
    
    func euclidean_dist(start : CGPoint, end : CGPoint) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        return Int(dist)
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
