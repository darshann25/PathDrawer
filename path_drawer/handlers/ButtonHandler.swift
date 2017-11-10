//
//  ButtonHandler.swift
//  path_drawer
//
//  Created by Henry Stahl on 10/25/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit

let sceneView = SceneView();

    func onHighlighterButtonClicked(){
        let highlighterTool = sceneView.toolManager.getHighlighterTool()
        sceneView.setPrimaryTool(tool: highlighterTool)
    }

    func onPenBtnClicked(){
        let penTool = sceneView.toolManager.getPenTool()
        sceneView.setPrimaryTool(tool : penTool)
    }
    
    func onPenBlackButtonClicked(){
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setColor(to: UIColor.black.cgColor)
        sceneView.setPrimaryTool(tool : penTool)
    }
    
    func onPenBlueButtonClicked(){
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setColor(to: UIColor.blue.cgColor)
        sceneView.setPrimaryTool(tool : penTool)
    }
    
    func onPenGreenButtonClicked(){
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setColor(to: UIColor.green.cgColor)
        sceneView.setPrimaryTool(tool : penTool)
    }
    
    func onPenRedButtonClicked(){
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setColor(to: UIColor.red.cgColor)
        sceneView.setPrimaryTool(tool : penTool)
    }
    
    func onPenSize1BtnClicked() {
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setSize(to: 5)
        sceneView.setPrimaryTool(tool : penTool)
    }
    
    func onPenSize2BtnClicked() {
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setSize(to: 10)
        sceneView.setPrimaryTool(tool : penTool)
    }

    func onPenSize3BtnClicked() {
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setSize(to: 15)
        sceneView.setPrimaryTool(tool : penTool)
    }

    func onPenSize4BtnClicked() {
        let penTool = sceneView.toolManager.getPenTool()
        penTool.setSize(to: 20)
        sceneView.setPrimaryTool(tool : penTool)
    }
