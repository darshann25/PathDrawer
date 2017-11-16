//
//  ButtonHandler.swift
//  path_drawer
//
//  Created by Henry Stahl on 10/25/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
import UIKit


func onHighlighterButtonClicked(sv : SceneView){
    let highlighterTool = Scene.sharedInstance.toolManager.getHighlighterTool()
    sv.setPrimaryTool(tool: highlighterTool)
}

func onPenBtnClicked(sv : SceneView){
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    sv.setPrimaryTool(tool : penTool)
}

func onPenBlackButtonClicked(sv : SceneView){
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setColor(to: UIColor.black.cgColor)
    sv.setPrimaryTool(tool : penTool)
}

func onPenBlueButtonClicked(sv : SceneView){
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setColor(to: UIColor.blue.cgColor)
    sv.setPrimaryTool(tool : penTool)
}

func onPenGreenButtonClicked(sv : SceneView){
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setColor(to: UIColor.green.cgColor)
    sv.setPrimaryTool(tool : penTool)
}

func onPenRedButtonClicked(sv : SceneView){
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setColor(to: UIColor.red.cgColor)
    sv.setPrimaryTool(tool : penTool)
}

func onPenSize1BtnClicked(sv : SceneView) {
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setSize(to: 5)
    sv.setPrimaryTool(tool : penTool)
}

func onPenSize2BtnClicked(sv : SceneView) {
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setSize(to: 10)
    sv.setPrimaryTool(tool : penTool)
}

func onPenSize3BtnClicked(sv : SceneView) {
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setSize(to: 15)
    sv.setPrimaryTool(tool : penTool)
}

func onPenSize4BtnClicked(sv : SceneView) {
    let penTool = Scene.sharedInstance.toolManager.getPenTool()
    penTool.setSize(to: 20)
    sv.setPrimaryTool(tool : penTool)
}

