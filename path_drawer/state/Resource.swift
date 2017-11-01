//
//  Resource.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/31/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

/*
 A Resource is a store for (potentially large) data that does not change and might be shared between multiple items (such as an image or a sequence of points defining a curve). Resources are not instantiated into subclasses--their data is stored in a format that is interpreted by the item holding the resource.
 
 TODO (improvements to Resource)
 TODO + include versioning in case the resource data format changes
 TODO + include reference counting for a resource to dispose quickly? (probably not a big deal...)
 */

// class Resource
class Resource {
    var id : Int
    var devId : Int
    var data : Any
    var imageCanvas : Any
    
    init (id : Int, devId : Int, data : Any) {
        self.id = id;
        self.devId = devId;
        self.data = data;
        
        self.imageCanvas = NSNull();
    }
    
    func minify() -> Dictionary<String, Any>{
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["id"] = self.id;
        obj["devId"] = self.devId;
        obj["data"] = self.data;
        // TODO: serialize imageCanvas?
        
        return obj;
    }
    
    // inverse of minify
    func unminify(obj : Dictionary<String, Any>) -> Resource {
        return Resource(id: obj["id"] as! Int, devId: obj["devId"] as! Int, data: obj["data"]);
    }
    
    
    
    
    
    
}
