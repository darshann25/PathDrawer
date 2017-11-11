//
//  ImageItem.swift
//  path_drawer
//
//  Created by Sai Reddy on 10/17/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation


import UIKit
/*
 class ImageItem : Item {
 var imageHasLoaded = false
 var placeHolderWidth = 0
 var placeHolderHeight = 0
 var imageCanvas
 init (state: ImageItemState) {
 
 var imageCanvas = NSNull()
 self.imageHasLoaded = false
 var resource = state.resource
 
 self.placeHolderWidth = state.resource.data[0]
 self.placeHolderHeight = state.resource.data[1]
 
 if (self.resource.imageCanvas != NSNull){
 self.imageCanvas = self.resource.imageCanvas
 self.imageHasLoaded = true
 }
 else{
 var thisImageItem = self
 let image = UIImage()
 func imageDidLoad(){
 let canvas = UIImageView(image: image)
 canvas.frame = CGRect(x: 0, y: 0, width: image.width, height: image.height)
 view.addSubview(canvas)
 let ctx = UIGraphicsGetCurrentContext()
 thisImageItem.imageCanvas = canvas
 thisImageItem.resource.imageCanvas = canvas
 thisImageItem.imageHasLoaded = true
 SceneView.refreshView()
 }
 }
 }
 
 
 func getPDFgenData(matrix :Matrix)
 {
 var flip =  Matrix(1,0,-1,0,self.imageCanvas.height)
 var data(t: img, m: matrix.times(flip).toArray(), devID: resource.id, resId: self.resource.id)
 
 return data
 
 }
 
 func getBoundingRect()
 {
 if(self.boundingRect==NSNull())
 {
 var w = self.placeholderWidth
 var h = self.placeholderHeight
 if(self.imageHasLoaded)
 {
 w = self.imageCanvas.width
 h = self.imageCanvas.height
 
 }
 var p :CGPoint
 var matrix = self.matrix
 var p0 = matrix.timesPoint(zero)
 p = (w,0)
 var p1 = matrix.timesPoint(p)
 p = (w,h)
 var p2 = matrix.timesPoint(p)
 p = (0,h)
 var p3 = matrix.timesPoint(p)
 var left = min(p0.x, p1.x, p2.x, p3.x)
 var right = max(p0.x, p1.x, p2.x, p3.x)
 var top = min(p0.y, p1.y, p2.y, p3.y)
 var bottom = max(p0.y, p1.y, p2.y, p3.y)
 self.boundingRect = CGRect(left, top, right - left, bottom - top)
 }
 return self.boundingRect
 }
 
 func intersectsSegment(End1 : CGPoint , End2: CGPoint)
 {
 var end1 = self.inverseMatrix.timesPoint(End1)
 var end2 = self.inverseMatrix.timesPoint(End2)
 
 if(self.imageHasLoaded==false)
 {
 var rect = CGRect(0,0,self.placeholderWidth, self.placeholderHeight)
 return rect.containsPointXY(end2.X,end2.Y)
 
 }
 
 var imageCanvas = self.imageCanvas
 var rect = Rect.rectFromXYXY(end1.x,end.y,end2.x,end2.y)
 var left = max(round(rect.left), 0)
 var right = min(round(rect.right), imageCanvas.width)
 var top = max(round(rect.top), 0)
 var bottom = min(Math.round(rect.bottom), imageCanvas.height)
 
 right = max(right, left + 1);
 bottom = max(bottom, top + 1);
 
 /////var ctx = imageCanvas.getContext('2d');   to-doo
 var pixels = ctx.getImageData(0, 0, imageCanvas.width, imageCanvas.height).data;
 var width = imageCanvas.width;
 
 for i in left...right
 {
 for j in top...bottom
 {
 if(pixels[4 * (i+width*j)+3]!=0)
 {
 return true
 }
 }
 }
 return false
 }
 
 
 } */


