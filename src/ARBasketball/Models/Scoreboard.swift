//
//  Scoreboard.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class Scoreboard {
    
    var players = [Player()]
    var frames = [[Frame]]()
    var rolls = [[Roll]]()
    
    var playerIndex = 0
    var frameIndex = 0
    
    var isLastFrame: Bool {
        return playerIndex == players.endIndex - 1 && frameIndex == Constants.Game.numberOfFrames - 1
    }
    
    var currentFrame: Frame {
        return frames[playerIndex][frameIndex]
    }
    
    var currentPlayer: Player {
        return players[playerIndex]
    }
    
    func setUp() {
        playerIndex = 0
        frameIndex = 0
        resetFrames()
        resetRolls()
    }
    
    func resetFrames() {
        frames = []
        players.forEach { _ in
            var playerFrames = [Frame]()
            for frameNumber in 1...Constants.Game.numberOfFrames {
                playerFrames.append(Frame(number: frameNumber))
            }
            frames.append(playerFrames)
        }
    }
    
    func resetRolls() {
        rolls = [[Roll]](repeating: [Roll](), count: players.count)
    }
    
    func roll(pins: Int) -> ThrowResults {
        let roll = currentFrame.roll(pins: pins)
        rolls[playerIndex].append(roll)
        calculateScores()
        
        return currentFrame.isComplete ? nextFrame() : nextBall()
    }
    
    private func nextFrame() -> ThrowResults {
        if isLastFrame { return .gameOver }
        
        playerIndex = (playerIndex + 1) % players.count
        if playerIndex == 0 {
            frameIndex = (frameIndex + 1) % Constants.Game.numberOfFrames
        }
        
        if frameIndex > 0 {
            currentFrame.previousFrame = frames[playerIndex][frameIndex - 1]
        }
        
        return .frameComplete
    }
    
    private func nextBall() -> ThrowResults {
        return .nextBall
    }
    
    private func calculateScores() {
        guard let roll = rolls[playerIndex].last else { return }
        
        // jogadas anteriores
        var rollPast1: Roll?
        var rollPast2: Roll?
        
        // jogada que pode ter sido um spare
        let spareIndex = rolls[playerIndex].endIndex - 2
        if spareIndex > 0 {
            rollPast1 = rolls[playerIndex][spareIndex]
        }
        
        // jogada que pode ter sido um strike
        let strikeIndex = rolls[playerIndex].endIndex - 3
        if strikeIndex > 0 {
            rollPast2 = rolls[playerIndex][strikeIndex]
        }
        
        // atualiza um possível strike
        if let strike = rollPast2, let spare = rollPast1 {
            switch strike.type {
            case .strike:
                strike.frame.score(10 + roll.pins + spare.pins)
            default:
                break
            }
        }
        
        // atualiza um possível spare
        if let spare = rollPast1 {
            switch spare.type {
            case .spare:
                spare.frame.score(10 + roll.pins)
            default:
                break
            }
        }
        
        // fecha o valor do quadro, se estiver completo e não for spare nem strike
        if currentFrame.isComplete {
            switch roll.type {
            case .open:
                currentFrame.score(currentFrame.totalPins)
            default:
                if frameIndex == Constants.Game.numberOfFrames - 1 {
                    // todo: calcular o score do último frame
                }
            }
        }
    }
}
