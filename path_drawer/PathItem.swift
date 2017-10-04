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
    
    
    func draw() {
        /*for point in points {
            let dot = UIBezierPath(ovalIn : CGRect(x : point.x-5, y : point.y-5, width : 10, height : 10));
            UIColor.blue.setFill();
            dot.fill();
        }*/
        
        
        var prevPoint = points[0];
        print(prevPoint);
        var i = 1;
        while(i < points.count) {
            let point = points[i];
            
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.blue.cgColor)
                context.setLineWidth(3)
                context.beginPath()
                context.move(to: CGPoint(x: prevPoint.x, y: prevPoint.y)) // This would be oldX, oldY
                context.addLine(to: CGPoint(x: point.x, y: point.y)) // This would be newX, newY
                context.strokePath()
               // context.move(to: CGPoint(x: 0, y: 0))
            }
            prevPoint = point;
            print(prevPoint);
            i+=1;
        }
    }
}
