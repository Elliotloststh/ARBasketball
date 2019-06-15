//
//  LastFrameView.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class LastFrameView: FrameView {
    
    @IBOutlet weak var thirdBallScoreLabel: UILabel!
    
    override func update(frame: Frame) {
        super.update(frame: frame)
        thirdBallScoreLabel.text = frame.thirdBall?.description
    }
}
