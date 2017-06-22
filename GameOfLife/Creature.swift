//
//  Creature.swift
//  GameOfLife
//
//  Created by Evan Chen on 6/21/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit

class Creature : SKSpriteNode{
    
    init(x:Int, y:Int){
        super.init(texture: SKTexture(imageNamed: "bubble") , color : UIColor.clear, size : SKTexture(imageNamed: "bubble").size())
        super.anchorPoint = CGPoint(x:0,y:0)
        super.position = CGPoint(x:x+19,y:y) //some tweaking to get the creature just about center on grid
        super.zPosition = 2
        //auto dead
        self.alpha = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
