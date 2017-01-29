//
//  ViewController.swift
//  CharacterIntros
//
//  Created by Aleksander Makedonski on 1/29/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

