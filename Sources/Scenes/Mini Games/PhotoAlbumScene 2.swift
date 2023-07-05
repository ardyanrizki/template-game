//
//  PhotoAlbumGameScene.swift
//  Memoryme
//
//  Created by Clarabella Lius on 28/06/23.
//

import SpriteKit
import GameplayKit

class PhotoAlbumScene: PlayableScene {
    
    //polaroid array
    var polaroidNodes: [SKSpriteNode] = []
    
    /** Initial position of polaroids*/
    var initialPolaroidPosition = [String: CGPoint]()
    
    /** Target position of polaroids*/
    var targetPolaroidNodes = [String: SKSpriteNode]()
    
    /**Next arrow button**/
    var rightArrow: SKSpriteNode?
    
    //flag to count photos matched
    var matchedPhotoCount = 0
    
    var photoPicked: String = ""
    
    override func update(_ currentTime: TimeInterval) {
        if matchedPhotoCount == 4{
            rightArrow = self.childNode(withName: "arrow-right") as? SKSpriteNode
            rightArrow?.alpha = 1
        }
    }
    
    override func didMove(to view: SKView) {
        setupDialogBox()
        
        /** Calls parent scene named polaroidNotes**/
        if let parentNode = childNode(withName: "polaroidNodes") {
            /**Sets the children of polaroidNodes  as SKSpriteNode**/
            let childrenNodes = parentNode.children as! [SKSpriteNode]
            
            /** Loop through polaroidNodes and makes the child nodes as enumerated **/
            for (_, childNode) in childrenNodes.enumerated() {
                
                //apppend the children of "polaroidNodes" to array
                polaroidNodes.append(childNode)
                
                //initializes the array of initial position
                initialPolaroidPosition[childNode.name!] = childNode.position
            }
        }
        
        // add dictionary. key: target child node, value: current position of the node
        /**Loop through targetPosition**/
        if let targetParentNode = childNode(withName: "targetPositionNodes") {
            
            /**Sets the children of targetNodePosition**/
            let childrenNodes = targetParentNode.children as! [SKSpriteNode]
            for (_, childNode) in childrenNodes.enumerated() {
                targetPolaroidNodes[childNode.name!] = childNode
            }
        }
        
        self.dialogBox?.startSequence(dialogs: [
            DialogResources.bedroom_2_withPhoto_seq1
        ], from: self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        // TODO
        // loop throuugh to the polaroidNodes
        // check whether touchLocation contain corresponding the child node
        // if yes, change the child node position to the current touchLocation
        // otherwise, do nothing
        for polaroidNode in polaroidNodes {
            if polaroidNode.contains(touchLocation) {
                photoPicked = polaroidNode.name!
                polaroidNode.position = touchLocation
            }
        }
        switch(touchedNode?.name) {
            case "arrow-right":
                sceneManager?.presentMGPhotoAlbumSecondScene()
                break
            case "back-button":
            sceneManager?.presentBedroomScene(playerPosition: .photoAlbumSpot)
                break
            default:
                break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // TODO
        // loop throuugh to the polaroidNodes
        // check whether touchLocation contain corresponding the child node
        // if yes, change the child node position to the current touchLocation
        // otherwise, do nothing
        
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        for polaroidNode in polaroidNodes{
            if polaroidNode.contains(touchLocation) && photoPicked == polaroidNode.name {
                polaroidNode.position = touchLocation
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO
        // loop throuugh to the polaroidNodes
        
        // if any polaroidNode selected
        // check whether the polaroid node intersect with target node
        // if yes, change polaroid node to the current target node
        
        // then remove the node from polaroidNodes
        // otherwise, use initial position to assign current selected node back to the origin position
        
        guard touches.first != nil else{
            return
        }
       
        for polaroidNode in polaroidNodes{

            if let targetNode = targetPolaroidNodes[polaroidNode.name!]{
                
                // check whether the polaroid node intersect with target node
                if polaroidNode.intersects(targetNode){
                    
                    // if yes, change polaroid node to the current target node
                    polaroidNode.position = targetNode.position
                    matchedPhotoCount += 1
        
                    //remove node from polaroidNodes
                    if let index = polaroidNodes.firstIndex(of: polaroidNode) {
                        polaroidNodes.remove(at: index)
                    }
                    
                }else{
                    
                    if let initialPosition = initialPolaroidPosition[polaroidNode.name!]{
                        polaroidNode.position = initialPosition
                    }
                    
                }
            } else {
                
                if let initialPosition = initialPolaroidPosition[polaroidNode.name!]{
                    polaroidNode.position = initialPosition
                }

            }
        }
    }
    
    func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
}
