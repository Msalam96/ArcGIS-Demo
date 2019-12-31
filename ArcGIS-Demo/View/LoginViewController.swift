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
     
     private let loginContentView:UIView = {
          let view = UIView()
          view.translatesAutoresizingMaskIntoConstraints = false
          view.backgroundColor = .white
          return view
     }()
     
     private let usernameTextField:UITextField = {
          let textField = UITextField()
          textField.backgroundColor = .white
          textField.borderStyle = .roundedRect
          textField.translatesAutoresizingMaskIntoConstraints = false
          return textField
     }()
     
     private let passwordTextField:UITextField = {
          let textField = UITextField()
          textField.backgroundColor = .white
          textField.borderStyle = .roundedRect
          textField.translatesAutoresizingMaskIntoConstraints = false
          return textField
     }()
     
     let loginButton:UIButton = {
          let btn = UIButton(type:.system)
          btn.backgroundColor = .systemTeal
          btn.setTitle("Login", for: .normal)
          btn.tintColor = .white
          btn.layer.cornerRadius = 5
          btn.clipsToBounds = true
          btn.translatesAutoresizingMaskIntoConstraints = false
          btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
          return btn
     }()
     
     func setUpAutoLayout(){
          loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
          loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
          loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
          loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
          
          usernameTextField.topAnchor.constraint(equalTo:loginContentView.topAnchor, constant:40).isActive = true
          usernameTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
          usernameTextField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
          usernameTextField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
          
          passwordTextField.topAnchor.constraint(equalTo:usernameTextField.bottomAnchor, constant:20).isActive = true
          passwordTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
          passwordTextField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
          passwordTextField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
          
          loginButton.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor, constant:20).isActive = true
          loginButton.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
          loginButton.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
          loginButton.heightAnchor.constraint(equalToConstant:50).isActive = true
     }
     
     @objc func buttonAction(sender: UIButton!) {
          if usernameTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false{
               let alert = UIAlertController(title: "Error", message: "Username and Password Must Be Filled", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
          } else {
               print("its haddening")
               let credentials = AGSCredential(user: usernameTextField.text!, password: passwordTextField.text!)
               auth.activeChallenge?.continue(with: credentials)
          }
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
               // check the portal item loaded and print the modified date
               if self?.auth.portal.loadStatus == AGSLoadStatus.loaded {
                    let fullName = self?.auth.portal.user?.fullName
                    print(fullName!)
               } else {
                    print("yeet")
                    let alert = UIAlertController(title: "Error", message: "Invalid Username or Password", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
               }
          }
     }
     
     func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
          auth.activeChallenge = challenge
          loginContentView.addSubview(usernameTextField)
          loginContentView.addSubview(passwordTextField)
          loginContentView.addSubview(loginButton)
          view.addSubview(loginContentView)
          setUpAutoLayout()
          
          //        let credentials = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
     }
}
