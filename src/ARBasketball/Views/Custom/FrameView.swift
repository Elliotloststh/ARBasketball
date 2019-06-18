//
//  FrameView.swift
//  ARBasketball
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class FrameView: CustomView {

    @IBOutlet weak var firstBallScoreLabel: UILabel!
    
    func update(frame: Frame) {
        firstBallScoreLabel.text = frame.cellScore
    }
}
