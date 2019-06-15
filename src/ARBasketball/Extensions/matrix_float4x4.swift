//
//  matrix_float4x4.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

extension matrix_float4x4 {
    
    var position: SCNVector3 {
        return SCNVector3(columns.3.x, columns.3.y, columns.3.z)
    }
}
