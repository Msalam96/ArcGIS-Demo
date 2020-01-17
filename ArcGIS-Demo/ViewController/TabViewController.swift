//
//  TabViewController.swift
//  ArcGIS-Demo
//
//  Created by Brandon Cortes on 12/26/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import UIKit
import ArcGIS

class TabViewController : UITabBarController {

    var auth:AGS
    
    init(ags:AGS){
        self.auth = ags
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
                
        super.viewDidLoad()
        
        let mapNavController = UINavigationController(rootViewController: MapViewController(auth: auth))
        mapNavController.tabBarItem.title = "Map"
        mapNavController.navigationBar.barTintColor = .orange
        
        //MARK: PROFILE SETUP
        let profileNavController = UINavigationController(rootViewController: ProfileViewController(auth: auth))
        profileNavController.tabBarItem.title = "Profile"
        profileNavController.navigationBar.barTintColor = .orange
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .orange
    
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        viewControllers = [
            mapNavController,
            profileNavController
        ]
    }
    
}
