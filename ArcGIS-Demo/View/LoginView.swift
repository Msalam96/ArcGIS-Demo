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
    
    let usernameTextField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.spellCheckingType = .no
        textField.placeholder = " Username"
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 3.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let passwordTextField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.placeholder = "Password"
        return textField
    }()
    
    let loginButton:UIButton = {
        let btn = UIButton(type:. system)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOpacity = 0.5
        btn.backgroundColor = .systemOrange
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.layer.masksToBounds = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        return btn
    }()
    
    let githubButton:UIButton = {
        let btn = UIButton(type: .custom)
        let image = UIImage(named: "githublogo")
        btn.setImage(image, for: .normal)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(LoginViewController.github), for: .touchUpInside)
        btn.showsTouchWhenHighlighted = true
        return btn
    }()
    
    func setUpAutoLayout(){
        
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
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        githubButton.topAnchor.constraint(equalTo:loginButton.bottomAnchor, constant: 20).isActive = true
    }
    
}
