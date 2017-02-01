//
//  Star.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit

class Star: SKSpriteNode, GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
    var pulseAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 40, height: 38)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.texture = textureAtlas.textureNamed("power-up-star.png")
        self.run(pulseAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.powerup.rawValue
    }
    
    func onTap() {
        
    }
    
    func createAnimations(){
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.85, duration: 0.8),
            SKAction.scale(to: 0.6, duration: 0.8),
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
            ])
        
        let pulseInGroup = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 1.5),
            SKAction.scale(to: 1, duration: 1.5),
            SKAction.rotate(byAngle: 3.5, duration: 1.5)

            ])
        
        let pulseSequence = SKAction.sequence([
            pulseOutGroup,pulseInGroup
            ])
        
        pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
}
