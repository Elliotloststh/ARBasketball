//
//  GameStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
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
