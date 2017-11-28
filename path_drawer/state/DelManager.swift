//
//  DelManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

/*
 Dels define ui changes that don't affect the state of the board.
 
 By design, they are very light, as they may sometimes be fired very quickly, and are not added to an undo/redo stack.
 
 Changes that affect the state of the board are Deltas, not Dels. Some Dels eventually 'become' Deltas after a short period of time. For example, if a user drags an item around the Scene, a sequence of Dels are sent so that other peers see the item being dragged around. Then, after the dragging stops, a Delta is released that actually updates the location of the items.
 
 Each del has a variable N, which is used to ensure a particular order is followed. The context for a given device has a delN variable, and a del is rejected if del.N!=context.delN. There is one exception, that if a del has the property 'new' and del.N>context.delN, then context.delN is set to del.N.
 
 Dels may have different priority levels. TODO
 */
class DelManager {
    typealias PenFunctionCallback = ([String : Any], [String : Any]) -> ()
    typealias DeviceId = Int
    typealias MessageCallback = ([String : Any], DeviceId) -> ()
    typealias DelN = Int
    
    private var _dels : [String : PenFunctionCallback]
    private var _currentDelN : DelN
    
    private var messenger : Messenger = BoardViewController.BoardContext.sharedInstance.messenger
    private var devicesManager : DevicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
    
    init() {
        self._dels = [String : PenFunctionCallback]()
        self._currentDelN = 0
        
        var delFunction : MessageCallback = { del, from in
            if(_dels[del["type"] as! String] != nil) {
                var context = self.devicesManager.getDevice(devId: from).context
                if(del["new"] != nil) {
                    del["N"] = del["new"]
                    if(del["N"] as! Int > context["delN"] as! Int) {
                        context["delN"] = del["N"]
                    }
                }
                if(context["delN"] as! Int == del["N"] as! Int) {
                    self._dels[del["type"] as! String](del, context)
                } else {
                    NSLog("del had unknown type : " + del["type"])
                }
            }
        }
        
        self.messenger.onMessage(type: "del", f: delFunction)
        
        // when a pen is down and drags for the first time
        self._dels["penStart"] = {del, context in
            var prePathItemT : PrePathItemT = PrePathItemT()
            context["prePathItemT"] = prePathItemT
            prePathItemT.setColor(color: del["color"] as! CGColor)
            prePathItemT.setSize(size: del["size"] as! CGFloat)
            prePathItemT.setOpacity(opacity: del["opacity"] as! CGFloat)
            prePathItemT.addPoint(x: del["x0"] as! Double, y: del["y0"] as! Double)
            prePathItemT.addPoint(x: del["x"] as! Double, y: del["y"] as! Double)
            Scene.sharedInstance.addForefrontItem(itemT: prePathItemT)
        }
        
        // when a pen drags
        self._dels["pen"] = {del, context in
            Scene.sharedInstance.beginChanges()
            
            (context["prePathItemT"] as! PrePathItemT).addPoint(x: Double(del["x"]), y: Double(del["y"]))
            (context["haloItemT"] as! HaloItemT).updateLocation(x: Double(del["x"]), y: Double(del["y"]))
            
            Scene.sharedInstance.endChanges()
        }
        
        // when a pen is lifted
        self._dels["penEnd"] = {del, context in
            Scene.sharedInstance.removeForefrontItem(itemT: context["prePathItemT"] as! PrePathItemT)
            context["prePathItemT"] = ItemT.nullItemT
        }
        
        // when a halo location is updated
        self._dels["halo"] = {del, context in
            (context["haloItemT"] as! HaloItemT).updateLocation(x: Double(del["x"]), y: Double(del["y"]))
        }

        // when a user's view rect is updated
        self._dels["view"] = {del, context in
            (context["viewRectItemT"]).updateRect(rectArray : del["rect"] as! [Double]) 
        }
        
        // when a user drags a SelectionItemT
        self._dels["selDrag"] = {del, context in
            Scene.sharedInstance.beginChanges()
            (context["selectionItemT"] as! SelectionItemT).setMatrix(matrix: Matrix.fromArray(del["matrix"] as! [Double]))
            (context["haloItemT"] as! HaloItemT).hide()
            Scene.sharedInstance.endChanges()
        }
        
         // when a user edits a textItem
        self._dels["textKeyDown"] = {del, context in
            Scene.sharedInstance.beginChanges()
            if(context["preTextItemT"] != nil || context["preTextItemT"] != ItemT.nullItemT) {
            //    (context["preTextItemT"] as! PrePathItemT).setBuffer(buffer : TextBuffer.fromObject(object : del["buffer"]))
            }
            Scene.sharedInstance.endChanges()
        }
        
    }
    
    public func newDelN() -> DelN {
        return ++self._currentDelN
    }
    
    public func currentDelnN() -> DelN {
        return self._currentDelnN
    }
}
