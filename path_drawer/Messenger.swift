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
    var handlers : Dictionary<String, Any>;
    
    // used to save messages received before a device instance is created (indexed by deviceId)
    var inboxes : Dictionary<String, Any>;
    
    init() {
        handlers = [String: (Any, Any) -> Any]();
        inboxes = [String: Any]();
    }
    
    // sends message to a list of devices through the server
    func sendMessageViaServer(type : String, message : String, to : String) {
        
    }
    
    // similar to broadcast, but only to another device
    //   TODO rename to sendMessageToDevice
    func sendMessageTo(type : String, message : String, deviceId : String) {
    
    }

    // sends message to all other devices as efficiently as possible
    func broadcast(type : String, message : String) {
    
    }
    
    typealias myFunc = (String, String) -> ();
    
    func onMessage(type: String, f : @escaping myFunc) {
        handlers[type] = f;
    }
    
    // internal, delivers to the appropriate handler (at this point, the device instance does exist)
    func deliverMessage(type : String, message : String, from : String) {
    
    }
    
    func incomingMessage(type : String, message : String, from : String) {
    // TODO handle case where device created, but message queue not empty (concurrency issue not actually relevant in javascript, right?)
    
    }
    
    func releaseMessagesFromDeviceWithId(deviceId : String) {
    
    }
    
}
