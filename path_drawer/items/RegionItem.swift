//
//  RegionItem.swift
//  path_drawer
//
//  Created by Darshan Patel on 11/25/17.
//  Copyright © 2017 scratchwork. All rights reserved.
//

import Foundation

class RegionItem : Item {
    override init(state : ItemState) {
        super.init(state: ItemState(type: Item.ItemType.Region))
    }
}
