//
//  FrameView.swift
//  ARBasketball
//
//  Created by Jack on 16/06/2019.
//  Copyright © 2019年 Jack. All rights reserved.
//

import UIKit

class FrameView: CustomView {

    @IBOutlet weak var firstBallScoreLabel: UILabel!
    
    func update(frame: Frame) {
        firstBallScoreLabel.text = frame.cellScore
    }
}
