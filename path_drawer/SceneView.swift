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
    var startPoint = CGPoint.zero;
    var pT = PenTool();
    var scene = Scene();
    
    //override func draw(_ rect: CGRect){
    //    scene.draw();
    //}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint = touch.location(in: self);
            // checks if the current point is not equal to start point
            if (startPoint != CGPoint.zero) {
                startPoint = currPoint;
            }
            pT.onDown(point: currPoint);
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint = touch.location(in: self);
            pT.onMove(point: currPoint);
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint = touch.location(in: self);
            if startPoint != currPoint {
                pT.onUp(point: currPoint, scene: &scene)
            }
            scene.draw();
            setNeedsDisplay();
            
        }
        
    }
    
    
}
