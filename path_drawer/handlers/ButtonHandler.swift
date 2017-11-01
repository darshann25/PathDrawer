//
//  ButtonHandler.swift
//  path_drawer
//
//  Created by Henry Stahl on 10/25/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

//Right now, the buttons call the pentool straight from the class, this needs to be changed to get them
//from the current instance

import Foundation
import UIKit

class ButtonHandler {
    var toolManager = ToolManager()
    var sceneView = SceneView()
    
    
    func onPenBtnClicked(){
        let penTool = toolManager.getPenTool()
        sceneView.setPrimaryTool(to: penTool)
    }
    
    func onPenBlackButtonClicked(){
        let penTool = toolManager.getPenTool()
        penTool.setColor(to: UIColor.black.cgColor)
        sceneView.setPrimaryTool(to: penTool)
    }
    
    func onPenBlueButtonClicked(){
        let penTool = toolManager.getPenTool()
        penTool.setColor(to: UIColor.blue.cgColor)
        sceneView.setPrimaryTool(to: penTool)
    }
    
    func onPenGreenButtonClicked(){
        let penTool = toolManager.getPenTool()
        penTool.setColor(to: UIColor.green.cgColor)
        sceneView.setPrimaryTool(to: penTool)
    }
    
    func onPenRedButtonClicked(){
        let penTool = toolManager.getPenTool()
        penTool.setColor(to: UIColor.red.cgColor)
        sceneView.setPrimaryTool(to: penTool)
    }
    
    func onPenSize1BtnClicked() {
        let penTool = toolManager.getPenTool()
        penTool.setSize(to: 5)
    }
    
    func onPenSize2BtnClicked() {
        let penTool = toolManager.getPenTool()
        penTool.setSize(to: 10)
        
    }
    func onPenSize3BtnClicked() {
        let penTool = toolManager.getPenTool()
        penTool.setSize(to: 15)
    }
    func onPenSize4BtnClicked() {
        let penTool = toolManager.getPenTool()
        penTool.setSize(to: 20)
    }
}
