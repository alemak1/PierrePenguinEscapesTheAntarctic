//
//  GameSprite.swift
//  PierrePenguinEscapesFromTheAntarctic
//
//  Created by Aleksander Makedonski on 1/27/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSprite{
    var textureAtlas: SKTextureAtlas {get set}
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize)
    func onTap()
}
