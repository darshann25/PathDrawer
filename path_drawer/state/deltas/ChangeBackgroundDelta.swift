//
//  ChangeBackgroundDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class ChangeBackgroundDelta : Delta {
    var from : ItemState
    var to : ItemState
    
    init( actId: Int, devId: Int,from : ItemState, to : ItemState) {
        self.from = from
        self.to = to
        
        super.init(type: Delta.types.ChangeBackgroundDelta,actId: actId,devId: devId)
    }
    
    enum types {
        case Parameter
        case Document
        case Page
    }

    func minify() -> Dictionary<String,Any>{
        
        var obj = [String : Any]()
        obj["version"] = 1
        obj["itemType"] = Delta.types.ChangeBackgroundDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId
        obj["from"] = self.from
        obj["to"] = self.to
        return obj
    }
    
    static func unminify(mini: Dictionary<String, Any>) ->ChangeBackgroundDelta{
        return ChangeBackgroundDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int,from:  mini["from"] as! ItemState,to: mini["to"] as! ItemState);

    }
    
    //UNCOMMENT AFTER scene fully implemented
    func applyToScene()
    {
        //var background = sceneView.scene.getBackground()
            var change = self.to
        //if(change.type = ChangeBackgroundDelta.types.Document){
            //if(change.value == NSNull)
            //{
                //background.removeDocument(change.id,change.devId)
            //}
            //else{
                //background.addDocument(Document(change.value))
        //}
    }
    
    
    
    //UNCOMMENT AFTER
    func applyToBoardState (boardState: BoardState)
    {
        
        var change = self.to;
        var devId = change.devId;
        var id = change.id;
        var state = boardState.getBackground();
        //if (change.type == ChangeBackgroundDelta.types.Document)
        //{
            //if (change.value == NSNull) {
                //deletestate.documents[devId][id];
            //}
            //else
            //{
                //if (!(devId in state.documents)) {
                    //state.documents[devId] = {}
                //}
                //state.documents[devId][id] = change.value;
            //}
    }
    //boardState.setBackground(state)
    
}

