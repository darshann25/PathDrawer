//
//  ItemT.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/17/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//


/*
 ItemTs are objects that belong to the Scene in the foreground layer only. ItemTs are similar to Items, but do not correspond to ItemStates as they are only transient UI objects. They are capable of responding to mouse and key input events, are likely to change state very frequently, and render differently. (They are given the canvas without the pre-applied context transformation so they can draw shapes with sizes independent of zoom.) For this reason, ItemTs are not as efficient at drawing as Items, but fortunately, it is unlikely that many ItemTs will be present at a given time.
 
 List of subclasses of ItemT
 + PrePathItemT
 + PreInkItemT
 + BoxPreSelectionItemT (needs to be updated)
 + LassoPreSelectionItemT (coming soon)
 + SelectionItemT (needs to be updated)
 + HaloItemT
 + ViewRectItemT
 + TextEditItemT (coming soon)
 + MathEditItemT (coming soon)
 + ShapeEditItemT (coming soon)
 
 List of functions to use outside this file
 + drawOnCanvas
 
 */

import Foundation
class ItemT {
    
    public static let nullItemT = NullItemT()
    
    var scene : Scene
    var respondsToHoverEvents : Bool
    var respondsToClickEvents : Bool
    var respondsToKeyEvents : Bool
    
    init(scene: Scene, respondsToHoverEvents: Bool, respondsToClickEvents: Bool, respondsToKeyEvents: Bool){
        self.respondsToClickEvents = false
        self.respondsToKeyEvents = false
        self.respondsToHoverEvents = false
        self.scene = Scene.nullScene
    }
    
    func setScene (scene: Scene){
        self.scene = scene
    }
    
    func setRespondsToHoverEvents(val: Bool){
        if (val != self.respondsToHoverEvents){
            self.respondsToHoverEvents = val
            if ((self.scene !== Scene.nullScene) && val){
                self.scene.addHoverResponder(responder : self)
            }
            if ((self.scene != Scene.nullScene) && !val){
                self.scene.removeHoverResponder(responder: self)
            }
        }
    }
    
    func setRespondsToClickEvents(val: Bool){
        if (val != self.respondsToClickEvents){
            self.respondsToClickEvents = val
            if ((self.scene !== Scene.nullScene) && val){
                self.scene.addClickResponder(responder: self)
            }
            if ((self.scene !== Scene.nullScene) && !val){
                self.scene.removeClickResponder(responder: self)
            }
        }
    }
    
    func setRespondsToKeyEvents(val: Bool){
        if (val != self.respondsToKeyEvents){
            self.respondsToKeyEvents = val
            if ((self.scene !== Scene.nullScene) && val){
                self.scene.addKeyResponder(responder: self)
            }
            if ((self.scene !== Scene.nullScene) && !val){
                self.scene.removeKeyResponder(responder: self)
            }
        }
    }
}

class NullItemT : ItemT {
    init() {
        
    }
    
}
