//
//  ItemT.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/17/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class ItemT {
    
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
