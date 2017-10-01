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
    var points = [CGPoint]()
    
    init (pointsArr: CGPoint...) {
        for point in pointsArr {
            points.append(point)
        }
    }
    
    
    func draw(_ rect: CGRect) {
        for point in points {
            let dot = UIBezierPath(ovalIn : CGRect(x : point.x-5, y : point.y-5, width : 10, height : 10));
            UIColor.darkGray.setFill();
            dot.fill();
        }
    }
}
