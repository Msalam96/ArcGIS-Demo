//
//  TabViewController.swift
//  ArcGIS-Demo
//
//  Created by Brandon Cortes on 12/26/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import UIKit

class TabViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: replace UIViewController with the actual view controllers
        let mapViewController = UIViewController()
        let profileViewController = UIViewController()
        
        //set tab titles
        mapViewController.tabBarItem.title = "Map"
        profileViewController.tabBarItem.title = "Profile"
        
        //DEBUGGING: change background color
        mapViewController.view.backgroundColor = .blue
        profileViewController.view.backgroundColor = .red
        
        viewControllers = [
            mapViewController,
            profileViewController
        ]
        
        
    }
    
}
