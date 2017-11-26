//
//  DeleteItemDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

// class DeleteItemDelta inherits Delta
class DeleteItemDelta : Delta {
    
    var itemState : ItemState
    
    init(actId: Int, devId: Int, itemState: ItemState) {
        self.itemState = itemState
        
        super.init(type: Delta.types.DeleteItemDelta, actId: actId, devId: devId)
    }
    
    func inverse (actId: Int, devId: Int) -> NewItemDelta {
        return NewItemDelta(actId: actId, devId: devId, itemState: self.itemState)
    }
    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["itemType"] = Delta.types.DeleteItemDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId;
        obj["itemState"] = self.itemState.minify()
        
        return obj
    }
    static func unminify(mini: Dictionary <String,Any>) -> DeleteItemDelta{
        return DeleteItemDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, itemState: mini["itemState"] as! ItemState)
    }
    
    func applyToScene (){
        var item = Scene.sharedInstance.getItemById(id: self.itemState.id, devId: self.itemState.devId)
        Scene.sharedInstance.removeSceneItem(item: item)
    }
    
    func applyToBoardState (boardState: BoardState){
        boardState.removeItemState(id: self.itemState.id, devId: self.itemState.devId)
    }

}
