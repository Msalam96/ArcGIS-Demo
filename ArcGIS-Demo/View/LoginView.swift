//
//  LoginView.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/31/19.
//  Copyright © 2019 BMS. All rights reserved.
//
import Foundation
import UIKit

class LoginView:UIView, UIGestureRecognizerDelegate {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.8
        imageView.image = UIImage(named: "gislogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginContentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    var usernameTextField:CustomTextField = CustomTextField()
    
    var passwordTextField:CustomTextField = CustomTextField()
    
    var loginButton:CustomButton = CustomButton()
    
    let githubButton:UIButton = {
        let btn = UIButton(type: .custom)
        let image = UIImage(named: "githublogo")
        btn.setImage(image, for: .normal)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(LoginViewController.github), for: .touchUpInside)
        return btn
    }()
    
    func setUpAutoLayout(){
        usernameTextField.addImage(image: "user")
        usernameTextField.changePlaceHolder(text: "Username", font: "AppleSDGothicNeo-Bold")
        usernameTextField.topAnchor.constraint(equalTo:loginContentView.topAnchor, constant:40).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        
        passwordTextField.addImage(image: "password")
        passwordTextField.changePlaceHolder(text: "Password", font: "AppleSDGothicNeo-Bold")
        passwordTextField.isPasswordField()
        passwordTextField.topAnchor.constraint(equalTo:usernameTextField.bottomAnchor, constant:20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant:50).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        
        loginButton.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor, constant:20).isActive = true
        loginButton.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        loginButton.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addtoSubView(){
        loginContentView.addSubview(usernameTextField)
        loginContentView.addSubview(passwordTextField)
        loginContentView.addSubview(loginButton)
    }
}
