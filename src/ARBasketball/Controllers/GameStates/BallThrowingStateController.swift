//
//  BallThrowingStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class BallThrowingStateController: GameStateController {
    
    @IBOutlet weak var currentBallLabel: UILabel!
    @IBOutlet weak var currentFrameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var instructionBox: UIView!
    
    var didThrow = false
    var pins = 0
    
    func setup() {
        resetPins()
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
        updateInstructions(text: Constants.Text.instructionsRelease)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !didThrow else { return }
        didThrow = true
        game.throwBall()
        waitForBallToFadeOut()
        updateInstructions(text: nil)
    }
    
    private func waitForBallToFadeOut() {
        Timer.scheduledTimer(withTimeInterval: Constants.Game.ballLifeTime, repeats: false) { [weak self] _ in
            guard let this = self else { return }
            let throwResults = this.game.scoreboard.roll(pins: this.pins)
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
    
    private func resetPins() {
        game.pinsPlaceholder.childNodes.forEach { $0.removeFromParentNode() }
    
        let pinSet = PinSet.create(position: SCNVector3Zero)
        game.pinsPlaceholder.addChildNode(pinSet)
    }
    
    func updateHeader() {
        currentBallLabel.text = (game.scoreboard.currentFrame.ballIndex + 1).description
        currentFrameLabel.text = game.scoreboard.currentFrame.number.description
        playerNameLabel.text = game.scoreboard.currentPlayer.name
    }
    
    func updateInstructions(text: String?) {
        instructionLabel.text = text
        instructionBox.isHidden = text == nil
    }
    
    private func setUpNextBall() {
        updateHeader()
        updateInstructions(text: Constants.Text.instructionsHold)
        didThrow = false
        pins = 0
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

extension BallThrowingStateController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodes = [contact.nodeA, contact.nodeB]
        guard let pinHead = nodes.first(where: { $0.name == Constants.NodeNames.pinHead }) else { return }
        
        // animations
        let delay = SCNAction.wait(duration: Constants.Game.pinLifeTimeAfterKnockDown)
        let fadeOut = SCNAction.fadeOut(duration: Constants.FX.pinFadeOutDuration)
        let remove = SCNAction.run { $0.removeFromParentNode() }
        pinHead.parent?.runAction(SCNAction.sequence([delay, fadeOut, remove]))
        pinHead.removeFromParentNode()
        
        // contabiliza o pino derrubado
        pins += 1
    }
    
}
