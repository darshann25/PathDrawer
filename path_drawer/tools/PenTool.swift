//
//  PenTool.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class PenTool : Tool {
    var color : CGColor;
    var size : CGFloat;
    var opacity : CGFloat;
    var points : [Point];
    var startPoint = CGPoint.zero;
    
    // The current PrePathItemT
    // var prePathItemT : PrePathItemT;
    
    init(color : CGColor, size : CGFloat, opacity : CGFloat) {
        self.color = color;
        self.size = size;
        self.opacity = opacity;
        
        points = [Point]();
        super.init();
    }
    
    convenience override init() {
        self.init(color: UIColor.black.cgColor, size : CGFloat(5), opacity : CGFloat(1));
    }
    
    override func onDown(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            if startPoint == point {
                startPoint = CGPoint.zero;
            } else {
                startPoint = point;
                let pt = convertFromCGPoint(point : point);
                points.append(pt);
            }
        }
    }
    
    override func onMove(touches: Set<UITouch>, sceneView: SceneView){
        // holds the distance of the interpolation between two points
        // var euclid_dist = 0;
        
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            //if !(prevPoint.x == point.x && prevPoint.y == point.y){
            //    euclid_dist = interpolate_points(start: &prevPoint, end: &point);
            //}
            let pt = convertFromCGPoint(point : point);
            points.append(pt);
        }
    }
    
    override func onUp(scene: inout Scene, sceneView: SceneView){
        //points.append(point);
        let lastPt = points[points.count - 1];
        let lastPoint = convertToCGPoint(point : lastPt);
        
        if lastPoint != startPoint {
            let resource = Resource(id: 1, devId: 1, data: points);
            let pItemState = PathItemState(id: 1, devId: 1, matrix: Matrix(), resource: resource, beginIndex: 0, endIndex: self.points.count, color: self.color, size: self.size, opacity: self.opacity)
            let pItem = PathItem(state : pItemState);
            scene.addItem(item: pItem);
        }
        points = [Point]();
        sceneView.refreshView();
    }
    
    func euclidean_dist(start : Point, end : Point) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2));
        return Int(dist);
    }
    
    func setColor(to: CGColor){
        self.color = to;
    }
    
    func setSize(to: CGFloat){
        self.size = to;
    }
    
    func setOpacity(to: CGFloat){
        self.opacity = to;
    }
    
}

