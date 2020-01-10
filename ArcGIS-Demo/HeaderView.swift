//
//  HeaderView.swift
//  ArcGIS-Demo
//
//  Created by Naresh on 1/3/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        
        backgroundColor = .blue
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
