//
//  PinsPositioningStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class HoopPositioningStateController: GameStateController {

    func setup() {
        game.sceneView.autoenablesDefaultLighting = true
        game.sceneView.scene = SCNScene()
//        game.pinsPlaceholder = createPinsPlaceholder()
        game.hoopPlaceholder = createHoopPlaceholder()
        game.ballPlaceholder = createBallPlaceholder()
        
//        game.pinsPlaceholder.addChildNode(Hoop.create(position: SCNVector3Zero))
        
    }
    
    func teardown() {
        game.createFloorNode()
        game.scoreboard.setUp()
    }
    
    func update(at time: TimeInterval) {
        guard let view = game.sceneView else { return }
        
        let hits = view.hitTest(game.viewCenter, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        if let position = hits.last?.worldTransform.position {
            game.hoopPlaceholder!.isHidden = false
//            game.pinsPlaceholder!.isHidden = false
            let cameraDirection = game.sceneView.pointOfView!.direction
            let offset = SCNVector3(cameraDirection.x, 0, 0.5*cameraDirection.z)
            game.hoopPlaceholder!.position = position + offset
//            game.pinsPlaceholder!.position = position + offset
        }
    }
    
    private func createPinsPlaceholder() -> SCNNode {
        let pins = SCNScene(named: Constants.Models.pins)!.rootNode
        game.sceneView.scene.rootNode.addChildNode(pins)
        pins.childNodes.forEach {  $0.opacity = 0.5 }
        pins.isHidden = true
        return pins
    }
    
    private func createHoopPlaceholder() -> SCNNode {
        let hoop = SCNScene(named: Constants.Models.hoop)!.rootNode
        let node = Hoop.create(position: SCNVector3Zero)
        hoop.addChildNode(node)
        game.sceneView.scene.rootNode.addChildNode(hoop)
        hoop.isHidden = true
        return hoop
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
