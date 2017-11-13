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
    
    let socket : SocketIOClient;
    
    var boardId : String;
    
    init(boardId : String) {
        self.boardId = boardId;
        self.socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress]);
    }
    
    func connect() {
        
        socket.on(clientEvent: .connect) {data, ack in
            print("Socket connected!");
            
            let params : [String : Any] = [
                "boardId": self.boardId,
                "notify": "all", // a tablet doesn't want halo updates
                "deviceId": -1, // -1 indicates new, another id indicates a re-connection
            ]
            
            print("Socket Connection Made!")
            let JSONParams : Data;
            do {
                JSONParams = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                print("Socket about to EMIT!");
                self.socket.emit("join_request", JSONParams);
            } catch {
                print(error.localizedDescription)
            }
            
        };
        print("Socket is about to Connect!");
        socket.connect();
        
    }
    
    func emit(type : String, data : Data) {
        
    }
    
    
}
