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
     
        // SINGLETON
        static var sharedInstance = BoardContext(boardId : "BkJAF1dyz", scene : Scene.sharedInstance);
        
        var socketIOManager : SocketIOManager;
        var messenger : Messenger;
        var devicesManager : DevicesManager;
        var boardStateManager : BoardStateManager;
        var peersManager : PeersManager;
        // var itemStateFactory : ItemStateFactory;
        // var deltaFactory : DeltaFactory;
        var boardId : String;
        // var delManager : DelManager;
        var scene : Scene;
        
        private init(boardId : String, scene : Scene) {
            
            self.boardId = boardId;
            self.scene = scene;
            
            self.socketIOManager = SocketIOManager(boardId : self.boardId);
            // socketIOManager.establistConnection();
            // print("Device is connected!");
            
            self.messenger = Messenger(socketIOManager : socketIOManager);
            self.devicesManager = DevicesManager(messenger : self.messenger);
            self.boardStateManager = BoardStateManager(msngr : messenger);
            self.peersManager = PeersManager(peer: Peer(peerId : 1), peersWidgetController : PeersWidgetController());
            // self.itemStateFactory = ItemStateFactory();
            // self.deltaFactory = DeltaFactory();
            // self.delManager = DelManager();
            
        }
     
    }

}

////////////////////////////////////
// GLOBAL INSTANCES  - SINGLETONS //
////////////////////////////////////
// var sceneView = SceneView();
// var boardContext = BoardViewController.BoardContext(boardId : "", scene : sceneView.scene);
