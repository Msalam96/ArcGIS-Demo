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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //license the app with the supplied License key
        do {
         let result = try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud7613398925,none,D7MFA0PL4S6LLAMEY139")
         print("License Result : \(result.licenseStatus)")
        }
        catch let error as NSError {
         print("error: \(error)")
        }
        
        //MARK: MAP SETUP
        //instantiate the MapViewController
        let mapViewController = MapViewController()
        
        //set its background color to red
        mapViewController.view.backgroundColor = .red
        
        //set its title to Map
        mapViewController.navigationItem.title = "Map"
        
        //wrap it in a navigation controller
        let mapNavController = UINavigationController(rootViewController: mapViewController)
       
        //add a left button to the nav bar
        mapViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Current Location", style: .plain, target: mapViewController, action: #selector(mapViewController.setupLocationDisplay))
        mapViewController.navigationItem.leftBarButtonItem?.tintColor = .white
        
        //add a right button to the nav bar
        mapViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: mapViewController, action: #selector(mapViewController.RefreshMap))
        mapViewController.navigationItem.rightBarButtonItem?.tintColor = .white
        
        //set the tab bar title to Map
        mapNavController.tabBarItem.title = "Map"
        
        //
        mapNavController.navigationBar.barTintColor = .orange
        
        
        
        //MARK: PROFILE SETUP
        //instantiate the ProfileViewController
        let profileViewController = UIViewController()
        
        //set its background color to blue
        profileViewController.view.backgroundColor = .blue
        
        //set its title to profile
        profileViewController.navigationItem.title = "Profile"
        
        //wrap it in a navigation controller
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        
        //set the tab bar title to Profile
        profileNavController.tabBarItem.title = "Profile"
        
        profileNavController.navigationBar.barTintColor = .orange
        
       
        let loginViewController = LoginViewController()
        //set tab titles
        mapViewController.tabBarItem.title = "Map"
        profileViewController.tabBarItem.title = "Profile"
        loginViewController.tabBarItem.title = "LogIn"
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .orange
        
        viewControllers = [
            mapViewController,
            profileViewController,
            loginViewController

        ]
        
        
    }
    
}
