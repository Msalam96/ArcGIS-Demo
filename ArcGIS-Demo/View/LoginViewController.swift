//
//  LoginViewController.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/27/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import ArcGIS

class LoginViewController:UIViewController, AGSAuthenticationManagerDelegate {
     
     private var auth = AGS()
     private var loginView = LoginView()

     static let NotificationDone = NSNotification.Name(rawValue: "Done")

     func setupConstraints(){
          loginView.loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
          loginView.loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
          loginView.loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
          loginView.loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     }
     
     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .lightGray
          AGSAuthenticationManager.shared().delegate = self
          
          auth.portal.load() {[weak self] (error) in
               if let error = error {
                    print(error)
                    return
               }

               if self?.auth.portal.loadStatus == AGSLoadStatus.loaded {
                    let fullName = self?.auth.portal.user?.fullNames
                    NotificationCenter.default.post(name: LoginViewController.NotificationDone, object: nil)
               }
          }
          
     }
     
     @objc func buttonAction(sender: UIButton!) {
          if loginView.usernameTextField.text?.isEmpty ?? false || loginView.passwordTextField.text?.isEmpty ?? false{
          let alert = UIAlertController(title: "Error", message: "Username and Password Must Be Filled", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
          present(alert, animated: true, completion: nil)
          } else {
               print("its haddening")
               let credentials = AGSCredential(user: loginView.usernameTextField.text!, password: loginView.passwordTextField.text!)
               auth.activeChallenge?.continue(with: credentials)
               if(auth.portal.loadError) == nil {
                    print("yata")
               }
          }
     }
     
     func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
          auth.activeChallenge = challenge
          loginView.loginContentView.addSubview(loginView.usernameTextField)
          loginView.loginContentView.addSubview(loginView.passwordTextField)
          loginView.loginContentView.addSubview(loginView.loginButton)
          view.addSubview(loginView.loginContentView)
          loginView.loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
          setupConstraints()
          loginView.setUpAutoLayout()
          
          //        let credentials = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
     }
}
