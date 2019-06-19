//
//  Floor.swift
//  ARBasketball
//
//  Created by Jack on 16/06/2019.
//  Copyright © 2019年 Jack. All rights reserved.
//

import SceneKit

class Floor: SCNNode {

    convenience init(at position: SCNVector3) {
        self.init()
        addGeometry()
        addPhysics()
        move(to: position)
        opacity = 0
    }
    
    private func addGeometry() {
        geometry = SCNBox(width: 1000, height: 10, length: 1000, chamferRadius: 0)
    }
    
    private func addPhysics() {
        physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        physicsBody!.restitution = 0.4
        physicsBody!.categoryBitMask = Physics.CategoryBitMask.floor
        physicsBody!.collisionBitMask = Physics.CategoryBitMask.allSolids
    }
    
    private func move(to position: SCNVector3) {
        let box = geometry as! SCNBox
        let offset = SCNVector3(0, -Float(box.height / 2 + 0.6), 0)
        self.position = position + offset
    }
}
