//
//  Parallelogram.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

/**
 A Parallelogram is a Rect, together with a Matrix.
 It is intended to generalize a Rect to something that can be rotated (ie. not respecting the xy coordinate system).
 
 Example use scenario:
 A PathItem has a non-trivial matrix.
 The Scene asks the PathItem if it intersects a Rect.
 The PathItem would like to use Path.intersectsRect(), but can't, because of the matrix.
 So instead, the PathItem uses Path.intersectsParallelogram(), and under the hood, the Path applies the matrix transformation to itself and calls intersectsRect().
 
 @class Parallelogram
 @param {Rect} rect A rectangle used to specify the parallelogram
 @param {Matrix} inverseMatrix The inverse of the matrix that should be applied to the rectangle to get the parallelogram. (It seems that this is the property that needs to be stored and retrieved, so this is an optimization to avoid computing a matrix inverse twice.)
 */

class Parallelogram {
    var rect : Rect
    var inverseMatrix : Matrix
    
    init (rect: Rect, inverseMatrix: Matrix){
        self.rect = rect
        self.inverseMatrix = inverseMatrix
    }
}

