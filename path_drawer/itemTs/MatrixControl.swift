//
//  MatrixControl.swift
//  ItemT
//
//  Created by URMISH M BHATT on 11/8/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation
import UIKit

import Matrix.swift
import Rect.swift
import Point.swift



/*
 
 func drawRectAccountingForZooms(ctx,rect,zoomX: Double,zoomY: Double)->Any?{
 
 var lineWidth = ctx.lineWidth;
 // Draw horizontal lines
 ctx.beginPath();
 ctx.lineWidth = lineWidth / zoomY;
 ctx.moveTo(rect.left, rect.top);
 ctx.lineTo(rect.right(), rect.top);
 ctx.moveTo(rect.left, rect.bottom());
 ctx.lineTo(rect.right(), rect.bottom());
 ctx.stroke();
 
 
 // Draw vertical lines
 ctx.beginPath();
 ctx.lineWidth = lineWidth / zoomX;
 ctx.moveTo(rect.left, rect.top);
 ctx.lineTo(rect.left, rect.bottom());
 ctx.moveTo(rect.right(), rect.top);
 ctx.lineTo(rect.right(), rect.bottom());
 ctx.stroke();
 
 
 }
 
 */


func MatrixControlButton(cx : Double, cy : Double, width: Double, height: Double, thickness: Double, color: UIColor) {
    
    var VISIBLE_TO_CLICK_RATIO = 0.4;
    
    func containsPoint(x : Double, y : Double, zoomX: Double, zoomY: Double) -> Any?{
        let left = cx - width / (2 * zoomX);
        let right = cx + width / (2 * zoomX);
        let top = cy - height / (2 * zoomY);
        let bottom = cy + height / (2 * zoomY);
        
        return (left < x   && right > x  && top < y && bottom > y );
    }
    
    /*
     func draw(ctx, zoomX: Double, zoomY: Double)->Any? {
     var radiusX = VISIBLE_TO_CLICK_RATIO * width / (2 * zoomX);
     var radiusY = VISIBLE_TO_CLICK_RATIO * height / (2 * zoomY);
     var rect = Rect(cx - radiusX, cy - radiusY, 2 * radiusX, 2 * radiusY);
     // Draw the white rectangle
     ctx.fillStyle = 'white';
     ctx.lineWidth = thickness;
     ctx.fillRect(rect.left, rect.top, rect.width, rect.height);
     // Draw the coloured border
     ctx.strokeStyle = color;
     ctx.lineWidth = thickness;
     drawRectAccountingForZooms(ctx, rect, zoomX, zoomY);
     }*/
    
    /*   var public_interface = {
     containsPoint: containsPoint,
     // May need to override this if the implementation isn't a square.
     draw: draw,
     // Override the following two methods to provide functionality for the button.
     getCursor: function(matrix) { return 'default'; },
     computePostMatrix: function(p0, p1) { return Matrix.identityMatrix(); },
     };
     return public_interface;
     
     */
    
}

class MatrixControl{
    
    // var color = options.color;
    // var showButtons = options.showButtons;
    
    var BTN_SIZE = 17.5;
    var LINE_THICKNESS = 1.5;
    
    /* if (!buttonOptions) {
     // default: show all eight buttons
     var buttonOptions = [true, true, true, true, true, true, true, true];
     }*/
    
    
    var initialTranslateMatrix;
    var rect;
    var totalMatrix;
    
    var matrix;
    var inverseMatrix;
    func setMatrix(matrix) {
        matrix = _matrix;
        inverseMatrix = _matrix.inverse();
    }
    
    var downPoint;
    var downMatrix;
    var downInverseMatrix;
    var downButton;
    
    var buttons=[];
    
    init (initialRect: Any, options :Any, buttonOptions: Any){
    
        
    
    
    
    }
    
    
    
    
}

