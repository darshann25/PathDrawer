//
//  Background.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

/*
 The Background is responsible for displaying an infinite pattern and then possibly rendering Documents above it.
 */
import Foundation
import UIKit

class Background : UIView {
    
    private var color = UIColor.white.cgColor
    
    // data for drawing a grid
    private var grid = false
    private var gridColor = UIColor.blue.cgColor
    private var gridDx = 72
    private var gridDy = 72
    private var initData : Dictionary<String, Any>
    
    // data for drawing axes
    private var axes = false
    private var axesColor = UIColor.gray.cgColor
    
    // organized by devId, then id
    private var documents = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(initData : Dictionary<String, Any>) {
        self.init(frame: CGRect.zero)
        
        self.initData = initData
        constructBackground()
    }
    
    //////////
    // init //
    //////////
    func constructBackground() {
        
        if (self.initData["color"] != nil) {
            self.color = initData["color"]
        }
        if (self.initData["grid"] != nil) {
            self.grid = initData["grid"]
        }
        if (self.initData["gridColor"] != nil) {
            self.gridColor = initData["gridColor"] as! CGColor
        }
        if (self.initData["gridDx"] != nil) {
            self.gridDx = initData["gridDx"] as! Int
        }
        if (self.initData["gridDy"] != nil) {
            self.gridDy = initData["gridDy"] as! Int
        }
        if (self.initData["axes"] != nil) {
            self.axes = initData["axes"] as! Bool
        }
        if (self.initData["axesColor"] != nil) {
            self.axesColor = initData["axesColor"] as! CGColor
        }
        if (self.initData["documents"] != nil) {
            var docs : Dictionary<String, Any> = initData["documents"] as! Dictionary<String, Any>
            
            for devId in docs {
                for id in docs[devId] {
                    var docJSON = docs[devId][id]
                    if(self.documents[devId] == nil) {
                        self.documents[devId] = {}
                    }
                    // self.documents[devId][id] = Document(doc : docJSON)
                }
            }
        }
    }
    
    /////////////
    // methods //
    /////////////

    // helper function for drawing a grid
    private func drawGrid (ctx: CGContext, x:Int, y:Int, s:Int, width:Int, height:Int){
        
        ctx.saveGState()
        ctx.setStrokeColor(self.gridColor)
        ctx.setLineWidth(1)
        let startx = s * (-(x % gridDx))
        let starty = s * (-(y % gridDy))
        
        var i = startx
        while ( i <= width ) {
            ctx.beginPath()
            ctx.move(to: CGPoint(x:i,y:0))
            ctx.addLine(to: CGPoint(x:i, y:height))
            ctx.strokePath()
            i = i + (s*gridDx)
        }
        var j = starty
        while ( j <= height ) {
            ctx.beginPath()
            ctx.move(to: CGPoint(x:0,y:j))
            ctx.addLine(to: CGPoint(x:width, y:j))
            ctx.strokePath()
            j = j + (s*gridDy)
        }
        ctx.restoreGState()
    }
    
    // helper function for drawing axes
    private func drawAxes(ctx: CGContext, x:Int, y:Int, s:Int, width:Int, height:Int){
        
        ctx.saveGState()
        ctx.setStrokeColor(self.axesColor)
        ctx.setLineWidth(1)
        // draw x axis
        let xAxis = (-y * s)
        ctx.beginPath()
        ctx.move(to: CGPoint(x:0,y:xAxis))
        ctx.addLine(to: CGPoint(x:width,y:xAxis))
        ctx.strokePath()
        // draw y axis
        let yAxis = (-x * s)
        ctx.beginPath()
        ctx.move(to: CGPoint(x:yAxis ,y:0))
        ctx.addLine(to: CGPoint(x:yAxis,y:height))
        ctx.strokePath()
    }
    
    // (x,y): upper-left corner of canvas in scene coordinates
    public func drawOnCanvas(canvas: SceneView, x: Double, y: Double, s: Double) {
    //TODO, FIGURE OUT WHAT CANVAS WILL BE IN SWIFT
        var width = canvas.getWidth()
        let height = canvas.getHeight()
        let ctx = UIGraphicsGetCurrentContext()
        
        // draw the background color
        ctx?.setFillColor(self.color)
        ctx?.beginPath()
        ctx?.addRect(CGRect(x: 0, y: 0, width: width, height: height))
        ctx?.fillPath()
        // draw the grid
        if (grid) {
            self.drawGrid(ctx: ctx, x: x, y: y, s: s, width: width, height: height)
        }
        
        // draw the axes
        if (axes) {
            self.drawAxes(ctx: ctx, x: x, y: y, s: s, width: width, height: height)
        }
        
        
        
        // draw the documents (if they overlap with viewable region)
        var viewRect = Rect(left: x, top: y, width: (width/s) , height: (height/s))
        for devId in self.documents {
            for id in self.documents[devId] {
                var document = self.documents[devId][id]
                if(viewRect.intersects(that: document.rect)) {
                    document.drawOnCanvas(canvas : canvas, x : x - document.rect.left, y : y - document.rect.top, s : s)
                }
            }
        }
    }
    
    // TODO : Add Documents
    public func getDocumentsList() {
        
    }
    
    // TODO : Add Documents
    public func addDocument(doc : Document) {
        
    }
    
    // TODO : Add Documents
    public func removeDocument(id : Int, devId : Int) {
        
    }
    
    // TODO : Add Documents
    public func getPositionForNewDocument() {
        
    }
    
    
}

