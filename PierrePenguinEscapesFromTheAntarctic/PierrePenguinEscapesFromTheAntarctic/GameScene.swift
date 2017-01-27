//
//  GameScene.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/27/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        let bee = SKSpriteNode(imageNamed: "bee.png")
        bee.size = CGSize(width: 25, height: 24)
        bee.position = CGPoint(x: 250, y: 250)
        self.addChild(bee)
   
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
