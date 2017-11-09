//
//  Background.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class Background : UIView {
    
    var color = UIColor.white.cgColor
    
    var grid = false
    var gridColor = UIColor.blue.cgColor
    var gridDx = 72
    var gridDy = 72
    
    var axes = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        didLoad()
    }
    
    func didLoad() {
    }
    
    
    func drawGrid (ctx: CGContext, x:Int, y:Int, s:Int, width:Int, height:Int){
        ctx.saveGState()
        ctx.setStrokeColor(gridColor)
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
    
    func drawAxes(ctx: CGContext, x:Int, y:Int, s:Int, width:Int, height:Int){
        ctx.saveGState()
        ctx.setStrokeColor(gridColor)
        ctx.setLineWidth(1)
        //draw x axis
        let xAxis = (-y * s)
        ctx.beginPath()
        ctx.move(to: CGPoint(x:0,y:xAxis))
        ctx.addLine(to: CGPoint(x:width,y:xAxis))
        ctx.strokePath()
        //draw y axis
        let yAxis = (-x * s)
        ctx.beginPath()
        ctx.move(to: CGPoint(x:yAxis ,y:0))
        ctx.addLine(to: CGPoint(x:yAxis,y:height))
        ctx.strokePath()
    }
    
    // (x,y): upper-left corner of canvas in scene coordinates
    func drawOnCanvas(canvas: Any, x: Double, y: Double, s: Double) {
    //TODO, FIGURE OUT WHAT CANVAS WILL BE IN SWIFT
        var width : Double
        let height : Double
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color)
        //ctx?.fill(CGRect(x:0, y:0,width: width, height: height))
        if (grid) {
            //drawGrid(ctx: ctx!, x: x, y: y, s: s, width: width, height: height);
        }
        if (axes) {
            //drawAxes(ctx: ctx!, x: x, y: y, s: s, width: width, height: height);
        }
        // draw the documents (if they overlap with viewable region)
        //var viewRect = Rect(left: x, top: y, width: (width/s) , height: (height/s))
        /*for (var devId in documents) {
            for (var id in documents[devId]) {
                var document = documents[devId][id];
                if (viewRect.intersects(document.rect)) {
                    document.drawOnCanvas(canvas,
                                          x - document.rect.left,
                                          y - document.rect.top,
                                          s);*/
        // also replaces existing document
        /*
        func addDocument(doc) {
            var devId = doc.devId;
            var id = doc.id;
            if (!(devId in documents)) {
                documents[devId] = {};
            }
            documents[devId][id] = doc;
            setNeedsDisplay()
        }
        
        func removeDocument(id, devId) {
            delete documents[devId][id];
            setNeedsDisplay()
        }
        
        function getPositionForNewDocument() {
            var left = 0;
            for (var devId in documents) {
                for (var id in documents[devId]) {
                    left = Math.max(left, documents[devId][id].rect.right());
                }
            }
            return [left, 0];
        }
        */
    }
}

