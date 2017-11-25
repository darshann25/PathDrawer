//
//  NewItemDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class NewItemDelta : Delta {
    
    var itemState : ItemState
    
    // class NewItemDelta inherits Delta
    init(actId: Int, devId: Int, itemState: ItemState) {
        self.itemState = itemState
        self.inverse = { actId, devId in
            return DeleteItemDelta(actId: actId, devId: devId, itemState: self.itemState)
        }
        
        super.init(type: Delta.types.NewItemDelta, actId: actId, devId: devId)
    }
    
    func inverse (actId: Int, devId: Int) -> DeleteItemDelta {
        return DeleteItemDelta(actId: actId, devId: devId, itemState: self.itemState)
    }
    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["itemType"] = Delta.types.NewItemDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId
        obj["itemState"] = self.itemState.minify()
        
        return obj
    }
    static func unminify(mini: Dictionary <String,Any>) -> NewItemDelta{
        
        // Might need to add a switch statement to call the unminify function for Item based on ItemType
        var itemState = ItemState.unminify(mini : mini)
        return NewItemDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, itemState: itemState as! ItemState)
    }
    
    func applyToScene (){
        var item = Item.fromItemState(self.itemState)
        Scene.sharedInstance.addSceneItem(item)
    }
    
    func applyToBoardState (boardState: BoardState){
        boardState.addItemState(itemState: self.itemState)
    }

}
