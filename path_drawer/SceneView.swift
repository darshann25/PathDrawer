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
    private var viewLeft : Double = 0
    private var viewTop : Double = 0
    
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
    
    func getViewPooint() {
        return Point(x: self.viewLeft, y: self.viewTop)
    }
    
    func setView(x : Double, y : Double) {
        self.viewLeft = x
        self.viewTop = y
    }
    
    // factor usually close to 1, x,y are in view coordinates
    func zoomAtXY(factor : Double, sceneX : Double, sceneY : Double) {
        var x : Double = zoom * (sceneX - self.viewLeft)
        var y : Double = zoom * (sceneY - self.viewTop)
        var oldzoom : Double = self.zoom
        self.zoom *= factor
        // Max Zoom and Min Zoom are 8 zooms from default
        self.zoom = max(0.262144, self.zoom)
        self.zoom = min(9.3132257, self.zoom)
        self.viewLeft += -(x * ((1 / self.zoom) - (1 / oldzoom)))
        self.viewTop += -(y * ((1 / self.zoom) - (1 / oldzoom)))
        self.onViewRectChanged()
    }
    
    func zoomIn() {
        self.zoomAtXY(factor: 1.25, sceneX: self.viewLeft + self.getWidth() / 2, sceneY: self.viewTop + self.getHeight() / 2)
    }
    
    func zoomOut() {
        self.zoomAtXY(factor: 0.8, sceneX: self.viewLeft + self.getWidth() / 2, sceneY: self.viewTop + self.getHeight() / 2)
    }
    
    func onDown(event : UIEvent, clientX : Double, clientY : Double) {
        var bounds : CGRect = self.canvas.frame
        var x : Double = (clientX - Double(bounds.width)) / self.zoom + self.viewLeft
        var y : Double = (clientY - Double(bounds.height)) / self.zoom + self.viewTop
        self.sceneGrabbedTouch = Scene.sharedInstance.onMouseDown(x: x, y: y, zoom: self.zoom, event: event)
        if(self.sceneGrabbedTouch == false) {
            self.primaryTool.onDown(clientX : x, clientY : y)
        }
        self.updateEventHandlers(f : self.onDown)
    }
    
    typealias SceneViewCallbackWithPoint = (UIEvent, Double, Double) -> ()
    func updateEventHandlers(fun : SceneViewCallbackWithPoint) {
        self.mouseEventHandler.setSceneViewOnDown(f: fun)
        self.touchEventHandler.
    }
    
    
    
    /*
     function onDown(event, clientX, clientY) {
     var bounds = canvas.getBoundingClientRect();
     var x = (clientX - bounds.left) / zoom + viewLeft;
     var y = (clientY - bounds.top) / zoom + viewTop;
     sceneGrabbedMouse = scene.onMouseDown(x, y, zoom, event);
     if (!sceneGrabbedMouse) {
     primaryTool.onDown(x, y);
     }
     }
     mouseEventHandler.setSceneViewOnDown(onDown);
     touchEventHandler.setSceneViewOnDown(onDown);

     */
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

