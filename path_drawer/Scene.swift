//
//  Scene.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/1/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class Scene {
    
    // SINGLETON
    public static var sharedInstance = Scene()
    public static var nullScene : Scene = NullScene()
    
    private var items = [Item]();
    
    // This is responsible for decorating the background of the Scene. It is drawn first.
    private var background : Background // initialize with empty background
    // These are the items that really belong to the Scene
    private var sceneItems : [Item]
    private var sceneItemsById : [Int : [Int : Item]]
    // These items are likely to change quickly, and are drawn last
    private var forefrontItems : [ItemT]
    // These are not drawn, but respond to mouse hover events
    private var hoverResponders : [ItemT]
    // These are not drawn, but respond to mouse click events
    private var clickResponders : [ItemT]
    // These are not drawn, but respond to keyboard events
    private var keyResponders : [ItemT]
    private var toolManager : ToolManager
    
    // The responders to the most recent event.
    private var activeHoverResponder : ItemT
    private var activeClickResponder : ItemT
    
    // This is a list of all SceneViews that are watching the Scene.
    private var sceneViews : [SceneView]
    
    private init() {
        self.background = Background()
        self.sceneItems = [Item]()
        self.sceneItemsById = [Int : [Int : Item]]()
        self.forefrontItems = [Item]()
        self.hoverResponders = [Item]()
        self.clickResponders = [Item]()
        self.keyResponders = [Item]()
        
        self.activeHoverResponder = ItemT.nullItemT
        self.activeClickResponder = ItemT.nullItemT
        
        self.toolManager = ToolManager()
        
        // This is a list of all SceneViews that are watching the Scene.
        self.sceneViews = [SceneView]()
        
        print("In Scene");
    }
    
    // resets the state of the scene
    public func reset() {
        self.sceneItems = [Item]()
        self.sceneItemsById = [Int : [Int : Item]]()
    }
    
    public func setBackground(_background : Background) {
        self.background = _background
        self.redisplay()
    }
    
    public func getBackground() -> Background {
        return self.background
    }
    
    /////////////////////
    // item management //
    /////////////////////
    
    // With start/endChanges(), it is no longer important to add items in batch.
    public func addSceneItem(item : Item) {
        self.sceneItems.append(item);
        if (sceneItemsById[item.devId] == nil) {
            sceneItemsById[item.devId] = [Int : Item]()
        }
        var innerDict : [Int : Item] = self.sceneItemsById[item.devId]
        innerDict[item.id] = item
        self.sceneItemsById[item.devId] = innerDict
        
        item.setScene(self)
        self.reindex()
        self.redisplay()
    }
    
    // With start/endChanges(), it is no longer important to remove items in batch.
    public func removeSceneItem(item : Item) {
        var i : Item = sceneItems.index(where: item)
        if (i > -1) {
            self.sceneItems.remove(at: 0)
        }
        var innerDict = self.sceneItemsById[item.devId]
        innerDict?.removeValue(forKey: item.id)
        self.sceneItemsById[item.devId] = innerDict
        
        item.setScene(Scene.nullScene)
        self.reindex()
        self.redisplay()
    }
    
    public func getItemById(id : Int, devId : Int) -> Item {
        var innerDict = self.sceneItemsById[devId]
        return innerDict[id]
    }
    
    ///////////////////////////
    // geometric item lookup //
    ///////////////////////////
    
    // TODO take a regionRect as a parameter
    public func getSelectableItems() -> [Item] {
        return self.sceneItems
    }
    
    // internal (used by functions below)
    private func getItemsWhereRectIntersectsRect(rect : CGRect) -> [Item] {
        var items = [Item]()
        for item in sceneItems {
            if(rect.intersects(item.getBoundingRect())) {
                items.append(item)
            }
        }
        return items
    }
    
    public func getItemsIntersectingRect(rect : CGRect) -> [Item] {
        var candidates = getItemsWhereRectIntersectsRect(rect: rect)
        var items = [Item]()
        for candidate in candidates {
            if(candidate.intersectsRect(rect: rect)){
                items.append(candidate)
            }
        }
        return items
    }
    
    public func getItemsIntersectingSegment(end1 : Point, end2 : Point) -> [Item] {
        var rect : Rect = Rect.rectFromXYXY(end1.x, end1.y, end2.x, end2.y)
        var candidates : [Item] = getItemsWhereRectIntersectsRect(rect: rect)
        var items = [Item]()
        for candidate in candidates {
            if(candidate.intersectsSegment(end1, end2)) {
                items.append(candidate)
            }
        }
        return items
    }
    
    
    //////////////////////////
    // forefront management //
    //////////////////////////
    
    public func addForefrontItem(itemT : ItemT) {
        self.forefrontItems.append(itemT)
        itemT.setScene(scene: self)
        
        // add itemT as event responder
        if (itemT.respondsToHoverEvents) {
            self.addHoverResponder(responder : itemT)
        }
        if (itemT.respondsToClickEvents) {
            self.addClickResponder(responder : itemT)
        }
        if (itemT.respondsToKeyEvents) {
            self.addKeyResponder(responder : itemT)
        }
        
        self.redisplay()
    }
    
    public func removeForefrontItem(itemT : ItemT) {
        var i = self.forefrontItems.index(where: itemT)
        if (i > -1) {
            // TODO why is this case not always happening (if I select a curve, then click away)
            self.forefrontItems.removeFirst()
            itemT.setScene(Scene.nullScene)
            // remove itemT as event responder
            if (itemT.respondsToHoverEvents) {
                self.removeHoverResponder(responder : itemT)
            }
            if (itemT.respondsToClickEvents) {
                self.removeClickResponder(responder : itemT)
            }
            if (itemT.respondsToKeyEvents) {
                self.removeKeyResponder(responder : itemT)
            }
            
            self.redisplay()
        }
    }
    
    public func onClickedAway() {
        if (self.activeClickResponder !== ItemT.nullItemT) {
            self.activeClickResponder.onClickedAway()
            self.activeClickResponder = ItemT.nullItemT
        }
    }
    
    // Adds the responder to the front of the list.
    public func addHoverResponder(responder : ItemT) {
        self.hoverResponders.insert(responder, at: 0)
    }
    
    public func removeHoverResponder(responder : ItemT) {
        var i = self.hoverResponders.index(where: responder)
        if (i > -1) {
            self.hoverResponders.removeFirst()
        }
        if (responder === self.activeHoverResponder) {
            self.activeHoverResponder = ItemT.nullItemT
        }
    }
    
    // Adds the responder to the front of the list.
    public func addClickResponder(responder : ItemT) {
        self.clickResponders.insert(responder, at: 0)
    }
    
    public func removeClickResponder(responder : ItemT) {
        var i = self.clickResponders.index(where: responder)
        if (i > -1) {
            self.clickResponders.removeFirst()
        }
        if (responder === self.activeClickResponder) {
            self.activeClickResponder = ItemT.nullItemT
        }
    }
    
    // Adds the responder to the front of the list.
    public func addKeyResponder(responder : ItemT) {
        self.keyResponders.insert(responder, at: 0)
    }
    
    public func removeKeyResponder(responder : ItemT) {
        var i = self.keyResponders.index(where: responder)
        if (i >= -1) {
            self.keyResponders.removeFirst()
        }
    }
    
    // Used when the activeClickResponder should point to a newly created item
    //   (so that it can receive onClickedAway() if the user clicks away)
    public func setActiveClickResponder(newClickResponder : Item) {
        // There likely shouldn't be an activeClickResponder, because this method probably indicates a tool is being used.
        if (self.activeClickResponder) {
            if (self.activeClickResponder !== newClickResponder) {
                self.activeClickResponder.onClickedAway()
            }
        }
        self.activeClickResponder = newClickResponder
    }
    
    /////////////////////////////
    // notify scene of changes //
    /////////////////////////////
    
    private var semaphore : Int = 0 // TODO choose better name
    private var redisplayAfterChanges : Bool = false
    private var reindexAfterChanges : Bool = false
    
    public func beginChanges() {
        self.semaphore += 1
    }
    
    public func endChanges() {
        self.semaphore -= 1
        if (self.semaphore == 0) {
            if (self.redisplayAfterChanges) {
                self.redisplay()
            }
            if (self.reindexAfterChanges) {
                self.reindex()
            }
        }
    }
    
    public func redisplay() {
        if (self.semaphore > 0) {
            self.redisplayAfterChanges = true
        } else {
            self.redisplayAfterChanges = false
            //for sv in sceneViews {
            //    self.redisplaySceneView(sv: sv)
            //}
        }
    }
    
    public func reindex() {
        if (self.semaphore > 0) {
            self.reindexAfterChanges = true
        } else {
            self.reindexAfterChanges = false
            // reindexing code goes here
        }
    }
    
    //////////////////////////
    // SceneView management //
    //////////////////////////
    
    // Redisplay on a SceneView (only called internally)
    private func redisplaySceneView(sv : SceneView) {
        var canvas : SceneView = sv.getCanvas()
        var left : Double = sv.getLeft()
        var top : Double = sv.getTop()
        var zoom : Double = sv.getZoom()
        // drawGrid(canvas,left,top,zoom);
        self.background.drawOnCanvas(canvas: canvas, x: left, y: top, s: zoom)
        // TODO since there is no cache, for now just draw all items
        var ctx : CGContext = UIGraphicsGetCurrentContext()
        ctx.saveGState()
        ctx.scaleBy(x: CGFloat(zoom), y: CGFloat(zoom))
        ctx.translateBy(x: CGFloat(-left), y: CGFloat(-top))
        
        for item in self.sceneItems {
            if(item.scaleInvariant) {
                item.drawOnCanvas(canvas : self.canvas)
            } else {
                item.drawOnCanvas(canvas: self.canvas, matrix: Matrix.identityMatrix())
            }
        }
        ctx.restoreGState()
        // the forefrontItems are given the canvas without the transformation applied
        for item in self.forefrontItems {
            item.drawOnCanvas(canvas: canvas, x: left, y: top, s: zoom)
        }
    }
    
    public func addSceneView(sv : SceneView) {
        self.sceneViews.append(sv)
        self.redisplaySceneView(sv : sv)
    }
    
    public func onViewingRectChangedForSceneView(sv : SceneView) {
        self.redisplaySceneView(sv : sv)
    }
    
    ///////////////////////////////////
    // input events from a SceneView //
    ///////////////////////////////////
    
    // internal, calls acceptsClick() for each clickResponder (in order)
    // As soon as a clickResponder accepts the click, it is returned.
    // If no clickResponder accepts the click, null is returned.
    private func getClickResponder(x : Int, y : Int, zoom : Int) -> ItemT {
        for i in 0...(self.clickResponders.count - 1) {
            if(self.clickResponders[i].acceptsClick(x: x, y: y, zoom: zoom)) {
                return self.clickResponders[i]
            }
        }
        return ItemT.nullItemT
    }
    
    // returns true if the scene wants a mouse grab (meaning a clickResponder accepted the click), false otherwise
    public func onMouseDown(x : Double, y : Double, zoom : Double, event : UIEvent) -> Bool {
        var oldClickResponder : ItemT = self.activeClickResponder
        self.activeClickResponder = getClickResponder(x: x, y: y, zoom: zoom)
        if (oldClickResponder !== ItemT.nullItemT) {
            if (oldClickResponder !== self.activeClickResponder) {
                oldClickResponder.onClickedAway()
            }
        }
        if (self.activeClickResponder !== ItemT.nullItemT) {
            self.activeClickResponder.onDown(x: x, y: y, zoom: zoom, event: event)
            return true
        } else {
            return false
        }
    }
    
    // internal, calls acceptsHover() for each hoverResponder (in order)
    // As soon as a hoverResponder accepts the hover, it is returned.
    // If no hoverResponder accepts the hover, null is returned.
    private func getHoverResponder(x : Double, y : Double, zoom : Double) -> ItemT {
        for i in 0...(self.hoverResponders.count - 1) {
            if(self.hoverResponders[i].acceptsHover(x: x, y: y, zoom: zoom)) {
                return self.hoverResponders[i]
            }
        }
        return ItemT.nullItemT
    }
    
    // returns the cursor to display above the Scene
    public func onMouseHover(x : Double, y : Double, zoom : Double) -> String {
        self.activeHoverResponder = getHoverResponder(x: x, y: y, zoom: zoom)
        if (self.activeHoverResponder !== ItemT.nullItemT) {
            // return activeHoverResponder.getCursor(x, y, zoom)
        } else {
            return "default"
        }
    }
    
    public func onMouseDrag(x : Double, y : Double, zoom : Double) {
        if (self.activeClickResponder !== ItemT.nullItemT) {
            // self.activeClickResponder.onDrag(x, y, zoom);
        }
    }
    
    public func onMouseUp() {
        if (self.activeClickResponder !== ItemT.nullItemT) {
            // activeClickResponder.onUp()
        }
    }
    
    public func getContextMenuData(x : Double, y : Double, zoom : Double) -> [String : Any] {
    
    }
    
    // Notifies each keyResponder (from first to last) until one returns true.
    public func onKeyDown(event: UIEvent) -> Bool{
        return false;
    }

    /////////////////////
    // legacy          //
    /////////////////////
    
    func addItem(item: Item) {
        items.append(item);
    }
    
    func draw(){
        for item in items{
            item.draw();
        }
    }
}

private class NullScene : Scene {
    init() {
        
    }
    
}

