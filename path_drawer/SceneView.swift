//
//  SceneView.swift
//  path_drawer
//
//  Created by DARSHAN DILIP PATEL on 9/28/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import UIKit



class SceneView : UIView {

    // tuple of points
    var points = [CGPoint]();
    var startPoint = CGPoint.zero;
    
    override func draw(_ rect: CGRect) {
        for point in points {
            let dot = UIBezierPath(ovalIn : CGRect(x : point.x-5, y : point.y-5, width : 10, height : 10));
            UIColor.darkGray.setFill();
            dot.fill();
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint = touch.location(in: self);
            // checks if the current point is not equal to start point
            if (startPoint != CGPoint.zero) {
                startPoint = currPoint;
            }
            points.append(currPoint);
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint = touch.location(in: self);
            points.append(currPoint);
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint = touch.location(in: self);
            points.append(currPoint);
            setNeedsDisplay();
            
        }
        
    }
    
    func euclidean_dist(start : CGPoint, end : CGPoint) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        return Int(dist)
    }
    
    func interpolate_points(_start: CGPoint, _end : CGPoint) -> Int {
        while _start != _end {
            if _start.x < _end.x {
                _start.x += 1;
            }
            
            if _start.x > _end.x {
                _start.x -= 1;
            }
            
            if _start.y < _end.y {
                _start.y += 1;
            }
            
            if _start.y > _end.y {
                _start.y -= 1;
            }
            
            points.append(_start)
        }
        
    }
}
