//
//  GameState.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 01/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

@objc protocol GameState: AnyObject {
    
    var game: Game { get }
    
    @objc optional func setup()
    
    @objc optional func teardown()
    
    @objc optional func update(at time: TimeInterval)
}
