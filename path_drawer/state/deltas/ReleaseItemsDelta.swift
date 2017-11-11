//
//  ReleaseItemsDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class ReleaseItemsDelta : Delta {
    
    var holderDevId: Int
    var uids : [(id: Int, devId: Int)]
    var finalMatrix: Matrix
    var intent : GrabItemsDelta.intents
    
    init(actId: Int, devId: Int, holderDevId: Int, uids: [(id: Int, devId: Int)], finalMatrix: Matrix, intent: GrabItemsDelta.intents){
        self.holderDevId = holderDevId
        self.uids = uids
        self.finalMatrix = finalMatrix
        self.intent = intent
        
        super.init(type: Delta.types.ReleaseItemsDelta, actId: actId, devId: devId)
    }
    
    func inverse (actId: Int, devId: Int) -> GrabItemsDelta{
        return GrabItemsDelta(actId: actId, devId: devId, holderDevId: holderDevId, uids:uids, initialMatrix:finalMatrix, intent:intent)
    }
    
    func minify () -> Dictionary<String,Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["deltaType"] = Delta.types.ReleaseItemsDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId
        obj["holderDevId"] = self.holderDevId
        obj["uids"] = self.uids
        obj["finalMatrix"] = self.finalMatrix.toArray()
        obj["intent"] = self.intent
        
        return obj
    }
    
    static func unminify(mini: Dictionary<String,Any>) -> ReleaseItemsDelta {
        return ReleaseItemsDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, holderDevId: mini["holderDevId"] as! Int, uids: mini["uids"] as! [(id: Int, devId: Int)], finalMatrix: mini["finalMatrix"] as! Matrix, intent: mini["intent"] as! GrabItemsDelta.intents)
    }
    
    //UNCOMMENT WHEN ItemT fully implemented
    func applyToScene () {
        sceneView.scene.beginChanges()
        var itemT : ItemT?
        switch(self.intent){
        case GrabItemsDelta.intents.SelectionItemT:
            itemT = boardContext.devicesManager.getDevice(devId: self.holderDevId).context()["preTextItemT"] as? ItemT
            boardContext.devicesManager.getDevice(devId: self.holderDevId).context()["preTextItemT"]
            //itemT.returnItemToScene
            break
        default:
            NSLog("Error")
        }
        if (itemT != nil){
            sceneView.scene.removeForefrontItem(itemT: itemT!)
        }
        sceneView.scene.endChanges()
    }
    
    func applyToBoardState (boardState: BoardState){
        boardState.releaseItems(devId: self.holderDevId)
    }
}

