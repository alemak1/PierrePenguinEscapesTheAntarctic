//
//  PageView.swift
//  CharacterIntros
//
//  Created by Aleksander Makedonski on 1/29/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import Foundation
import UIKit

class PageView: UIView{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    class func loadFromNib() -> PageView{
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "PageView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! PageView
        return view
    }
    
    func configure(data: [String:String]){
        backgroundColor = UIColor.cyan
        label.text = data["title"]
        let image = UIImage(named: data["img"]!)
        imageView.image = image
        
    }
}
