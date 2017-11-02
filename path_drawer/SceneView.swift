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
    var scene = Scene();
    var toolManager = ToolManager();
    //var primaryTool : PenTool;
    //var secondaryTool : PenTool;
    
    override func draw(_ rect: CGRect){
        scene.draw(toolManager : self.toolManager);
    }
    
    override func touchesBegan(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        toolManager.penTool.onDown(touches: touchPoints, sceneView: self);
    }
    
    override func touchesMoved(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        toolManager.penTool.onMove(touches: touchPoints, sceneView: self);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        toolManager.penTool.onUp(scene: &scene, sceneView: self);
        // setNeedsDisplay();
    }
    
    func setPrimaryTool(tool : PenTool){
        // TODO:
        // since we cannot make another PenTool object, we need to figure out how to
        // set a primaryTool to an empty PenTool
        var primaryTool = tool;
    }
    
    func refreshView() {
        setNeedsDisplay();
    }
}
