//
//  Cell.swift
//  ArcGIS-Demo
//
//  Created by Naresh on 12/26/19.
//  Copyright © 2019 BMS. All rights reserved.
//
import UIKit

class Cell: UICollectionViewCell {
    
    static var identifier: String = "Cell"
    
    weak var textLabel: UILabel!

    //this gets called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
        ])
        self.textLabel = textLabel
        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.textLabel.textAlignment = .center
    }
}
