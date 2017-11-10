//
//  ItemT.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class ItemT {
    
    var scene : Scene?
    var respondsToHoverEvents : Bool
    var respondsToClickEvents : Bool
    var respondsToKeyEvents : Bool
    
    init(scene: Scene, respondsToHoverEvents: Bool, respondsToClickEvents: Bool, respondsToKeyEvents: Bool){
        self.respondsToClickEvents = false
        self.respondsToKeyEvents = false
        self.respondsToHoverEvents = false
        self.scene = nil
    }
    
    func setScene (scene: Scene){
        self.scene = scene
    }
    
    func setRespondsToHoverEvents(val: Bool){
        if (val != self.respondsToHoverEvents){
            self.respondsToHoverEvents = val
            if ((self.scene != nil) && val){
                //self.scene.addHoverResponder()
            }
            if ((self.scene != nil) && !val){
                //self.scene.removeHoverResponder()
            }
        }
    }
    
    func setRespondsToClickEvents (val: Bool){
        if (val != self.respondsToClickEvents){
            self.respondsToClickEvents = val
            if ((self.scene != nil) && val){
                //self.scene.addClickResponder()
            }
            if ((self.scene != nil) && !val){
                //self.scene.removeClickResponder()
            }
        }
    }
    func setRespondsToKeyEvents (val: Bool){
        if (val != self.respondsToKeyEvents){
            self.respondsToKeyEvents = val
            if ((self.scene != nil) && val){
                //self.scene.addKeyResponder()
            }
            if ((self.scene != nil) && !val){
                //self.scene.removeKeyResponder()
            }
        }
    }
}
