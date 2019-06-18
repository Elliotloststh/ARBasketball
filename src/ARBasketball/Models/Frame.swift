//
//  Frame.swift
//  ARBasketball
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class Frame {
    
    weak var previousFrame: Frame?
    
    let number: Int
    let maxNumber: Int = 10
    
    var cellScore : String

    private (set) var ballIndex = 0

    
    private var maxRolls: Int {
        return 1
//        return number == Constants.Game.numberOfFrames ? 3 : 2
    }
    
    var ballsLeft: Int {
        return maxRolls - ballIndex
    }
    
    var isComplete: Bool {
        return ballsLeft == 0
    }
    
    init(number: Int) {
        self.number = number
        self.cellScore = "0"
    }
    
    func roll(score: Int) {
        self.cellScore = String(score)
        ballIndex += 1
    }
    
}
