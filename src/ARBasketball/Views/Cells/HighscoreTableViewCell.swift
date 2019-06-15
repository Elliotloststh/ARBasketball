//
//  HighscoreTableViewCell.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class HighscoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var highscore: (player: String, score: Int)! {
        didSet {
            playerLabel.text = highscore.player
            scoreLabel.text = highscore.score.description
        }
    }
}
