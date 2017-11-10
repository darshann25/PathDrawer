//
//  BoardState.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import Intents

class BoardState {

    var background : Dictionary<Int, Any>;
    
    // both tables organized by devId, then id
    var resources : Dictionary<Int, Resource>;
    var itemstates : Dictionary<Int, ItemState>;
    // organized by devId
    var holds : Dictionary<Int, Any>;

    init() {
        
        self.background = [Int: Any]();
        self.resources = [Int: Resource]();
        self.itemstates = [Int: ItemState]();
        self.holds = [Int: Any]();
    
    }

    func addResource(resource : Resource) {
    
    }

    func addItemState(itemState : ItemState) {
    
    }

    func grabItems(devId : Int, uids : [Int], initialMatrix : Matrix, intent : INIntent) {
    
    }

    // it's ok to call this even if the device doesn't have a hold
    func releaseItems(devId : Int) {
    
    }

    func releaseAllHolds() {
    
    }

    func minify() {
    
    }

    // call this to set the board state
    func unminify(mini : Dictionary<String, Any>) {
    
    }

    // cleans up resources
    // (somehow must hold on to resources for BoardStateManager's history)
    func garbageCollect() {
    // TODO implement
    }

    func getFreeItemStates() {
    
    }

    // returns null if the device doesn't have a hold
    func getItemStatesHeldByDevice(devId : Int) {
    
    }

    // should only be called when there is actually a hold
    func getMatrixForDeviceHold(devId : Int) {
    
    }

    func getIntentForDeviceHold(devId : Int) {
    
    }

}
