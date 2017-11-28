//
//  ViewRectItemT.swift
//  path_drawer
//
//  Created by Henry Stahl on 11/7/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class ViewRectItemT : ItemT {
    
    
    var peerId: Double
    var rectArray = [Double]()
    
    init(peerId : Double){
        
        self.peerId = peerId
        self.rectArray = [Double]()
    }
    
    //ViewRectItemT.prototype = Object.create(ItemT.prototype);
    
    func updateRect(rectArray: Array<Any?>){
    
   /*     this.rectArray =  rectArray
        
        if(self.scene){
            
            self.scene.redisplay()
        
        }*/
    }
    
    func drawOnCanvas (canvas: SceneView, left: Double, top:Double, zoom: Double){
        
    /*    if (!self.rectArray){
            return
        }
        */
        
        let _left = (self.rectArray[0] - left) * zoom;
        let _top = (self.rectArray[1] - top) * zoom;
        let _width = self.rectArray[2] * zoom;
        let _height = self.rectArray[3] * zoom;

        if (_left + _width < 0 ||
            _left > sceneView.getWidth() ||
            _top + _height < 0 ||
            _top > sceneView.getHeight()) {
            return;
        }
        
  //      var ctx = canvas.getContext("2d");
  /*
        if let ctx = UIGraphicsGetCurrentContext(){
            ctx.save();
            ctx.strokeStyle = peersManager.getColorForPeerId(this.peerId);
            ctx.beginPath();
            ctx.rect(_left, _top, _width, _height);
            ctx.stroke();
            ctx.restore();
        
        }
 */

    
    
    
    }
    
    func updateRect(rectArray : [Double]) {
        
    }
    
    
}
