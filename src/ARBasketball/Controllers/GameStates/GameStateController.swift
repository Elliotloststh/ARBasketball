//
//  GameStateController.swift
//  ARBasketball
//
//  Created by 佳浩 on 13/06/2019.
//  Copyright © 2019年 佳浩. All rights reserved.
//

import UIKit

class GameStateController: BaseViewController, GameState {
    
    var game: Game {
        return Game.instance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game.state = self
    }
}
