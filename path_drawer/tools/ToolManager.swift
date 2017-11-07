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
    var penTool : PenTool!
    //ERASER TOOL
    var magicEraserTool : MagicEraserTool;
    //HIGHLIGHTER TOOL
    var highlighterTool : PenTool;
    
    init() {
        self.penTool = PenTool()
        self.penTool.setColor(to: UIColor.black.cgColor)
        self.penTool.setSize(to: 5)
        self.penTool.setAlpha(to: 1)
        
        self.highlighterTool = PenTool();
        self.highlighterTool.setSize(to: 25);
        self.highlighterTool.setAlpha(to: 0.7);
        self.highlighterTool.setColor(to: UIColor.yellow.cgColor);
        
        self.magicEraserTool = MagicEraserTool();
    }
    
    func getPenTool() -> PenTool{
        return self.penTool;
    }
    
    func getHighlighterTool () -> PenTool{
        return self.highlighterTool;
    }
    
    func getEraserTool () -> MagicEraserTool{
        return self.magicEraserTool;
    }
}
