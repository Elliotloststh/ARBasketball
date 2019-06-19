//
//  GameState.swift
//  ARBasketball
//
//  Created by 佳浩 on 13/06/2019.
//  Copyright © 2019年 佳浩. All rights reserved.
//

import Foundation

@objc protocol GameState: AnyObject {
    
    var game: Game { get }
    
    @objc optional func setup()
    
    @objc optional func teardown()
    
    @objc optional func update(at time: TimeInterval)
}
