//
//  BedroomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BedroomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = BedroomScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> BedroomScene? {
        let scene = BedroomScene(fileNamed: Constants.bedroomScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
}
