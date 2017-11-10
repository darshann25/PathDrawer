//
//  PathItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/16/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

// PathItemState inherits from ItemState
class PathItemState : ItemState {
    
    var resource : Resource;
    var beginIndex : Any;
    var endIndex : Any;
    var color : CGColor;
    var size : Int;
    var opacity : Int;
    
    init(id : Int, devId : Int, matrix : Matrix, resource : Resource, beginIndex : Int, endIndex : Int, color : CGColor,
                       size : Int, opacity : Int) {
        self.resource = resource;
        self.beginIndex = beginIndex;
        self.endIndex = endIndex;
        self.color = color;
        self.size = size;
        self.opacity = opacity;
        
        super.init(type : Item.ItemType.Path, id: id, devId : devId, matrix : matrix);
    }

    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["itemType"] = Item.ItemType.Path;
        obj["id"] = self.id;
        obj["devId"] = self.devId;
        obj["matrix"] = self.matrix;
        obj["resource"] = self.resource;
        obj["beginIndex"] = self.beginIndex is Int ? self.beginIndex : 0;
        obj["endIndex"] = self.endIndex is Int ? self.endIndex : self.resource.data;
        obj["color"] = self.color;
        obj["size"] = self.size;
        obj["opacity"] = self.opacity;
        
        return obj;
    }
    
    static func unminify(mini : Dictionary<String, Any>) -> PathItemState {
        return PathItemState(id : mini["id"] as! Int, devId : mini["devId"] as! Int, matrix : mini["matrix"] as! Matrix,
                             resource : mini["resource"] as! Resource, beginIndex : mini["beginIndex"] as! Int,
                             endIndex : mini["endIndex"] as! Int, color : mini["color"] as! CGColor,
                             size : mini["size"] as! Int, opacity : mini["opacity"] as! Int);
    }
    
}
