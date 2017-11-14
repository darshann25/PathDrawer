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
        //self.socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000/board")!, config: [.log(true), .compress]);
        self.manager = SocketManager(socketURL: URL(string:"http://localhost:3000/")!)
        self.socket = manager.socket(forNamespace: "/board")
        print("In SocketIOManager Constructor");
    }
    
    func establistConnection() {
        print("In establishConnection")
        
        socket.on(clientEvent: .connect) {data, ack in
            print("In Socket.connect")
            
            let params: [String : Any] = [
                "boardId": self.boardId,
                "notify": "all", // a tablet doesn't want halo updates
                "deviceId": -1, // -1 indicates new, another id indicates a re-connection
            ]
            if (JSONSerialization.isValidJSONObject(params)) {
                print("Socket about to EMIT!");
                self.socket.emit("join_request", params);
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
        socket.connect()
        
    }
    
    func emitData(type : String, data : Dictionary<String, Any>) {
    
    }

    
}
