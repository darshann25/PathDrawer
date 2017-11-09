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
    var items = [Item]();
    
    // This is responsible for decorating the background of the Scene. It is drawn first.
    var background : Background; // initialize with empty background
    // These are the items that really belong to the Scene
    var sceneItems : [Item];
    var sceneItemsById : [Item];
    // These items are likely to change quickly, and are drawn last
    var forefrontItems : [Item];
    // These are not drawn, but respond to mouse hover events
    var hoverResponders : [Item];
    // These are not drawn, but respond to mouse click events
    var clickResponders : [Item];
    // These are not drawn, but respond to keyboard events
    var keyResponders : [Item];
    
    // The responders to the most recent event.
    var activeHoverResponder : Item;
    var activeClickResponder : Item;
    
    // This is a list of all SceneViews that are watching the Scene.
    var sceneViews : [SceneView];
    
    init() {
        self.background = Background();
        self.sceneItems = [Item]();
        self.sceneItemsById = [Item]();
        self.forefrontItems = [Item]();
        self.hoverResponders = [Item]();
        self.clickResponders = [Item]();
        self.keyResponders = [Item]();
        
        self.activeHoverResponder = Item();
        self.activeClickResponder = Item();
        
        // This is a list of all SceneViews that are watching the Scene.
        self.sceneViews = [SceneView]();
    }
    
    // resets the state of the scene
    func reset() {
        
    }
    
    func setBackground(_background : Background) {
        
    }
    
    /////////////////////
    // item management //
    /////////////////////
    
    // With start/endChanges(), it is no longer important to add items in batch.
    func addSceneItem(item : Item) {
        
    }
    
    // With start/endChanges(), it is no longer important to remove items in batch.
    func removeSceneItem(item : Item) {
        
    }
    
    func getItemById(id : Int, devId : Int) -> Item {
        return Item(state: ItemState(type: Item.ItemType.Unknown));
    }
    
    ///////////////////////////
    // geometric item lookup //
    ///////////////////////////
    
    // TODO take a regionRect as a parameter
    func getSelectableItems() -> [Item] {
        return sceneItems;
    }
    
    // internal (used by functions below)
    func getItemsWhereRectIntersectsRect(rect : CGRect) -> [Item] {
        return [Item()];
    }
    
    func getItemsIntersectingRect(rect : CGRect) -> [Item] {
        return [Item()];
    }
    
    func getItemsIntersectingSegment(end1 : Point, end2 : Point) -> [Item] {
        return [Item()];
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
    func addHoverResponder(responder : Item) {
    
    }
    
    func removeHoverResponder(responder : Item) {
    
    }
    
    // Adds the responder to the front of the list.
    func addClickResponder(responder : Item) {
    
    }
    
    func removeClickResponder(responder : Item) {
    
    }
    
    // Adds the responder to the front of the list.
    func addKeyResponder(responder : Item) {
    
    }
    
    func removeKeyResponder(responder : Item) {
    
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
    func onMouseDown(x : Int, y : Int, zoom : Int, event : UIEvent) {
    
    }
    
    // internal, calls acceptsHover() for each hoverResponder (in order)
    // As soon as a hoverResponder accepts the hover, it is returned.
    // If no hoverResponder accepts the hover, null is returned.
    func getHoverResponder(x : Int, y : Int, zoom : Int) -> Item {
        return Item();
    }
    
    // returns the cursor to display above the Scene
    func onMouseHover(x : Int, y : Int, zoom : Int) {
    
    }
    
    func onMouseDrag(x : Int, y : Int, zoom : Int) {
    
    }
    
    func onMouseUp() {
    
    }
    
    func getContextMenuData(x : Int, y : Int, zoom : Int) {
    
    }
    
    // Notifies each keyResponder (from first to last) until one returns true.
    func onKeyDown(event: UIEvent) -> Bool{
        return false;
    }

    /////////////////////
    // legacy           //
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
