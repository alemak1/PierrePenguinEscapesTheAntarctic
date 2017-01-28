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
        "EncounterBats"
    ]
    
    //Each encounter is an SKNode, store an array
    var encounters: [SKNode] = []
    
    
    //We will call this addEncountersToWorld function from the GameScene to append
    //all of the encounter nodes to the world node from our GameScene
    
    
    func addEncountersToWorld(world: SKNode){
        for index in 0 ... encounters.count-1 {
            encounters[index].position = CGPoint(x: -2000, y: index*1000)
            world.addChild(encounters[index])
        }
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
            
        }
    
    }
    
}
