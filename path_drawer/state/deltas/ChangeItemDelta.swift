//
//  ChangeItemDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class ChangeItemDelta : Delta {
    
    var from : ItemState
    var to: ItemState
    
    init(actId: Int, devId: Int, from: ItemState, to: ItemState ) {
        self.from = from
        self.to = to
        
        super.init(type: Delta.types.ChangeItemDelta, actId: actId, devId: devId)
    }
    
    func inverse (actId: Int, devId: Int) -> ChangeItemDelta
    {
        return ChangeItemDelta(actId: actId, devId: devId, from: to, to: from)
    }
    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["itemType"] = Delta.types.ChangeItemDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId;
        obj["from"] = self.from.minify()
        obj["to"] = self.to.minify()
        
        return obj
    }
    
    static func unminify(mini: Dictionary <String,Any>) -> ChangeItemDelta{
        return ChangeItemDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, from: mini["from"] as! ItemState, to: mini["to"] as! ItemState )
    }
    
    /**
     * If the item corresponding to the itemstate this.from is on the scene, remove
     * it. Add the item corresponding to the itemstate this.to to the scene.
     */

    
    //UNCOMMENT AFTER item fully implemented
    func applyToScene (){
        //var oldItem = Scene.sharedInstance.getItemById(id: self.from.id, devId: self.from.devId)
        //var newItem = item.fromItemState(self.to)
        //if (oldItem) {
        //Scene.sharedInstance.removeSceneItem(item: oldItem)
        //}
        //sceneView.scene.addSceneItem(item: newItem)
    }
    
    //UNCOMMENT AFTER BoardState fully implemented
    func applyToBoardState (boardState: BoardState){
        //boardState.removeItemState(self.itemState.id, self.itemState.devId)
        //boardState.addItemState(self.to)
    }
    
}
