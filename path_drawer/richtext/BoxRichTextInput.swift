//
//  BoxRichTextInput.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class BoxRichTextInput : RichTextInput {
    
    var width: Float
    var ascent: Float
    var type: String
    
    override init(){
        
        self.type = "box"
        self.width=1
        self.ascent=1
        
        super.init()
    }
    
    //BoxTextInput.prototype = Object.create(TextInput.prototype);
    

    func fromObject(object: BoxRichTextInput)->BoxRichTextInput{
    
        return BoxRichTextInput()
        
    }
}
