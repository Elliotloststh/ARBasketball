//
//  SCNNode.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 03/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

extension SCNNode {
    
    var direction: SCNVector3 {
        let x = -rotation.x
        let y = -rotation.y
        let z = -rotation.z
        let w = rotation.w
        let cameraRotationMatrix = GLKMatrix3Make(
            cos(w) + pow(x, 2) * (1 - cos(w)),
            x * y * (1 - cos(w)) - z * sin(w),
            x * z * (1 - cos(w)) + y * sin(w),
            
            y * x * (1 - cos(w)) + z * sin(w),
            cos(w) + pow(y, 2) * (1 - cos(w)),
            y * z * (1 - cos(w)) - x * sin(w),
            
            z * x * (1 - cos(w)) - y * sin(w),
            z * y * (1 - cos(w)) + x * sin(w),
            cos(w) + pow(z, 2) * (1 - cos(w)))
        
        let direction = GLKMatrix3MultiplyVector3(cameraRotationMatrix, GLKVector3Make(0, 0, -1))
        return SCNVector3FromGLKVector3(direction)
    }
}
