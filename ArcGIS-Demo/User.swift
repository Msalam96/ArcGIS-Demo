//
//  User.swift
//  ArcGIS-Demo
//
//  Created by Naresh on 1/9/20.
//  Copyright © 2020 BMS. All rights reserved.
//
import UIKit
struct User{
    let fullName: String
    let email: String
    let userName: String
    let dateCreated: String
    
    init(fullName: String, email: String, userName: String, dateCreated: String)
    {
        self.fullName = fullName
        self.email = email
        self.userName = userName
        self.dateCreated = dateCreated
    } 
}
