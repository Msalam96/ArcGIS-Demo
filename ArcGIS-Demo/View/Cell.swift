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
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //this gets called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupViews()
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

    func setupViews()
    {
        addSubview(iconImageView)
        addSubview(separatorView)                                                                    
                            
                                        //|-  => represents the left most corner of the screen
                                        //-|  => represents the right most corner of
                                        //[v0]  => represents the subview in this case it is the iconImageView, which has the cell as its parentView
        addConstraintsWithFormat(format: "H:|-1-[v0]-350-|", views: iconImageView)
        addConstraintsWithFormat(format:  "V:|-1-[v0]-16-[v1(1)]|", views: iconImageView,separatorView)
        addConstraintsWithFormat(format:"H:|[v0]|", views: separatorView)

//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:[v0(5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:["v0":separatorView]))
       //iconImageView.frame = CGRect(x:0, y:0 , width: 50, height: 100)
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


/*
 -Parameters:
    format: A string representation of how you want your subview to look corresponding to your parent view
 
 
 */
extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...)
    {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated()
        {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}
