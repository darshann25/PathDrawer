//
//  PathItem.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

/*
     The Path class represents a path, which is internally defined by a PointBuffer and a float-valued index range.
     For closed paths, the initial point also appears at the end of the PointBuffer (to simplify a few algorithms).
     The parameter for a path (often denoted as 's') can be float-valued (see PointBuffer.getPoint())
     If it is an integer, it indexes a point in the PointBuffer.
     Otherwise, it interpolates between the two nearest points in the PointBuffer.
     Note that some paths may not start at parameter 0 (or end at parameter PointBuffer.length-1).
     If a parameter is given out of range, it should be clamped to the given range.
     Paths can be joined. See this.nextPath and Path.getPoint() for details of the implementation.
 */


import Foundation
import UIKit

let DEBUG_MODE = false
let LINEAR_ONLY = false

class PathItem : Item {
    
    /////////////
    // private //
    /////////////
    
    private var path : Path
    private var pathItemColor : CGColor
    private var pathItemSize : CGFloat
    private var pathItemOpacity : CGFloat
    
    private var resource : Resource
    private var beginIndex : Int
    private var endIndex : Int
    private var pointBuffer : PointBuffer
    private var points : [Point]
    
    // var prePathItemT : PrePathItemT
    
    init (state: PathItemState) {
        
        self.pathItemColor = state.color
        self.pathItemSize = state.size
        self.pathItemOpacity = state.opacity
        
        self.resource = state.resource
        self.beginIndex = state.beginIndex
        self.endIndex = state.endIndex
        self.points = resource.data as! [Point]
        
        self.pointBuffer = PointBuffer(pointsArray : self.points)
        self.path = Path(buffer: pointBuffer, s0: state.beginIndex, s1: state.endIndex)
        
        super.init(state: state)
    }
    
    func shallowCopyItemState(id : Int, devId : Int) -> PathItemState {
        return PathItemState(id: id, devId : devId, matrix: self.matrix.copy(), resource : self.resource, beginIndex: self.beginIndex,
                             endIndex: self.endIndex, color: self.pathItemColor, size: self.pathItemSize, opacity: self.pathItemOpacity)
    }
    
    func drawOnCanvas(sv : SceneView) {
        if let context = UIGraphicsGetCurrentContext() {
            
            context.beginPath()
            context.saveGState()
            
            context.setStrokeColor(self.pathItemColor)
            context.setLineWidth(self.pathItemSize)
            context.setAlpha(self.pathItemOpacity)
            context.setLineCap(CGLineCap.round)
            let matrix = self.matrix
            // context.userSpaceToDeviceSpaceTransform(matrix)
            
            context.restoreGState()
            
        }
    }

    override func getPdfgenData(matrix: Matrix) -> Dictionary<String, Any> {
        var xs = [Double]()
        var ys = [Double]()
        
        for i in 0...(self.path.pointBuffer.points.count - 1) {
            xs.append(self.path.pointBuffer.points[i].x)
            ys.append(self.path.pointBuffer.points[i].y)
        }
        
        var m = matrix.times(that: self.matrix)
        
        var data : [String: Any] = [
            "t" : "path",
            "m" : m.toArray(),
            "c" : self.pathItemColor, // TODO : Convert to RGB Value
            "s" : self.size,
            "xs" : xs,
            "ys" : ys
        ]
        if (self.opacity != 1) {
            data["alpha"] = 1     // set alpha flag
        }
        
        return data;
        
    }
    
    
    // TODO : Understand and fix addSvgData function
    func addSvgData(svg : PathItem, svgMatrix : Matrix) {
        /*
        var pathStringBuffer = []
        pathStringBuffer.append("M${ " + String(self.path.pointBuffer.points[0].x) + " } ${ ", String(self.path.pointBuffer.points[0].y) + " }")
        
        // TODO : Cubic Data
        for i in 0...(self.path.cubicData.count - 1) {
            var cd = self.path.cubicData[i]
            pathStringBuffer.append("C${ " + String(cd[0]) + " } ${ " + String(cd[1]) + " } ${ " + String(cd[2]) + " } ${ " + String(cd[3]) + " } ${ " + String(cd[4]) + " } ${ " + String(cd[5]) + " }`")
        }
        var pathString = pathStringBuffer
        var path = svg.path(pathString)
        path.fill("none");
        path.stroke([ "width" : self.size, "color" : self.color ]);
        path.attr("stroke-opacity", self.opacity);
        path.transform(SVG.Matrix(svgMatrix.times(self.matrix).toArray()));
         */
    }
    
    override func getBoundingRect() -> Rect {
        
        if(self.boundingRect == nil) {
            var rect = Rect(left: 0, top: 0, width: 0, height: 0)
            
            if (LINEAR_ONLY) {
                rect = self.path.computeBoundingRectLinear(matrix : self.matrix)
            } else {
                rect = self.path.computeBoundingRectCubic(matrix : self.matrix)
            }
            
            var thickness = self.size * sqrt(self.matrix.det())
            self.boundingRect = rect.expandedBy(mdl: thickness/2, mdt: thickness/2, dr: thickness/2, db: thickness/2)
        }
        
        return self.boundingRect
    }
    
    func intersectsSegment(end1 : Point, end2 : Point) -> Bool {
        // since the segment is generally small, we use this hack for now
        return self.intersectsRect(Rect.rectFromXYXY(x0 : end1.x, y0 : end1.y, x1 : end2.x, y1 : end2.y))
    }
    
    func intersectsRect(rect : Rect) -> Bool {
        var parallelogram = Parallelogram(rect : rect, inverseMatrix : self.matrix)
        return self.path.intersectsParallelogram(parallelogram : parallelogram)
    };
    
    /*
     PathItem.prototype.getBoundingRect = function() {
     if (!this.boundingRect) {
     var rect;
     if (LINEAR_ONLY) {
     rect = this.path.computeBoundingRectLinear(this.matrix);
     } else {
     rect = this.path.computeBoundingRectCubic(this.matrix);
     }
     var thickness = this.size * Math.sqrt(this.matrix.det());
     this.boundingRect = rect.expandedBy(thickness / 2, thickness / 2, thickness / 2, thickness / 2);
     }
     return this.boundingRect;
     };
     }*/
    
    /////////////////////////////
    //// LEGACY /////////////////
    /////////////////////////////
    override func draw() {
        
        var prevPoint = self.points[0];
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
