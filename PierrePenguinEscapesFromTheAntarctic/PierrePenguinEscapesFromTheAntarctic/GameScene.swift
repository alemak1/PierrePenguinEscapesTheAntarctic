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
    let ground = Ground()
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
    
        self.addChild(world)
        addTheFlyingBee()
        
        let bee2 = Bee()
        let bee3 = Bee()
        let bee4 = Bee()
        
        bee2.spawn(parentNode: world, position: CGPoint(x: 325, y: 325))
        bee3.spawn(parentNode: world, position: CGPoint(x: 200, y: 325))
        bee4.spawn(parentNode: world, position: CGPoint(x: 50, y: 200))
        
        let groundPosition = CGPoint(x: -self.size.width, y: 100)
        let groundSize = CGSize(width: self.size.width*3, height: 0)
        ground.spawn(parentNode: world, position: groundPosition, size: groundSize)
        
    }
    
    
    func addTheFlyingBee(){
        bee.size = CGSize(width: 28, height: 24)
        bee.position = CGPoint(x: 250, y: 250)
        world.addChild(bee)
        
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
    
    override func didSimulatePhysics() {
        let worldXPos = -(bee.position.x*world.xScale - (self.size.width)/2)
        let worldYPos = -(bee.position.y*world.yScale - (self.size.height/2))
        world.position = CGPoint(x: worldXPos, y: worldYPos)
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
