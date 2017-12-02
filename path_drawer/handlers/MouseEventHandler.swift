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
    typealias SceneViewCallbackWithPoint = (UIEvent, Double, Double) -> ()
    typealias SceneViewCallback = (UIEvent) -> ()
    
    private var canvas : SceneView
    private var isDragging : Bool = false
    
    init(sv : SceneView) {
        self.canvas = sv
    }
    
    private var sceneViewOnDown : SceneViewCallbackWithPoint = {event, x , y in }
    private var sceneViewOnMove : SceneViewCallbackWithPoint = {event, x , y in }
    private var sceneViewOnMoveInSceneOnly : SceneViewCallbackWithPoint = {event, x , y in }
    private var sceneViewOnUp : SceneViewCallback = {event in }
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

    public func setSceneViewOnDown(f : @escaping SceneViewCallbackWithPoint) {
        self.sceneViewOnDown = f
    }
    
    public func setSceneViewOnMove(f : @escaping SceneViewCallbackWithPoint) {
        self.sceneViewOnMove = f
    }
    
    public func setSceneViewOnMoveInSceneOnly(f : @escaping SceneViewCallbackWithPoint) {
        self.sceneViewOnMoveInSceneOnly = f
    }
    
    public func setSceneViewOnUp(f : @escaping SceneViewCallback) {
        self.sceneViewOnUp = f
    }
    
    
    public func getIsDragging() -> Bool {
        return isDragging
    }
    
    public func setIsDragging(x : Bool){
        self.isDragging = x
    }
}
