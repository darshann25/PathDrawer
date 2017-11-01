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
    
    var m_id : Int;
    var m_devId : Int;
    var m_matrix : Matrix;
    var m_resource : Resource;
    var m_beginIndex : Any;
    var m_endIndex : Any;
    var m_color : CGColor;
    var m_size : Int;
    var m_opacity : Int;
    
    init(id : Int, devId : Int, matrix : Matrix, resource : Resource, beginIndex : Int, endIndex : Int, color : CGColor,
                       size : Int, opacity : Int) {
        self.m_id = id;
        self.m_devId = devId;
        self.m_matrix = matrix;
        self.m_resource = resource;
        self.m_beginIndex = beginIndex;
        self.m_endIndex = endIndex;
        self.m_color = color;
        self.m_size = size;
        self.m_opacity = opacity;
        
        super.init(type : Item.ItemType.Path, id: id, devId : devId, matrix : matrix);
    }

    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["itemType"] = Item.ItemType.Path;
        obj["id"] = self.m_id;
        obj["devId"] = self.m_devId;
        obj["matrix"] = self.m_matrix;
        obj["resource"] = self.m_resource;
        obj["beginIndex"] = self.m_beginIndex is Int ? self.m_beginIndex : 0;
        obj["endIndex"] = self.m_endIndex is Int ? self.m_endIndex : self.m_resource.data;
        obj["color"] = self.m_color;
        obj["size"] = self.m_size;
        obj["opacity"] = self.m_opacity;
        
        return obj;
    }
    
    func unminify(mini : Dictionary<String, Any>) -> PathItemState {
        return PathItemState(id : mini["id"] as! Int, devId : mini["devId"] as! Int, matrix : mini["matrix"] as! Matrix,
                             resource : mini["resource"] as! Resource, beginIndex : mini["beginIndex"] as! Int,
                             endIndex : mini["endIndex"] as! Int, color : mini["color"] as! CGColor,
                             size : mini["size"] as! Int, opacity : mini["opacity"] as! Int);
    }
    
}
