//
//  ThTabBarViewController.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/20/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit

class ThTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let itemWidth = floor(self.tabBar.frame.size.width / CGFloat(self.tabBar.items!.count))
        let separatorWidth: CGFloat = 0.5
        for i in 0...(self.tabBar.items!.count - 2) {
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2), y: 0, width: CGFloat(separatorWidth), height: self.tabBar.frame.size.height))
            separator.backgroundColor = UIColor.white
            self.tabBar.addSubview(separator)
        }
        if let items = self.tabBar.items, items.count == 3{
            items[0].imageInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        }
    }

}
