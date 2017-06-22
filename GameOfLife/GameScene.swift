//
//  GameScene.swift
//  GameOfLife
//
//  Created by Evan Chen on 6/21/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    static var generationNode = SKLabelNode()
    var generationLabel = SKLabelNode()

    
    override func didMove(to view: SKView) {
        GameScene.generationNode = (self.childNode(withName: "GenNum") as! SKLabelNode)
        GameScene.generationNode.fontSize = 40
        
        generationLabel = (self.childNode(withName: "GenLabel") as! SKLabelNode)
        generationLabel.fontSize = 40
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}

   

