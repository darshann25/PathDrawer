//
//  Item.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/8/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

/*
 Items are objects that belong to the Scene. They are more advanced than ItemStates, as they include other data and methods that help for fast rendering to the Scene. (However, an item is constructed from an ItemState--to construct a new item, use the static Item.fromItemState() method.) Items are similar to ItemTs, but ItemTs do not correspond to ItemStates as ItemTs are only transient UI objects. Unlike for ItemTs, a SceneView will apply its own transformation to the canvas before telling an Item to draw. (This allows ItemTs to draw lines of constant width independent of zoom.)

 List of subclasses of Item
 + PathItem
 + ImageItem
 + InkItem
 + TextItem (in progress)
 + GroupItem (not ready yet)
 + EquationItem (in progress)
 + ShapeItem (coming soon)
 
 List of functions to use outside this file
 + drawOnCanvas
 + getBoundingRect
 + intersectsSegment
 + static fromItemState
 + getMatrix
 + setMatrix
 
 @class Item
 @param {ItemState} state The state of the item.
 
 */

class Item {
    
    public static let nullItem = NullItem()
    
    public var id : Int
    public var devId : Int
    public var state : ItemState
    internal var scene : Scene
    internal var matrix : Matrix
    internal var inverseMatrix : Matrix
    internal var boundingRect : CGRect
    
    init(state: ItemState){
        
        ////////////
        // public //
        ////////////

        self.id = state.id
        self.devId = state.devId
        self.state = state
        
        ///////////////
        // protected //
        ///////////////

        // Represents the transformation of the item.
        //   This transformation is applied to the item, so if it is scale by 2, then the ite appears twice as large.
        //    Do not access this property directly--use getMatrix() and setMatrix() instead. (Otherwise inverseMatrix and boundingRect might be wrong.)
        self.scene = Scene.nullScene
        self.matrix = state.getMatrix()
        self.inverseMatrix = state.getMatrix().inverse()
        
        // if boundingRect is null, it will be recomputed on a call to getBoundingRect()
        self.boundingRect = Rect.nullRect
        
        
    }
    
    convenience init(){
        let _state = ItemState(type: Item.ItemType.Unknown);
        
        self.init(state: _state)
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
    
    func drawOnCanvas(canvas : SceneView, matrix : Matrix = Matrix.identityMatrix()) {
        // null
    }
    
    func getBoundingRect() -> Rect {
        return Rect(left: 0, top: 0, width: 0, height: 0)
    }
    
    func intersectsSegment(end1 : Point, end2 : Point) -> Bool {
        return false
    }
    
    
    // TODO: Currently this has a default implementation that returns true. Should the line 'throw new Error("Abstract method called.");' be added into the abstract function?
    func intersectsRect(rect: CGRect) -> Bool {
        return true    // assumes boundingRec intersects rect
    }
    
    /*
     TODO Currently this has a default implementation that returns null. Should the line 'throw new Error("Abstract method called.");' be added into the abstract function?
     */
    func getPdfgenData(matrix: Matrix) {
        //return nil
    }
    
    func draw() {
        // null
    }
    
    ///////////////////
    // other methods //
    ///////////////////
    
    // static
    /*
     Given an item state, this creates a member of the item class corresponding to that state.
     @param {ItemState} itemState The ItemState object which encodes the item.
     @return {Item} The item created from the ItemState information.
     */
    func fromItemState(itemState : ItemState) -> Item {
        var type = itemState.type
        
        switch(type) {
            case Item.ItemType.Path:
                return PathItem(state: itemState)
            
            case Item.ItemType.Image:
                return ImageItem(state : itemState)
            
            case Item.ItemType.Ink:
                return InkItem(state : itemState)
            
            case Item.ItemType.Text:
                return TextItem(state : itemState)
            
            case Item.ItemType.RichText:
                // analytics.unexpected("Item.fromItemState(): deprecated type: RichText")
                NSLog("Item.fromItemState(): deprecated type: RichText")
                return TextItem(state : itemState)
            
            case Item.ItemType.Equation:
                return EquationItem(state : itemState)
        
            case Item.ItemType.Region:
                return RegionItem(state : ItemState)
            
            default:
                // analytics.unexpected("Item.fromItemState():  ${ type }")
                NSLog("Item.fromItemState(): unknown type")
            
            
        }
        
    }
    
    /*
     Sets the scene of the item to the inputed scene.
     @param {Scene} scene The inputed scene.
     */
    func setScene(scene : Scene) {
        self.scene = scene
    }
    
    /*
     Returns the items' transformation matrix.
     @return {Matrix} The items' transformation matrix.
     */
    func getMatrix() -> Matrix {
        return self.matrix;
    }

    /*
     Sets the transformation matrix of the item to the inputed matrix.
     @param {Matrix} matrix The inputed matrix.
     */
    func setMatrix(matrix : Matrix) {
        if (self.matrix !== matrix) {
            self.matrix = matrix
            self.inverseMatrix = matrix.inverse();
            self.boundingRect = Rect.nullRect;
        
            if (self.scene !== Scene.nullScene) {
                self.scene.redisplay();
                self.scene.reindex();
            }
        }
    }
    
    // Should the Item use the default matrix transformation operations?
    // If true, the item is drawn on canvas after the transformation, so it will be drawn on
    // a transformed canvas (determined by the SelectionItemT matrix).
    // If false, the item will not be drawn on a transformed canvas (such as for a text item).
    // In this case, the draw method will receive
    // an extra parameter matrix, which the item must use to draw itself.
    // For example, TextItem applies the matrix to determine the base points for
    // rendering the text, but then draws the text based on those points, without any further
    // reference to the matrix (so it doesn't distort the text).
    public let scaleInvariant = true
    
}

private class NullItem : Item {
    init() {
        
    }
}
