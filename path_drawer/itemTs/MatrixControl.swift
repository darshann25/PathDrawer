//
//  MatrixControl.swift
//  ItemT
//
//  Created by URMISH M BHATT on 11/8/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation
import UIKit



func drawRectAccountingForZooms(ctx: CGContext ,rect: Rect,zoomX: Double,zoomY: Double){
    
    let lineWidth = ctx.setLineWidth(<#CGFloat#>);
    // Draw horizontal lines
    ctx.beginPath()
    ctx.setlineWidth = lineWidth / zoomY;
    ctx.move(to: (rect.left,rect.top));
    ctx.addLine(to: (rect.right(), rect.top));
    ctx.move(to: (rect.left, rect.bottom()));
    ctx.addLine(to:(rect.right(), rect.bottom()));
    ctx.strokePath();
    
    
    // Draw vertical lines
    ctx.beginPath();
    ctx.setLineWidth = lineWidth / zoomX;
    ctx.move(to:(rect.left, rect.top));
    ctx.addLine(to: (rect.left, rect.bottom()));
    ctx.move(to: (rect.right(), rect.top));
    ctx.addLine(to:(rect.right(), rect.bottom()));
    ctx.strokePath();
 
 }
 



func MatrixControlButton(cx : Double, cy : Double, width: Double, height: Double, thickness: Double, color: UIColor) {
    
    var VISIBLE_TO_CLICK_RATIO = 0.4;
    
    func containsPoint(x : Double, y : Double, zoomX: Double, zoomY: Double) -> Any?{
        let left = cx - width / (2 * zoomX);
        let right = cx + width / (2 * zoomX);
        let top = cy - height / (2 * zoomY);
        let bottom = cy + height / (2 * zoomY);
        
        return (left < x   && right > x  && top < y && bottom > y );
    }
    
    
     func draw(ctx: CGContext , zoomX: Double, zoomY: Double)->Any? {
        
        var radiusX = VISIBLE_TO_CLICK_RATIO * width / (2 * zoomX);
        var radiusY = VISIBLE_TO_CLICK_RATIO * height / (2 * zoomY);
        var rect = Rect(left: cx - radiusX, top : cy - radiusY, width: 2 * radiusX, height : 2 * radiusY);
        // Draw the white rectangle
        
        ctx.setFillColor(color: "White");
        ctx.setLineWidth = thickness;
        ctx.fillRect(rect.left, rect.top, rect.width, rect.height);
        // Draw the coloured border
        ctx.strokeStyle = color;
        ctx.lineWidth = thickness;
        drawRectAccountingForZooms(ctx: ctx, rect: rect, zoomX: zoomX, zoomY: zoomY);
    }

        
    var public_interface = {
        
        containsPoint: containsPoint;
        // May need to override this if the implementation isn't a square.
        draw: draw;
        // Override the following two methods to provide functionality for the button.
        func getCursor(matrix:Matrix){
            return "default";
        }
        func computePostMatrix(p0:Double,p1:Double){
            return Matrix.identityMatrix();
        }
    };
    return public_interface;

    
 
    
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
    
    
    var initialTranslateMatrix: Matrix;
    var rect: Rect;
    var totalMatrix:Matrix;
    
    var matrix:Matrix;
    var inverseMatrix:Matrix;
    func setMatrix(matrix: Matrix) {
        matrix = matrix;
        inverseMatrix = matrix.inverse();
    }
    
    var downPoint;
    var downMatrix;
    var downInverseMatrix;
    var downButton;
    
    var buttons=[];
    
    init (initialRect: Any, options :Any, buttonOptions: Any){
    
        var cx = initialRect.left + initialRect.width / 2;
        var cy = initialRect.top + initialRect.height / 2;
        initialTranslateMatrix = Matrix.translateMatrix(-cx, -cy);
        totalMatrix = matrix.identityMatrix();
        setMatrix(Matrix.translateMatrix(cx, cy));

        var wo2 = initialRect.width / 2;
        var ho2 = initialRect.height / 2;
        rect = Rect(-wo2, -ho2, wo2 * 2, ho2 * 2);

        func pushButton(x:Double, y: Double, buttonName: String) {
            var button = MatrixControlButton(x, y, BTN_SIZE, BTN_SIZE, LINE_THICKNESS, color);
            func ButtongetCursor (matrix: Matrix){
            
                return buttonName.concat("-resize");
            }
            button.ButtongetCursor(matrix);
            button.computePostMatrix = function(p0, p1) {
                var shift = Matrix.translateMatrix(x, y);
                func direction(a:Double) {
                    if (a > 0) {
                        return 1;
                    } else if (a < 0) {
                        return -1;
                    } else {
                        return 0;
                    }
                }
                var scaleX = (rect.width + direction(x) * (p1.x - p0.x)) / rect.width;
                var scaleY = (rect.height + direction(y) * (p1.y - p0.y)) / rect.height;
                var m = Matrix(scaleX, 0, 0, scaleY, 0, 0);
                var unshift = Matrix.translateMatrix(-x, -y);
                return unshift.times(m.times(shift));
            };
            buttons.push(button);
        }
        
        if (buttonOptions[0]) {
            pushButton(-wo2, -ho2, "nw");
        }
        
        // north button
        if (buttonOptions[1]) {
            pushButton(0, -ho2, "n");
        }
        
        // northeast button
        if (buttonOptions[2]) {
            pushButton(wo2, -ho2, "ne");
        }
        
        // east button
        if (buttonOptions[3]) {
            pushButton(wo2, 0, "e");
        }
        
        // southeast button
        if (buttonOptions[4]) {
            pushButton(wo2, ho2, "se");
        }
        
        // south button
        if (buttonOptions[5]) {
            pushButton(0, ho2, "s");
        }
        
        // southwest button
        if (buttonOptions[6]) {
            pushButton(-wo2, ho2, "sw");
        }
        
        // west button
        if (buttonOptions[7]) {
            pushButton(-wo2, 0, "w");
        }
        
        func drag(p0:Double, p1:Double) {
            return Matrix.translateMatrix(p1.x - p0.x, p1.y - p0.y);
        }
        
        var cButton = MatrixControlButton(0, 0, wo2 * 2, ho2 * 2);
        func cButtongetCursor(matrix:Matrix) {
            return "move";
        };
        cButton.cButtongetCursor(matrix);
        
        cButton.computePostMatrix = drag;
        cButton.draw = function() {};
        // unlike the other buttons, this button will scale with the transformation
        func cButtoncontainsPoint(x: Double, y: Double, zoomX:Double, zoomY:Double) {
            var left = -wo2;
            var right = wo2;
            var top = -ho2;
            var bottom = ho2;
            return (left < x   &&
                right > x  &&
                top < y    &&
                bottom > y );
        };
        buttons.push(cButton);
    }
   
    
    func acceptsHover(x:Double, y:Double, zoom:Double) {
        
        var localPoint = inverseMatrix.timesPoint(point: Point(x, y));
        var zoomX = zoom * matrix.a;
        var zoomY = zoom * matrix.d;
        
        // If the cursor isn't over the large rectangle, don't check each button.
        var dx = BTN_SIZE / (2 * zoomX);
        var dy = BTN_SIZE / (2 * zoomY);
        if (!rect.expandedBy(dx, dy, dx, dy).containsPointXY(localPoint.x, localPoint.y)) {
            return false;
        }
        
        // Check the buttons
        for (var i = 0; i < buttons.length; i += 1) {
            if (buttons[i].containsPoint(localPoint.x, localPoint.y, zoomX, zoomY)) {
                return true;
            }
        }
        return false;

    
    
    }
    
    func getCursor(x:Double, y:Double, zoom:Double) {
        
        var localPoint = inverseMatrix.timesPoint(point: Point(x, y));
        var zoomX = zoom * matrix.a;
        var zoomY = zoom * matrix.d;
        
        // Return that button's cursor
        return getButton(localPoint.x, localPoint.y, zoomX, zoomY).getCursor(matrix);
  
    }
    
    func getButton(x:Double, y:Double, zoomX:Double, zoomY:Double) {
        var button = NSNull();
        
        var i = 0;
        while (button === NSNull() && i < buttons.length) {
            if ((buttons[i] as AnyObject).containsPoint(x, y, zoomX, zoomY)) {
                button = buttons[i] as! NSNull;
            }
            i += 1;

        }
        
        if (((i < buttons.length - 1 && buttons[i].containsPoint(x, y, zoomX, zoomY))
            || (i === buttons.length - 1 && buttons[0].containsPoint(x, y, zoomX, zoomY)))
            && buttons[buttons.length - 1].containsPoint(x, y, zoomX, zoomY)) {
            button = buttons[buttons.length - 1]; // the last button is the shift button
        }
        return button;
    }
    
    func acceptsClick(x:Double, y:Double, zoom:Double) {
        return acceptsHover(x: x, y: y, zoom: zoom);
    }
    
    func onDown(x:Double, y:Double, zoom:Double) {
        var localPoint = inverseMatrix.timesPoint(point: Point(x: x, y: y));
        var zoomX = zoom * matrix.a;
        var zoomY = zoom * matrix.d;
        
        downPoint = Point(localPoint.x, localPoint.y);
        downMatrix = matrix.copy();
        downInverseMatrix = inverseMatrix.copy();
        // ... including the button that was hit
        downButton = getButton(localPoint.x, localPoint.y, zoomX, zoomY);
    }
    
    func onDrag(x:Double, y:Double, zoom:Double) {
        var localPoint = downInverseMatrix.timesPoint(point: Point(x, y));
        var postMatrix = downButton.computePostMatrix(downPoint, localPoint);
        setMatrix(downMatrix.times(postMatrix));
        totalMatrix = matrix.times(that: initialTranslateMatrix);

    }
    
    /*func drawOnCanvas(canvas:CGContext, left:Double, top:Double, zoom:Double) {
        
        var ctx = canvas.getContext("2d");
        ctx.save();
        ctx.translate(-left * zoom, -top * zoom);
        ctx.strokeStyle = color;
        ctx.setLineWidth = LINE_THICKNESS;
        
        var _points = [];
        _points.push(Point(initialRect.left, initialRect.top));
        _points.push(Point(initialRect.right(), initialRect.top));
        _points.push(Point(initialRect.right(), initialRect.bottom()));
        _points.push(Point(initialRect.left, initialRect.bottom()));
        var points = [];
        for (i in 0 ..< 4) {
            points.push(totalMatrix.timesPoint(_points[i]));
        }
        ctx.beginPath();
        ctx.moveTo(points[3].x * zoom, points[3].y * zoom);
        for (i = 0; i < 4; i += 1) {
            ctx.lineTo(points[i].x * zoom, points[i].y * zoom);
        }
        ctx.stroke();
        ctx.restore();
        
        if (showButtons) {
            ctx.save();
            ctx.scale(zoom, zoom);
            ctx.translate(-left, -top);
            // switch to local coordinates
            ctx.transform(matrix.a, matrix.b, matrix.c, matrix.d, matrix.e, matrix.f);
            var zoomX = zoom * matrix.a;
            var zoomY = zoom * matrix.d;
            ctx.fillStyle = color;
            for (var i = buttons.length - 1; i >= 0; i--) {
                buttons[i].draw(ctx, zoomX, zoomY);
            }
            ctx.restore();
        }
        
    }
    
    var public_interface = {
        // the purpose of this class is to get the totalMatrix.
        func getTotalMatrix()->totalMatrix{
            return totalMatrix;
        }
        setTotalMatrix(): setTotalMatrix()
        // event handling
        acceptsHover(): acceptsHover()
        getCursor: getCursor,
        acceptsClick: acceptsClick()
        onDown: onDown()
        onDrag: onDrag()
        // drawing
        drawOnCanvas: drawOnCanvas,
    };
    return public_interface;
    


*/
    


    
    
    
    
    
    
    
}

