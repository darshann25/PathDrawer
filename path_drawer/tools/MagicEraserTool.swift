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
    var actId : Int;
    
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
        let items = sceneView.scene.getItemsIntersectingSegment(end1: point, end2: self.previousPoint);
        
        if(items.count > 0) {
            if(actId != -1) {
                self.actId = sceneView.boardContext.boardStateManager.getNewActId();
            }
            
            let deviceId = sceneView.boardContext.devicesManager.getMyDeviceId();
            sceneView.scene.beginChanges();
            //self.messenger.onMessage(type : "entire_board_state", f: {message, type in
            //});
            
            items.forEach{item in
                let delta = DeleteItemDelta(actId: self.actId, devId: deviceId, itemState: item.state);
                sceneView.boardContext.boardStateManager.addDelta(delta : delta);
                sceneView.boardContext.devicesManager.enqueueDelta(delta : delta);
                delta.applyToScene(); // scene.removeSceneItem(item);
            };
            sceneView.scene.endChanges();
            sceneView.boardContext.devicesManager.send();
        }
        self.previousPoint = point;
    }
    
    func onUp() {
        // TODO : Null previousPoint
        self.previousPoint = Point(x : 0, y : 0);
        self.actId = -1;
    }
    
    func getCursor() -> String {
        return "default";
    }
    
}


