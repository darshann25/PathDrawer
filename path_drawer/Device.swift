//
//  Device.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

// class Device
class Device {
    
    var id : Int
    var peerId : Int
    var accessLevel : String
    var context : Dictionary<String, Any>
    
    var inCall : Bool
    var inCallWithThisDevice : Bool
    var suppliesAudio : Bool
    var suppliesVideo : Bool
    
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
        
        // keep track of device call state
        self.inCall = false
        self.inCallWithThisDevice = false
        self.suppliesAudio = false
        self.suppliesVideo = false
        
        // id is initially set to -1 for this device.
        if(self.id >= 0) {
            // create the haloItemT
            var haloItemT = HaloItemT(peerId : peerId)
            Scene.sharedInstance.addForefrontItem(itemT: haloItemT)
            self.context["haloItemT"] = haloItemT
            
            // create the viewRectItemT
            var viewRectItemT = ViewRectItemT(peerId : peerId)
            Scene.sharedInstance.addForefrontItem(itemT: viewRectItemT)
            self.context["viewRectItemT"] = viewRectItemT
            
            // TODO : set up the WebRTC stream connection (if device belongs to different peer)
            
        }
    }

    // returns true if message successfully sent directly
    // TODO : WebRTC Support needed
    func sendMessageDirectly(type : String, message : String) -> Bool {
        // return this.dataConnection.sendObject({ type: type, message: message });
        return false;
    }
    
    func getStatus() {
        return "getStatus() not implemented yet."
    }
    
    func onLeft() {
        var scene = Scene.sharedInstance
        var boardStateManager = BoardViewController.BoardContext.sharedInstance.boardStateManager
        var messanger = BoardViewController.BoardContext.sharedInstance.messenger
        
        scene.beginChanges()
        scene.removeForefrontItem(itemT: self.context["haloItemT"] as! ItemT)
        scene.removeForefrontItem(itemT: self.context["viewRectItemT"] as! ItemT)
        
        if(self.context["selectionItemT"] != nil) {
            sItemT = self.context["selectionItemT"] as! SelectionItemT
            sItemT.returnsItemsToScene()
            scene.removeForefrontItem(itemT: sItemT)
            self.context["selectionItemT"] = nil
        }
        
        boardStateManager.onDeviceLeft(devId: self.id)
        scene.endChanges()
        if(self.inCall) {
            var data : [String : Any] = [
                "peerId" : self.peerId,
                "devId" : self.devId
            ]
            messanger.fakeIncomingMessage(type: "hangup", message: data, from: self.id)
        }
    }
}
