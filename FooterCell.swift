//
//  FooterCell.swift
//  ArcGIS-Demo
//
//  Created by Naresh on 1/17/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class FooterCell: UICollectionReusableView {
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        imageView.frame = self.frame
        
        imageView.image = UIImage(named: "gislogo")
        addSubview(imageView)
        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        

       }
       
    
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       override func prepareForReuse() {
           super.prepareForReuse()
           
       }

       override func layoutSubviews() {
           super.layoutSubviews()
       }
    
}
