//
//  BoxRichTextOutput.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit
class BoxRichTextOutput {

    var type: String
    var charPos: Float
    var width:Float
    var ascent: Float
    var descent: Float
    
    
    init(){
    
        self.type="box"
     //   self.charPos = charPos
        self.width=5
        self.ascent=5
        self.descent=0
    }
    
   // BoxTextOutput.prototype = Object.create(TextOutput.prototype);
    
    func drawOnCanvas(ctx:UIGraphicsRenderer, x:Float, y:Float, ascent:Float){
   
        let ctx = UIGraphicsGetCurrentContext()
        
 //       ctx.setFillColor(UIColor.blue)
   //     ctx.fillRect(x,y,5,ascent)
    
 
    }

    
    
    
}
