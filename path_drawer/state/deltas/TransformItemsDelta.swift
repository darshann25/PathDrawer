//
//  TransformItemsDelta.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation
class TransformItemsDelta : Delta {
    
    var holderDevId : Int
    var fromMatrix : Matrix
    var toMatrix : Matrix
    
    init(actId: Int, devId: Int, holderDevId: Int, fromMatrix: Matrix, toMatrix: Matrix){
        self.holderDevId = holderDevId
        self.fromMatrix = fromMatrix.copy()
        self.toMatrix = toMatrix.copy()
        
        super.init(type: Delta.types.TransformItemsDelta, actId: actId, devId: devId)
    }
    
    func inverse (actId: Int, devId: Int) -> TransformItemsDelta{
        return TransformItemsDelta(actId: actId, devId: devId, holderDevId: holderDevId, fromMatrix: toMatrix, toMatrix: fromMatrix)
    }
    
    func minify () -> Dictionary<String,Any> {
        var obj = [String: Any]()
        obj["version"] = 1
        obj["deltaType"] = Delta.types.TransformItemsDelta
        obj["actId"] = self.actId
        obj["devId"] = self.devId
        obj["holderDevId"] = self.holderDevId
        obj["fromMatrix"] = self.fromMatrix.toArray()
        obj["toMatrix"] = self.toMatrix.toArray()
        
        return obj
    }
    
    static func unminify(mini: Dictionary<String, Any>) -> TransformItemsDelta {
        let fromMatrix = mini["fromMatrix"]
        let toMatrix = mini["toMatrix"]
        return TransformItemsDelta(actId: mini["actId"] as! Int, devId: mini["devId"] as! Int, holderDevId: mini["holderDevId"] as! Int, fromMatrix: fromMatrix as! Matrix, toMatrix: toMatrix as! Matrix)
    }
    
    func applyToScene() {
        var devicesManager = BoardViewController.BoardContext.sharedInstance.devicesManager
        var selectionItemT = devicesManager.getDevice(devId: holderDevId).context["selectionItemT"] as! SelectionItemT
        selectionItemT.setMatrix(matrix: self.toMatrix)
    }
    
    func applyToBoardState (boardState: BoardState){
        boardState.transformItems(devId: self.holderDevId, matrix: self.toMatrix)
    }
    
}
