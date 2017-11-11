//
//  Peer.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class Peer {
    
    var peerId : Int;
    var colorIndex : Int;
    var color : String;
    var name : String;
    var devices : [Device];
    var inCall : Bool;
    var rejectedRecentCall : Bool;
    
    init(peerId : Int) {
        self.peerId = peerId;
        self.colorIndex = 0;
        self.color = "grey";
        self.name = "noname";
        self.devices = [];
        self.inCall = false; // default, but not necessarily true
        self.rejectedRecentCall = true; // must be true by default, since a new Peer won't know about the call
    }
    
    func addDevice(device : Device) {
        self.devices.append(device);
    }
    
    func removeDevice(device : Device) {
        var index = -1;
        for i in 0..<self.devices.count {
            if (device === self.devices[i]) {
                index = i;
                break;
            }
        }
        if (index >= 0) {
            self.devices.remove(at: index);
        }
    }
    
    func countDevices() -> Int {
        return self.devices.count;
    };
    
    func onLeave() {
        // empty function
    }
    
    
}
