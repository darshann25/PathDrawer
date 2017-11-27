//
//  DevicesManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/10/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

/*
 deviceManager is a singleton that manages connections to each device.
 
 __TODO__
 perhaps absorb socketioclient into here (maybe)
 keep track of acknowledgements from peers and update BoardStateManager
 */
class DevicesManager {
    // number of milliseconds to wait for a peer to provide the board state
    // before turning to the server

    // TODO: restructure the messaging so that peer, instead of sending
    // the entire board state, sends a promise to send the board state, followed
    // forthwith by the board state itself.
    let BOARD_STATE_TIMEOUT = 2000
    
    // create this device even before knowing the data for the constructor
    private var thisDevice : Device
    
    // the set of devices (indexed by devId)
    private var devices : [Int: Device]
    
    // items in these lists are already minified
    private var resourcesToSend : [[String : Any]]
    private var deltasToSend : [[String : Any]]
    
    // id of the board state from server timer
    private var boardStateFromServerTimerId : Int

    private var messenger : Messenger
    private var peersManager : PeersManager
    private var boardStateManager : BoardStateManager
    
    private var boardStateProviderId : Timer
    
    init(messenger : Messenger) {
        self.thisDevice = Device(id : -1, peerId : -1, accessLevel : "unknown");
        self.devices = [Int: Device]()
        self.resourcesToSend = [[String: Any]()]
        self.deltasToSend = [[String : Any]()]
        self.boardStateFromServerTimerId = -1
        
        self.messenger = messenger
        self.peersManager = BoardViewController.BoardContext.sharedInstance.peersManager
        self.boardStateManager = BoardViewController.BoardContext.sharedInstance.boardStateManager
        
        
        ///////////////
        // messaging //
        ///////////////
        
        self.messenger.onMessage(type : "board", f : {message, from in
            receive(message)
        })

        // TODO : Web RTC
        // help relay messages to device.dataConnection
        self.messenger.onMessage(type : "rtc_data", f : {message, from in
        //    devices[from].dataConnection.onMessageViaServer(message)
        })

        // TODO : Web RTC
        // help relay messages to device.streamConnection
        self.messenger.onMessage(type : "rtc_stream", f : {message, from in
        //    devices[from].streamConnection.onMessageFromPeer(message)
        })

        self.messenger.onMessage(type : "request_board_state", f : {message, from in
            self.messenger.sendMessageTo(type: "entire_board_state", message: self.boardStateManager.getMinifiedState(), deviceId: from)
        })

        self.messenger.onMessage(type : "console", f : {message, from in
            NSLog("message from device @: @", String(from), message)
        })
        

    }
    
    ///////////////////////
    // device management //
    ///////////////////////
    
    // when this device successfully joins, this is the first thing to happen
    public func thisDeviceJoined(data: [String : Any]) {
        
        // first create the associated peer
        self.peersManager.onThisDeviceJoined(data: data)
        // since thisDevice has already been created, update it with the real data
        self.thisDevice.id = data["deviceId"] as! Int
        self.thisDevice.peerId = data["peerId"] as! Int
        self.thisDevice.accessLevel = data["accessLevel"] as! String
        // associate this device with its peer
        var peer = self.peersManager.getMyself()
        peer.addDevice(device : thisDevice)
        
    }
    
    // when this device joins, this function is called with a list of data for the other devices
    // WARNING! it is possible that some old devices (that have left) are still included here
    //          (in this case, the server will eventually send a device_left message
    
    public func devicesOnJoin(devicesData: [String : Any]) {
        self.boardStateProviderId = nil
        
        for data in devicesData {
            if ((data["deviceId"] as! Int) == thisDevice.id) {
                return
            }
            // first check if there is an associated peer, and if not, create it
            self.peersManager.onDeviceJoined(data: data)
            
            // create the device instance
            var deviceId = data["deviceId"] as! Int
            var peerId = data["peerId"] as! Int
            var accessLevel = data["accessLevel"] as! String
            var device = Device(id: deviceId, peerId: peerId, accessLevel: accessLevel)
            self.devices[deviceId] = device
            
            // associate the device with its peer
            var peer = peersManager
            peer.addDevice(device)
            // now that the device is created, release any messages that were in the inbox
            self.messenger.releaseMessagesFromDeviceWithId(deviceId: deviceId)
            
            // initiate dataConnection
            // TODO : Web RTC
            // device.dataConnection.makeCall()
            if (self.boardStateProviderId == nil) {
                // TODO SECURITY check whether the device has write privileges
                self.boardStateProviderId = deviceId
            }
        }
        
        if (boardStateProviderId != nil) {
            // there is a device to ask for the board state
            // we ask it now to guarantee that all board instances have been created
            self.messenger.sendMessageTo(type: "request_board_state", message: [String : Any](), deviceId: self.boardStateProviderId)
            // set a timeout in case we don't get the board state data in time
            self.boardStateFromServerTimerId = setTimeout(BOARD_STATE_TIMEOUT, block: getBoardStateFromServer)
        } else {
            // there were no devices to ask for board state, so ask the server instead
            getBoardStateFromServer();
        }
        
        
    }
    
    typealias MessageCallback = () -> Void
    typealias SuccessFunctionCallback = (Any) -> Void
    typealias ErrorFunctionCallback = (String) -> Void
    
    // TODO : How to work with .ajax
    private var getBoardStateFromServer : MessageCallback = {
        var boardId = BoardViewController.BoardContext.sharedInstance.boardId
        
        var success : SuccessFunctionCallback = { res in
            NSLog("get board state");
            self.boardStateManager.onBoardStateFromServer(rawdata : res)

        }
        
        var error : ErrorFunctionCallback = { res in
            NSLog("get board state error : @", res)
        }
        
        var _boardState : [String : Any] = [
            "url" : "/board/" + boardId + "/state",
            "type" : "GET",
            "processData" : false,
            "success" : success,
            "error" : error
        ]
    }
    
    public var cancelGetBoardStateFromServerTime : MessageCallback = {
        if(self.boardStateFromServerTimerId != nil) {
            self.boardStateFromServerTimerId.invalidate()
            self.boardStateFromServerTimerId = nil
        }
    }

    // when another device joins, this function is called with data for the other device
    public func onDeviceJoined(data: [String : Any]) {
        
        // first check if there is an associated peer, and if not, create it
        self.peersManager.onDeviceJoined(data: data)
        
        // create the device instance
        var deviceId = data["deviceId"] as! Int
        var peerId = data["peerId"] as! Int
        var accessLevel = data["accessLevel"] as! String
        var device = Device(id: deviceId, peerId: peerId, accessLevel: accessLevel)
        self.devices[deviceId] = device
        // associate the device with its peer
        var peer = self.peersManager.getPeerIncludingMyself(id: peerId)
        peer.addDevice(device: device)
        // now that the device is created, release any messages that were in the inbox
        self.messenger.releaseMessagesFromDeviceWithId(deviceId: deviceId)
        // Note: it's up to the new device to call this device
    }

    // when another device leaves, this function is called with data for the other device
    
    public func onDeviceLeft(data: [String : Any]) {
        var deviceId = data["deviceId"] as! Int
        var device = devices[deviceId]
        // inform the device it has left
        device?.onLeft()
        // inform the peersManager the device has left (possibly causing peer to also leave)
        self.peersManager.onDeviceLeft(device: device)
        // delete reference to this device (TODO should I do this or leave it in 'ended' state?)
        devices.removeValue(forKey: deviceId)
    }

    public func getDevice(devId: Int) -> Device {
        // TODO make ghost devices (or getDeviceOrGhost method)
        if (devices[devId] != nil) {
            return devices[devId]
        }
        if (devId == self.thisDevice.id) {
            return thisDevice
        }
    }

    ////////////////////////////
    // relaying board changes //
    ////////////////////////////

    public func send() {
        var data : [String : Any] = [
            "devId" : thisDevice.id,
            "res" : resourcesToSend,
            "delta" : deltasToSend
        ]
        self.messenger.broadcast(type: "board", message: data)
        self.resourcesToSend = [[String : Any]]
        self.deltasToSend = [[String : Any]]
    }
    
    public func receive(data: [String : Any]) {
        var devId = data["devId"] as! Int
        var resources = data["res"] as! [[String : Any]]
        var deltas = data["delta"] as! [[String : Any]]
        
        // add the resources to the board state
        for mini in resources {
            var resource : Resource = Resource.unminify(mini)
            self.boardStateManager.addResource(resource: resource)
        }
        
        // add the deltas to the board state
        if(deltas.count > 0) {
            Scene.sharedInstance.beginChanges()
            for mini in deltas {
                var delta : Delta = Delta.unminify(mini)
                self.boardStateManager.addDelta(delta: delta)
                delta.applyToScene()
            }
            Scene.sharedInstance.endChanges()
        }
        
    }
    
    public func getMyDeviceId() -> Int {
        return self.thisDevice.id;
    }
    
    public func getDevices() -> Dictionary<Int, Device> {
        return devices;
    }
    
    public func getThisDevice() -> Device {
        return thisDevice;
    }
    
    public func enqueueResource(resource : Resource) {
        self.resourcesToSend.append(resource.minify());
    }
    
    public func enqueueDelta(delta : Delta) {
        deltasToSend.append(delta.minify());
    }
}

////////////////////////////
// helper functions       //
////////////////////////////
/*
 setTimeout()
 
 Shorthand method for create a delayed block to be execute on started Thread.
 
 This method returns ``Timer`` instance, so that user may execute the block
 within immediately or keep the reference for further cancelation by calling
 ``Timer.invalidate()``
 
 Example:
 let timer = setTimeout(0.3) {
 // do something
 }
 timer.invalidate()      // cancel it.
 */
func setTimeout(_ delay : TimeInterval, block: @escaping ()->Void) -> Timer {
    return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
}


