//
//  CustomButton.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 1/3/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import Foundation
import UIKit

class CustomButton:UIButton {
    
    func setup() {
        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
//        self.layer.shadowRadius = 8
//        self.layer.shadowOpacity = 0.5
        self.backgroundColor = .systemOrange
        self.setTitle("Login", for: .normal)
        self.tintColor = .white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.black.cgColor
        self.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.titleLabel?.isHighlighted = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}
