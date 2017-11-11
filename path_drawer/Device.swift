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
    
    init(id: Int, peerId: Int, accessLevel: String){
        self.id = id
        self.peerId = peerId
        self.accessLevel = accessLevel
        self.inCall = false
        self.inCallWithThisDevice = false;
        self.suppliesAudio = false;
        self.suppliesVideo = false;
    }
    
    // keep track of items this device is managing
    func context() -> Dictionary<String, Any> {
        var context = [String: Any]()
        context["delN"] = 0
        context["haloItemT"] = nil
        context["prePathItemT"] = nil
        context["preTextItemT"] = nil
        context["viewRectItemT"] = nil
        context["selectionItemT"] = nil
        return context
    }
    
    // keep track of device call state
    var inCall : Bool
    var inCallWithThisDevice : Bool
    var suppliesAudio : Bool
    var suppliesVideo : Bool

    /*if (self.id >= 0){
        var haloItemT = HaloItemT(peerID)
    
    }*/
}
