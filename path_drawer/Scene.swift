//
//  Scene.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class Scene {
    var pathItems = [PathItem]();
    
    init() {
        
    }
    
    func addPathItem(pathItem: PathItem) {
        pathItems.append(pathItem);
    }
    
    func draw(){
        for path in pathItems{
            path.draw();
        }
    }
}
