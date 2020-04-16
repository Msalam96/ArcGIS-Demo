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
    var leftText: String! {
        didSet{
            theTextLabelLeft.text = leftText
        }
    }
    
    var rightText: String! {
        didSet{
            theTextLabelRight.text = rightText
        }
    }
    
    fileprivate let theTextLabelLeft : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    fileprivate let theTextLabelRight : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()

        var width = (contentView.frame.width)/2
        
        theTextLabelLeft.frame = CGRect(x: 0, y: 0, width: width-12, height: 20)
        theTextLabelRight.frame = CGRect(x: width, y: 0, width: width-24, height: 20)

        self.contentView.addSubview(theTextLabelLeft)
        self.contentView.addSubview(theTextLabelRight)

        print(leftText)
        
        theTextLabelLeft.text = "\(leftText) :"
        theTextLabelRight.text = "\(rightText)"
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
    }
}
