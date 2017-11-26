//
//  GrabItemsDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

// class GrabItemsDelta inherits Delta
class GrabItemsDelta : Delta {
    
    var holderDevId: Int
    var uids : [(id: Int, devId: Int)]
    var initialMatrix: Matrix
    var intent : GrabItemsDelta.intents
    
    init(actId: Int, devId: Int, holderDevId: Int, uids: [(id: Int, devId: Int)], initialMatrix: Matrix, intent: GrabItemsDelta.intents){
        self.holderDevId = holderDevId
        self.uids = uids
        self.initialMatrix = initialMatrix
        self.intent = intent
        
        super.init(type: Delta.types.GrabItemsDelta, actId: actId, devId: devId)
    }
    
    
    func inverse (actId: Int, devId: Int) -> ReleaseItemsDelta {
        return ReleaseItemsDelta(actId : actId, devId : devId, holderDevId : holderDevId, uids : uids, finalMatrix : initialMatrix, intent : intent)
    }
    
    enum intents {
        case SelectionItemT
        case PreTextItemT
    }
    
    func minify () -> Dictionary<String,Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["deltaType"] = Delta.types.GrabItemsDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId
        obj["holderDevId"] = self.holderDevId
        obj["uids"] = self.uids
        obj["initialMatrix"] = self.initialMatrix.toArray()
        obj["intent"] = self.intent
        
        return obj
    }
    
    static func unminify(mini: Dictionary<String,Any>) -> GrabItemsDelta {
        return GrabItemsDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, holderDevId: mini["holderDevId"] as! Int, uids: mini["uids"] as! [(id: Int, devId: Int)], initialMatrix: mini["initialMatrix"] as! Matrix, intent: mini["intent"] as! GrabItemsDelta.intents)
    }
    
    func applyToScene (){
        Scene.sharedInstance.beginChanges()
        var items = [Item]()
        var initialMatrixInverse = self.initialMatrix.inverse()
        for i in 0...(self.uids.count - 1) {
            let itemId = self.uids[i].id
            let itemDevId = self.uids[i].devId
            let item = Scene.sharedInstance.getItemById(id: itemId, devId: itemDevId)
            Scene.sharedInstance.removeSceneItem(item: item)
            item.setMatrix(matrix: initialMatrixInverse.times(that: item.getMatrix()))
            items.append(item)
        }
        
     
        let devicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
        var isMyGrab = (self.holderDevId == devicesManager.getMyDeviceId())
        var itemT : ItemT
        switch (self.intent) {
            case GrabItemsDelta.intents.SelectionItemT:
                itemT = SelectionItemT(items: items, showButtons: isMyGrab)
                let holderDevice = devicesManager.getDevice(devId: self.holderDevId)
                holderDevice.context["selectionItemT"] = itemT
                itemT.setMatrix(matrix : self.initialMatrix)
                break
            
            case GrabItemsDelta.intents.PreTextItemT:
                item = items[0] as! TextItem
                itemT = item.createPreTextItemT()
                devicesManager.getDevice(self.holderDevId).context()["preTextItemT"] = itemT
                if (isMyGrab) {
                    // detailsMenuController.switchToTextMenu();
                }
                break
            
            default:
                // analytics.unexpected('GrabItemsDelta.applyToScene(), intent switch', this.intent)
                NSLog("Error in GrabItemsDelta.applyToScene()")
                break
        }
    
        if (itemT != ItemT.nullItemT) {
            if (isMyGrab){
                SelectDetailsMenuController.selectionAvailable()
                itemT.setRespondsToHoverEvents(val: true)
                itemT.setRespondsToClickEvents(val: true)
                itemT.setRespondsToKeyEvents(val: true)
                Scene.sharedInstance.setActiveClickResponder(itemT)
            }
         Scene.sharedInstance.addForefrontItem(itemT)
        }
        Scene.sharedInstance.endChanges()
    }
    
    func applyToBoardState (boardState: BoardState){
        boardState.grabItems(devId: self.holderDevId, uids: self.uids, initialMatrix: self.initialMatrix, intent: self.intent)
    }
}
