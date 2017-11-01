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
    
    
    
    //PEN TOOL
    var penTool : PenTool
    //ERASER TOOL
    var magicEraserTool : MagicEraserTool
    //HIGHLIGHTER TOOL
    var highlighterTool : PenTool
    
    init() {
        self.penTool = PenTool()
        penTool.setSize(to: 10)
        penTool.setAlpha(to: 1.0)
        penTool.setColor(to: UIColor.black.cgColor)
        
        self.highlighterTool = PenTool();
        highlighterTool.setSize(to: 25)
        highlighterTool.setAlpha(to: 0.7)
        highlighterTool.setColor(to: UIColor.yellow.cgColor)
    
        self.magicEraserTool = MagicEraserTool();
    }
    
    
    func getPenTool() -> PenTool{
        return penTool
    }
    
    func getHighlighterTool () -> PenTool{
        return highlighterTool
    }
    
    func getEraserTool () -> MagicEraserTool{
        return magicEraserTool
    }
}

