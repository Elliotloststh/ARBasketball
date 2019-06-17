//
//  Hoop.swift
//  ARBasketball
//
//  Created by 佳浩 on 2019/6/16.
//  Copyright © 2019 Charles Ferreira. All rights reserved.
//

import SceneKit

class Hoop: SCNNode {
    
    private static let shared = Hoop(position: SCNVector3Zero,model: SCNScene(named: Constants.Models.hoop)!.rootNode)
    
    static func create(position: SCNVector3) -> Hoop {
        let hoop = shared.clone()
        hoop.position = position
        //        pinSet.animateChildNodes()
        return hoop
    }
    
    private convenience init(position: SCNVector3, model: SCNNode) {
        self.init()
        addChildNode(model)
        
        guard let backboardNode = model.childNode(withName: "backboard", recursively: true) else { return}
        guard let netNode = model.childNode(withName: "net", recursively: true) else { return}
//        guard let rim = model.childNode(withName: "rim", recursively: false) else { return  }
        
        for child in backboardNode.childNodes{
            print("FFFFFFF\(String(describing: child.name))");
            if (child.name == "rim"){
                print("KKK")
                addRimPhysicsBody(to: child);
            }
        }
        addBoardPhysicsBody(to: backboardNode)
        addNetPhysicsBody(to: netNode)
//        addRimPhysicsBody(to: rim)
//        scheduleRemoval()
    }
    
    private func addBoardPhysicsBody(to node: SCNNode) {
        let physicsShape = SCNPhysicsShape(node: node, options: [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron])
        node.physicsBody = SCNPhysicsBody(type: .static, shape: physicsShape)
        
        
        //TODO
        node.physicsBody!.categoryBitMask = Physics.CategoryBitMask.pin
        node.physicsBody!.collisionBitMask = Physics.CategoryBitMask.allSolids
        node.physicsBody!.contactTestBitMask = Physics.CategoryBitMask.ball
    }
    
    private func addNetPhysicsBody(to node: SCNNode) {
        let physicsShape = SCNPhysicsShape(node: node, options: [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron])
        node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        
        
        //TODO
        node.physicsBody!.categoryBitMask = Physics.CategoryBitMask.pin
        node.physicsBody!.collisionBitMask = Physics.CategoryBitMask.allSolids
        node.physicsBody!.contactTestBitMask = Physics.CategoryBitMask.ball
    }
    
    private func addRimPhysicsBody(to node:SCNNode){
        let physicsShape = SCNPhysicsShape(node: node, options: [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron])
        node.physicsBody = SCNPhysicsBody(type: .static, shape: physicsShape)
        
        node.name = "rim"
        //TODO
        node.physicsBody!.categoryBitMask = Physics.CategoryBitMask.pin
        node.physicsBody!.collisionBitMask = Physics.CategoryBitMask.allSolids
        node.physicsBody!.contactTestBitMask = Physics.CategoryBitMask.ball
    }

}
