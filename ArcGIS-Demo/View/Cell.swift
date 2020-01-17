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
    
    let iconImageView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test text lets see if it prints out"
        
        return label
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.image = UIImage(named: "userIcon-1")
        
        return imageView
    }()
    
    //this gets called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .blue
        setupViews()
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
        ])
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|-50-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:["v0":textLabel]))
        self.textLabel = textLabel
        self.reset()
    }

    func setupViews()
    {
        addSubview(iconImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
                            
                                        //|-  => represents the left most corner of the screen
                                        //-|  => represents the right most corner of
                                        //[v0]  => represents the subview in this case it is the iconImageView, which has the cell as its parentView
        addConstraintsWithFormat(format: "H:|-75-[v0]-16-|", views: iconImageView)
        
        
        addConstraintsWithFormat(format: "H:|-4-[v0(34)]", views: userProfileImageView)
        //vertical constraints
        addConstraintsWithFormat(format:  "V:|-8-[v0]-8-[v1(34)]-8-[v2(1)]|", views: iconImageView, userProfileImageView, separatorView)
        
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
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}
