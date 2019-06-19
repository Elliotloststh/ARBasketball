//
//  Physics.swift
//  ARBasketball
//
//  Created by Jack on 16/06/2018.
//  Copyright © 2019年 Jack. All rights reserved.
//

import Foundation

struct Physics {
    
    struct CategoryBitMask {
        static let none    = 0
        static let floor   = 1 << 0
        static let ball    = 1 << 1
        static let hoop     = 1 << 2
        
        static let allSolids = floor | ball | hoop
    }
    
    private init() {}
}
