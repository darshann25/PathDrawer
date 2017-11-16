//
//  Item.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/8/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

/**
 Items are objects that belong to the Scene. They are more advanced than ItemStates, as they include other data and methods that help for fast rendering to the Scene. (However, an item is constructed from an ItemState--to construct a new item, use the static Item.fromItemState() method.) Items are similar to ItemTs, but ItemTs do not correspond to ItemStates as ItemTs are only transient UI objects. Unlike for ItemTs, a SceneView will apply its own transformation to the canvas before telling an Item to draw. (This allows ItemTs to draw lines of constant width independent of zoom.)
 @class Item
 @param {ItemState} state The state of the item.
 */

class Item {
    
    public var id : Int;
    public var devId : Int;
    public var state : ItemState;
    internal var scene : Scene;
    internal var matrix : Matrix;
    internal var inverseMatrix : Matrix;
    internal var boundingRect : CGRect;
    
    init(state: ItemState){
        
        ////////////
        // public //
        ////////////

        self.id = state.id;
        self.devId = state.devId;
        self.state = state
        
        ///////////////
        // protected //
        ///////////////

        // Represents the transformation of the item.
        //   This transformation is applied to the item, so if it is scale by 2, then the ite appears twice as large.
        //    Do not access this property directly--use getMatrix() and setMatrix() instead. (Otherwise inverseMatrix and boundingRect might be wrong.)
        self.scene = Scene.sharedInstance;
        self.matrix = state.getMatrix();
        self.inverseMatrix = state.getMatrix().inverse();
        
        // if boundingRect is null, it will be recomputed on a call to getBoundingRect()
        self.boundingRect = CGRect();
        
        
    }
    
    convenience init(){
        let _state = ItemState(type: Item.ItemType.Unknown);
        
        self.init(state: _state);
    }
    
    enum ItemType {
        case Path
        case Image
        case Ink
        case Group
        case Text
        case Equation
        case Region
        case RichText
        case Unknown
    }
    
    //////////////////////
    // abstract methods //
    //////////////////////
    
    func shallowCopyItemState() {
        // null
    }
    
    func drawOnCanvas() {
        // null
    }
    
    func getBoundingRect() {
        // null
    }
    
    func intersectsSegment() {
        // null
    }
    
    
    // TODO: Currently this has a default implementation that returns true. Should the line 'throw new Error("Abstract method called.");' be added into the abstract function?
    func intersectsRect(rect: CGRect) -> Bool {
        return true;    // assumes boundingRec intersects rect
    }
    
    /**
     TODO Currently this has a default implementation that returns null. Should the line 'throw new Error("Abstract method called.");' be added into the abstract function?
     */
    func getPdfgenData(matrix: Matrix) {
        //return nil;
    }
    
    func draw() {
        // null
    }
    
    
    
    // static
    /**
     Given an item state, this creates a member of the item class corresponding to that state.
     @param {ItemState} itemState The ItemState object which encodes the item.
     @return {Item} The item created from the ItemState information.
     */
    func fromItemState(itemState : ItemState) {
        var type = itemState.type;
        
    }
    
    /*
    Item.fromItemState = function(itemState) {
    var type = itemState.type;
    if (type === Item.types.PathItem) {
    return new PathItem(state : itemState);
    } else if (type === Item.types.ImageItem) {
    return new ImageItem(itemState);
    } else if (type === Item.types.InkItem) {
    return new InkItem(itemState);
    } else if (type === Item.types.TextItem) {
    return new TextItem(itemState);
    } else if (type === 'RichText') {
    // compatibility for rename, remove me when all old data is deleted
    analytics.unexpected('Item.fromItemState(): deprecated type: RichText');
    return new TextItem(itemState);
    } else if (type === Item.types.EquationItem) {
    return new EquationItem(itemState);
    } else if (type === Item.types.RegionItem) {
    return new RegionItem(itemState);
    } else {
    analytics.unexpected(`Item.fromItemState(): unknown type: ${ type }`);
    }
    };*/
}
