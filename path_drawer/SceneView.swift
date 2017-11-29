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
    private var devicesManager : DevicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
    private var boardStateManager : BoardStateManager = BoardViewController.BoardContext.sharedInstance.boardStateManager
    
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
        self.updateEventHandlers(f : self.onDown as! SceneViewCallbackWithPoint)
    }
    
    typealias SceneViewCallbackWithPoint = (UIEvent, Double, Double) -> ()
    typealias SceneViewCallback = (UIEvent) -> ()
    
    func updateEventHandlers(fun : SceneViewCallbackWithPoint) {
        self.mouseEventHandler.setSceneViewOnDown(f: fun)
        self.touchEventHandler.setSceneViewOnDown(f: fun)
    }
    
    func updateEventHandlers(fun : SceneViewCallback) {
        self.mouseEventHandler.setSceneViewOnDown(f: fun)
        self.touchEventHandler.setSceneViewOnDown(f: fun)
    }

    
    func onMove(event : UIEvent, clientX : Double , clientY : Double) {
        var bounds : CGRect = self.canvas.frame
        var x : Double = (clientX - Double(bounds.width)) / self.zoom + self.viewLeft
        var y : Double = (clientY - Double(bounds.height)) / self.zoom + self.viewTop
        
        if(self.mouseEventHandler.getIsDragging() || self.touchEventHandler.getIsDragging()) {
            // This is a drag event.
            Scene.sharedInstance.onMouseDrag(x: x, y: y, zoom: self.zoom)
        } else {
            self.primaryTool.onMove(clientX: x, clientY: y)
        }
        self.updateEventHandlers(fun: SceneViewCallbackWithPoint)
    }
    
    // SHOULD NOT BE APPLICABLE FOR IOS APP
    func onMoveInSceneOnly(event : UIEvent, clientX : Double, clientY : Double) {
        var bounds : CGRect = self.canvas.frame
        var x : Double = (clientX - Double(bounds.width)) / self.zoom + self.viewLeft
        var y : Double = (clientY - Double(bounds.height)) / self.zoom + self.viewTop
        
        if(self.mouseEventHandler.getIsDragging() == false && self.touchEventHandler.getIsDragging() == false) {
            // Not a drag event (those are handled in onMove()), but a halo
            // var newCursor = Scene.sharedInstance.onMouseHover(x: x, y: y, zoom: self.zoom)
            // canvas.style.cursor = newCursor
            
            var haloDel : [String : Any] = [
                "type" : "halo",
                "N" : self.delManager.currentDelnN(),
                "x" : x,
                "y" : y
            ]
            self.messenger.broadcastDel(del: haloDel)
        }
        
        self.updateEventHandlers(fun: onMoveInSceneOnly as! SceneViewCallbackWithPoint)
    }
    
    func onUp(event : UIEvent) {
        // this event fires for the entire document (not just over the scene)
        if(self.sceneGrabbedTouch) {
            Scene.sharedInstance.onMouseUp()
        } else /* if (self.mouseEventHandler.getIsDragging() || self.touchEventHandler.getIsDragging()) */ {
            self.primaryTool.onUp()
        }
        self.sceneGrabbedTouch = false
        // event.preventDefault()
        
        self.updateEventHandlers(fun: onUp as! SceneViewCallback)
        
    }
    
    // SHOULD NOT BE APPLICABLE FOR IOS APP
    // right-click (contextMenu)
    func onContextMenu(event : UIEvent, clientX : Double, clientY : Double) {
        var bounds : CGRect = self.canvas.frame
        var x : Double = (clientX - Double(bounds.width)) / self.zoom + self.viewLeft
        var y : Double = (clientY - Double(bounds.height)) / self.zoom + self.viewTop
        
        var data : [String : Any] = Scene.sharedInstance.getContextMenuData(x: x, y: y, zoom: self.zoom)
        // contextMenuController.showContextMenu(data : data, event : event)
        
        self.updateContextMenuEventHandler(fun: onContextMenu as! SceneViewCallbackWithPoint)
    }
    
    func updateContextMenuEventHandler(fun : SceneViewCallbackWithPoint) {
        // self.contextMenuEventHandler.setSceneViewOnContextMenu(f : fun)
    }
    
    func doPaste() {
        var itemsData : [String : Any]
        // itemsData = self.clipboardManager.getClipboardItemsData()
        if (itemsData != nil) {
            return
        }
        let OFFSET : Int = 10
        
        // if selectionItemT, then find a new paste location and release selected items
        var selectionItemT : SelectionItemT = self.devicesManager.getThisDevice().context["selectionItemT"]
        var matrix : Matrix
        if (selectionItemT != ItemT.nullItemT) {
            // TODO: should check that paste location is within the screen
            var upperLeftPoint : Point = selectionItemT.getUpperLeftPoint()
            var targetUpperLeftPoint : Point = Point(x : Double(upperLeftPoint.x + OFFSET), y : Double(upperLeftPoint.y + OFFSET));
            selectionItemT.onClickedAway()
            var curPoint : Point = Point(x : (itemsData["rect"] as! Rect).left, (itemsData["rect"] as! Rect).top)
            matrix = Matrix.translateMatrix(dx: Double(targetUpperLeftPoint.x - curPoint.x), dy : Double(targetUpperLeftPoint.y - curPoint.y))
        } else { // else, paste in center
            var bounds : CGRect = self.canvas.frame
            var itemsWidth : Double = (itemsData["rect"] as! Rect).width
            var itemsHeight : Double = (itemsData["rect"] as! Rect).height
            var x : Double = (self.viewLeft + (bounds.width / self.zoom - itemsWidth) / 2 ) - (itemsData["rect"] as! Rect).left
            var y : Double = (self.viewTop + (bounds.height / self.zoom - itemsHeight) / 2) - (itemsData["rect"] as! Rect).top
            matrix = Matrix.translateMatrix(dx : x, dy : y)
        }
        // Make a copy of all the selected items
        var actId = self.boardStateManager.getNewActId()
        var devId = self.devicesManager.getMyDeviceId()
        Scene.sharedInstance.beginChanges()
        var items = [(Int, Int)]
        
        var itemStates : [ItemState] = itemsData["itemStates"] as! [ItemState]
        for itemState : ItemState in itemStates {
            var id : Int = self.boardStateManager.getNewItemId()
            itemState.setIdAndDevId(id: id, devId: devId)
            items.append((id, devId))
            itemState.matrix = matrix.times(that: itemState.matrix)
            var delta = NewItemDelta(actId: actId, devId: devId, itemState: itemState)
            self.boardStateManager.addDelta(delta: delta)
            self.devicesManager.enqueueDelta(delta: delta)
            delta.applyToScene()
        }
        
        var grabItemsDelta : GrabItemsDelta = GrabItemsDelta(actId: actId, devId: devId, holderDevId: devId, uids: items, initialMatrix: Matrix.identityMatrix(), intent: GrabItemsDelta.intents.SelectionItemT)
        grabItemsDelta.applyToScene()
        self.boardStateManager.addDelta(delta: grabItemsDelta)
        self.devicesManager.enqueueDelta(delta: grabItemsDelta)
        Scene.sharedInstance.endChanges()
        self.devicesManager.send()
    }
    
    /*
         var grabItemsDelta = new GrabItemsDelta(actId, devId, devId, items, Matrix.identityMatrix(), GrabItemsDelta.intents.SelectionItemT);
         grabItemsDelta.applyToScene();
         boardStateManager.addDelta(grabItemsDelta);
         devicesManager.enqueueDelta(grabItemsDelta);
         scene.endChanges();
         devicesManager.send();
     });
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

