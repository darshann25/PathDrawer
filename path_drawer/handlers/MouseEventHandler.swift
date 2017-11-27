//
//  MouseEventHandler.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class MouseEventHandler {
    private var canvas : SceneView
    private var isDragging : Bool = false
    
    init(sv : SceneView) {
        self.canvas = sv
    }
    
    public func sceneViewOnDown(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnMove(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnMoveInSceneOnly(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnUp(event : UIEvent) {}
    private func onMouseDownInSceneOnly(event : UIEvent) {

    }
    // canvas.addEventListener('mousedown', onMouseDownInSceneOnly);
    
    private func onMouseMove(event : UIEvent) {
    }
    // document.addEventListener('mousemove', onMouseMove);
    
    private func onMouseMoveInSceneOnly(event : UIEvent) {
    }
    // canvas.addEventListener('mousemove', onMouseMoveInSceneOnly);
    
    private func onMouseUp(event : UIEvent) {
    }
    // document.addEventListener('mouseup', onMouseUp);

    public func getIsDragging() -> Bool {
        return isDragging
    }
    
    public func setIsDragging(x : Bool){
        self.isDragging = x
    }
}
