//
//  DevicesManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class DevicesManager {
    
    //TODO: FIGURE OUT EXPECTED TYPES
    var thisDevice : Any
    //var resourcesToSend = [Any]()
    //var deltasToSend = [Any]()
    //var boardStateFromServerTimerId : Bool
    
    
    init (thisDevice: Any){
        // create this device even before knowing the data for the constructor
        self.thisDevice = Device(id: -1, peerId: -1, accessLevel: "unknown")
    }
    
    func thisDeviceJoined(data: Any) {
        //peersManager.onThisDeviceJoined(data)
        //thisDevice.id = data.deviceId
        //thisDevice.peerId = data.peerId
        //thisDevice.accessLevel = data.accessLevel
        
        // associate this device with its peer
        //var peer = peersManager.getMyself()
        //peer.addDevice(thisDevice)
    }
    
    // when this device joins, this function is called with a list of data for the other devices
    // WARNING! it is possible that some old devices (that have left) are still included here
    //          (in this case, the server will eventually send a device_left message
    
    func devicesOnJoin(devicesData: Int) {
        var data : Any
        var boardStateProviderId : Bool
        // it is this device's responsibility to set up a WebRTC connection with the other devices
        
        //func get(data: Int) {
        // if this device made it into devicesData, then avoid creating duplicate
        //if (data.deviceId === thisDevice.id) {
        //return;
        //devicesData.forEach(get(data)
        //peersManager.onDeviceJoined(data)
        //var deviceId = data.deviceId
        //var peerId = data.peerId
        //var accessLevel = data.accessLevel
        //var device = Device(deviceId, peerId, accessLevel)
        //var devices = [deviceId]
        //devices = device
        //var peer = peersManager.getPeerIncludingMyself(data.peerId)
        //peer.addDevice(device)
        
        // now that the device is created, release any messages that were in the inbox
        //messenger.releaseMessagesFromDeviceWithId(deviceId)
        
        // initiate dataConnection
        //device.dataConnection.makeCall()
        //if (!boardStateProviderId) {
        // TODO SECURITY check whether the device has write privileges
        //boardStateProviderId = device.id;
        //}
    }
    
    //if (boardStateProviderId = true) {
    // there is a device to ask for the board state
    // we ask it now to guarantee that all board instances have been created
    //messenger.sendMessageTo('request_board_state', {}, boardStateProviderId);
    // set a timeout in case we don't get the board state data in time
    //boardStateFromServerTimerId = setTimeout(getBoardStateFromServer, BOARD_STATE_TIMEOUT)
    //} else {
    // there were no devices to ask for board state, so ask the server instead
    //getBoardStateFromServer()
    //}
    
    func getBoardStateFromServer() {
        /*$.ajax({
         url: `/board/${ boardId }/state`,
         type: 'GET',
         processData: false,
         success: function(res) {
         console.log('got board state');
         boardStateManager.onBoardStateFromServer(res);
         },
         error: function(res) {
         console.log('get board state error:');
         console.log(res);
         },
         });*/
    }
    
    func cancelGetBoardStateFromServerTimer() {
        //if (boardStateFromServerTimerId) {
        //clearTimeout(boardStateFromServerTimerId)
    }
}

// when another device joins, this function is called with data for the other device
func onDeviceJoined(data: Any) {
    // first check if there is an associated peer, and if not, create it
    //peersManager.onDeviceJoined(data)
    // create the device instance
    //var deviceId = data.deviceId
    //var peerId = data.peerId
    //var accessLevel = data.accessLevel
    //var device = Device(deviceId, peerId, accessLevel)
    //var devices = [deviceId]
    //devices = device
    
    // associate the device with its peer
    //var peer = peersManager.getPeerIncludingMyself(data.peerId)
    //peer.addDevice(device)
    
    // now that the device is created, release any messages that were in the inbox
    //messenger.releaseMessagesFromDeviceWithId(deviceId)
    // Note: it's up to the new device to call this device
}

func onDeviceLeft(data: Any) {
    //var deviceId = data.deviceId
    //var device = devices[deviceId]
    // inform the device it has left
    //device.onLeft()
    
    // inform the peersManager the device has left (possibly causing peer to also leave)
    //peersManager.onDeviceLeft(device)
    
    // delete reference to this device (TODO should I do this or leave it in 'ended' state?)
    //delete devices[deviceId]
}

func getDevice(devId: Int) {
    // TODO make ghost devices (or getDeviceOrGhost method)
    /*if (devId in devices) {
     return devices[devId];
     }
     if (devId === thisDevice.id) {
     return thisDevice;
     }*/
}


///////////////
// messaging //
///////////////

/*
 messenger.onmessage('board', function(message, from) {
 receive(message);
 });
 
 // help relay messages to device.dataConnection
 messenger.onmessage("rtc_data", function(message, from) {
 devices[from].dataConnection.onMessageViaServer(message);
 });
 
 // help relay messages to device.streamConnection
 messenger.onmessage("rtc_stream", function(message, from) {
 devices[from].streamConnection.onMessageFromPeer(message);
 });
 
 messenger.onmessage("request_board_state", function(message, from) {
 messenger.sendMessageTo('entire_board_state',
 boardStateManager.getMinifiedState(),
 from);
 });
 
 messenger.onmessage('console', function(message, from) {
 console.log(`message from ${ from }:`)
 console.log(message)
 });
 */

////////////////////////////
// relaying board changes //
////////////////////////////

// TODO deprecate
func send() {
    /*var data = {
     devId: thisDevice.id,
     res: resourcesToSend,
     delta: deltasToSend,
     };*/
    //messenger.broadcast('board', data)
    //resourcesToSend = []
    //deltasToSend = []
}

// TODO deprecate
func receive(data: Any) {
    /*
     var devId = data.devId
     var resources = data.res
     var deltas = data.delta
     
     // add the resources to the board state
     resources.forEach(function(mini) {
     var resource = Resource.unminify(mini)
     boardStateManager.addResource(resource)
     })
     // add the deltas to the board state
     if (deltas.length > 0) {
     scene.beginChanges()
     deltas.forEach(function(mini) {
     var delta = Delta.unminify(mini, devId)
     boardStateManager.addDelta(delta)
     delta.applyToScene()
     })
     scene.endChanges()
     }*/
}

