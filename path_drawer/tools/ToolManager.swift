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
        var penTool = PenTool()

            //NEED TO FIGURE OUT HOW TO CALL FUNCTIONS IN CLASS
            penTool.setSize(to: 10)
            penTool.setAlpha(to: 1.0)
            penTool.setColor(to: UIColor.black.cgColor)
    
        //HIGHLIGHTER TOOL
        var highlighterTool = PenTool()
    
            highlighterTool.setSize(to: 25)
            highlighterTool.setAlpha(to: 0.7)
            highlighterTool.setColor(to: UIColor.yellow.cgColor)
    
    
        //ERASER TOOL
        var magicEraserTool = MagicEraserTool()

    
                func getPenTool() -> Any{
                    return penTool
                }
    
                func getHighlighterTool () -> Any{
                    return highlighterTool
                }
    
                func getEraserTool () -> Any{
                    return magicEraserTool
                }
}
