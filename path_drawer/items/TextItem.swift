//
//  TextItem.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

// set DEBUG_MODE to display helper line and rect
let DEBUG_MODE = false

class TextItem : Item {
    
    private var buffer : TextBuffer
    private var localBaselineLeft : Point
    private var localBaselineRight : Point
    private var lines : RichTextLines
    
    init(state : TextItemState) {
        self.buffer = state.buffer
        
        // points where the line 0 baseline intersects the left (resp. right) margin
        // in the item's local coordinates
        self.localBaselineLeft = state.baselineLeft
        self.localBaselineRight = state.baselineRight
        
        // TODO: fix this when we implement rotations
        var textWidth = this.localBaselineRight.x - this.localBaselineLeft.x;
        self.lines = TextLines(buffer : self.buffer, maxWidth : textWidth);
        
    }
    
    func shallowCopyItemState(id : Int, devId : Int) -> TextItemState {
        return TextItemState(id: id, devId: devId, matrix: self.matrix, buffer: self.buffer, baselineLeft: self.localBaselineLeft, baselineRight: self.localBaselineRight)
    }
    
    func getBoundingRect() -> Rect {
        var topLeft = self.getCorner(chirality : "left", matrix : self.matrix, refLine : "topBox")
        var topRight = self.getCorner(chirality : "right", matrix : self.matrix, refLine : "topBox")
        var left = topLeft.x
        var top = topLeft.y
        // respect a larger width if baselineRight demands it
        var width = max(self.lines.getWidth(), topRight.x - topLeft.x)
        var height = self.lines.getHeight() + 2 * TEXT_PADDING
        var rect = Rect(left : left, top : top, width : width, height : height)
        return rect
    }
    
    func drawOnCanvas(canvas : CGContext, matrix : Matrix) {
        var ctx = UIGraphicsGetCurrentContext()
        // if matrix is non-trivial then width might have changed, so the layout must
        // be recalculated
        var lines : RichTextLines
        var topBoxLeft : Point // top-left corner of the implicit textbox
        var totalMatrix = matrix.times(self.matrix)
        
        
        if(matrix != nil || matrix === Matrix.identityMatrix()) {
            lines = self.lines
            topBoxLeft = self.getCorner(chirality : "left", matrix : self.matrix, refLine : "topBox")
        } else {
            topBoxLeft = self.getCorner(chirality : "left", matrix : totalMatrix, refLine : "topBox")
            lines = RichTextLines(buffer : self.buffer, maxWidth : self.getTextWidth(matrix : totalMatrix))
        }
        // point where the top and left margins intersect
        var textTopLeft = topBoxLeft.translate(xDist : TEXT_PADDING, yDist : TEXT_PADDING)
        ctx.saveGState()
        ctx.translateBy(textTopLeft.x, textTopLeft.y)
        lines.drawOnContext(context : ctx)
        ctx.restoreGState()
    
        if (DEBUG_MODE) {
            // should draw the line 0 baseline
            // debug code
            var baselineLeft = self.getCorner(chirality : "left", matrix : totalMatrix, refLine : "baseline")
            var baselineRight = this.getCorner(chirality : "right", matrix : totalMatrix, refLine : "baseline")
            ctx.beginPath()
            ctx.move(to: convertToCGPoint(point: baselineLeft))
            ctx.addLine(to: convertToCGPoint(point: baselineRight))
            ctx.strokePath()
            
            var rect = self.getBoundingRect()
            ctx.addRect(CGRect(x: rect.left, y: rect.top, width: rect.width, height: rect.height))
            ctx.strokePath()
        }
    }
    
    
    // TODO : SVG Data Support
    /*
    func addSvgData(svg : Any, svgMatrix : Matrix) {
        var matrix = svgMatrix.times(matrix : self.matrix)
        self.lines.addSvgData(svg : svg, matrix : matrix)
    }
    */
    
    var scaleInvariant = false
    
    func setMatrix(matrix : Matrix) {
        // Object.getPrototypeOf(TextItem.prototype).setMatrix.call(this, matrix);
        self.lines = RichTextLines(buffer : self.buffer, maxWidth : self.getTextWidth(matrix : self.matrix));
        if (self.scene != Scene.nullScene) {
            self.scene.redisplay()
            self.scene.reindex()
        }
    }
    
    // enums
    enum chiralities {
        case Left: "left"
        case Right: "right"
    }
    
    enum referenceLines {
        case TopBox: 'topBox'       // top of the (implicit) textbox
        case Baseline: 'baseline'   // line 0 baseline
    }

    func getInitialBaseline(chirality : TextItem.chiralities) -> Point {
        switch (chirality) {
            case TextItem.chiralities.Left
                return self.localBaselineLeft
        
            case TextItem.chiralities.Right:
                return self.localBaselineRight
        
            default:
                // analytics.unexpected('TextItem.getInitialBaseline, chirality', chirality)
        }
    }
    
    func getCorner(chirality : TextItem.chiralities, matrix : Matrix, refLine : TextItem.referenceLines) -> Point {
        // FIX ME when rotation is implemented
        var dx = 0
        var dy = -self.getDistToptoBaseline()
        
        switch (chirality) {
            case TextItem.chiralities.Left:
                dx = -TEXT_PADDING;
                break
        
            case TextItem.chiralities.Right:
                dx = TEXT_PADDING
                break
        
            default:
                //analytics.unexpected('TextItem.getCorner, chirality', chirality)
        }
        
        var topBoxBeforeMatrix = self.getInitialBaseline(chirality : chirality).translate(xDist : dx, yDist : dy)
        var topBox = matrix.timesPoint(point : topBoxBeforeMatrix)
    
        switch (refLine) {
            case TextItem.referenceLines.TopBox:
                return topBox
        
            case TextItem.referenceLines.Baseline:
                return topBox.translate(xDist : -dx, yDist : -dy)
        
            default:
                //analytics.unexpected('TextItem.getCorner, refLine', refLine)
                return topBox; // return any old point eh
        }
    }
    
    func getDistToptoBaseline() -> Double {
        if (self.lines != nil) {
            NSLog("ERROR: TextItem.getDistTopToBaseline(), lines === null")
            return TEXT_PADDING; // next best thing
        } else {
            // return self.lines.lines[0].ascent + TEXT_PADDING;
        }
    }
    
    func getTextWidth(matrix : Matrix) -> Double {
        // FIX ME when rotation is implemented
        var topBoxLeft = self.getCorner(chirality: "left", matrix: matrix, refLine: "topBox")
        var topBoxRight = self.getCorner(chirality: "right", matrix: matrix, refLine: "topBox")
        return topBoxRight.x - topBoxLeft.x - 2 * TEXT_PADDING
    }
    
    func createPreTextItemT() -> PreTextItemT {
        var newBuffer = self.buffer.revertFromLatexToText();
        var baselineLeft = self.getCorner(chirality: "left", matrix: self.matrix, refLine: "baseline")
        var baselineRight = self.getCorner(chirality: "right", matrix: self.matrix, refLine: "baseline")
        var newLines = RichTextLines(buffer : newBuffer, maxWidth : baselineRight.x - baselineLeft.x);
        var dy = - newLines.lines[0].ascent - TEXT_PADDING;
        var newBoxTopLeft = baselineLeft.translate(xDist : -TEXT_PADDING, yDist : dy);
        // var newBoxTopRight = baselineRight.translate(TEXT_PADDING, dy);
        return PreTextItemT(x : newBoxTopLeft.x, y : newBoxTopLeft.y, textItem : this, width : this.getBoundingRect().width);
    };

    
    
}
