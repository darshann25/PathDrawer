//
//  ButtonHandlers.swift
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
        var penTool = PenTool()
        //sceneView.setPrimaryTool(penTool) NOT YET IMPLEMENTED
    }
    
    func onPenBlackButtonClicked(){
        var penTool = PenTool()
        penTool.setColor(to: UIColor.black.cgColor)
        //sceneView.setPrimaryTool(penTool) NOT YET IMPLEMENTED
    }
    
    func onPenBlueButtonClicked(){
        var penTool = PenTool()
        penTool.setColor(to: UIColor.blue.cgColor)
        //sceneView.setPrimaryTool(penTool) NOT YET IMPLEMENTED
    }
    
    func onPenGreenButtonClicked(){
        var penTool = PenTool()
        penTool.setColor(to: UIColor.green.cgColor)
        //sceneView.setPrimaryTool(penTool) NOT YET IMPLEMENTED
    }
    
    func onPenRedButtonClicked(){
        var penTool = PenTool()
        penTool.setColor(to: UIColor.red.cgColor)
        //sceneView.setPrimaryTool(penTool) NOT YET IMPLEMENTED
    }
    
    func onPenSize1BtnClicked() {
        var penTool = PenTool()
        penTool.setSize(to: 5)
    }
    
    func onPenSize2BtnClicked() {
        var penTool = PenTool()
        penTool.setSize(to: 10)
        
    }
    func onPenSize3BtnClicked() {
        var penTool = PenTool()
        penTool.setSize(to: 15)
    }
    func onPenSize4BtnClicked() {
        var penTool = PenTool()
        penTool.setSize(to: 20)
    }

    
    
}
