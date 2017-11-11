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
    
    let socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress]);
    
    let boardId = "ABCD1234";
    
    
    
    func connect() {
        
        socket.on(clientEvent: .connect) {
            var params : [String : Any] = [
                "boardId": boardId,
                "notify": "all", // a tablet doesn't want halo updates
                "deviceId": -1, // -1 indicates new, another id indicates a re-connection
            ]
            
            let JSONParams = JSONSerialization.isValidJSONObject(params)
            socket.emit("join_request", JSONParams);
        };
        
        socket.connect();
    }
    
    func emit(type : String, data : String) {
        
    }
    
    
}
