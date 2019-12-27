//
//  LoginViewController.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/20/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import UIKit
import ArcGIS

class LoginViewController:UIViewController, AGSAuthenticationManagerDelegate {
//   private let credential = AGSCredential(user: "brandontod97", password:"wyrsuz-wyhwo6-Wefmyw")
     private let portalURL = URL(string: "https://www.arcgis.com")!
     private let clientID = "e6Lfvlw05UccMiiU"
     private let redirectURL = "ArcGIS-Demo://auth"
     private let credential = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
     var authenticationManager = AGSAuthenticationManager.shared()
     var activeChallenge:AGSAuthenticationChallenge?

     //private let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)

     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .red
          self.authenticationManager.delegate = self
          self.setupOauth()
          //activeChallenge? = AGSAuthenticationChallengeType.usernamePassword
          print("credential[ username: \(credential.username ?? "UNKNOWN") -- password: \(credential.password ?? "UNKNOWN")")
          activeChallenge?.continueWithDefaultHandling()
          print(activeChallenge == nil)
//          activeChallenge?.continue(with: credential)
     }
     
     func setupOauth(){
          let oauthConfiguration = AGSOAuthConfiguration(portalURL: NSURL(string: "https://www.arcgis.com")! as URL, clientID: clientID, redirectURL: redirectURL)
          authenticationManager.oAuthConfigurations.add(oauthConfiguration)
     }
     
     func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
          activeChallenge = challenge
          print(activeChallenge == nil)
          activeChallenge?.continue(with: credential)
          //challenge.continueWithDefaultHandling()
     }
     
     func authenticationTypeFromChallengeType (challengeType:AGSAuthenticationChallengeType) -> String {

         switch challengeType {
         case AGSAuthenticationChallengeType.oAuth:
             return "OAuth"
         case AGSAuthenticationChallengeType.usernamePassword:
             return "ArcGIS Token"
         case AGSAuthenticationChallengeType.untrustedHost:
             return "HTTP"
         case AGSAuthenticationChallengeType.clientCertificate:
             return "PKI"
         default:
             return "unknown"
         }
     }
}

    


