//
//  PrePathItemT.swift
//  path_drawer
//
//  Created by xujiachen on 2017/10/10.
//  Copyright © 2017 scratchwork. All rights reserved.
//

/*
 PrePathItemT represents a path currently being drawn (by a pen or highlighter). Once the tool is lifted, then the PrePathItemT is removed and replaced with a PathItem.
 
 */

import UIKit
import Foundation

class PrePathItemT : ItemT {
    var points : [Point]
    var color : CGColor
    var size : CGFloat
    var opacity : CGFloat
    
    init() {
        self.points = [Point]()
        self.color = UIColor.red.cgColor
        self.size = 1
        self.opacity = 1
        
        super.init(scene: Scene.sharedInstance, respondsToHoverEvents: false, respondsToClickEvents: false, respondsToKeyEvents: false)
    }
    
    func getXList() -> [Double] {
        var xList = [Double]()
        
        if (self.points.count > 0) {
            for i in 0...(self.points.count - 1) {
                xList.append(self.points[i].x)
            }
        }
        
        return xList
    }
    
    func getYList() -> [Double] {
        var yList = [Double]()
        
        if (self.points.count > 0) {
            for i in 0...(self.points.count - 1) {
                yList.append(self.points[i].y)
            }
        }
        
        return yList
    }
}

