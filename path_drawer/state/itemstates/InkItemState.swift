//
//  InkItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/16/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class InkItemState : ItemState {
    
    var m_id : Int;
    var m_devId : Int;
    var m_matrix : Matrix;
    var m_resource : Resource;
     
    init(id : Int, devId : Int, matrix : Matrix, resource : Resource) {
        self.m_id = id;
        self.m_devId = devId;
        self.m_matrix = matrix;
        self.m_resource = resource;
        
        super.init(type : Item.ItemType.Image, id: id, devId: devId, matrix: matrix);
    }
     
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["itemType"] = Item.ItemType.Image;
        obj["id"] = self.m_id;
        obj["devId"] = self.m_devId;
        obj["matrix"] = self.m_matrix;
        obj["resource"] = self.m_resource;
        
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

