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
    }
    
    func minify(){
    }
    
    func unminify(obj: Dictionary <String,Any>){
        var version : Int = -1
        if (!(obj["version"] != nil)) {
            version = obj["version"] as! Int
        }
        else {
            print ("Delta has no version")
            return
        }
        if (obj["deltaType"] != nil) {
            let type = obj["deltaType"]
        }
        else {
            print ("Delta has no deltaType")
        }
        /*switch (type) {
         case types.NewItemDelta:
         return unminify(obj:NewItemDelta)
         
         case types.ChangeItemDelta:
         return unminify(obj:ChangeItemDelta)
         
         case types.DeleteItemDelta:
         return unminify(obj:DeleteItemDelta)
         
         case types.GrabItemsDelta:
         return unminify(obj:GrabItemsDelta)
         
         case types.TransformItemsDelta:
         return unminify(obj:TransformItemsDelta)
         
         case types.ReleaseItemsDelta:
         return unminify(obj:ReleaseItemsDelta)
         
         case types.ChangeBackgroundDelta:
         return unminify(obj:ChangeBackgroundDelta)
         
         default:
         print ("Delta.unminify(): unknown type")
         }*/
    }
}

