//
//  SelectionItemT.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class SelectionItemT : ItemT {
    init(items : [Item], showButtons : Bool) {
        super.init(scene: Scene.sharedInstance, respondsToHoverEvents: false, respondsToClickEvents: false, respondsToKeyEvents: false)
    }
    
    func setMatrix(matrix : Matrix) {
        
    }
    
    func returnItemsToScene() {
        
    }
    
    func getUpperLeftPoint() -> Point {
        return Point(x: 0, y: 0)
    }
    
    override func onClickedAway() {
        
    }
}
