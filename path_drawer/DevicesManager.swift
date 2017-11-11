//
//  DevicesManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/10/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class DevicesManager {
    // number of milliseconds to wait for a peer to provide the board state
    // before turning to the server

    // TODO: restructure the messaging so that peer, instead of sending
    // the entire board state, sends a promise to send the board state, followed
    // forthwith by the board state itself.
    let BOARD_STATE_TIMEOUT = 2000;
    /*
     var thisDevice = new Device(-1, -1, 'unknown');
    
    var devices = {};
    
    // items in these lists are already minified
    var resourcesToSend = [];
    var deltasToSend = [];
    */
    // create this device even before knowing the data for the constructor
    var thisDevice : Device;
    
    // the set of devices (indexed by devId)
    var devices : Dictionary<Int, Device>;
    
    // items in these lists are already minified
    var resourcesToSend : [Dictionary<String, Any>]; // BAD IDEA!
    var deltasToSend : [()];
    
    // id of the board state from server timer
    var boardStateFromServerTimerId : Int;

    var messenger : Messenger;
    
    init() {
        self.thisDevice = Device(id : -1, peerId : -1, accessLevel : "unknown");
        self.devices = [Int: Device]();
        self.resourcesToSend = [[String: Any]()];
        self.deltasToSend = [()];
        self.boardStateFromServerTimerId = -1;
        
        self.messenger = sceneView.boardContext.messenger;
        
        
        ///////////////
        // messaging //
        ///////////////
        
        self.messenger.onMessage(type : "board", f : {message, from in
            
        });

        // help relay messages to device.dataConnection
        self.messenger.onMessage(type : "rtc_data", f : {message, from in
        
        });

        // help relay messages to device.streamConnection
        self.messenger.onMessage(type : "rtc_stream", f : {message, from in
        
        });

        self.messenger.onMessage(type : "request_board_state", f : {message, from in

        });

        self.messenger.onMessage(type : "console", f : {message, from in
        
        });
        

    }
    
    func thisDeviceJoined(data: Any) {
    
    }
    
    // when this device joins, this function is called with a list of data for the other devices
    // WARNING! it is possible that some old devices (that have left) are still included here
    //          (in this case, the server will eventually send a device_left message
    
    func devicesOnJoin(devicesData: Int) {
    
    }
    
    func getBoardStateFromServer() {
    
    }
    
    func cancelGetBoardStateFromServerTimer() {
    
    }

    // when another device joins, this function is called with data for the other device
    func onDeviceJoined(data: Any) {
    
    }

    func onDeviceLeft(data: Any) {
    
    }

    func getDevice(devId: Int) {
    
    }

    ////////////////////////////
    // relaying board changes //
    ////////////////////////////

    // TODO deprecate
    func send() {
    
    }

    // TODO deprecate
    func receive(data: Any) {
    
    }
    
    func getMyDeviceId() -> Int {
        return self.thisDevice.id;
    }
    
    func getDevices() -> Dictionary<Int, Device> {
        return devices;
    }
    
    func getThisDevice() -> Device {
        return thisDevice;
    }
    
    func enqueueResource(resource : Resource) {
        self.resourcesToSend.append(resource.minify());
    }
    
    func enqueueDelta(delta : Delta) {
        deltasToSend.append(delta.minify());
    }
}

