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
    
    public func sceneViewOnDown(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnMove(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnMoveInSceneOnly(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnUp(event : UIEvent) {}
    public func sceneViewOnStartPan(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnChangePan(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnEndPan(event : UIEvent) {}
    public func sceneViewOnStartZoom(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnChangeZoom(event : UIEvent, x : Double, y : Double) {}
    public func sceneViewOnEndZoom(event : UIEvent) {}
    
    func getIsDragging() -> Bool {
        return self.isDragging
    }
    
    func setIsDragging(x : Bool) {
        self.isDragging = x
    }
}
