//
//  SocketIOManager.swift
//  path_drawer
//
//  Created by Darshan Patel on 11/11/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import SocketIO

// TODO : Import all handlers from public/js/socketioclient.js
class SocketIOManager {
    
    let socket : SocketIOClient
    let boardSocket : SocketIOClient
    let manager : SocketManager
    let devicesManager : DevicesManager
    let messenger : Messenger
    
    var boardId : String;
    
    init(boardId : String) {
        self.boardId = boardId;
        self.manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
        self.boardSocket = self.manager.socket(forNamespace: "/board")
        self.devicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
        self.messenger = BoardViewController.BoardContext.sharedInstance.messenger
        
        print("In SocketIOManager Constructor");
    }
    
    func establistConnection() {
        print("In establishConnection")
        
        boardSocket.on(clientEvent: .connect) {data, ack in
            print("In Socket.connect")
            
            let params: [String : Any] = [
                "boardId": self.boardId,
                "notify": "all", // a tablet doesn't want halo updates
                "deviceId": -1, // -1 indicates new, another id indicates a re-connection
            ]
            if (JSONSerialization.isValidJSONObject(params)) {
                print("Socket about to EMIT!");
                self.boardSocket.emit("join_request", params);
            }
            
        }
        boardSocket.connect()
        
    }
    
    func emitData(type : String, data : Dictionary<String, Any>) {
        print("In emitData")
        
        // response to join_request (if authenticated)
        boardSocket.on(clientEvent .join) {data, ack in
            print("In Socket.join")
            
            // construct data for this device
            var thisDeviceData : [String : Any] = [
                "deviceId" : data["deviceId"],
                "peerId": data["peerId"],
                "peerName": data["peerName"],
                "peerColor": data["peerColor"],
                "accessLevel": data["accessLevel"]
            ]
            
            // first, we construct our own device (which will also cause us to construct this peer)
            self.devicesManager.thisDeviceJoined(data : thisDeviceData)
            // then we construct other devices (which will also cause us to construct other peers)
            // WARNING! it is possible that some old devices (that have left) are still included here
            //          (in this case, the server will eventually send a device_left message)
            self.devicesManager.devicesOnJoin(devicesData: data.devices)
        }

        // happens when another device (not this one) joins
        boardSocket.on(clientEvent .device_joined) {data, ack in
            self.devicesManager.onDeviceJoined(data : data)
        };

        // happens when another device (not this one) leaves
        socket.on(clientEvent .device_left) {data, ack in
            self.devicesManager.onDeviceLeft(data: data)
        }

        // happens when another devices wishes to relay a message over the server
        boardSocket.on(clientEvent .relay) {data, ack in
            self.messenger.incomingMessage(type : data["type"], message : data["message"], from : data["from"]);
        }

        boardSocket.on(clientEvent .peripherals) {data, ack in
            if (data["count"] === 0) {
              NSLog("There are no peripherals available.")
            }
        }

        // all server errors go here (for now)
        boardSocket.on(clientEvent .server_error) {data, ack in
            NSLog("socket.io server error: @", data["message"])
        }

        // tell if we've disconnected
        boardSocket.on(clientEvent .disconnect) {
            NSLog("Socket Disconnected!")
            
        }
        
        boardSocket.join(data)
    }
}

