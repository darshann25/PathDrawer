//
//  Unimplemented.swift
//  path_drawer
//
//  Created by Haixin on 2017/11/11.
//  Copyright © 2017年 scratchwork. All rights reserved.
//

import Foundation
import UIKit

class Unimplemented {
    enum Errors: Error{
        case errorcase
    }
    static func method (funcName : String) {
        //throw Errors.errorcase
        
        //var message :NSString = "Error"
        
        NSLog( "Unimplemented function '%@'",funcName);
    }
}


