//
//  HoopPositioningStateController.swift
//  ARBasketball
//
//  Created by Jack on 17/06/2019.
//  Copyright © 2019年 Jack. All rights reserved.
//

import SceneKit

class HoopPositioningStateController: GameStateController {

    func setup() {
        game.sceneView.autoenablesDefaultLighting = true
        game.sceneView.scene = SCNScene()
        game.hoopPlaceholder = createHoopPlaceholder()
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
            game.hoopPlaceholder!.isHidden = false
            var yOff = game.sceneView.pointOfView!.direction.y
            if (yOff < 0){
                yOff = -yOff
            }
            yOff *= 30
            game.hoopPlaceholder!.simdPosition = game.sceneView.pointOfView!.simdWorldFront + simd_float3(0, 0, -2.0-yOff)
        }
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
