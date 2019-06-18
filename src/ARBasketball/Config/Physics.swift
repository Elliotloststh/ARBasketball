//
//  Physics.swift
//  ARBasketball
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
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
