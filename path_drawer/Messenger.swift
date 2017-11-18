/*
 The messenger singleton is responsible for sending and reporting messages.
 
 // send a message to all devices
 messenger.broadcast(type,message)
 
 // receive messages for a given type
 //   (handlerFn is of the form function(message,from){...} )
 messenger.onmessage(type,handlerFn)
 
 */

import Foundation

class Messenger {
    
    // list of all message handlers
    private var handlers : Dictionary<String, Any>;
    
    // used to save messages received before a device instance is created (indexed by deviceId)
    private var inboxes : Dictionary<String, [(String, String)]>;
    
    private let socket : SocketIOManager;
    private let devicesManager : DevicesManager
    private let scene : Scene
    
    init(socketIOManager : SocketIOManager) {
        handlers = [String: (Any, Any) -> Any]();
        inboxes = [String: [(String, String)]]();
        self.socket = socketIOManager;
        self.devicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
        self.scene = Scene.sharedInstance
    }
    
    // sends message to a list of devices through the server
    func sendMessageViaServer(type : String, message : String, to : [String]) {
        let data : [String : Any] = [
            "to": to,
            "type": type,
            "message": message
        ]
        
        socket.emitData(type : "relay", data : data);

    }
    
    // similar to broadcast, but only to another device
    // TODO rename to sendMessageToDevice
    func sendMessageTo(type : String, message : String, deviceId : String) {
        let device = self.devicesManager.getDevice(devId : Int(deviceId)!);
        let success = device.sendMessageDirectly(type: type, message : message);
        if (success != false) {
            sendMessageViaServer(type : type, message : message, to : [deviceId]);
        }
    }

    // sends message to all other devices as efficiently as possible
    func broadcast(type : String, message : String) {
    
        var devices = self.devicesManager.getDevices();
        var to = [String](); // used to relay via server
        for id in devices.keys {
            let device = devices[id];
            let success = device!.sendMessageDirectly(type : type, message : message);
            if (success != false) {
                to.append(String(id));
            }
        }
        // send once to server
        if (to.count > 0) {
            sendMessageViaServer(type : type, message : message, to : to);
        }
        
        
    }
    
    typealias myFunc = (String, String) -> ();
    
    func onMessage(type: String, f : @escaping myFunc) {
        handlers[type] = f;
    }
    
    // internal, delivers to the appropriate handler (at this point, the device instance does exist)
    internal func deliverMessage(type : String, message : String, from : String) {
        if (handlers[type] != nil) {
            //handlers[type](message, from);
            let f : myFunc = handlers[type] as! myFunc
            f(message, from)
        } else {
            NSLog("Incoming message had unrecognized type: $@ ", type);
        }
    }
    
    func incomingMessage(type : String, message : String, from : String) {
        // TODO handle case where device created, but message queue not empty (concurrency issue not actually relevant in javascript, right?)
        if (self.devicesManager.getDevices()[Int(from)!] != nil) {
            deliverMessage(type : type, message : message, from : from);
        } else {
            // there is no device instance, so hold the message in the inbox
            if (inboxes[from] == nil) {
                inboxes[from] = [(String, String)]();
            }
            //inboxes[from].append((type, message));
        }
    }
    
    func fakeIncomingMessage(type : String, message : String, from : String) {
        // TODO handle case where device created, but message queue not empty (concurrency issue not actually relevant in javascript, right?)
        if (self.devicesManager.getDevices()[Int(from)!] != nil) {
            deliverMessage(type : type, message : message, from : from);
        } else {
            // there is no device instance, so hold the message in the inbox
            if (inboxes[from] == nil) {
                inboxes[from] = [(String, String)]();
            }
            //inboxes[from].append((type, message));
        }
    }
    
    func releaseMessagesFromDeviceWithId(deviceId : String) {
        if(inboxes[deviceId] == nil) {
            // there were no messages
            return
        }
        
        // TODO : ADD QUEUE STRUCTURE
        var queue = inboxes[deviceId]
        self.scene.beginChanges()
        while(queue?.count != 0) {
            let mail = queue.pop(0)
            deliverMessage(type: mail[0], message: mail[1], from: deviceId)
        }
        self.scene.endChanges()
        inboxes.removeValue(forKey: deviceId)
        
    }
    
    // TODO : What does broadcast del do? Which broadcast function does it call?
    /*
    func broadcastDel(del : Delta) {
        broadcast(type: "del", message: del)
    }
     */
    
    
}
