//
//  BallThrowingStateController.swift
//  ARBasketball
//
//  Created by 佳浩 on 17/06/2019.
//  Copyright © 2019年 佳浩. All rights reserved.
//

import SceneKit

class BallThrowingStateController: GameStateController, SCNPhysicsContactDelegate {
    
    @IBOutlet weak var currentBallLabel: UILabel!
    @IBOutlet weak var currentFrameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var didThrow = false
    
    func setup() {
        resetHoop()
        setUpNextBall()
        game.sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    func teardown() {
        game.sceneView.scene.physicsWorld.contactDelegate = nil
    }
    
    func update(at time: TimeInterval) {
        game.camera.update(at: time)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !didThrow else { return }
        game.showBallPlaceholder()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !didThrow else { return }
        didThrow = true
        
        waitForBallToFadeOut(ballNode: game.throwBall())
    }
    
    private func waitForBallToFadeOut(ballNode: Ball) {
        var score = 0
        var count = 0
        
        //检测球心，150帧率
        Timer.scheduledTimer(withTimeInterval: Constants.Game.ballLifeTime/150, repeats: true) {
            timer1 in
            
            var ballVector = ballNode.presentation.worldPosition
            var rimNode = self.game.hoopPlaceholder.childNode(withName: "backboard", recursively: false)?.childNode(withName: "rim", recursively: false)
            var rimVector = rimNode?.presentation.worldPosition
            
//            rimVector = convertPosition(rimVector,ballNode)
//            ballNode.convertVector(ballVector, to: rimNode)
            
            
            rimVector = rimVector! + SCNVector3(0, 0.2, 0.5)
            print(ballVector, rimVector)
            
            //球心与lrim之间距离
            let distance = ballVector-rimVector!

            let length: Float = sqrtf(distance.x * distance.x + distance.y * distance.y + distance.z * distance.z)
            print(length)
            
            //距离小于0.2视为进球
            if length < 0.2 {
                score = 1
            }
            
            
            count += 1
            if count==145 {
                timer1.invalidate()
            }
            
        }
        
        //进入下一环节
        Timer.scheduledTimer(withTimeInterval: Constants.Game.ballLifeTime, repeats: false) { [weak self] _ in
            guard let this = self else { return }
            let throwResults = this.game.scoreboard.roll(score: score)
            switch throwResults {
            case .nextBall:
                this.setUpNextBall()
            case .frameComplete:
                this.showScoreboard(gameOver: false)
            case .gameOver:
                this.showScoreboard(gameOver: true)
            }
        }
    }
    
    private func resetHoop() {
//        game.hoopPlaceholder.childNodes.forEach { $0.removeFromParentNode() }
        let hoop = Hoop.create(position: SCNVector3Zero)
        game.hoopPlaceholder.addChildNode(hoop)
    }
    
    func updateHeader() {
        currentBallLabel.text = (game.scoreboard.currentFrame.ballIndex + 1).description
        currentFrameLabel.text = game.scoreboard.currentFrame.number.description
        playerNameLabel.text = game.scoreboard.currentPlayer.name
    }
    
    private func setUpNextBall() {
        updateHeader()
        didThrow = false
    }
    
    private func showScoreboard(gameOver: Bool) {
        performSegue(withIdentifier: "ShowScoreboard", sender: gameOver)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? ScoreboardStateController,
            let isGameOver = sender as? Bool else { return }
        
        controller.previousState = self
        controller.isGameOver = isGameOver
    }
}
