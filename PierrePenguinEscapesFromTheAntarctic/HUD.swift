//
//  HUD.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 2/1/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit

class HUD: SKNode{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "hud.atlas")
    
    //An array to keep track of the hearts
    var heartNodes: [SKSpriteNode] = []
    
    //An SKLabelNode to print the coin score
    let coinCountText = SKLabelNode(text: "000000")
    
    func setHealthDisplay(newHealth: Int){
        //Create a fade SKAction to fade out any lost hearts
        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: 0.3)
        
        //Loop through each heart and update its status
        for index in 0 ..< heartNodes.count{
            if index < newHealth{
                //This heart should be full red
                heartNodes[index].alpha = 1
                
            } else {
                //This heart should be faded
                heartNodes[index].run(fadeAction)
            }
        }
    }
    
    func setCoinCountDisplay(newCoinCount: Int){
        //We can use the NSNumberFormatter class to pad leading 0's onto the coin count
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 6
        
        if let coinStr = formatter.string(from: NSNumber(value: newCoinCount)){
            //update the label node with the new coin count
            coinCountText.text = coinStr
        }
    }
    
    func createHudNodes(screenSize: CGSize){
        // -- Create the coin counter --
        
        //First, create and position a bronze coin icon:
        
        let coinTextureAtlas: SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
        let coinIcon = SKSpriteNode(texture: coinTextureAtlas.textureNamed("coin-bronze.png"))
        
        //Size and position the coin icon
        let coinYPos = screenSize.height - 23
        
        coinIcon.size = CGSize(width: 26, height: 26)
        coinIcon.position = CGPoint(x: 23, y: coinYPos)
        
        //Configure the coin text label
        coinCountText.fontName = "AvenirNext-HeavyItalic"
        
        //These two properties allow you to align the text relative to the SKLabelNode's position
        
        coinCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        //Add the textLabel and the coin icon to the HUD
        self.addChild(coinIcon)
        self.addChild(coinCountText)

        
        //Create three heartnodes for the life meter
        
        for index in 0 ..< 3{
            let newHeartNode = SKSpriteNode(texture: textureAtlas.textureNamed("heart-full.png"))
            newHeartNode.size = CGSize(width: 46, height: 40)
            
            //Position the hearts below the coin counter
            let xPos = CGFloat(index*60 + 33)
            let yPos = screenSize.height - 66
            newHeartNode.position = CGPoint(x: xPos, y: yPos)
            
            //Keep track of nodes in an array Property
            heartNodes.append(newHeartNode)
            self.addChild(newHeartNode)
        }
        
        
    }
    
}
