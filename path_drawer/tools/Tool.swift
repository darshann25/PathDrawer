//
//  Tool.swift
//  path_drawer
//
//  Created by Darshan Patel on 11/3/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

/**
 Tool is an abstract class that serves as the parent class for all tools - PenTool and MagicEraser
 @class Tool
 @param {ItemState} state The state of the item.
 */

class Tool {
    
    init() {
        
    }
    
    func onDown(touches: Set<UITouch>, sceneView: SceneView) {}
    func onMove(touches: Set<UITouch>, sceneView: SceneView){}
    func onUp(scene: inout Scene, sceneView: SceneView){}
    
}
