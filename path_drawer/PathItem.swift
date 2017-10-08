//
//  PathItem.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class PathItem {
    var points = [CGPoint]();
    
    init (pointsArr: [CGPoint]) {
        for point in pointsArr {
            points.append(point)
        }
    }
    
    //print(points);
    
    
    func draw() {
        // Dots for Lines
        /*for point in points {
            let dot = UIBezierPath(ovalIn : CGRect(x : point.x-5, y : point.y-5, width : 10, height : 10));
            UIColor.blue.setFill();
            dot.fill();
        }*/
        
        
        var prevPoint = points[0];
        var i = 1;
        while(i < points.count) {
            let point = points[i];
            
            if let context = UIGraphicsGetCurrentContext() {
                
                context.setStrokeColor(UIColor.blue.cgColor)
                context.setLineWidth(5)
                context.beginPath() //start drawing
                context.move(to: CGPoint(x: prevPoint.x, y: prevPoint.y)) // move to old points
                context.addLine(to: CGPoint(x: point.x, y: point.y)) // add line to new points
                context.strokePath() //fill the path
            }
            prevPoint = point;
            i+=1;
        }
    }
}
