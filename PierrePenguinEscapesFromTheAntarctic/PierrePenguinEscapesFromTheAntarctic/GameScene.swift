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
    

    let world = SKNode()
    let bee = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        let bee = SKSpriteNode()
        bee.size = CGSize(width: 28, height: 24)
        bee.position = CGPoint(x: 250, y: 250)
        self.addChild(bee)
   
        let beeAtlas = SKTextureAtlas(named: "bee.atlas")
        let beeFrames: [SKTexture] = [
            beeAtlas.textureNamed("bee.png"),
            beeAtlas.textureNamed("bee_fly.png")
            ]
        
        let flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.14)
        let beeAction = SKAction.repeatForever(flyAction)
        bee.run(beeAction)
        
        let pathLeft = SKAction.moveBy(x: -200, y: -10, duration: 2)
        let pathRight = SKAction.moveBy(x: 200, y: 10, duration: 2)
        
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        let flightOfBee = SKAction.sequence([
            pathLeft,flipTextureNegative,pathRight,flipTexturePositive
            ])
        let neverEndingFlight = SKAction.repeatForever(flightOfBee)
        bee.run(neverEndingFlight)
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
