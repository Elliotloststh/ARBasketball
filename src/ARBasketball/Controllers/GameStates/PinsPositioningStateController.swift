//
//  PinsPositioningStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class PinsPositioningStateController: GameStateController {

    func setup() {
        game.sceneView.autoenablesDefaultLighting = true
        game.sceneView.scene = SCNScene()
        game.pinsPlaceholder = createPinsPlaceholder()
        game.ballPlaceholder = createBallPlaceholder()
    }
    
    func teardown() {
        game.createFloorNode()
        game.scoreboard.setUp()
    }
    
    func update(at time: TimeInterval) {
        guard let view = game.sceneView else { return }
        
        let hits = view.hitTest(game.viewCenter, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        if let position = hits.last?.worldTransform.position {
            game.pinsPlaceholder!.isHidden = false
            let cameraDirection = game.sceneView.pointOfView!.direction
            let offset = SCNVector3(cameraDirection.x, 0, cameraDirection.z)
            game.pinsPlaceholder!.position = position + offset
        }
    }
    
    private func createPinsPlaceholder() -> SCNNode {
        let pins = SCNScene(named: Constants.Models.pins)!.rootNode
        game.sceneView.scene.rootNode.addChildNode(pins)
        pins.childNodes.forEach {  $0.opacity = 0.5 }
        pins.isHidden = true
        return pins
    }
    
    private func createBallPlaceholder() -> SCNNode? {
        guard let pointOfView = game.sceneView.pointOfView else { return nil }
        let node = Ball.create().childNodes.first!.clone()
        node.position = pointOfView.position + SCNVector3(0, 0, -1)
        node.opacity = 0
        pointOfView.addChildNode(node)
        return node
    }
}
