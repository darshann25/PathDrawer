//
//  GrabItemsDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
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
    
    //UNCOMMENT AFTER implementing ReleaseItemsDelta
    //func inverse (actId: Int, devId: Int) -> ReleaseItemsDelta{
        //return ReleaseItemsDelta(actId: actId, devId: devId, holderDevId: holderDevId, uids:uids, initialMatrix:initialMatrix, intent:intent)
    //}
    
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
    
    func unminify(mini: Dictionary<String,Any>) -> GrabItemsDelta {
        return GrabItemsDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, holderDevId: mini["holderDevId"] as! Int, uids: mini["uids"] as! [(id: Int, devId: Int)], initialMatrix: mini["initialMatrix"] as! Matrix, intent: mini["intent"] as! GrabItemsDelta.intents)
    }
    
    //UNCOMMENT AFTER implementing scene
    func applyToScene (){
        //Scene.beginChanges()
        var items = [Item]()
        var initialMatrixInverse = self.initialMatrix.inverse()
        var i = 0
        while (i < uids.count) {
            var itemId = self.uids[i].id
            var itemDevId = self.uids[i].devId
            //var item = Scene.getItemById(itemId, itemDevId)
            //Scene.removeSceneItem(item)
            //item.setMatrix(initialMatrixInverse.times(item.getMatrix()))
            //item.push(item)
            i += i
        }
        
        //UNCOMMENT AFTER implementing DevicesManager, SelectionItemT, ItemT
        //var isMyGrab = (self.holderDevId == DevicesManager.getMyDeviceId())
        var itemT : ItemT
        switch (intent) {
        case GrabItemsDelta.intents.SelectionItemT:
            //itemT = SelectionItemT(items, isMyGrab)
            //DevicesManager.getDevice(self.holderDevId).context.selectionItemT = itemT
            //itemT.setMatrix(self.initialMatrix)
            break
        case GrabItemsDelta.intents.PreTextItemT:
            //itemT = items[0].createPreTextItemT
            //DevicesManager.getDevice(self.holderDevId).context.preTextItemT = itemT
            //if (isMyGrab) {
            //    detailsMenuController.switchToTextMenu();
            //}
            break
        default:
            NSLog("Error")
        }
        
        /*
        if (itemT != nil) {
            if (isMyGrab){
                SelectDetailsMenuController.selectionAvailable()
                itemT.setRespondsToHoverEvents(val: true)
                itemT.setRespondsToClickEvents(val: true)
                itemT.setRespondsToKeyEvents(val: true)
                Scene.setActiveClickResponder(itemT)
            }
         Scene.addForefrontItem(itemT)
        }
        Scene.endChanges()
         */
    }
    func applyToBoardState (boardState: BoardState){
        //BoardState.grabItems(self.holderDevId, self.uids, self.initialMatrix, self.intent)
    }
}
