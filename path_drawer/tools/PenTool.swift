//
//  PenTool.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class PenTool {
    var points = [CGPoint]();
    var startPoint = CGPoint.zero;
    
    init () {
    }
    
    func onDown(touches: Set<UITouch>, sceneView: SceneView) {
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            // sets the startPoint to avoid creating a dot
            if startPoint == point {
                startPoint = CGPoint.zero;
            } else {
                startPoint = point;
                points.append(point);
            }
        }
    }
    
    func onMove(touches: Set<UITouch>, sceneView: SceneView){
        // holds the distance of the interpolation between two points
        // var euclid_dist = 0;
        
        if let touch = touches.first {
            let point = touch.location(in: sceneView);
            //if !(prevPoint.x == point.x && prevPoint.y == point.y){
            //    euclid_dist = interpolate_points(start: &prevPoint, end: &point);
            //}
            points.append(point);
        }
    }
    
    func onUp(scene: inout Scene, sceneView: SceneView){
        //points.append(point);
        let lastPoint = points[points.count - 1];
        
        if lastPoint != startPoint {
            let pItem = PathItem(pointsArr: points);
            scene.addItem(item: pItem);
        }
        points = [CGPoint]();
        sceneView.refreshView();
    }
    
    
    func euclidean_dist(start : CGPoint, end : CGPoint) -> Int {
        let dist = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        return Int(dist)
    }
    
    /*
     // Fix interpolation
     func interpolate_points(start: inout CGPoint, end : inout CGPoint) -> Int {
     var curr = start;
     
     while curr != end {
     if curr.x < end.x {
     curr.x += 1;
     }
     
     if curr.x > end.x {
     curr.x -= 1;
     }
     
     if curr.y < end.y {
     curr.y += 1;
     }
     
     if curr.y > end.y {
     curr.y -= 1;
     }
     
     points.append(curr)
     }
     
     return euclidean_dist(start: start, end: end)
     }*/
    
}

//
//  PenTool.swift
//  PenTool
//
//  Created by Haixin on 2017/10/10.
//  Copyright © 2017年 Haixin Wang. All rights reserved.
//
/*
 import Foundation
 import UIKit
 import Matrix from '../geometry/Matrix.js';
 import NewItemDelta from '../state/deltas/NewItemDelta.js';
 import PrePathItemT from '../itemTs/PrePathItemT.js';
 import Resource from '../state/Resource.js';
 import PathItemState from '../state/itemstates/PathItemState.js';
 
 class PenTool {
 
 // The current PrePathItemT
 var prePathItemT;
 // The initial point
 var x = 0.00;
 var y = 0.00;
 }
 //var x0, y0;
 
 // The color
 var color;
 var size;
 var opacity;
 
 func setColor() {
 color = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
 }
 
 func setSize() {
 size = 1;
 }
 
 func setOpacity() {
 Opacity : Float { get set }
 }
 
 func onDown() {
 init (x: Double, y: Double){
 self.x = x;
 self.y = y;
 }
 }
 
 func onDrag(touches: Set<UITouch>, sceneView: SceneView) {
 if let touch = touches.first {
 let point = touch.location(in: sceneView);
 messenger.broadcastDel({
 type: "pen",
 N: delManager.currentDelN(),
 x: x, y: y,
 });
 } else {
 // This is the first drag. Make the prePathItemT now and add it to the Scene.
 var points = [CGPoint]()
 init (pointsArr: [CGPoint]) {
 for point in pointsArr {
 points.append(point)
 }
 }
 func draw() {
 for point in points {
 let dot = UIBezierPath(ovalIn : CGRect(x : point.x-5, y : point.y-5, width : 10, height : 10));
 UIColor.red.setFill();
 dot.fill();
 }
 }
 }
 }
 
 func onUp(scene: inout Scene, sceneView: SceneView){
 //points.append(point);
 let lastPoint = points[points.count - 1];
 
 if lastPoint != startPoint {
 let pItem = PathItem(pointsArr: points);
 scene.addPathItem(pathItem: pItem);
 }
 sceneView.refreshView();
 }
 
 var deviceId = devicesManager.getMyDeviceId();
 // create a resource
 var xs = prePathItemT.getXList();
 var ys = prePathItemT.getYList();
 var resource = newResource(boardStateManager.getNewResourceId(),
 deviceId,
 [xs, ys]);
 boardStateManager.addResource(resource);
 devicesManager.enqueueResource(resource);
 
 // create the itemState
 var itemState = new.PathItemState(boardStateManager.getNewItemId(),
 deviceId,
 Matrix.identityMatrix(),
 resource,
 0,
 xs.length - 1,
 color,
 size,
 opacity);
 
 // create the delta
 var delta = new NewItemDelta(boardStateManager.getNewActId(),
 deviceId,
 itemState);
 boardStateManager.addDelta(delta);
 devicesManager.enqueueDelta(delta);
 
 // update the scene
 scene.beginChanges();
 delta.applyToScene();
 scene.removeForefrontItem(prePathItemT);
 prePathItemT = null;
 scene.endChanges();
 
 // send the data to all other devices
 devicesManager.send();
 }
 
 var public_interface = {
 onDown: onDown,
 onDrag: onDrag,
 onUp: onUp,
 getCursor: function() { return 'default'; },
 setColor: setColor,
 setSize: setSize,
 setOpacity: setOpacity,
 getColor: function() { return color; },
 getSize: function() { return size; },
 };
 
 return public_interface;
 
 }
 */


