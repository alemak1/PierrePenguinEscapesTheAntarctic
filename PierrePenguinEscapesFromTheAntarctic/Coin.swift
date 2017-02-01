//
//  Coin.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit


class Coin: SKSpriteNode, GameSprite{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
    var value = 1
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 26, height: 26)) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.texture = textureAtlas.textureNamed("coin-bronze.png")
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        self.physicsBody?.collisionBitMask = 0
        
        
    }
    
    func collect(){
        //Prevent further contact
        self.physicsBody?.categoryBitMask = 0
        
        //Fade out, move up, and scale up the coin
        let collectionAnimation = SKAction.group([
            SKAction.fadeAlpha(to: 0, duration: 0.2),
            SKAction.scale(to: 1.5, duration: 0.2),
            SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2),
            ])
        
        //After fading it out, move the coin out of the way and reset it to the initial values until the encounter system re-uses it
        let resetAfterCollected = SKAction.run({
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            
            self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        })
        
        //Combine the actions into a sequence
        let collectSequence = SKAction.sequence([
            collectionAnimation,
            resetAfterCollected
            ])
        
        //Run the collection animation
        self.run(collectSequence)
        
        
    }
    
    func turnToGold(){
        self.texture = textureAtlas.textureNamed("coin-gold.png")
        self.value = 5
    }
    
    func onTap() {
        
    }
    
    func createAnimations(){
        
    }
}
