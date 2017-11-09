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

    //TODO: Primary and secondary tool are not initialized by tool manager when called
    
/*
    var primaryTool : PenTool;
    var secondaryTool : PenTool;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
 
    convenience init() {
        self.init(frame: CGRect.zero)
        didLoad()
 }
    
    func didLoad(){
        primaryTool = toolManager.getPenTool()
        secondaryTool = toolManager.getPenTool()
    }
    */
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self)
    }
    
    @IBAction func highlighterButton(_ sender: Any) {
        onHighlighterButtonClicked()
    }
    
    @IBAction func penSize2(_ sender: Any) {
        onPenSize2BtnClicked()
    }
    
    @IBAction func penSize4(_ sender: Any) {
        onPenSize4BtnClicked()
    }
    
    override func draw(_ rect: CGRect){
        scene.draw();
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
        //var primaryTool = tool;
    }
    
    func refreshView() {
        setNeedsDisplay();
    }
}
