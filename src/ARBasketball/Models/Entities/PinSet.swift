import SceneKit

class PinSet: SCNNode {
    
    private static let shared = PinSet(position: SCNVector3Zero, model: SCNScene(named: Constants.Models.pins)!.rootNode)
    
    static func create(position: SCNVector3) -> PinSet {
        let pinSet = shared.clone()
        pinSet.position = position
//        pinSet.animateChildNodes()
        return pinSet
    }
    
    private convenience init(position: SCNVector3, model: SCNNode) {
        self.init()
        addChildNode(model)
        for pin in model.childNodes {
            addPhysicsBody(to: pin)
            addPinHeadTrigger(to: pin)
        }
    }
    
    private func addPhysicsBody(to node: SCNNode) {
        let cylinder = SCNCylinder(radius: 0.15, height: 1)
        let cylinderShape = SCNPhysicsShape(geometry: cylinder, options: nil)
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: cylinderShape)
        node.physicsBody!.categoryBitMask = Physics.CategoryBitMask.pin
        node.physicsBody!.collisionBitMask = Physics.CategoryBitMask.allSolids
    }
    
    private func addPinHeadTrigger(to node: SCNNode) {
        let pinHead = SCNNode(geometry: SCNSphere(radius: 0.25))
        pinHead.name = Constants.NodeNames.pinHead
        pinHead.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        pinHead.physicsBody!.categoryBitMask = Physics.CategoryBitMask.pinHead
        pinHead.physicsBody!.collisionBitMask = Physics.CategoryBitMask.none
        pinHead.physicsBody!.contactTestBitMask = Physics.CategoryBitMask.floor
        pinHead.position = SCNVector3(0, 0.5, 0)
        pinHead.opacity = 0
        node.addChildNode(pinHead)
    }
    
    private func animateChildNodes() {
        guard let pins = childNodes.first?.childNodes else { return }
        for child in pins {
            guard let skittle = child.childNode(withName: "Skittle", recursively: false) else { continue }
            let originalPosition = skittle.position
            let startingPosition = skittle.position + SCNVector3(0, 0.5, 0)
            skittle.position = startingPosition
            skittle.opacity = 0
            let duration = Constants.FX.pinFadeInDuration * (1.0 + 0.25 * drand48())
            let fadeIn = SCNAction.fadeIn(duration: duration)
            let slideIn = SCNAction.move(to: originalPosition, duration: duration)
            skittle.removeAllActions()
            skittle.runAction(SCNAction.group([fadeIn, slideIn]))
        }
    }
}
