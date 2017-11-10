//
//  MagicEraserTool.swift
//  MagicEraserTool
//
//  Created by Haixin on 2017/10/10.
//  Copyright © 2017年 Haixin Wang. All rights reserved.
//

import Foundation
import UIKit

/*
 * MagicEraserTool is responsible for removing entire items that are hit by the mouse drag.
 */

class MagicEraserTool : Tool {
    // Used to determine the swipe segment, which is used to locate any items.
    var previousPoint : Point;
    var actId : Any;
    
    init(point : Point, id : Int) {
        self.previousPoint = point;
        self.actId = id;
    }
    
    func onDown(x : Double, y : Double) {
        self.previousPoint = Point(x : x, y : y);
        actId = -1;
    }
    
    func onDrag(_x : Double, _y : Double) {
        let point = Point(x : _x, y : _y);
        var items = sceneView.scene.getItemsIntersectingSegment(end1: point, end2: self.previousPoint);
        
        if(items.count > 0) {
            if(actId is Int) {
                //self.actId = boardStateManager.getNewActId();
            }
        }
    }
    
    /*
     export default function MagicEraserTool() {
     
     // Used to determine the swipe segment, which is used to locate any items.
     var previousPoint;
     var actId = null;
     
     function onDown(x, y) {
     previousPoint = new Point(x, y);
     actId = null;
     }
     
     function onDrag(x, y) {
     var point = new Point(x, y);
     var items = scene.getItemsIntersectingSegment(point, previousPoint);
     if (items.length > 0) {
     if (!actId) {
     actId = boardStateManager.getNewActId();
     }
     var deviceId = devicesManager.getMyDeviceId();
     scene.beginChanges();
     items.forEach(function(item) {
     var delta = new DeleteItemDelta(actId,
     deviceId,
     item.state);
     boardStateManager.addDelta(delta);
     devicesManager.enqueueDelta(delta);
     delta.applyToScene(); // scene.removeSceneItem(item);
     });
     scene.endChanges();
     devicesManager.send();
     }
     previousPoint = point;
     }
     
     function onUp() {
     // Just to be safe...
     previousPoint = null;
     actId = null;
     }
     
     var public_interface = {
     onDown: onDown,
     onDrag: onDrag,
     onUp: onUp,
     getCursor: function() { return 'default'; },
     };
     return public_interface;
     }
     */
}


