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
    var pT = PenTool();
    var scene = Scene();
    
    override func draw(_ rect: CGRect){
        scene.draw();
    }
    
    override func touchesBegan(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        pT.onDown(touches: touchPoints, sceneView: self);
    }
    
    override func touchesMoved(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        pT.onMove(touches: touchPoints, sceneView: self);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pT.onUp(scene: &scene, sceneView: self);
        // setNeedsDisplay();
            
    }
    
    func refreshView() {
        setNeedsDisplay();
    }
    
}
