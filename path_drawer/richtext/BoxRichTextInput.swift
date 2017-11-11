//
//  BoxRichTextInput.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class BoxRichTextInput {
    
    var TextInput: RichTextInput

    var width: Float
    var ascent: Float
    var type: String
    
    init(){

        //TextInput.call(self);
        
        self.type = "box"
        self.width=1
        self.ascent=1
        
    }
    
    //BoxTextInput.prototype = Object.create(TextInput.prototype);
    

    func fromObject(object: BoxRichTextInput)->BoxRichTextInput{
    
        return BoxRichTextInput()
        
    }
}
