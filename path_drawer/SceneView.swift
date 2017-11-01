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
    var penTool = PenTool();
    var scene = Scene();
    var primaryTool = PenTool()
    var secondaryTool = PenTool()
    
    override func draw(_ rect: CGRect){
        scene.draw();
    }
    
    override func touchesBegan(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        penTool.onDown(touches: touchPoints, sceneView: self);
    }
    
    override func touchesMoved(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        penTool.onMove(touches: touchPoints, sceneView: self);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        penTool.onUp(scene: &scene, sceneView: self);
        // setNeedsDisplay();
    }
    
    func setPrimaryTool(to: Any){
        primaryTool = to as! PenTool
    }
    
    func refreshView() {
        setNeedsDisplay();
    }
}
