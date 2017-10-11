//
//  ItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/10/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class ItemState {
    
    /*
    public ItemType type = NSNull;
    public var id = 0;
    public var devId = 0;
    public Matrix matrix;
    
    // abstract class ItemState
    func ItemState(type : ItemType, id : var, devId: var, matrix : Matrix) {
        
        self.type = type;  // corresponds to Item.types enum
        self.id = id;
        self.devId = devId;
        self.matrix = matrix;
        
    }
 
    
    // Set id and dev id for pasted item
    func setIdAndDevId(id : var, devId : var) {
        // Checks that original ids are -1 to ensure method is used for copy/paste
        if (self.id !== -1 || self.devId !== -1) {
            console.log('Id and DevId are not -1. This method is only intended for copy/paste.');
            return false;
        }
        self.id = id;
        self.devId = devId
    }
    
    func copy() {
        ItemState.unminify(self.minify());
    }
    
    func minify() {
        // null
    }
     */
}

/*
func unminify(obj : NSObject, devId : var) {
    
    // all minify implementations must contain a version number
    var version = -1;

    if (!(version in obj)) {
        version = obj.version;
    } else {
        console.log('ItemState has no version');
    }

    if ('itemType' in obj) {
        var type = obj.itemType;
    } else {
        console.log('ItemState has no itemType');
    return;
    }
  
    switch (type) {
        case Item.types.PathItem:
            return PathItemState.unminify(obj);

        case Item.types.ImageItem:
            return ImageItemState.unminify(obj);

        case Item.types.InkItem:
            return InkItemState.unminify(obj);

        case Item.types.GroupItem:
            return GroupItemState.unminify(obj);

        // backward compatibility; remove me when we delete all RichText items.
        case 'RichText':
            analytics.unexpected('ItemState.unminify(): deprecated type: RichText');
        // fall through
        case Item.types.TextItem:
            return TextItemState.unminify(obj);

        case Item.types.EquationItem:
            return EquationItemState.unminify(obj);

        case Item.types.RegionItem:
            return RegionItemState.unminify(obj);

        default:
            analytics.unexpected(`ItemState.unminify(): unknown type: ${ type }`);
            return null;
      }
}
 */
