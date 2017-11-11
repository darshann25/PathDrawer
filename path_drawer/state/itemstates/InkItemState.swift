//
//  InkItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/16/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class InkItemState : ItemState {
    
    var resource : Resource;
     
    init(id : Int, devId : Int, matrix : Matrix, resource : Resource) {
        self.resource = resource;
        
        super.init(type : Item.ItemType.Image, id: id, devId: devId, matrix: matrix);
    }
     
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["itemType"] = Item.ItemType.Image;
        obj["id"] = self.id;
        obj["devId"] = self.devId;
        obj["matrix"] = self.matrix;
        obj["resource"] = self.resource;
        
        return obj;
    }
    
    static func unminify(mini : Dictionary<String, Any>) -> InkItemState {
        // Uncomment once boardStateManager is defined
        /*
         var r_id = mini["resource_id"] as! Int;
         var r_devId = mini["resource_devId"] as! Int;
         var resource = boardstateManager.getResource(r_id, r_devId);
         */
        
        return InkItemState(id : mini["id"] as! Int, devId : mini["devId"] as! Int, matrix : mini["matrix"] as! Matrix,
                            resource : mini["resource"] as! Resource);
    }
    
    
}

