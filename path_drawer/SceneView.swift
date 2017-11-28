//
//  SceneView.swift
//  path_drawer
//
//  Created by DARSHAN DILIP PATEL on 9/28/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class SceneView : UIView {
    ///////////////////////////
    // DEFAULT CONSTRUCTORS  //
    ///////////////////////////
    
    private override init(frame: CGRect) {
        self.primaryTool = toolManager.penTool
        super.init(frame: frame)
    }
    
    //required to subclass UIView
    required init?(coder aDecoder: NSCoder) {
        self.primaryTool = toolManager.penTool
        super.init(coder: aDecoder)
    }
    
    //////////////////
    // WEBSITE CODE //
    //////////////////
    
    private var scene : Scene = Scene.sharedInstance
    private var toolManager : ToolManager = Scene.sharedInstance.toolManager
    private var messenger : Messenger = BoardViewController.BoardContext.sharedInstance.messenger
    private var delManager : DelManager = BoardViewController.BoardContext.sharedInstance.delManager
    
    private var canvas : SceneView = self
    
    // To determine whether the scene wants the mouse events.
    private var sceneGrabbedTouch : Bool = false
    
    // These properties define the part of the Scene that the user is viewing
    private var viewLeft : Int = 0
    private var viewTop : Int = 0
    
    // 1.25^2=1.5625
    private var zoom : Double = 1.5625
    
    private var mouseEventHandler : MouseEventHandler = MouseEventHandler(sv: self)
    private var touchEventHandler : TouchEventHandler = TouchEventHandler(sv: self)
    
    private func getWidth() -> Double {
        return Double(self.canvas.frame.size.width) / self.zoom
    }
    
    private func getHeight() -> Double {
        return Double(self.canvas.size.height) / zoom
    }
    
    // The current tools
    private var primaryTool : Tool
    private var secondaryTool : Tool
    
    private func setPrimaryTool(tool : Tool) {
        if (self.mouseEventHandler.getIsDragging() || self.touchEventHandler.getIsDragging()) {
            self.mouseEventHandler.setIsDragging(x : false)
            self.touchEventHandler.setIsDragging(x : false)
            self.primaryTool.onUp()
        }
    }
    
    private func setSecondaryTool(tool : Tool) {
        self.secondaryTool = tool
    }
    
    internal func onViewRectChanged() {
        self.scene.onViewingRectChangedForSceneView(sv: self.canvas)
        var rectArray : [Double] = [
            Double(self.viewLeft),
            Double(self.viewTop),
            Double(self.canvas.frame.width) / self.zoom,
            Double(self.canvas.frame.height) / self.zoom
        ]
        
        var delJSON : [String : Any] = [
            "type" : "view",
            "N" : self.delManager.currentDelN(),
            "rect" : rectArray
        ]
        self.messenger.broadcastDel(del: delJSON)
    }
    
    /////////////////////
    // USER INTERFACE  //
    /////////////////////
    
    @IBAction func PenTool(_ sender: UIButton) {
        onPenBtnClicked(sv : self)
    }
    
    @IBAction func Highlighter(_ sender: UIButton) {
        onHighlighterButtonClicked(sv : self)
    }
    
    @IBAction func one(_ sender: Any) {
        onPenSize1BtnClicked(sv : self)
    }
    
    @IBAction func two(_ sender: Any) {
        onPenSize2BtnClicked(sv : self)
    }
    
    @IBAction func three(_ sender: Any) {
        onPenSize3BtnClicked(sv : self)
    }
    
    @IBAction func four(_ sender: Any) {
        onPenSize4BtnClicked(sv : self)
    }
    
    
    // internal
    func onViewRectChanged() {
    
    }
    
    func getViewPoint() {
    
    }
    
    func setViewXY(x : Double, y : Double) {
    
    }
    
    // factor usually close to 1, x,y are in view coordinates
    func zoomAtXY(factor : Double, sceneX : Double, sceneY : Double) {
    
    }
    
    func zoomIn() {
    
    }
    
    func zoomOut() {
    
    }
    
    func onDown(event : UIEvent, clientX : Double, clientY : Double) {
    
    }
    
    // mouseEventHandler.setSceneViewOnDown(onDown);
    // touchEventHandler.setSceneViewOnDown(onDown);
    
    func onMove(event : UIEvent, clientX : Double, clientY : Double) {
    
    }
    // mouseEventHandler.setSceneViewOnMove(onMove);
    // touchEventHandler.setSceneViewOnMove(onMove);
    
    func onMoveInSceneOnly(event : UIEvent, clientX : Double, clientY : Double) {
    
    }
    // mouseEventHandler.setSceneViewOnMoveInSceneOnly(onMoveInSceneOnly);
    // touchEventHandler.setSceneViewOnMoveInSceneOnly(onMoveInSceneOnly);
    
    func onUp(event : UIEvent) {
    
    }
    // mouseEventHandler.setSceneViewOnUp(onUp);
    // touchEventHandler.setSceneViewOnUp(onUp);
    
    // right-click (contextMenu)
    func onContextMenu(event : UIEvent, clientX : Double, clientY : Double) {
    
    }
    // contextMenuEventHandler.setSceneViewOnContextMenu(onContextMenu);
    
    func doPaste() {
    
    }
    
    // TODO: Add log message
    func onKeyDown(event : UIEvent) {
    
    }
    // keyEventHandler.setSceneViewOnKeyDown(onKeyDown);
    
    func onSelectAll() {
    
    }
    
    func onZoom(event : UIEvent, clientX : Double, clientY : Double, scaleFactor : Double) {
    
    }
    // wheelEventHandler.setSceneViewOnZoom(onZoom);
    // touchEventHandler.setSceneViewOnChangeZoom(onZoom);
    
    func onPan(event : UIEvent, deltaX : Double, deltaY : Double) {
    
    }
    // wheelEventHandler.setSceneViewOnPan(onPan);
    // touchEventHandler.setSceneViewOnChangePan(onPan);
    
    // Initialize the SceneView.
    
    
    ////////////////////////////
    // Legacy   ////////////////
    ////////////////////////////
    override func draw(_ rect: CGRect){
        scene.draw();
    }
    
    override func touchesBegan(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
        self.primaryTool.onDown(touches: touchPoints, sceneView: self);
    }
    
    override func touchesMoved(_ touchPoints: Set<UITouch>, with event: UIEvent?) {
       self.primaryTool.onMove(touches: touchPoints, sceneView: self);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.primaryTool.onUp(scene: &scene, sceneView: self);
        // setNeedsDisplay();
    }
    
    
    func refreshView() {
        setNeedsDisplay();
    }
}

