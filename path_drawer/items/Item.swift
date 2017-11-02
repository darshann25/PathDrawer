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
        self.scene = Scene();
        self.matrix = state.getMatrix();
        self.inverseMatrix = state.getMatrix().inverse();
        
        // if boundingRect is null, it will be recomputed on a call to getBoundingRect()
        self.boundingRect = CGRect();
        
        
    }
    
    /**
     Enumeration for all item types.
     @readonly
     @enum
     */
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
    
    /**
     @abstract
     */
    func shallowCopyItemState() {
        // null
    }
    
    /**
     @abstract
     */
    func drawOnCanvas() {
        // null
    }
    
    /**
     @abstract
     */
    func getBoundingRect() {
        // null
    }
    
    /**
     @abstract
     */
    func intersectsSegment() {
        // null
    }
    
    /**
     @abstract
     @todo Currently this has a default implementation that returns true. Should the line 'throw new Error("Abstract method called.");' be added into the abstract function?
     */
    func intersectsRect(rect: CGRect) -> Bool {
        return true;    // assumes boundingRec intersects rect
    }
    
    /**
     @abstract
     @todo Currently this has a default implementation that returns null. Should the line 'throw new Error("Abstract method called.");' be added into the abstract function?
     */
    func getPdfgenData(matrix: Matrix) {
        //return nil;
    }
    
    func draw(toolManager : ToolManager) {
        // null
    }
}
