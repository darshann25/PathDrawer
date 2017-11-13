//
//  PathItem.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class PathItem : Item {
    
    /////////////
    // private //
    /////////////
    
    private var path : Path;
    private var pathItemColor : CGColor;
    private var pathItemSize : CGFloat;
    private var pathItemOpacity : CGFloat;
    
    private var resource : Resource;
    private var beginIndex : Int;
    private var endIndex : Int;
    private var pointBuffer : PointBuffer;
    private var points : [Point]
    
    // var prePathItemT : PrePathItemT;
    
    init (state: PathItemState) {
        
        self.pathItemColor = state.color;
        self.pathItemSize = state.size;
        self.pathItemOpacity = state.opacity;
        
        self.resource = state.resource;
        self.beginIndex = state.beginIndex;
        self.endIndex = state.endIndex;
        self.points = resource.data as! [Point];
        
        self.pointBuffer = PointBuffer(pointsArray : resource.data as! [Point])
        self.path = Path(buffer: pointBuffer, begin: state.beginIndex, end: state.endIndex)
        
        super.init(state: state)
    }
    
    func shallowCopyItemState(id : Int, devId : Int){
        return PathItemState(id: id, devId : devId, matrix: self.matrix.copy(), resource : self.resource, beginIndex: self.beginIndex,
                             endIndex: self.endIndex, color: self.pathItemColor, size: self.pathItemSize, opacity: self.pathItemOpacity )
    }

    /*func getPdfGenData (matrix: Matrix) {
     var xs = [0]
     var ys = [0]
     var i = 0
     while(i < self.path.pointBuffer.points.count){
     xs.append(self.path.pointBuffer.points[i].x)
     ys.append(self.path.pointBuffer.points[i].y)
     }
     var m = matrix.times(self.matrix)
     var data(t: path, m: Array(m), s: self.size, xs: xs, ys: ys)
     
     return data
     }*/
    
    /*func addSvgData (Svg: svg, matrix: svgMatrix){
     var pathStringBuffer = [0]
     var i = 0
     while (i < self.path.cubicData.count){
     
     }
     }*/
    
    /*
     func getBoundingRect(){
     if(self.boundingRect = NSNull){
     var rect = self.path.computeBoundingRectCubic(self.matrix)
     var thickness = self.size * Math.sqrt(self.matrix.det())
     self.boundingRect = rect.expandedBy(a: thickness/2, b: thickness/2, c: thickness/2, d: thickness/2,)
     }
     }*/
    
    /////////////////////////////
    //// LEGACY /////////////////
    /////////////////////////////
    override func draw() {
        
        var prevPoint = points[0];
        var i = 1;
        while(i < points.count) {
            let point = points[i];
            
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(self.pathItemColor);
                context.setLineWidth(self.pathItemSize);
                context.setAlpha(self.pathItemOpacity);
                context.beginPath(); //start drawing
                context.move(to: CGPoint(x: prevPoint.x, y: prevPoint.y)); // move to old points
                context.addLine(to: CGPoint(x: point.x, y: point.y)); // add line to new points
                context.strokePath(); //fill the path
            }

            prevPoint = point;
            i+=1;
        }
    }
    
    

}
