//
//  LoginViewController.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/20/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import UIKit
import ArcGIS

class LoginViewController:UIViewController {
//   private let credential = AGSCredential(user: "brandontod97", password:"wyrsuz-wyhwo6-Wefmyw")
     private let portalURL = URL(string: "https://www.arcgis.com")!
     private let clientID = "e6Lfvlw05UccMiiU"
     private let redirectURL = "ArcGIS-Demo://auth"
     var authenticationManager:AGSAuthenticationManager = AGSAuthenticationManager.shared()


     private let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .red
          self.portal.credential = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
          
           self.portal.load() {[weak self] (error) in
              if let error = error {
                  print(error)
                  return
              }
                   // check the portal item loaded and print the modified date
              if self?.portal.loadStatus == AGSLoadStatus.loaded {
                  let fullName = self?.portal.user?.fullName
                  print(fullName!)
              }
          }
          
          let oauthConfiguration = AGSOAuthConfiguration(portalURL: NSURL(string: "https://www.arcgis.com")! as URL, clientID: clientID, redirectURL: redirectURL)
          authenticationManager.oAuthConfigurations.add(oauthConfiguration)

     
     }
    
}

    


