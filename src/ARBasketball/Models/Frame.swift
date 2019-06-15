//
//  Frame.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class Frame {
    
    weak var previousFrame: Frame?
    
    let number: Int
    
    private (set) var rolls = [Roll]()
    private (set) var score: Int?
    private (set) var ballIndex = 0
    
    var firstBall: Roll? { return rollForBall(atIndex: 0) }
    var secondBall: Roll? { return rollForBall(atIndex: 1) }
    var thirdBall: Roll? { return rollForBall(atIndex: 2) }
    
    private var maxRolls: Int {
        return number == Constants.Game.numberOfFrames ? 3 : 2
    }
    
    var ballsLeft: Int {
        return maxRolls - ballIndex
    }
    
    var pinsLeft: Int {
        guard let lastRoll = rolls.last else { return 10 }
        switch lastRoll.type {
        case .open(let x):
            return 10 - x
        default:
            return 0
        }
    }
    
    var totalPins: Int {
        return rolls.reduce(0, { $0 + $1.pins })
    }
    
    var hasLeftOver: Bool {
        return pinsLeft > 0
    }
    
    var isComplete: Bool {
        return ballsLeft == 0 || !hasLeftOver
    }
    
    init(number: Int) {
        self.number = number
    }
    
    var previousRoll: Roll? {
        return rollForBall(atIndex: ballIndex - 1)
    }
    
    func roll(pins: Int) -> Roll {
        // ⚠️ ATENÇÃO ⚠️ //
        // Aos 45'do segundo tempo, daqui pra baixo é só xunxo... 😬
        switch (ballIndex, pins, previousRoll?.type) {
        case (0, 10, _):
            rollStrike()
        case (1, let x, .open(let y)?) where x + y == 10:
            rollSpare(pins: x)
        default:
            rollOpen(pins: pins)
        }
        
        ballIndex += 1
        return rolls.last!
    }
    
    func score(_ score: Int) {
        self.score = (previousFrame?.score ?? 0) + score
    }
    
    func scoreStrike(pins: Int) {
        //        score = (previousFrame?.score ?? 0) + 10 + pins
    }
    
    private func rollStrike() {
        rolls.append(Roll(type: .strike, pins: 10, frame: self))
    }
    
    private func rollSpare(pins: Int) {
        rolls.append(Roll(type: .spare, pins: pins, frame: self))
    }
    
    private func rollOpen(pins: Int) {
        rolls.append(Roll(type: .open(pins), pins: pins, frame: self))
    }
    
    private func rollForBall(atIndex index: Int) -> Roll? {
        guard rolls.indices.contains(index) else { return nil }
        
        return rolls[index]
    }
    
}
