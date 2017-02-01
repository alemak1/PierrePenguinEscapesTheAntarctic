//
//  GameScene.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/27/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let powerUpStar = Star()
    
    var coinsCollected = 0
    
    var nextEncounterSpawnPosition = CGFloat(150)
    
    let encounterManager = EncounterManager()
    
    let world = SKNode()
    let player = Player()
    let ground = Ground()
    
    var screenCenterY = CGFloat()
    let initialPlayerPosition = CGPoint(x: 150, y: 250)
    var playerProgress = CGFloat()
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        self.screenCenterY = self.size.height/2
    
        self.addChild(world)
        
       
        let groundPosition = CGPoint(x: -self.size.width, y: 30)
        let groundSize = CGSize(width: self.size.width*3, height: 0)
        
        ground.spawn(parentNode: world, position: groundPosition, size: groundSize)
        
        player.spawn(parentNode: world, position: initialPlayerPosition)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        encounterManager.addEncountersToWorld(self.world)
        encounterManager.encounters[0].position = CGPoint(x: 300, y: 0)
        
        powerUpStar.spawn(parentNode: world, position: CGPoint(x: -2000, y: -1000))
        self.physicsWorld.contactDelegate = self
        
       
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //Each contact has two bodies, we do not know which is which. We will find the penguin body, then use the other body to determine the type of contact
        let otherBody: SKPhysicsBody
        
        //Combine the two penguin physics categories into one bitmask using the bitwise
        //OR operator ||
        
        
        let penguinMask = PhysicsCategory.penguin.rawValue | PhysicsCategory.damagedPenguin.rawValue
        
        //Use the bitwise AND operator & to find the penguin. This returns a positive number if body A's category is the same as either the penguin or the damaged penguin
        
        if (contact.bodyA.categoryBitMask & penguinMask > 0){
            //bodyA is the penguin, we will test bodyB
            otherBody = contact.bodyB
        } else {
            //bodyB is the penguin, we will test bodyA
            otherBody = contact.bodyA
        }
        
        
        //Find the type of contact
        switch otherBody.categoryBitMask{
            case PhysicsCategory.ground.rawValue:   print("Hit the ground")
                                                    player.takeDamage()
            case PhysicsCategory.enemy.rawValue:    print("Take damage")
                                                    player.takeDamage()
            case PhysicsCategory.coin.rawValue:
                if let coin = otherBody.node as? Coin {
                    coin.collect()
                    self.coinsCollected += 1
                    print(self.coinsCollected)
            }
            case PhysicsCategory.powerup.rawValue:
                player.starPower()
                print("start the power-up")
            default:                                print("Contact with no game logic")
        }
    }

    
    override func didSimulatePhysics() {
        
        var worldYPos: CGFloat = 0
        
        if(player.position.y > screenCenterY) {
            let percentOfMaxHeight = (player.position.y - screenCenterY)/(player.maxHeight - screenCenterY)
            let scaleSubtraction = (percentOfMaxHeight > 1 ? 1: percentOfMaxHeight)*0.6
            let newScale = 1 - scaleSubtraction
            world.yScale = newScale
            world.xScale = newScale
            worldYPos = -(player.position.y*world.yScale-self.size.height/2)
        }
        
        let worldXPos = -(player.position.x*world.xScale - (self.size.width)/3)
        world.position =  CGPoint(x: worldXPos, y: worldYPos)
        
        playerProgress = player.position.x - initialPlayerPosition.x
        ground.checkForReposition(playerProgress: playerProgress)
        
        if player.position.x > nextEncounterSpawnPosition{
            encounterManager.placeNextEncounter(currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1400
            
            //Each encounter has a 10% chance to spawn a star
            //let starRoll = Int(arc4random_uniform(10))
            let starRoll = 0
            if starRoll == 0{
                if abs(player.position.x - powerUpStar.position.x) > 1200 {
                    //only move the star if it is off the screen
                    let randomYPos = CGFloat(arc4random_uniform(400))
                    powerUpStar.position = CGPoint(x: nextEncounterSpawnPosition, y: randomYPos)
                    powerUpStar.physicsBody?.angularVelocity = 0
                    powerUpStar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
            }
        }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.startFlapping()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        player.update()
    }
}


enum PhysicsCategory: UInt32{
    case penguin = 1
    case damagedPenguin = 2
    case ground = 4
    case enemy = 8
    case coin = 16
    case powerup = 32
    
}
