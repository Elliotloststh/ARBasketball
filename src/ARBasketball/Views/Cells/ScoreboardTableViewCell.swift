//
//  ScoreboardTableViewCell.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class ScoreboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet var frameViews: [FrameView]!
    @IBOutlet weak var lastFrameView: LastFrameView!
    
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
        lastFrameView.update(frame: frames.last!)
    }
}
