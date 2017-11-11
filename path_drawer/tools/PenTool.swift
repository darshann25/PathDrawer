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
    var alpha : CGFloat;
    var points : [CGPoint];
    var startPoint = CGPoint.zero;
    
    // The current PrePathItemT
    // var prePathItemT : PrePathItemT;
    
    init(color : CGColor, size : CGFloat, alpha : CGFloat) {
        self.color = color;
        self.size = size;
        self.alpha = alpha;
        
        points = [CGPoint]();
        super.init();
    }
    
    convenience override init() {
        self.init(color: UIColor.black.cgColor, size : CGFloat(5), alpha : CGFloat(1));
    }
    
    override func onDown(touches: Set<UITouch>, sceneView: SceneView) {
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
    
    override func onMove(touches: Set<UITouch>, sceneView: SceneView){
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
    
    override func onUp(scene: inout Scene, sceneView: SceneView){
        //points.append(point);
        let lastPoint = points[points.count - 1];
        
        if lastPoint != startPoint {
            let pItem = PathItem(pointsArr: points, color : self.color, size : self.size, alpha : self.alpha);
            scene.addItem(item: pItem);
        }
        points = [CGPoint]();
        sceneView.refreshView();
    }
    
    
    func setColor(_color : CGColor) {
        self.color = _color;
    }
    
    func setSize(_size : CGFloat) {
        self.size = _size;
    }
    
    func setAlpha(_alpha : CGFloat) {
        self.alpha = _alpha;
    }
    
    func euclidean_dist(start : CGPoint, end : CGPoint) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2));
        return Int(dist);
    }
    
    func setColor(to: CGColor){
        self.color = to;
    }
    
    func setSize(to: CGFloat){
        self.size = to;
    }
    
    func setAlpha(to: CGFloat){
        self.alpha = to;
    }
    
}

