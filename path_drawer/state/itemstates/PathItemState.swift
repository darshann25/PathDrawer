//
//  PathItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/16/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

// PathItemState inherits from ItemState
class PathItemState : ItemState {
    
    /*
    // private variables to PathItemState
    var resource;
    var beginIndex;
    var endIndex;
    var color;
    var size;
    var opacity;
    
    func PathItemState(id : var, devId : var, matrix : Matrix, resource : var, beginIndex : var, endIndex : var, color : var, size : var, opacity : var) {
        
        super(ItemType.Path, id, devId, matrix);
        self.resource = resource;
        self.beginIndex = beginIndex;
        self.endIndex = endIndex;
        self.color = color;
        self.size = size;
        self.opacity = opacity;
    }
    
    /*
     PathItemState.prototype = Object.create(ItemState.prototype);
     PathItemState.prototype.constructor = PathItemState;
     PathItemState.prototype.minify = function() {
         return {
             version: 1, // TODO: use a constant
             itemType: Item.types.PathItem,
             id: this.id,
             devId: this.devId,
             matrix: this.matrix.toArray(),
             resource: {
             id: this.resource.id,
             devId: this.resource.devId,
         },
         beginIndex: ('beginIndex' in this ? this.beginIndex : 0),
         endIndex: ('endIndex' in this ? this.endIndex : this.resource.data[0].length - 1),
         color: this.color,
         size: this.size,
         opacity: this.opacity,
         };
     };
    */
    
    // protected (invoke ItemState.unminify outside this file)
    internal func unminify(mini : ItemState) {
        var id = mini.id;
        var matrix = Matrix.fromArray(mini.matrix);
        var resourceId = mini.resource.id;
        var resourceDevId = mini.resource.devId;
        var resource = boardStateManager.getResource(resourceId, resourceDevId);
        // var beginIndex = ('beginIndex' in mini ? mini.beginIndex : 0);
        // var endIndex = ('endIndex' in mini ? mini.endIndex : resource.data[0].length - 1);
        var color = mini.color;
        var size = mini.size;
        var opacity = mini.opacity;
        return PathItemState(id, mini.devId, matrix, resource, beginIndex, endIndex, color, size, opacity);

    }
     */
}
