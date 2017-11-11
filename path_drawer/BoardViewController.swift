//
//  ViewController.swift
//  path_drawer
//
//  Created by DARSHAN DILIP PATEL on 9/28/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    class BoardContext {
        
        var socketIOManager : SocketIOManager;
        var messenger : Messenger;
        var devicesManager : DevicesManager;
        var boardStateManager : BoardStateManager;
        var peersManager : PeersManager;
        // var itemStateFactory : ItemStateFactory;
        // var deltaFactory : DeltaFactory;
        var boardId : Int;
        // var delManager : DelManager;
        var scene : Scene;
        
        init(boardId : Int, scene : Scene) {
            
            self.socketIOManager = SocketIOManager();
            socketIOManager.connect();
            
            self.messenger = Messenger(socketIOManager : socketIOManager);
            self.devicesManager = DevicesManager();
            self.boardStateManager = BoardStateManager(msngr : messenger);
            self.peersManager = PeersManager(peer: Peer(peerId : 1), peersWidgetController : PeersWidgetController());
            // self.itemStateFactory = ItemStateFactory();
            // self.deltaFactory = DeltaFactory();
            // self.delManager = DelManager();
            self.boardId = boardId;
            self.scene = scene;
        }
     
    }

}

////////////////////////////////////
// GLOBAL INSTANCES  - SINGLETONS //
////////////////////////////////////
var sceneView = SceneView();
var boardContext = BoardViewController.BoardContext(boardId : 1, scene : sceneView.scene);
