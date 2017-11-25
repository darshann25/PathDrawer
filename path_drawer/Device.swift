//
//  Device.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class Device {
    
    var id : Int
    var peerId : Int
    var accessLevel : String
    var context : Dictionary<String, Any>
    
    init(id: Int, peerId: Int, accessLevel: String){
        self.id = id
        self.peerId = peerId
        self.accessLevel = accessLevel
        
        // keep track of items this device is managing
        self.context = [
            "delN" : 0,
            "haloItemT" : null,
            "prePathItemT" : null,
            "preTextItemT" : null,
            "viewRectItemT" : null,
            "selectionItemT" : null
        ]
        
        self.inCall = false
        self.inCallWithThisDevice = false;
        self.suppliesAudio = false;
        self.suppliesVideo = false;
    }
    
    // keep track of device call state
    var inCall : Bool
    var inCallWithThisDevice : Bool
    var suppliesAudio : Bool
    var suppliesVideo : Bool

    /*if (self.id >= 0){
        var haloItemT = HaloItemT(peerID)
    
    }*/
    
    // returns true if message successfully sent directly
    // TODO : WebRTC Support needed
    func sendMessageDirectly(type : String, message : String) -> Bool {
        return false;
    }
}
