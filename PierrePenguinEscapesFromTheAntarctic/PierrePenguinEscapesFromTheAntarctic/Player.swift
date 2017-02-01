//
//  Pierre.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/27/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, GameSprite{
    //The player will be able to take 3 hits before game over
    var health: Int = 3
    
    //Keep track of when the player is invulnerable
    var invulnerable: Bool = false
    
    //Keep track of when the player is newly damaged
    var damaged: Bool = false
    
    //Animations will be created to run when the player either takes damage or dies
    var damageAnimation = SKAction()
    var dieAnimation = SKAction()
    
    //We want to stop forward velocity if the player dies, so forward velocity is stored as a property
    
    var forwardVelocity: CGFloat = 200
    
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "pierre.atlas")
    var flyAnimation = SKAction()
    var soarAnimation = SKAction()
    
    var flapping = false
    let maxFlappingForce: CGFloat = 57000
    let maxHeight: CGFloat = 1000
    
    
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 64, height: 64)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        
        self.run(soarAnimation, withKey: "soarAnimation")
        
        let bodyTexture = textureAtlas.textureNamed("pierre-flying-3.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 30
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.penguin.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue | PhysicsCategory.ground.rawValue | PhysicsCategory.powerup.rawValue | PhysicsCategory.coin.rawValue
        
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
    
    func startFlapping(){
        
        if (health <= 0) { return }
        
        self.removeAction(forKey: "soarAnimation")
        self.run(flyAnimation, withKey: "flyAnimation")
        self.flapping = true
    }
    
    
    func stopFlapping(){
        
        if (health <= 0) { return }
        self.removeAction(forKey: "flapAnimation")
        self.run(soarAnimation, withKey: "soarAnimation")
        self.flapping = false
    }
    
    
    func die(){
        //Make sure the player is fully visible
        self.alpha = 1
        
        //Remove all animations
        self.removeAllActions()
        
        //Run the die animation
        self.run(self.dieAnimation)
        
        //Prevent any further upward movement
        self.flapping = false
        
        //Stop forward movement
        self.forwardVelocity = 0
        
        
    }
    
    func takeDamage(){
        //If invulnerable or damaged, return:
        if self.invulnerable || self.damaged { return }
        
        //Remove one from our health pool
        self.health -= 1
        
        if self.health == 0 {
            //If we are out of health, run the die function
            self.die()
        } else {
            //Runt the take damage animation
            self.run(self.damageAnimation)
        }
    }
    
    func onTap() {
        
      
    }
    
    func update(){
        if self.flapping{
            var forceToApply = maxFlappingForce
            
            if position.y > 600 {
                let percentOfMaxHeight = position.y/maxHeight
                let flappingForceSubtraction = percentOfMaxHeight*maxFlappingForce
                
                forceToApply -= flappingForceSubtraction
                
            }
            
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: forceToApply))
            
            if self.physicsBody!.velocity.dy > 300 {
                self.physicsBody!.velocity.dy = 300
            }
            
        }
        
        self.physicsBody?.velocity.dx = self.forwardVelocity
        
    }
}
