//
//  ImageItemState.swift
//  path_drawer
//
//  Created by Darshan Patel on 10/10/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class ImageItemState : ItemState {
    
    var resource : Resource;
    
    init (id : Int, devId : Int, matrix : Matrix, resource : Resource) {
        self.resource = resource;
        super.init(type : Item.ItemType.Image, id: id, devId: devId, matrix: matrix);
    }
    
    // TODO : Understand what minify  does and port it from website
    //ImageItemState.prototype = Object.create(ItemState.prototype);
    //ImageItemState.prototype.constructor = ImageItemState;
    /*
    ImageItemState.prototype.minify = function() {
        return {
            version: 1, // TODO: use a constant
            itemType: Item.types.ImageItem,
            id: this.id,
            devId: this.devId,
            matrix: this.matrix.toArray(),
            resource: {
            id: this.resource.id,
            devId: this.resource.devId,
        },
    };
    
    // protected (invoke ItemState.unminify outside this file)
    internal func unminify(mini : ItemState) {
        var id = mini.id;
        var matrix = Matrix.fromArray(mini.matrix);
        var resourceId = mini.resource.id;
        var resourceDevId = mini.resource.devId;
        var resource = boardStateManager.getResource(resourceId, resourceDevId);
        return ImageItemState(id, mini.devId, matrix, resource);
    }
    */
}

