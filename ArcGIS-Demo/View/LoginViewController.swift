//
//  LoginViewController.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/27/19.
//  Copyright © 2019 BMS. All rights reserved.
import Foundation
import ArcGIS

class LoginViewController:UIViewController, AGSAuthenticationManagerDelegate {
     
     private var auth = AGS()
     private var loginView = LoginView()
     
     func setupConstraints(){
          loginView.loginContentView.insertSubview(loginView.logoImageView, aboveSubview: view)
          loginView.logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90.0).isActive = true
          loginView.logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
          loginView.logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.4).isActive = true
          loginView.logoImageView.widthAnchor.constraint(equalTo: view.heightAnchor, constant: 0.0).isActive = true
          
          loginView.loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
          loginView.loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
          loginView.loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
          loginView.loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

          loginView.githubButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
          loginView.githubButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
          loginView.githubButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.4).isActive = true
          loginView.githubButton.widthAnchor.constraint(equalTo: view.heightAnchor, constant: 0.0).isActive = true
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .white
          
          AGSAuthenticationManager.shared().delegate = self
          
          auth.portal.load() {[weak self] (error) in
               if (error != nil) {
                    let alert = UIAlertController(title: "Error", message: "Username or Password Does Not Match", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self!.present(alert, animated: true, completion: nil)
               }
               if self?.auth.portal.loadStatus == AGSLoadStatus.loaded {
                    // TO DO: Change how to pass data between controllers
                    let vc = TabViewController(ags: self!.auth)
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
               }
          }
     }
     
     @objc func login(sender: UIButton!) {
          if loginView.usernameTextField.text!.isEmpty || loginView.passwordTextField.text!.isEmpty {
               let alert = UIAlertController(title: "Error", message: "Username and Password Must Be Filled", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
               present(alert, animated: true, completion: nil)
          } else {
               let credentials = AGSCredential(user: loginView.usernameTextField.text!, password: loginView.passwordTextField.text!)
               auth.activeChallenge?.continue(with: credentials)
          }
     }
     
     @objc func github(sender: UIButton!) {
          UIApplication.shared.open(URL(string: "https://github.com/Msalam96/ArcGIS-Demo")!)
     }
     

     func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
          auth.activeChallenge = challenge
          loginView.addtoSubView()
          view.addSubview(loginView.loginContentView)
          view.addSubview(loginView.githubButton)
          loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
          setupConstraints()
          loginView.setUpAutoLayout()
          //        let credentials = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
     }
}
