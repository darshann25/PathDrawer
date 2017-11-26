//
//  Delta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

/*
 Deltas define changes to the underlying state of the board. Their behavior is specified by the abstract class Delta. For ui-only changes that may be very frequent, see Dels instead. Each Delta has a specific type (see the enum Delta.types) and a (actId,devId) pair (used to refer to groups of Deltas corresponding to a single action for an undo/redo operation or an acknowledgement).
 
 List of subclasses of Delta
 + NewItemDelta (to introduce a new item)
 + ChangeItemDelta (to change a property of an item) NOT BEING USED
 + DeleteItemDelta (to delete an item)
 + GrabItemsDelta (selects items, reserving them to avoid conflicts)
 + TransformItemsDelta (applies a transformation to all grabbed items)
 + ReleaseItemsDelta (inverse of GrabItemsDelta)
 + ChangeBackgroundDelta
 
 List of functions to use outside this file
 + constructors for subclasses
 + minify()
 + static unminify(mini,devId)
 + inverse()
 + applyToScene
 + applyToBoardState
 
 TODO make sure this file makes sense even outside the context of a Scene
 
 */


import Foundation

/*
 List of state changes that need to be supported
 + user draws path (NewItemDelta)
 + user erases path (DeleteItemDelta)
 + user selects items (nothing)
 + user moves/resizes selection (multiple ChangeItemDeltas)
 + user copies items (multiple NewItemDeltas)
 + user deletes selection (multiple DeleteItemDeltas)
 */

// abstract class Delta
class Delta {
    
    public static let nullDelta = NullDelta()
    
    var type : Delta.types
    var actId : Int
    var devId : Int
    
    init (type: Any, actId: Int, devId: Int){
        self.type = type
        self.actId = actId
        self.devId = devId
    }
    
    enum types {
        case NewItemDelta
        case ChangeItemDelta
        case DeleteItemDelta
        case GrabItemsDelta
        case TransformItemsDelta
        case ReleaseItemsDelta
        case ChangeBackgroundDelta
        case Unknown
    }
    
    // returns a compact object that can be used to reproduce the Delta on another device
    // abstract
    func minify(){
        // null function
    }
    
    func unminify(obj : Dictionary <String,Any>) -> Delta{
        
        // all minify implementations must contain a version number
        var version : Int = -1
        if (obj["version"] != nil) {
            version = obj["version"] as! Int
        }
        else {
            NSLog("Delta has no version")
        }
        if (obj["deltaType"] != nil) {
            let _ = obj["deltaType"]
        }
        else {
            NSLog("Delta has no deltaType")
        }
        
        switch (type) {
         case types.NewItemDelta:
            return NewItemDelta.unminify(mini: obj)
         
         case types.ChangeItemDelta:
            return ChangeItemDelta.unminify(mini: obj)
         
         case types.DeleteItemDelta:
            return DeleteItemDelta.unminify(mini: obj)
         
         case types.GrabItemsDelta:
            return GrabItemsDelta.unminify(mini: obj)
         
         case types.TransformItemsDelta:
            return TransformItemsDelta.unminify(mini: obj)
         
         case types.ReleaseItemsDelta:
            return ReleaseItemsDelta.unminify(mini: obj)
         
         case types.ChangeBackgroundDelta:
            return ChangeBackgroundDelta.unminify(mini: obj)
         
         default:
            NSLog("Delta.unminify(): unknown type")
            return Delta.nullDelta
         }
    }
    
    // abstract
    func applyToScene() {
        // null function
    }
    
    func applyToBoardState() {
        // null function
    }
}

private class NullDelta : Delta {
    init() {
        
    }
    
}
