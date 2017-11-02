//
//  ItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/10/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class ItemState {
   
    
    public var type : Item.ItemType;
    public var id : Int;
    public var devId : Int;
    public var matrix : Matrix;
    
    // abstract class ItemState
    init(type : Item.ItemType, id : Int, devId: Int, matrix : Matrix) {
        
        self.type = type;  // corresponds to Item.types enum
        self.id = id;
        self.devId = devId;
        self.matrix = matrix;
        
    }
    
    // defined for 'Unknown' and currently not defined ItemTypes
    convenience init(type : Item.ItemType) {
        self.init(type: type, id : -1, devId : -1, matrix : Matrix());
    }
    
    // Set id and dev id for pasted item
    func setIdAndDevId(id : Int, devId : Int) -> Bool {
        // Checks that original ids are -1 to ensure method is used for copy/paste
        if (self.id != -1 || self.devId != -1) {
            NSLog("Id and DevId are not -1. This method is only intended for copy/paste.");
            return false;
        }
        self.id = id;
        self.devId = devId;
        
        return true;
    }
    
    func copy() {
        //ItemState.unminify(self.minify());
    }
    
    func minify() {
        // null
    }
    
    func getMatrix() -> Matrix {
        return self.matrix;
    }
    
}


    func unminify(obj : Dictionary<String, Any>, devId : Int) -> ItemState{
        
        // all minify implementations must contain a version number
        var type = Item.ItemType.Unknown;
        
        if(obj["version"] != nil) {
            var _ = obj["version"] as! Int;
        } else {
            NSLog("ItemState has no version.");
        }
        
        if(obj["itemType"] != nil) {
            type = obj["itemType"] as! Item.ItemType;
        } else {
            NSLog("ItemState has no itemType");
        }
        
        switch (type) {
            case Item.ItemType.Path:
                return PathItemState.unminify(mini : obj);
            
            case Item.ItemType.Image:
                return ImageItemState.unminify(mini : obj);
            
            case Item.ItemType.Ink:
                return InkItemState.unminify(mini : obj);
            
            // TODO : Define GroupItemState
            case Item.ItemType.Group:
                // do nothing
                return ItemState(type : Item.ItemType.Group);
            
            // TODO : Define RichTextItemState
            case Item.ItemType.RichText:
                // analytics.unexpected('ItemState.unminify(): deprecated type: RichText');
                return ItemState(type : Item.ItemType.RichText);
            
            // TODO : Define TextItemState
            case Item.ItemType.Text:
                return ItemState(type : Item.ItemType.Text);

            // TODO : Define EquationItemState
            case Item.ItemType.Equation:
                return ItemState(type : Item.ItemType.Equation);

            // TODO : Define RegionItemState
            case Item.ItemType.Region:
                return ItemState(type : Item.ItemType.Region);
    
            default:
                // analytics.unexpected(`ItemState.unminify(): unknown type: ${ type }`);
                return ItemState(type : Item.ItemType.Unknown);
            
        }
        
}

