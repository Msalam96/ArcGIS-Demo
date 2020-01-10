//
//  Cell.swift
//  Overstats
//
//  Created by Brandon Cortes on 12/26/19.
//  Copyright © 2019 Brandon Cortes. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    //var theTextLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        theTextLabel = UILabel(frame: .zero)
//        theTextLabel!.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(theTextLabel)
//
//        theTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        theTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//        theTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        theTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//
//        self.contentView.addSubview(theTextLabel)
//
//        //self.theTextLabel.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Interface Builder is not supported!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //self.backgroundColor = .gray
        self.textLabel?.text = ""
    }
    
}
