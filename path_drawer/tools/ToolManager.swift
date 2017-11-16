//
//  toolManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 10/25/17.
//  Authored by Darshan Patel on 11/11/17.
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
    
    var textTool : TextTool;
    var boxSelectorTool : BoxSelectorTool;
    // var panTool : PanTool;
    var myScriptTool : MyScriptTool;
    
    
    init() {
        self.penTool = PenTool()
        self.penTool.setColor(to: UIColor.black.cgColor)
        self.penTool.setSize(to: 5)
        self.penTool.setOpacity(to: 1)
        
        self.highlighterTool = PenTool();
        self.highlighterTool.setSize(to: 25);
        self.highlighterTool.setOpacity(to: 0.7);
        self.highlighterTool.setColor(to: UIColor.yellow.cgColor);
        
        self.textTool = TextTool();
        textTool.setFormattingToDefault();
        
        self.magicEraserTool = MagicEraserTool();
        self.boxSelectorTool = BoxSelectorTool();
        // self.panTool = PanTool();
        self.myScriptTool = MyScriptTool();

    }
    
    func getPenTool() -> PenTool {
        return self.penTool;
    }
    
    func getHighlighterTool() -> PenTool {
        return self.highlighterTool;
    }
    
    func getTextTool() -> TextTool {
        return self.textTool;
    }
    
    func getEraserTool() -> MagicEraserTool {
        return self.magicEraserTool;
    }
    
    func getMouseTool() -> BoxSelectorTool {
        return self.boxSelectorTool;
    }
    
    //func getPanTool() -> PanTool {
    //    return self.panTool;
    //}
    
    func getMyScriptTool() -> MyScriptTool {
        return self.myScriptTool;
    }
}
