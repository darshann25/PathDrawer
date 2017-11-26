//
//  Region.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Authored by Darshan Patel on 11/26/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

/*
 The Region class represents a 2D connected region, which is internally defined by an array of closed Paths.
 The first path in the array should be counterclockwise oriented and defines the exterior boundary of the region.
 The remaining paths should be clockwise oriented and define holes in the region.
 No paths should cross any other path and no hole should contain another hole.
 With this definition, a point is inside the region if its winding number is 1, otherwise its winding number is 0.
 */

// class Region
class Region {
    
    var boundary : Path
    var holes : [Path]
    
    init(paths : [Path]) {
        // NOTE: All paths must be closed!
        self.boundary = paths[0]
        self.holes = paths.removeFirst(1)
    }
    
    // traces out the Region
    func trace(ctx : CGContext) {
        self.boundary.traceLinear(ctx: ctx)
        
        for hole in holes {
            hole.traceLinear(ctx: ctx)
        }
    }
    
    func computeBoundingRect(matrix : Matrix) -> Rect {
        return self.boundary.computeBoundingRectLinear(matrix:matrix)
    }
    
    func containsPoint(point : Point) {
        // TODO use winding numbers
    }
    
    // returns a potentially empty array of regions (for partial erase)
    func removeParallelogram(parallelogram : Parallelogram) {
        // TODO
    }
    
    // chooses a path to follow during a trace (assumes path1 and path2 start at the same point)
    func choosePath(path1 : Path, path2 : Path) {
        // TODO
    }
    
}
