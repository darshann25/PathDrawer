//
//  TouchEventHandler.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class TouchEventHandler {
    typealias SceneViewCallback = (UIEvent) -> ()
    typealias SceneViewCallbackWithPoint = (UIEvent, Double, Double) -> ()
    typealias SceneViewCallbackWithPointScale = (UIEvent, Double, Double, Double) -> ()
    
    private var canvas : SceneView
    // To determine whether a move event corresponds to a drag event.
    private var isDragging : Bool = false
    private var isPanning : Bool = false
    private var isZooming : Bool = false
    private var isLiveZooming : Bool = false
    private var accumulatedX : Double = 0
    private var accumulatedY : Double = 0
    private var totalDeltaX : Double = 0
    private var totalDeltaY : Double = 0
    private var totalScaleFactor : Double = 1
    private var MIN_SCALE_EPSILON : Double = 0.10 // minimum percentage before a pinch event is
    // treated as an attempt to zoomv
    
    init(sv : SceneView) {
        self.canvas = sv
    }
    
    private var sceneViewOnDown : SceneViewCallbackWithPoint = {}
    private var sceneViewOnMove : SceneViewCallbackWithPoint = {}
    private var sceneViewOnMoveInSceneOnly : SceneViewCallbackWithPoint = {}
    private var sceneViewOnUp : SceneViewCallback = {}
    private var sceneViewOnStartPan : SceneViewCallbackWithPoint = {}
    private var sceneViewOnChangePan : SceneViewCallbackWithPoint = {}
    private var sceneViewOnEndPan : SceneViewCallback = {}
    private var sceneViewOnStartZoom : SceneViewCallbackWithPoint = {}
    private var sceneViewOnChangeZoom : SceneViewCallbackWithPointScale = {}
    private var sceneViewOnEndZoom : SceneViewCallback = {}
    
    public func getIsDragging() -> Bool {
        return self.isDragging
    }
    
    public func setIsDragging(x : Bool) {
        self.isDragging = x
    }
    
    public func setSceneViewOnDown(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnDown = f
    }
    
    public func setSceneViewOnMove(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnMove = f
    }
    
    public func setSceneViewOnMoveInSceneOnly(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnMoveInSceneOnly = f
    }
    
    public func setSceneViewOnUp(f : SceneViewCallback) {
        self.sceneViewOnUp = f
    }
    
    public func setSceneViewOnStartPan(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnStartPan = f
    }
    
    public func setSceneViewOnChangePan(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnChangePan = f
    }
    
    public func setSceneViewOnEndPan(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnEndPan = f
    }
    
    public func setSceneViewOnStartZoom(f : SceneViewCallbackWithPoint) {
        self.sceneViewOnStartZoom = f
    }
    
    public func setSceneViewOnChangeZoom(f : SceneViewCallbackWithPointScale) {
        self.sceneViewOnChangeZoom = f
    }
    
    public func setSceneViewOnEndZoom(f : SceneViewCallback) {
        self.sceneViewOnEndZoom = f
    }
}
