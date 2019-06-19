//
//  ScoreboardTableViewCell.swift
//  ARBasketball
//
//  Created by Jack on 18/06/2019.
//  Copyright © 2019年 Jack. All rights reserved.
//

import UIKit

class ScoreboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet var frameViews: [FrameView]!
    
    var playerIndex: Int! {
        didSet {
            updateContent()
        }
    }
    
    private func updateContent() {
        updatePlayer()
        updateFrames()
    }
    
    private func updatePlayer() {
        let player = Game.instance.scoreboard.players[playerIndex]
        playerNameLabel.text = player.name
        playerScoreLabel.text = player.score.description
    }
    
    private func updateFrames() {
        let frames = Game.instance.scoreboard.frames[playerIndex]
        frameViews.forEach { $0.update(frame: frames[$0.tag]) }
    }
}
