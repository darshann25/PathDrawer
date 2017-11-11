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
    var from : Int
    var to : Int
    

    init( actId: Int, devId: Int,from : Int /*should be changed*/ , to : Int /*should be changed*/ ) {
        self.from = from
        self.to = to
        
        super.init(type: Delta.types.NewItemDelta/*should be changed to ChangeBackgroundDelta*/,actId: actId,devId: devId)
        
    }
    
    /* Untouched website code
     
     
     ChangeBackgroundDelta.prototype = Object.create(Delta.prototype);
     ChangeBackgroundDelta.prototype.constructor = ChangeBackgroundDelta;
     
     // enum
     ChangeBackgroundDelta.types = {
     Parameter: 'param',
     Document: 'doc',
     Page: 'page',
     };

     
     */
    
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
    
    func unminify(mini: Dictionary<String, Any>) ->ChangeBackgroundDelta{
        return ChangeBackgroundDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int,from:  mini["from"] as! Int,to: mini["to"] as! Int);

    }
    
    func applyToScene() //Needs to be completely implemented
    {/*
        var background = scene.getBackground()
            var change = self.to
        if(change.type == ChangeBackgroundDelta.types.Document){
            if(change.value == NSNull)
            {
                background.removeDocument(change.id,change.devId)
            }
            else
                background.addDocument(Document(change.value))
        }*/
    }
    
    
    
    //Needs to be implemented
    func applyToBoardState (/*boardState*/ /*Type needs to be given*/)
    {
        /*
        var change = self.to;
        var devId = change.devId;
        var id = change.id;
        var state = boardState.getBackground();
        if (change.type === ChangeBackgroundDelta.types.Document)
        {
            if (change.value == NSNull) {
                delete state.documents[devId][id];
            }
            else
            {
                if (!(devId in state.documents)) {
                    state.documents[devId] = {}
                }
                state.documents[devId][id] = change.value;
            }
    }
    boardState.setBackground(state);
         */
    }
    
}

