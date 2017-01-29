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
        #imageLiteral(resourceName: "tablet-1"),
        #imageLiteral(resourceName: "pierre-flying-1"),
        #imageLiteral(resourceName: "combined_enemies4"),
        #imageLiteral(resourceName: "gold-medal")
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
    
    
    let gameData = [
        [
        "title":"Help Pierre Fly Past His Enmies!",
        "img":"tablet-1"
        ],
        
        [
        "title":"Meet Mister MadFly!",
        "img":"mad-fly-1"
        ],
        
        [
        "title":"Meet the Abominable Bat!",
        "img":"bat-fly-1"
        ],
        
        [
        "title":"Meet the Ballistic Bee!",
        "img":"bee"
        ],
        
        [
        "title":"If Pierre Can Overcome His Enemies, He Gets a Prize",
        "img": "gold-medal"
        ]
    
    ]
    
    func createPageView(data: [String: String]) -> PageView{
        let pageView = PageView.loadFromNib()
        pageView.configure(data: data)
        return pageView
        
    }
    

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        setuptPageViews()

    }
    
 
    func setuptPageViews(){
        var totalWidth: CGFloat = 0
        
        for data in gameData{
            let pageView = createPageView(data: data)
            pageView.frame = CGRect(origin: CGPoint(x: totalWidth, y: 0), size: view.bounds.size)
            scrollView.addSubview(pageView)
            totalWidth += pageView.bounds.size.width
        }
        
        scrollView.contentSize = CGSize(width: totalWidth,
                                        height: scrollView.bounds.size.height)
    }

}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = Int(scrollView.contentSize.width)/gameData.count
        pageControl.currentPage = Int(scrollView.contentOffset.x)/pageWidth
        
    }
}
