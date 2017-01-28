//
//  Pierre.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/27/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "pierre.atlas")
    var flyAnimation = SKAction()
    var soarAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 64, height: 64)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        
        self.run(flyAnimation, withKey: "flyAnimation")
        
        let bodyTexture = textureAtlas.textureNamed("pierre-flying-3.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 30
        self.physicsBody?.allowsRotation = false
        
    }
    
    func createAnimations(){
        let rotateUpAction = SKAction.rotate(toAngle: 0, duration: 0.475)
        rotateUpAction.timingMode = .easeOut
        let rotateDownAction = SKAction.rotate(toAngle: -1, duration: 0.8)
        rotateDownAction.timingMode = .easeIn
        
        let flyFrames: [SKTexture] = [
            textureAtlas.textureNamed("pierre-flying-1.png"),
            textureAtlas.textureNamed("pierre-flying-2.png"),
            textureAtlas.textureNamed("pierre-flying-3.png"),
            textureAtlas.textureNamed("pierre-flying-4.png"),
            textureAtlas.textureNamed("pierre-flying-3.png"),
            textureAtlas.textureNamed("pierre-flying-2.png"),
            
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.03)
        
        flyAnimation = SKAction.group([
            SKAction.repeatForever(flyAction),
            rotateUpAction
            ])
        
        let soarFrames: [SKTexture] = [textureAtlas.textureNamed("pierre-flying-1.png")]
        let soarAction = SKAction.animate(with: soarFrames, timePerFrame: 1)
        
        soarAnimation = SKAction.group([
            SKAction.repeatForever(soarAction),
            rotateDownAction
            ])
    }
    
    func onTap() {
        
    }
    
    func update(){
        
    }
}
