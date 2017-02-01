//
//  Blade.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit

class Blade: SKSpriteNode, GameSprite{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    var spinAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 185, height: 92)) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(texture: textureAtlas.textureNamed("blade-1.png"), size: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        createAnimations()
        self.run(spinAnimation)
        
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue

    }
    
    func onTap() {
        
    }
    
    func createAnimations(){
        let spinFrames: [SKTexture] = [
            textureAtlas.textureNamed("blade-1.png"),
            textureAtlas.textureNamed("blade-2.png")
        ]
        
        let spinAction = SKAction.animate(with: spinFrames, timePerFrame: 0.07)
        spinAnimation = SKAction.repeatForever(spinAction)
    }
}
