//
//  MatrixControl.swift
//  ItemT
//
//  Created by URMISH M BHATT on 11/8/17.
//  Copyright © 2017 URMISH M BHATT. All rights reserved.
//

import Foundation
import UIKit

class HaloItem: ItemT {

   // ItemT.call(self)
    
    var peerId: Any;
    var x: Float
    var y: Float
    var radius:Float
    var alpha:Any
    var activeTimeInterval:Any
    var timer: Any
    
    
    init(peerId : Double){
    
        // ItemT.call(self)
        self.peerId = peerId;
        self.x = -1
        self.y = -1
        self.radius=10
        self.alpha = 0.5; // constant
        self.activeTimeInterval = 1000; // milliseconds
        self.timer = NSNull(); // the halo is visible if this is not null

        
    
    }



    func updateLocation(x:Float, y:Float){
        
        self.x=x
        self.y=y
        
        /*   if(self.timer != NSNull()){
         clearTimeout(self.timer);
         
         }*/
        
        var _self = self;
        
        
        /*self.timer = setTimeout(func() {
            self.timer = NSNull();
            if (_self.scene) {
                _self.scene.redisplay();
            }
        }, self.activeTimeInterval);
        // redisplay scene
        if (self.scene) {
            self.scene.redisplay();
        }*/
    }
    
    func hide(){
        
        if(self.timer != nil){
        
      //      clearTimeout(self.timer)
            self.timer = NSNull()
            
            if((self.scene) != nil){
      //          self.scene.redisplay();
            }
        }
    
    
    }
    
    func drawOnCanvas(canvas: CGContext, left:Float, top: Float, zoom : Float){
        
        if(self.timer == nil){
            return
        }
        
        var x = (self.x - left) * zoom;
        var y = (self.y - top) * zoom;
        
        if (x + self.radius < 0 ||
            x - self.radius > Float(canvas.width) ||
            y + self.radius < 0 ||
            y - self.radius > Float(canvas.height)) {
            return;
        }
        
/*      var ctx = canvas.getContext('2d');
        
        var ctx = UIGraphicsGetCurrentContext()
        ctx?.saveGState();
       // ctx.globalAlpha = this.alpha;
        ctx.fillStyle = peersManager.getColorForPeerId(this.peerId);
        ctx.beginPath();
        ctx.arc(x, y, this.radius, 0, 2 * Math.PI);
        ctx.closePath();
        ctx.fill();
        ctx.restore();


        */
    
    
    }




}
