//
//  TextItem.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

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
}
