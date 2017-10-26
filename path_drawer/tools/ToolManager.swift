//
//  toolManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 10/25/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class ToolManager {
    
    var penTool = PenTool()
    
    penTool.setSize(10)
    penTool.setAlpha(1.0)
    penTool.setColor(UIColor.black.cgColor)
    
    var highlighterTool = PenTool()
    
    highlighterTool.setSize(25)
    highlighterTool.setAlpha(0.7)
    highlighterTool.setColor(UIColor.yellow.cgColor)
    
    var magicEraserTool = MagicEraserTool()

}
