//
//  Roll.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 05/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

enum RollType {
    case strike
    case spare
    case open(Int)
}

struct Roll {
    
    var type: RollType
    var pins: Int
    weak var frame: Frame!
    
    var description: String {
        switch type {
        case .strike:
            return "X"
        case .spare:
            return "/"
        case .open(let pins):
            return "\(pins)"
        }
    }
}
