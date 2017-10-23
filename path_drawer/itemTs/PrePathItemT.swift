//
//  PrePathItemT.swift
//  path_drawer
//
//  Created by xujiachen on 2017/10/10.
//  Copyright © 2017 scratchwork. All rights reserved.
//
/*
 
 
 import UIKit
 import Foundation
 
 var myItem = ItemT();
 var myPoint = Point();
 var myRect = Rect();
 
 /*
 PrePathItemT represents a path currently being drawn (by a pen or highlighter). Once the tool is lifted, then the PrePathItemT is removed and replaced with a PathItem.
 
 */
 
 // class PrePathItemT inherits ItemT
 class PrePathItemT {  //export default function PrePathItemT()
 
 public var x = 0;
 public var y = 0;
 
 
 ItemT.call(self);
 
 self.points = [];
 self.color = "red";
 self.size = 1;
 self.opacity = 1;
 
 }
 
 //let PrePathItemT=Object.create.prototype(ItemT)
 PrePathItemT.prototype = Object.create(ItemT.prototype);
 PrePathItemT.prototype.constructor = PrePathItemT;
 
 func getXList() {  //PrePathItemT.prototype.getXList = function() {
 var xList = [];
 for i in 0..<self.point.length {  //for (var i = 0; i < this.points.length; i++) {
 xList.push(self.points[i].x);
 }
 return xList;
 };
 
 func getYList() { //PrePathItemT.prototype.getYList = function() {
 var yList = [];
 for i in 0..<self.point.length { //for (var i = 0; i < this.points.length; i++) {
 yList.push(self.points[i].y);
 }
 return yList;
 };
 
 func addPoint(x:var,y:var) { //PrePathItemT.prototype.addPoint = function(x, y) {
 self.points.push(new, Point(x, y));
 if self.scene {
 self.scene.redisplay();
 }
 };
 
 func drawOnCanvas(canvas:var, left:var, top:var, zoom:var){ //PrePathItemT.prototype.drawOnCanvas = function(canvas, left, top, zoom) {
 if self.points.length < 2 {
 return;
 }
 // at this point, there are enough points to draw
 var ctx = canvas.getContext("2d");
 // make sure to save the context before setting the globalAlplha property
 ctx.save();
 
 // apply the transformation
 ctx.scale(zoom, zoom);
 ctx.translate(-left, -top);
 
 // draw the path
 ctx.beginPath();
 ctx.strokeStyle = self.color;
 ctx.lineWidth = self.size;
 ctx.globalAlpha = self.opacity;
 ctx.lineCap = "round";
 ctx.moveTo(self.points[0].x, self.points[0].y);
 
 for i in 0..<self.point.length {   //for (var i = 1; i < this.points.length; i++) {
 ctx.lineTo(self.points[i].x, self.points[i].y);
 }
 ctx.stroke();
 ctx.restore();
 };
 
 func setPonits(points:Point)->Bool { //PrePathItemT.prototype.setPoints = function(points) {
 self.points = points;
 if self.scene {
 self.scene.redisplay();
 }
 };
 
 func setColor(color:var)->UIColor{ //PrePathItemT.prototype.setColor = function(color) {
 color = UIColor.red;
 }
 ;
 
 func setSize(size:var) { //PrePathItemT.prototype.setSize = function(size) {
 self.size = size;
 if self.scene {
 self.scene.redisplay();
 }
 };
 
 func setOpacity(opacity:var){ // PrePathItemT.prototype.setOpacity = function(opacity) {
 self.opacity = opacity;
 if self.scene {
 self.scene.redisplay();
 }
 };
 
 func computeBoundingRect(){ //PrePathItemT.prototype.computeBoundingRect = function() {
 if self.points.length === 0 {
 // return null (shouldn't happen)
 return null;
 }
 else {
 var left = self.points[0].x;
 var right = left;
 var top = self.points[0].y;
 var bottom = self.points[0].y;
 for i in 0..<self.point.length { //for (var i = 1; i < this.points.length; i++) {
 let left = Math.min(left, self.points[i].x);
 let right = Math.max(right, self.points[i].x);
 let top = Math.min(top, self.points[i].y);
 let bottom = Math.max(bottom, self.points[i].y);
 }
 return new; Rect(left, top, right - left, bottom - top);
 }
 };
 */

