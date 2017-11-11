//
//  PeersManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/10/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class PeersManager {
    var myPeerId : Int;
    var myself : Peer;
    var myPeers : Dictionary<Int, Peer>;
    var peersWidgetController : PeersWidgetController;
    
    init(peer: Peer, peersWidgetController : PeersWidgetController) {
        self.myPeerId = -1;
        self.myself = peer;
        self.myPeers = [Int: Peer]();
        self.peersWidgetController = peersWidgetController;
    }
    
    func getPeerIncludedMyself(id : Int) -> Peer {
        if (id == myPeerId) {
            return myself;
        }
        return myPeers[id]!;
    }
    
    // gets name associated with peer having peerId == id
    func getNameForPeerId(id : Int) -> String {
        if (id == myself.peerId) {
            return myself.name;
        }
    
        if (myPeers[id] != nil) {
            return myPeers[id]!.name;
        } else {
            return "ghost";
        }
    }
    
    // gets color associated with peer having peerId = id
    func getColorForPeerId(id : Int) -> String {
    
        if (id == self.myPeerId) {
            return myself.color;
        } else if (myPeers[id] != nil) {
            return myPeers[id]!.color;
        } else {
            return "grey";
        }
    
    }
    
    func countMyPeers() -> Int {
        return myPeers.count;
    }
    
    func everyoneRejectedRecentCall() -> Bool {
        for peer in myPeers {
            if (!peer.value.rejectedRecentCall) {
                return false;
            }
        }
        return true;
    }
    
    func clearCallRejections() {
        for peer in myPeers {
            peer.value.rejectedRecentCall = false;
        }
    }
    
    func countMyPeersInCall() -> Int {
        var count = 0;
        for peer in myPeers {
            if peer.value.inCall {
                count += 1;
            }
        }
        return count;
    }
    
    func onThisDeviceJoined(data : Dictionary<String, Any>) {
        let myPeerId = data["peerId"] as! Int;
        myself = Peer(peerId : myPeerId);
        myself.name = data["peerName"] as! String;
        myself.color = data["peerColor"] as! String;
    }
    
    func onDeviceJoined(data : Dictionary<String, Any>) {
        let p_id = data["peerId"] as! Int;
        if (myPeers[p_id] != nil || p_id == self.myPeerId) {
            return;
        }
        // the peer with id data.peerId joined
        let peer = Peer(peerId: p_id);
        peer.name = data["peerName"] as! String;
        peer.color = data["peerColor"] as! String;
        myPeers[p_id] = peer;
        peersWidgetController.relayout(peers: myPeers); // TODO this is called too often when this device joins. is that a problem?
    }
    
    func onDeviceLeft(device : Device) {
        var peer = myPeers[device.peerId]!;
            if (device.peerId == myPeerId) {
                peer = myself;
            }
        peer.removeDevice(device : device);
        if (peer.countDevices() == 0) {
            // the peer left
            peer.onLeave();
            myPeers.removeValue(forKey: device.peerId);
        }
        peersWidgetController.relayout(peers : myPeers);
    }
}
