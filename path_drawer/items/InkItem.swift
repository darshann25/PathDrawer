

import Foundation
import UIKit

/*
 
 class InkItem : Item
 {
 
 init(state: InkItemState)
 {
 self.imageCanvas = NSNull
 self.imageHasLoaded = false
 self.resource = state.resource
 self.placeholderWidth = this.resource.data[0]
 self.placeholderHeight = this.resource.data[1]
 
 if (self.resource.imageCanvas != NSNull)
 {
 self.imageCanvas = self.resource.imageCanvas
 self.imageHasLoaded = true
 }
 else
 {
 var thisInkItem= self
 var image = new Image()
 func imageDidLoad()
 {
 let canvas = UIImageView(image: image)
 canvas.frame = CGRect(x: 0, y: 0, width: image.width, height: image.height)
 view.addSubview(canvas)
 let ctx = UIGraphicsGetCurrentContext()
 thisImageItem.imageCanvas = canvas
 thisImageItem.resource.imageCanvas = canvas
 thisImageItem.imageHasLoaded = true
 SceneView.refreshView()()
 }
 }
 }
 //InkItem.prototype = Object.create(Item.prototype);  //Unedited
 //InkItem.prototype.constructor = InkItem;             //Unedited
 
 func shallowCopyItemState(ID: Id, Dev: devId)
 {
 return PathItemState(ID: Id, matrix: self.matrix.copy, resc: self.resource, begin: self.beginIndex, end: self.endIndex, color: self.color, size: self.size, alpha: self.opacity )
 }
 
 func drawOnCanvas(){}
 
 func getPdfgenData(matrix : Matrix)
 {
 var data = [0]
 var canvas = self.resource.imageCanvas
 var width = canvas.width
 var height = canvas.height
 var ctx = canvas.getContext('2d');
 var _data = ctx.getImageData(0, 0, width, height).data;
 var state = 0;
 var last = 0;
 for i in 0...(width * height)
 {
 if(_data[i * 4 + 3]!= state)
 {
 state = _data[i * 4 + 3];
 data.append(i - last);
 last = i;
 }
 }
 if(state != 0)
 {
 data.append(width*height)
 }
 return //
 }
 func addSvgData(svg :Matrix, svgMatrix : Matrix){}
 func getBoundingRect(){}
 func intersectsSegment(end1 : CGPoint, end2 : CGPoint) {}
 func intersectRect(/*_rect*//*Unedited*/) {}
 }*/






