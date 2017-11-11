//
//  Delta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class Delta {
    var type : Any
    var actId : Int
    var devId : Int
    //var inverse : Any
    
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
    
    func minify(){
    }
    
    func unminify(obj: Dictionary <String,Any>) -> Delta{
        var version : Int = -1
        if (!(obj["version"] != nil)) {
            version = obj["version"] as! Int
        }
        else {
            print ("Delta has no version")
        }
        if (obj["deltaType"] != nil) {
            let type = obj["deltaType"]
        }
        else {
            print ("Delta has no deltaType")
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
         print ("Delta.unminify(): unknown type")
            return Delta(type: types.Unknown, actId: actId, devId: devId)
         }
    }
}

