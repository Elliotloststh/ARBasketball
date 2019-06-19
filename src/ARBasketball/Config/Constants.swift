//
//  Constants.swift
//  ARBasketball
//
//  Created by 佳浩 on 13/06/2019.
//  Copyright © 2019年 佳浩. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Player {
        static let nameMaxLength = 15
        static let defaultPlayerName = "Player 1"
    }
    
    struct Game {
        static let numberOfFrames: Int = 10
        static let maxPlayers: Int = 4
        static let ballLifeTime: Double = 3
        static let spawnDepth: Double = 1
        static let throwingIntensity: Double = 3
    }

    
    struct Models {
        static let ball = "art.scnassets/Basketball.scn"
        static let hoop = "art.scnassets/hoop.scn"
    }
    
    struct FX {
        static let placeholderFadeDuration = 0.1
        static let ballFadeOutDuration = 1.0
    }
    
    private init() {}
}
