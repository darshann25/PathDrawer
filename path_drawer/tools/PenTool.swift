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
    
    private var color : CGColor
    private var size : CGFloat
    private var opacity : CGFloat
    var points : [Point]
    var startPoint = CGPoint.zero
    
    // The current PrePathItemT
    private var prePathItemT : PrePathItemT
    private var x0, y0 : Double
    private var scene : Scene
    private var delManager : DelManager
    private var messenger : Messenger
    private var devicesManager : DevicesManager
    private var boardStateManager : BoardStateManager
    
    init(color : CGColor, size : CGFloat, opacity : CGFloat) {
        self.color = color
        self.size = size
        self.opacity = opacity
        
        self.prePathItemT = PrePathItemT()
        self.points = [Point]()
        self.x0 = 0
        self.y0 = 0
        self.scene = Scene.sharedInstance
        self.delManager = BoardViewController.BoardContext.sharedInstance.delManager
        self.messenger = BoardViewController.BoardContext.sharedInstance.messenger
        self.devicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
        self.boardStateManager = BoardViewController.BoardContext.sharedInstance.boardStateManager
        
        super.init()
    }
    
    convenience override init() {
        self.init(color: UIColor.black.cgColor, size : CGFloat(5), opacity : CGFloat(1))
    }
    
    
    override func onDown(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView)
            self.x0 = Double(point.x)
            self.y0 = Double(point.y)
        }
    }
    
    override func onMove(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView)
            var x = Double(point.x)
            var y = Double(point.y)
            
            if (self.prePathItemT !== nullPrePathItemT) {
                self.prePathItemT.addPoint(x: x, y : y)
                var del : [String: Any] = [
                    "type" : "pen",
                    "N" : self.delManager.newDelN(),
                    "x" : x,
                    "y" : y
                ]
                self.messenger.broadcastDel(delta : del)
                
            } else {
            
                // This is the first drag. Make the prePathItemT now and add it to the Scene.
                self.prePathItemT = PrePathItemT()
                self.prePathItemT.setColor(color : color)
                self.prePathItemT.setSize(size : size)
                self.prePathItemT.setOpacity(opacity : opacity)
                self.prePathItemT.addPoint(x : x0, y : y0)
                self.prePathItemT.addPoint(x : x, y : y)
                self.scene.addForefrontItem(itemT: self.prePathItemT)
                
                var del : [String: Any] = [
                    "type" : "penStart",
                    "new" : self.delManager.newDelN(),
                    "color" : self.color,
                    "size" : self.size,
                    "opacity" : self.opacity,
                    "x0" : self.x0,
                    "y0" : self.y0,
                    "x" : x,
                    "y" : y
                ]
                self.messenger.broadcastDel(delta : del)
            }
        }
    }
    
    override func onUp(scene: inout Scene, sceneView: SceneView) {
        if (self.prePathItemT !== PrePathItemT.nullPrePathItemT) {
            return
        }
        
        var del : [String: Any] = [
            "type" : "penEnd",
            "new" : self.delManager.newDelN()
        ]
        self.messenger.broadcastDel(delta : del)
        
        var deviceId = self.devicesManager.getMyDeviceId()
        // create a resource
        var xs = self.prePathItemT.getXList()
        var ys = self.prePathItemT.getYList()
        var pts = [[xs, ys]]
        var resource = Resource(id : self.boardStateManager.getNewResourceId(), devId : deviceId, data : pts)
        self.boardStateManager.addResource(resource : resource)
        self.devicesManager.enqueueResource(resource : resource)
        
        // create the itemState
        var itemState = PathItemState(id : self.boardStateManager.getNewItemId(), devId : deviceId, matrix : Matrix.identityMatrix(), resource : resource, beginIndex : 0, endIndex : xs.count - 1, color : self.color, size : self.size, opacity : self.opacity)
        
        // create the delta
        var delta = NewItemDelta(id : self.boardStateManager.getNewActId(), devId : deviceId, state : itemState)
        self.boardStateManager.addDelta(delta : delta)
        self.devicesManager.enqueueDelta(delta : delta)
        
        // update the scene
        self.scene.beginChanges()
        delta.applyToScene()
        self.scene.removeForefrontItem(item : self.prePathItemT)
        self.prePathItemT = PrePathItemT.nullPrePathItemT
        self.scene.endChanges()
        
        // send the data to all other devices
        self.devicesManager.send()
    }
    
    func setColor(to: CGColor){
        self.color = to
    }
    
    func setSize(to: CGFloat){
        self.size = to
    }
    
    func setOpacity(to: CGFloat){
        self.opacity = to
    }
    
    func getColor() -> CGColor {
        return self.color
    }
    
    func getSize() -> CGFloat {
        return self.size
    }
    
    // TODO : Understand applicability to iOS app
    func getCursor() -> String {
        return "default"
    }
    
    
    
    ///////////////////////
    //  LEGACY ///////////
    //////////////////////
    override func onDown(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            if self.startPoint == point {
                self.startPoint = CGPoint.zero;
            } else {
                self.startPoint = point;
                let pt = convertFromCGPoint(point : point);
                self.points.append(pt);
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
            let pt = convertFromCGPoint(point : point);
            self.points.append(pt);
        }
    }
    
    override func onUp(scene: inout Scene, sceneView: SceneView){
        //points.append(point);
        
        var lastPt = convertFromCGPoint(point: startPoint)
        if (self.points.count > 1){
            lastPt = self.points[self.points.count - 1];
        }
        let lastPoint = convertToCGPoint(point : lastPt);
        
        if lastPoint != self.startPoint {
            let resource = Resource(id: 1, devId: 1, data: points);
            let pItemState = PathItemState(id: 1, devId: 1, matrix: Matrix(), resource: resource, beginIndex: 0, endIndex: 0, color: self.color, size: self.size, opacity: self.opacity)
            let pItem = PathItem(state : pItemState);
            scene.addItem(item: pItem);
        }
        self.points = [Point]();
        sceneView.refreshView();
    }
    
    func euclidean_dist(start : Point, end : Point) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2));
        return Int(dist);
    }
    
    
    
}

