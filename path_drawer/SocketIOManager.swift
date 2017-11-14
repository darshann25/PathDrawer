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
    
    
    var boardId : String;
    
    init(boardId : String) {
        self.boardId = boardId;
        self.manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
        self.boardSocket = self.manager.socket(forNamespace: "/board")

        
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
            
            /*
            do {
                
                let isValid : Bool = JSONSerialization.isValidJSONObject(params);
                print(isValid);
                let JSONParams = try JSONSerialization.data(withJSONObject: params)
                let JSONString = NSString(data: JSONParams, encoding: String.Encoding.utf8.rawValue)
                print (params);
                print(JSONString);
             
                
            } catch {
                print(error.localizedDescription)
                print ("ERROR!!!!!!")
            }
            */
        }
        boardSocket.connect()
        
    }
    
    func emitData(type : String, data : Dictionary<String, Any>) {
    
    }

    
}
