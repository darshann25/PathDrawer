//
//  BoardStateManager.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class BoardStateManager {
    
    // used to provide unique ids for this device
    var nextResourceId : Int;
    var nextItemId : Int;
    var nextActId : Int;

    // this represents the absolute up-to-date state of the board
    var boardState : BoardState;
    // this handles saving the board state with the server
    var saveManager : SaveManager;
    // this makes sure we don't clobber the server's board state with a peer's
    var loaded : Bool;
    
    // this holds the messenger passed from the BoardViewController
    var messenger : Messenger;

    init(msngr : Messenger) {
        self.nextResourceId = 1;
        self.nextItemId = 1;
        self.nextActId = 1;
        self.boardState = BoardState();
        self.saveManager = SaveManager(boardState : boardState);
        self.loaded = false;
        self.messenger = msngr;
    }
    
    ///////////////////////////////////
    // initialization of board state //
    ///////////////////////////////////

    // either another device relays the board state through a message with id "entire_board_state" or (if there are no other current devices) the server will deliver a message
    
    
    
    
    
    // self.messenger.onmessage('entire_board_state', function(message, from) {
    // }
    
    func onBoardStateFromServer(rawdata : String) {
    
    }

    //////////
    // misc //
    //////////

    func addResource(resource : Resource) {
    
    }

    func addDelta(delta : Delta) {
    
    }

    // thought: should I make a rule that once a device leaves, no more deltas can happen?
    func onDeviceLeft(devId : Int) {
    
    }

    // force scene to be the same as the state
    // (currently this means recreating all scene items, but leaving forefront items in place)
    func updateScene() {
    
    }

    func _applyDelta(delta : Delta) {
    
    }
    
}
