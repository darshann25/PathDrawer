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
    
    var items = [Item]();
    
    // This is responsible for decorating the background of the Scene. It is drawn first.
    var background : Background // initialize with empty background
    // These are the items that really belong to the Scene
    var sceneItems : [Item]
    var sceneItemsById : [Int : [Int : Item]]
    // These items are likely to change quickly, and are drawn last
    var forefrontItems : [Item]
    // These are not drawn, but respond to mouse hover events
    var hoverResponders : [Item]
    // These are not drawn, but respond to mouse click events
    var clickResponders : [Item]
    // These are not drawn, but respond to keyboard events
    var keyResponders : [Item]
    var toolManager : ToolManager
    
    // The responders to the most recent event.
    //var activeHoverResponder : Item
    //var activeClickResponder : Item
    
    // This is a list of all SceneViews that are watching the Scene.
    var sceneViews : [SceneView]
    
    private init() {
        self.background = Background()
        self.sceneItems = [Item]()
        self.sceneItemsById = [Int : [Int : Item]]()
        self.forefrontItems = [Item]()
        self.hoverResponders = [Item]()
        self.clickResponders = [Item]()
        self.keyResponders = [Item]()
        
        //self.activeHoverResponder = Item();
        //self.activeClickResponder = Item();
        
        self.toolManager = ToolManager()
        
        // This is a list of all SceneViews that are watching the Scene.
        self.sceneViews = [SceneView]()
        
        print("In Scene");
    }
    
    // resets the state of the scene
    func reset() {
        self.sceneItems = [Item]()
        self.sceneItemsById = [Int : [Int : Item]]()
    }
    
    func setBackground(_background : Background) {
        self.background = _background
        self.redisplay()
    }
    
    /////////////////////
    // item management //
    /////////////////////
    
    // With start/endChanges(), it is no longer important to add items in batch.
    func addSceneItem(item : Item) {
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
    func removeSceneItem(item : Item) {
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
    
    func getItemById(id : Int, devId : Int) -> Item {
        var innerDict = self.sceneItemsById[devId]
        return innerDict[id]
    }
    
    ///////////////////////////
    // geometric item lookup //
    ///////////////////////////
    
    // TODO take a regionRect as a parameter
    func getSelectableItems() -> [Item] {
        return self.sceneItems
    }
    
    // internal (used by functions below)
    func getItemsWhereRectIntersectsRect(rect : CGRect) -> [Item] {
        var items = [Item]()
        for item in sceneItems {
            if(rect.intersects(item.getBoundingRect())) {
                items.append(item)
            }
        }
        return items
    }
    
    func getItemsIntersectingRect(rect : CGRect) -> [Item] {
        var candidates = getItemsWhereRectIntersectsRect(rect: rect)
        var items = [Item]()
        for candidate in candidates {
            if(candidate.intersectsRect(rect: rect)){
                items.append(candidate)
            }
        }
        return items
    }
    
    func getItemsIntersectingSegment(end1 : Point, end2 : Point) -> [Item] {
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
    
    func addForefrontItem(itemT : ItemT) {
    
    }
    
    func removeForefrontItem(itemT : ItemT) {
    
    }
    
    func onClickedAway() {
    
    }
    
    // Adds the responder to the front of the list.
    func addHoverResponder(responder : ItemT) {
    
    }
    
    func removeHoverResponder(responder : ItemT) {
    
    }
    
    // Adds the responder to the front of the list.
    func addClickResponder(responder : ItemT) {
    
    }
    
    func removeClickResponder(responder : ItemT) {
    
    }
    
    // Adds the responder to the front of the list.
    func addKeyResponder(responder : ItemT) {
    
    }
    
    func removeKeyResponder(responder : ItemT) {
    
    }
    
    // Used when the activeClickResponder should point to a newly created item
    //   (so that it can receive onClickedAway() if the user clicks away)
    func setActiveClickResponder(newClickResponder : Item) {
    
    }
    
    /////////////////////////////
    // notify scene of changes //
    /////////////////////////////
    
    var semaphore = 0; // TODO choose better name
    var redisplayAfterChanges = false;
    var reindexAfterChanges = false;
    
    func beginChanges() {
    semaphore += 1;
    }
    
    func endChanges() {
        semaphore -= 1;
        if (semaphore == 0) {
            if (redisplayAfterChanges) {
                redisplay();
            }
            if (reindexAfterChanges) {
                reindex();
            }
        }
    }
    
    func redisplay() {
        if (semaphore > 0) {
            redisplayAfterChanges = true;
        } else {
            redisplayAfterChanges = false;
            // sceneViews.forEach(function(sv) {
            // redisplaySceneView(sv);
            // });
        }
    }
    
    func reindex() {
        if (semaphore > 0) {
            reindexAfterChanges = true;
        } else {
            reindexAfterChanges = false;
            // reindexing code goes here
        }
    }
    
    //////////////////////////
    // SceneView management //
    //////////////////////////
    
    // Redisplay on a SceneView (only called internally)
    func redisplaySceneView(sv : SceneView) {
    
    }
    
    func addSceneView(sv : SceneView) {
    
    }
    
    func onViewingRectChangedForSceneView(sv : SceneView) {
    
    }
    
    ///////////////////////////////////
    // input events from a SceneView //
    ///////////////////////////////////
    
    // internal, calls acceptsClick() for each clickResponder (in order)
    // As soon as a clickResponder accepts the click, it is returned.
    // If no clickResponder accepts the click, null is returned.
    func getClickResponder(x : Int, y : Int, zoom : Int) -> Item {
        return Item();
    }
    
    // returns true if the scene wants a mouse grab (meaning a clickResponder accepted the click), false otherwise
    func onMouseDown(x : Int, y : Int, zoom : Int, event : UIEvent) -> Bool {
        return false
    }
    
    // internal, calls acceptsHover() for each hoverResponder (in order)
    // As soon as a hoverResponder accepts the hover, it is returned.
    // If no hoverResponder accepts the hover, null is returned.
    func getHoverResponder(x : Int, y : Int, zoom : Int) -> Item {
        return Item();
    }
    
    // returns the cursor to display above the Scene
    func onMouseHover(x : Double, y : Double, zoom : Double) {
    
    }
    
    func onMouseDrag(x : Double, y : Double, zoom : Double) {
    
    }
    
    func onMouseUp() {
    
    }
    
    func getContextMenuData(x : Double, y : Double, zoom : Double) -> [String : Any] {
    
    }
    
    // Notifies each keyResponder (from first to last) until one returns true.
    func onKeyDown(event: UIEvent) -> Bool{
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

