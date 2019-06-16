//
//  Constants.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
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
        static let pinLifeTimeAfterKnockDown: Double = 2.5
        static let spawnDepth: Double = 1
        static let throwingIntensity: Double = 4
    }

    
    struct Models {
        static let ball = "art.scnassets/ball.scn"
        static let pins = "art.scnassets/pins.scn"
        static let hoop = "art.scnassets/hoop.scn"
    }
    
    struct NodeNames {
        static let pinHead = "PinHead"
    }
    
    struct FX {
        static let placeholderFadeDuration = 0.1
        static let ballFadeOutDuration = 1.0
        static let pinFadeInDuration = 0.5
        static let pinFadeOutDuration = 0.5
    }
    
    private init() {}
}
