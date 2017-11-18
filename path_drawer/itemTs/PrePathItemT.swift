//
//  PrePathItemT.swift
//  path_drawer
//
//  Created by xujiachen on 2017/10/10.
//  Authored by Darshan Patel on 11/18/2017.
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
    
    func addPoint(x : Double, y : Double) {
        self.points.append(Point(x : x, y : y))
        if(self.scene != Scene.nullScene) {
            self.scene.redisplay()
        }
    }
    
    func drawOnCanvas(sv : SceneView, left : CGFloat, top : CGFloat, zoom : CGFloat) {
        if(self.points.count < 2) {
            return
        }
        
        // at this point, there are enough points to draw
        if let ctx = UIGraphicsGetCurrentContext() {
            // make sure to save the context before setting the globalAlplha property
            ctx.saveGState()
            
            // apply the transformation
            ctx.scaleBy(x: zoom, y: zoom)
            ctx.translateBy(x: -left, y: -top)
            
            // draw the path
            ctx.beginPath()
            ctx.setStrokeColor(self.color)
            ctx.setLineWidth(self.size)
            ctx.setAlpha(self.opacity)
            ctx.setLineCap(CGLineCap.round)
            
            //ctx.move(to: convertToCGPoint(points: self.points[0]))
            //for i in 1...(self.points.count-1) {
            //    ctx.addLine(to: self.points[i])
            //}
            
            ctx.addLines(between: convertToCGPoint(points: self.points))
            ctx.strokePath()
            ctx.restoreGState()
            
        }
    }
    
    func setPoints(points : [Point]) {
        self.points = points
        if(self.scene !== Scene.nullScene) {
            self.scene.redisplay()
        }
    }
    
    func setColor(color : CGColor) {
        self.color = color
        if(self.scene !== Scene.nullScene) {
            self.scene.redisplay()
        }
    }
    
    func setSize(size : CGFloat) {
        self.size = size
        if(self.scene !== Scene.nullScene) {
            self.scene.redisplay()
        }
    }
    
    func setOpacity(opacity : CGFloat) {
        self.opacity = opacity
        if(self.scene !== Scene.nullScene) {
            self.scene.redisplay()
        }
    }
    
    func computingBoundingRect() -> Rect {
        if(self.points.count == 0) {
            // return null shouldn't happen
            return NSNull
        } else {
            var left = self.points[0].x
            var right = left
            var top = self.points[0].y
            var bottom = self.points[0].y
            
            for i in 1...(self.points.count - 1) {
                left = min(left, self.points[i].x)
                right = max(right, self.points[i].x)
                top = min(top, self.points[i].y)
                bottom = max(bottom, self.points[i].y)
            }
            return Rect(left, top, right - left, bottom - top)
        }
    }
}

