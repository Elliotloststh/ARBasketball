//
//  Physics.swift
//  NanoChallenge5
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
        static let pin     = 1 << 2
        static let pinHead = 1 << 3
        
        static let allSolids = floor | ball | pin
    }
    
    private init() {}
}
