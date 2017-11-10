//
//  TextItemState.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class TextItemState : ItemState {
    
    var buffer : TextBuffer;
    var baselineLeft : Point;
    var baselineRight : Point;
    
    init(id : Int, devId : Int, matrix : Matrix, buffer : TextBuffer, baselineLeft : Point, baselineRight : Point) {
        
        self.buffer = buffer;
        self.baselineLeft = baselineLeft;
        self.baselineRight = baselineRight;
        super.init(type : Item.ItemType.Text, id : id, devId : devId, matrix : matrix);
        
    }
    
    func minify() -> Dictionary<String, Any> {
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["itemType"] = Item.ItemType.Text;
        obj["id"] = self.id;
        obj["devId"] = self.devId;
        obj["matrix"] = self.matrix;
        obj["buffer"] = self.buffer;
        obj["baselineLeft"] = self.baselineLeft;
        obj["baselineRight"] = self.baselineRight;
        
        return obj;
    }
    
    func unminify(mini : Dictionary<String, Any>) -> TextItemState {
        return TextItemState(id : mini["id"] as! Int, devId : mini["devId"] as! Int,
                             matrix : mini["matrix"] as! Matrix, buffer : mini["buffer"] as! TextBuffer,
                             baselineLeft : mini["baselineLeft"] as! Point!,baselineRight : mini["baselineRight"] as! Point);
        
    }
}
