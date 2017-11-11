//
//  EquationItemState.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class EquationItemState : ItemState {
    var equation : Any
    var eqnType : Any
    init(id : Int , devId : Int, matrix : Matrix, equation :Any, eqnType:Any)
    {
        self.eqnType = eqnType
        self.equation = equation
        
        super.init(type : Item.ItemType.Path /*Should not be .Path should be .EquationItem*/, id: id, devId :devId , matrix: matrix);
    }
    
    func minify() -> Dictionary<String,Any>{
        var obj = [String: Any]();
        obj["version"] = 1;
        obj["itemType"] = Item.ItemType.Path; /*Should not be .Path should be .EquationItem*/
        obj["id"] = self.id;
        obj["devId"] = self.devId;
        obj["matrix"] = self.matrix;
        obj["equation"] = self.equation;
        obj["eqnType"] = self.eqnType;
        

        
        return obj;
    }
    
    func unminify(mini : Dictionary<String, Any>)->EquationItemState {
    
        return EquationItemState(id: mini["id"] as! Int , devId : mini["devId"] as! Int, matrix : mini["matrix"] as! Matrix, equation: mini["equation"], eqnType: mini["eqnType"]);
    
    }

}
