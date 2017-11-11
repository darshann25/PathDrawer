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
    
    init(actId: Int, devId: Int, itemState: ItemState) {
        self.itemState = itemState
        
        super.init(type: Delta.types.NewItemDelta, actId: actId, devId: devId)
    }
    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["itemType"] = Delta.types.NewItemDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId;
        obj["itemState"] = self.itemState.minify()
        
        return obj
    }
    func unminify(mini: Dictionary <String,Any>) -> NewItemDelta{
        return NewItemDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, itemState: mini["itemState"] as! ItemState)
    }
    
    //UNCOMMENT AFTER item fully implemented
    func applyToScene (){
        //var item = scene.getItemById(self.itemState)
        //Scene.addSceneItem(item)
    }
    
    //UNCOMMENT AFTER BoardState fully implemented
    func applyToBoardState (boardState: BoardState){
        //boardState.removeItemState(self.itemState.id, self.itemState.devId)
    }

}
