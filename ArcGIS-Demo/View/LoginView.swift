//
//  LoginView.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/31/19.
//  Copyright © 2019 BMS. All rights reserved.
//
import Foundation
import UIKit

class LoginView:UIView {
    
    let loginContentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let usernameTextField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.spellCheckingType = .no
        textField.placeholder = "Username"
        textField.text = "Brandontod97"
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
        textField.text = "wyrsuz-wyhwo6-Wefmyw"
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
        loginButton.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
}
