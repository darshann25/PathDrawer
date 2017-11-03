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
    //var prePathItemT : PrePathItemT;
    var points : [CGPoint];
    var pstate : ItemState;
    var pathItemColor : CGColor;
    var pathItemSize : CGFloat;
    var pathItemAlpha : CGFloat;
    
    init(pointsArr: [CGPoint], penTool : PenTool) {
        self.pstate = ItemState(type : ItemType.Path, id: 1, devId : 1, matrix : Matrix());
        
        // The Stroke properties are immutably set from the PenTool on initialization
        self.pathItemColor = penTool.color;
        self.pathItemSize = penTool.size
        self.pathItemAlpha = penTool.alpha;
        
        self.points = [CGPoint]();
        for point in pointsArr {
            self.points.append(point);
        }
        //prePathItemT = PrePathItemT();
        super.init(state : self.pstate);
    }
    
    /*init (state: PathItemState) {
        
        self.path = NSNull
        self.color = state.color
        self.size = state.size
        self.opacity = state.opacity
        
        self.resource = state.resource
        self.beginIndex = state.beginIndex
        self.endIndex = state.endIndex
        
        struct PointBuffer {
            var x = 0
            var y = 0
        }
        
        var pointBuffer = PointBuffer(x: self.resource.data[0], y: self.resource.data[1])
        self.path = Path(buffer: pointBuffer, begin: state.beginIndex, end: state.endIndex)
    }*/
    
   /*func shallowCopyItemState(ID: Id, Dev: devId){
        return PathItemState(ID: Id, matrix: self.matrix.copy, resc: self.resource, begin: self.beginIndex, end: self.endIndex, color: self.color, size: self.size, alpha: self.opacity )
    }*/

    override func draw() {
        
        var prevPoint = points[0];
        var i = 1;
        while(i < points.count) {
            let point = points[i];
            
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(self.pathItemColor);
                context.setLineWidth(self.pathItemSize);
                context.setAlpha(self.pathItemAlpha);
                context.beginPath(); //start drawing
                context.move(to: CGPoint(x: prevPoint.x, y: prevPoint.y)); // move to old points
                context.addLine(to: CGPoint(x: point.x, y: point.y)); // add line to new points
                context.strokePath(); //fill the path
            }

            prevPoint = point;
            i+=1;
        }
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

}
