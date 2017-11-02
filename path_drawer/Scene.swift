//
//  Scene.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class Scene {
    var items = [Item]();
    
    init() {
        
    }
    
    func addItem(item: Item) {
        items.append(item);
    }
    
    func draw(toolManager : ToolManager){
        for item in items{
            item.draw(toolManager : toolManager);
        }
    }
}
