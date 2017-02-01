//
//  Ghost.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit

class Ghost: SKSpriteNode, GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    var fadeAnimation = SKAction()
    
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 30, height: 44)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.texture = textureAtlas.textureNamed("ghost-frown.png")
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.run(fadeAnimation)
        self.alpha = 0.8
        
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue

        
        
    }
    
    func onTap() {
        
    }
    
    func createAnimations(){
        let fadeOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.3, duration: 2),
            SKAction.scale(to: 0.8, duration: 2)
            ])
        
        let fadeInGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.8, duration: 2),
            SKAction.scale(to: 1, duration: 2)
            ])
        
        let fadeSequence = SKAction.sequence([
            fadeOutGroup, fadeInGroup
            ])
        fadeAnimation = SKAction.repeatForever(fadeSequence)
    }
}
