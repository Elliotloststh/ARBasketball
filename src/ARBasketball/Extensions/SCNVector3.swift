//
//  SCNVector3.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

extension SCNVector3 {
    
    static func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    static func -(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }
    
    static func *(lhs: SCNVector3, rhs: Float) -> SCNVector3 {
        return SCNVector3Make(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    }
    
    static func *(lhs: SCNVector3, rhs: Double) -> SCNVector3 {
        return lhs * Float(rhs)
    }
    
    static func /(lhs: SCNVector3, rhs: Float) -> SCNVector3 {
        return SCNVector3Make(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }
}
