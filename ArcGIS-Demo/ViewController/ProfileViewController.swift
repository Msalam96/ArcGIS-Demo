//
//  ProfileViewController.swift
//  ArcGIS-Demo
//
//  Created by Naresh on 12/31/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import UIKit
import ArcGIS


class ProfileViewController : UIViewController{
    
    var auth:AGS?
    
    init(auth:AGS) {
        super.init(nibName: nil, bundle: nil)
        self.auth = auth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("NASDFSDFASDFSDF")
        view.backgroundColor = .red
        //print(login.auth.portal.user?.fullName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
   
        print("sdfasdfasd",auth?.portal.user?.fullName)
    }
}
