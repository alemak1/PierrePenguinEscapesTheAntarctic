//
//  ViewController.swift
//  CharacterIntros
//
//  Created by Aleksander Makedonski on 1/29/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let images = [
        #imageLiteral(resourceName: "Icon-76"),
        #imageLiteral(resourceName: "ghost-frown"),
        #imageLiteral(resourceName: "bee"),
        #imageLiteral(resourceName: "mad-fly-1"),
        #imageLiteral(resourceName: "blade-1"),
        #imageLiteral(resourceName: "coin-gold"),
        #imageLiteral(resourceName: "coin-bronze")
    ]
    
    let imageNames: [String] = [
        "Icon-76",
        "ghost-frown",
        "bee",
        "mad-fly-1",
        "blade-1",
        "coin-gold",
        "coin-bronze"
    ]
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        scrollView.isPagingEnabled = true
        setupImageViews()

    }
    
 
    func setupImageViews(){
        var totalWidth: CGFloat = 0
        
        for image in images{
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(origin: CGPoint(x: totalWidth, y: 0), size: scrollView.bounds.size)
            imageView.contentMode = .scaleToFill
            scrollView.addSubview(imageView)
            totalWidth += imageView.bounds.size.width
        }
        
        scrollView.contentSize = CGSize(width: totalWidth,
                                        height: scrollView.bounds.size.height)
    }

}

