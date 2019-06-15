//
//  FrameView.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class FrameView: CustomView {

    @IBOutlet weak var firstBallScoreLabel: UILabel!
    @IBOutlet weak var secondBallScoreLabel: UILabel!
    @IBOutlet weak var frameScoreLabel: UILabel!
    
    func update(frame: Frame) {
        firstBallScoreLabel.text = frame.firstBall?.description
        secondBallScoreLabel.text = frame.secondBall?.description
        frameScoreLabel.text = frame.score?.description
    }
}
