//
//  Camera.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import ARKit

class Camera {
    
    private (set) var position = SCNVector3Zero {
        didSet { displacement = position - oldValue }
    }
    
    var velocity: SCNVector3 {
        guard deltaTime > 0 else { return SCNVector3Zero }
        return displacement / Float(deltaTime)
    }
    
    private var time: TimeInterval = 0 {
        didSet { deltaTime = time - oldValue }
    }
    
    private var deltaTime: TimeInterval = 0
    
    private var displacement = SCNVector3Zero
    
    private var arCamera: ARCamera? {
        return Game.instance.sceneView.session.currentFrame?.camera
    }
    
    func update(at time: TimeInterval) {
        self.time = time
        position = arCamera?.transform.position ?? SCNVector3Zero
    }
}
