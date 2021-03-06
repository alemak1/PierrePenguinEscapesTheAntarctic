//
//  EncounterManager.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit


class EncounterManager{
    //Store your encounter file names
    let encounterNames: [String] = [
        "EncounterBats",
        "EncounterBees",
        "EncounterGhosts"
    ]
    
    var currentEncounterIndex: Int?
    var previousEncounterIndex: Int?
    
    //Each encounter is an SKNode, store an array
    var encounters: [SKNode] = []
    
    
    //Save the initial positions of the children of a node
    
    func saveSpritePositions(node: SKNode){
        for sprite in node.children{
            if let spriteNode = sprite as? SKSpriteNode{
                let initialPositionValue = NSValue(cgPoint: sprite.position)
                spriteNode.userData = ["initialPosition":initialPositionValue]
                
                //Save the positions for the children of this node
                saveSpritePositions(node: spriteNode)
            }
        }
    }
    
    //Reset all the children nodes to their original position
    
    func resetSpritePositions(node: SKNode){
        for sprite in node.children{
            if let spriteNode = sprite as? SKSpriteNode{
                spriteNode.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
                spriteNode.physicsBody?.angularVelocity = 0
                
                //Reset the rotation of the sprite
                spriteNode.zRotation = 0
                
                if let initialPositionVal = spriteNode.userData?.value(forKey: "initialPosition") as? NSValue{
                    spriteNode.position = initialPositionVal.cgPointValue
                    
                    resetSpritePositions(node: spriteNode)
                }
            }
        }
    }
    
    //We will call this addEncountersToWorld function from the GameScene to append
    //all of the encounter nodes to the world node from our GameScene

    
    func addEncountersToWorld(_ world: SKNode){
        for index in 0 ... encounters.count-1 {
            encounters[index].position = CGPoint(x: -2000, y: index*1000)
            world.addChild(encounters[index])
        }
    }
    
    func placeNextEncounter(currentXPos: CGFloat){
        //Count the encounters in a random ready type (Uint32)
        let encounterCount = UInt32(encounters.count)
        
        //The game requires three encounters to function so exit this function if there are less than 3
        
        if encounterCount < 3 { return }
        
        //We need to pick an encounter that is currently not displayed on the screen
        var nextEncounterIndex: Int?
        var trulyNew: Bool?
        
        while trulyNew == false || trulyNew == nil{
            //Pick a random encounter to set next
            nextEncounterIndex = Int(arc4random_uniform(encounterCount))
            
            //First, assert that this is a new counter 
            trulyNew = true
            
            
            //Test if it is instead the current encounter
            if let currentIndex = currentEncounterIndex{
                if (nextEncounterIndex == currentIndex){
                    trulyNew = false
                }
            }
            
            //Test if it is the directly previous encounter:
            if let previousIndex = previousEncounterIndex{
                if (nextEncounterIndex == previousIndex){
                    trulyNew = false
                }
            }
        }
        
        //Keep track of the current encounter
        previousEncounterIndex = currentEncounterIndex
        currentEncounterIndex = nextEncounterIndex
        
        //Reset the new encounter and position it ahead of the player
        let encounter = encounters[currentEncounterIndex!]
        encounter.position = CGPoint(x: currentXPos + 1000, y: 0)
        resetSpritePositions(node: encounter)
        
    }
    
    
    init(){
        //Loop through each encounter scene
        
        for encounterFileName in encounterNames{
            //Create a new node for the encounter
            let encounter = SKNode()
            
            //Load this scene file into an SKScene instance
            if let encounterScene = SKScene(fileNamed: encounterFileName){
                //Loop through each placeholder, spawn the appropriate game object:
                for placeholder in encounterScene.children {
                    if let node = placeholder as? SKNode{
                        switch node.name!{
                            case "Bat":
                                let bat = Bat()
                                bat.spawn(parentNode: encounter, position: node.position)
                            case "Bee":
                                let bee = Bee()
                                bee.spawn(parentNode: encounter, position: node.position)
                            case "Blade":
                                let blade = Blade()
                                blade.spawn(parentNode: encounter, position: node.position)
                            case "Ghost":
                                let ghost = Ghost()
                                ghost.spawn(parentNode: encounter, position: node.position)
                            case "MadFly":
                                let madFly = MadFly()
                                madFly.spawn(parentNode: encounter, position: node.position)
                            case "GoldCoin":
                                let coin = Coin()
                                coin.spawn(parentNode: encounter, position: node.position)
                                coin.turnToGold()
                            case "BronzeCoin":
                                let coin = Coin()
                                coin.spawn(parentNode: encounter, position: node.position)
                            default:
                                print("Name error: \(node.name)")
                            
                        }
                    }
                }
            }
            
            //Add the populated encounter node to the array
            encounters.append(encounter)
            saveSpritePositions(node: encounter)
        }
    
    }
    
}
