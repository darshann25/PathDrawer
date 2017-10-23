//
//  MagicEraserTool.swift
//  MagicEraserTool
//
//  Created by Haixin on 2017/10/10.
//  Copyright © 2017年 Haixin Wang. All rights reserved.
//

import Foundation

/*
 * MagicEraserTool is responsible for removing entire items that are hit by the mouse drag.
 */

class MagicEraserTool {
    /*
    // Used to determine the swipe segment, which is used to locate any items.
    var previousPoint;
    var actId = null;
    
    func onDown() {
        previousPoint = [CGPoint]();
        actId = null;
    }
    
    func onDrag() {
        var point = CGPoint.zero;
        var items = scene.getItemsIntersectingSegment(point, previousPoint);
        if (items.length > 0) {
            if (!actId) {
                actId = boardStateManager.getNewActId();
            }
            var deviceId = devicesManager.getMyDeviceId();
            scene.beginChanges();
            items.forEach(function(item) {
                var delta = DeleteItemDelta(actId,
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
    
    func onUp() {
        // Just to be safe...
        previousPoint = null;
        actId = null;
    }
    
    var public_interface = {
        onDown: onDown;
        onDrag: onDrag;
        onUp: onUp,
        func getCursor();
    };
    return public_interface;
*/
}


