//
//  Bee.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/27/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit

class Bee: SKSpriteNode, GameSprite{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "bee.atlas")
    
    var flyAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 28, height: 24)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.run(flyAnimation)
    }
    
    func onTap() {
        
    }
    
    func createAnimations(){
        
        let flyFrames: [SKTexture] = [
            textureAtlas.textureNamed("bee.png"),
            textureAtlas.textureNamed("bee_fly.png")
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.14)
        flyAnimation = SKAction.repeatForever(flyAction)
        
    }
}
