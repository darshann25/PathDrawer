//
//  ViewController.swift
//  path_drawer
//
//  Created by DARSHAN DILIP PATEL on 9/28/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    var penTool = PenTool()
    
    @IBAction func Test(_ sender: UIButton) {
        penTool.setSize(to: 30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class BoardContext {
        /*
        public final Messenger messenger;
        public final DevicesManager devicesManager;
        public final BoardStateManager boardStateManager;
        public final PeersManager peersManager;
        public final ItemStateFactory itemStateFactory;
        public final DeltaFactory deltaFactory;
        public final String boardId;
        public final DelManager delManager;
        public final Scene scene;
        
        func BoardContext (boardId_ : String, scene_ : Scene) {
            messenger = Messenger(self);
            devicesManager = DevicesManager(self);
            boardStateManager = BoardStateManager(self);
            peersManager = PeersManager();
            itemStateFactory = ItemStateFactory(self);
            deltaFactory = DeltaFactory(self);
            delManager = DelManager(self);
            boardId = boardId_;
            scene = scene_;
        }
         */
    }


}

