//
//  MainRoomItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum MainRoomItem: String, CaseIterable {
    case broom
    case mainDesk
    case mainWindow
    case radioTable
    case vase
    
    var props: ItemProps {
        switch self {
        case .broom:
            return .init(heightMultiplier: 1,
                         textures: [
                            .normal: SKTexture(imageNamed: TextureResources.broom)
                         ], 
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .mainDesk:
            return .init(heightMultiplier: 1,
                         textures: [
                            .normal: SKTexture(imageNamed: TextureResources.mainDeskNormal),
                            .closed: SKTexture(imageNamed: TextureResources.mainDeskClosed),
                            .opened: SKTexture(imageNamed: TextureResources.mainDeskOpened)
                         ], 
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .mainWindow:
            return .init(textures: [
                .opened: SKTexture(imageNamed: TextureResources.mainWindowOpened),
                .closed: SKTexture(imageNamed: TextureResources.mainWindowClosed)
            ],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .radioTable:
            return .init(heightMultiplier: 0.6,
                         textures: [
                            .normal: SKTexture(imageNamed: TextureResources.radioTable)
                         ], makePhysicsBody: { node in makeRectPhysicsBody(node: node) }
            )
        case .vase:
            return .init(textures: [
                .ripe: SKTexture(imageNamed: TextureResources.vaseRipe),
                .budding: SKTexture(imageNamed: TextureResources.vaseBudding),
                .partialBlossom: SKTexture(imageNamed: TextureResources.vasePartialBlossom),
                .fullBlossom: SKTexture(imageNamed: TextureResources.vaseFullBlossom)
            ], 
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        }
    }
}

extension MainRoomItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
    var makePhysicsBody: (ItemNode) -> SKPhysicsBody?  {
        props.makePhysicsBody
    }
    
}
