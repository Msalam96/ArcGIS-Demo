//
//  CustomTextField.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 1/3/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField:UITextField {
    
    func setup() {
        self.backgroundColor = .white
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spellCheckingType = .no
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = 10
        
//        self.attributedPlaceholder = NSAttributedString(string: placeholdername, attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20)!])
        self.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        self.textColor = UIColor.orange
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func addImage(image: String) {
        let imageView = UIImageView()
        let image = UIImage(named: image)
        imageView.image = image
        imageView.frame = CGRect(x: 5, y: 4, width: 40, height: 40)
        self.leftViewMode = UITextField.ViewMode.always
        self.addSubview(imageView)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        self.leftView = paddingView
    }
    
    func changePlaceHolder(text: String, font: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont(name: font, size: 20)!])
    }
}
